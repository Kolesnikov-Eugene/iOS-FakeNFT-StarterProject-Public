import UIKit

final class CartViewController: UIViewController, LoadingView {
    var activityIndicator = UIActivityIndicatorView()
    private var viewModel: CartViewModel!

    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.sortButtonPicTitle), for: .normal)
        button.addTarget(self, action: #selector(tapFilterButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var cartTableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private lazy var countNFTLabel: UILabel = {
        let label = UILabel()
        label.text = "0 NFT"
        label.textColor = .textPrimary
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "0 ETH"
        label.textColor = .yaGreen
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var paymentInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 3
        stackView.addArrangedSubview(countNFTLabel)
        stackView.addArrangedSubview(totalPriceLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.setTitle(Constants.paymentButtonText, for: .normal)
        button.setTitleColor(.textOnPrimary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapPayButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var paymentContainView: UIView = {
       let view = UIView()
        view.backgroundColor = .segmentInactive
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var emptyCartLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.emptyCart
        label.textColor = .textPrimary
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        observeViewModelChanges()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        createSubviews()
        viewModel.loadData()
        showLoading()
        checkPlaceholder()
    }

    private func observeViewModelChanges() {
        viewModel.$nfts.bind { [weak self] _ in
            self?.cartTableView.reloadData()
            self?.countNFTLabel.text = "\(self?.viewModel.countNftInCart() ?? 0) NFT"
            self?.totalPriceLabel.text = "\(self?.viewModel.getTotalPrice() ?? "") ETH"
            self?.hideLoading()
        }
    }

    private func checkPlaceholder() {
        if !viewModel.isEmpty {
            paymentContainView.isHidden = true
            filterButton.isHidden = true
            cartTableView.isHidden = true
            paymentButton.isHidden = true
            emptyCartLabel.isHidden = false
        }
    }

    @objc
    private func tapFilterButton() {
    }

    @objc
    private func tapPayButton() {
    }
}

extension CartViewController {
    private func createSubviews() {
        addCartTableView()
        addPaymentContainView()
        addPaymentInfoStackView()
        addPayButton()
        addEmptyCartLabel()
        addActivityIndicator()
    }

    private func addActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }

    private func addCartTableView() {
        view.addSubview(cartTableView)
        NSLayoutConstraint.activate([
            cartTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cartTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cartTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }

    private func addPaymentContainView() {
        view.addSubview(paymentContainView)
        NSLayoutConstraint.activate([
            paymentContainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            paymentContainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            paymentContainView.topAnchor.constraint(equalTo: cartTableView.bottomAnchor),
            paymentContainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            paymentContainView.heightAnchor.constraint(equalToConstant: 76)
        ])
    }

    private func addPaymentInfoStackView() {
        paymentContainView.addSubview(paymentInfoStackView)
        NSLayoutConstraint.activate([
            paymentInfoStackView.leadingAnchor.constraint(equalTo: paymentContainView.leadingAnchor, constant: 16),
            paymentInfoStackView.centerYAnchor.constraint(equalTo: paymentContainView.centerYAnchor)
        ])
    }

    private func addPayButton() {
        paymentContainView.addSubview(paymentButton)
        NSLayoutConstraint.activate([
            paymentButton.leadingAnchor.constraint(equalTo: paymentInfoStackView.trailingAnchor, constant: 24),
            paymentButton.trailingAnchor.constraint(equalTo: paymentContainView.trailingAnchor, constant: -16),
            paymentButton.centerYAnchor.constraint(equalTo: paymentContainView.centerYAnchor),
            paymentButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func addEmptyCartLabel() {
        view.addSubview(emptyCartLabel)
        NSLayoutConstraint.activate([
            emptyCartLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}

extension CartViewController: CartViewModelDelegate {
    func getLoadData() {
        hideLoading()
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.reuseIdentifier)
                as? CartTableViewCell else {
            return UITableViewCell()
        }
        let nft = viewModel.getNft(at: indexPath.row)
        cell.configure(with: nft)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countNftInCart()
    }
}