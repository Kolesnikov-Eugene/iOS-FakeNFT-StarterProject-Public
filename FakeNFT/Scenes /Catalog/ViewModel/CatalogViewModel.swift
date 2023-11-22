//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Eugene Kolesnikov on 04.11.2023.
//

import Foundation
import Combine

protocol CatalogViewModelProtocol: AnyObject {
    var catalog: [Catalog] { get set }
    var catalogPublisher: Published<Array<Catalog>>.Publisher { get }
    var isLoadingData: Bool { get }
    var loadingDataPublisher: Published<Bool>.Publisher { get }
    var networkError: Error? { get }
    var errorPublisher: Published<Error?>.Publisher { get }
    func sortCatalogByName()
    func sortCatalogByQuantity()
    func sortCatalog()
    func fetchCatalog()
}

final class CatalogViewModel: CatalogViewModelProtocol {

    // MARK: - Public properties
    @Published var isLoadingData: Bool = true
    @Published var catalog: [Catalog] = []
    @Published var networkError: Error?
    var catalogPublisher: Published<Array<Catalog>>.Publisher { $catalog }
    var loadingDataPublisher: Published<Bool>.Publisher { $isLoadingData }
    var errorPublisher: Published<Error?>.Publisher { $networkError }

    // MARK: - Private properties
    private var filter: CatalogFilter?
    private var catalogService: CatalogServiceProtocol
    private var subscribes = [AnyCancellable]()

    init(catalogService: CatalogServiceProtocol) {
        self.catalogService = catalogService

        fetchCatalog()
        fetchProfileLikes()
        fetchAddedToBasketNfts()

        self.filter = CatalogFilter(
            rawValue: CatalogFilterStorage.shared.filterDescriptor ?? CatalogFilter.filterQuantity.rawValue
        )
        sortCatalog()
    }

    // MARK: - Public methods
    func sortCatalog() {
        switch filter {
        case .filterName:
            sortCatalogByName()
        case .filterQuantity:
            sortCatalogByQuantity()
        default:
            sortCatalogByQuantity()
        }
    }

    func sortCatalogByName() {
        catalog.sort { $0.name < $1.name }
        CatalogFilterStorage.shared.filterDescriptor = CatalogFilter.filterName.rawValue
    }

    func sortCatalogByQuantity() {
        catalog.sort { $0.nfts.count > $1.nfts.count }
        CatalogFilterStorage.shared.filterDescriptor = CatalogFilter.filterQuantity.rawValue
    }

    // MARK: - Private mathods
    func fetchCatalog() {
        isLoadingData = true
        catalogService.fetchCatalog { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let catalogRes):
                isLoadingData = false
                catalog = catalogRes
                sortCatalog()
            case .failure(let error):
                isLoadingData = false
                networkError = error
            }
        }
    }

    private func fetchProfileLikes() {
        catalogService.fetchProfileLikes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let profile):
                LikesStorage.shared.likes = profile.likes
                print(profile)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchAddedToBasketNfts() {
        catalogService.fetchAddedToBasketNfts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let order):
                PurchaseCartStorage.shared.nfts = order.nfts
                print(order)
            case .failure(let error):
                print(error)
            }
        }
    }
}