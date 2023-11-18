import UIKit

final class CurrencyScreenViewController: UIViewController {
    private let viewModel: CurrencyViewModel

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.backwardPicTitle), for: .normal)
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var currencyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.allowsMultipleSelection = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CurrencyCollectionViewCell.self,
                                forCellWithReuseIdentifier: CurrencyCollectionViewCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var agreementLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .textOnSecondary
        label.text = Constants.cartUserAgreementText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var agreementLinkButton: UIButton = {
       let button = UIButton()
        button.setTitle(Constants.cartUserAgreementLinkText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.setTitleColor(.yaBlue, for: .normal)
        button.addTarget(self, action: #selector(tapUserAgreementLink), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var userAgreementStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.addArrangedSubview(agreementLabel)
        stackView.addArrangedSubview(agreementLinkButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var paymentButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 16
        button.setTitle(Constants.paimentConfirmButtonText, for: .normal)
        button.setTitleColor(.textOnPrimary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(tapPayButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var paymentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.addArrangedSubview(userAgreementStackView)
        stackView.addArrangedSubview(paymentButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var paymentContainView: UIView = {
       let view = UIView()
        view.backgroundColor = .segmentInactive
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createSubviews()
    }

    @objc
    private func tapBackButton() {
        dismiss(animated: true)
    }

    @objc
    private func tapUserAgreementLink() {
    }

    @objc
    private func tapPayButton() {
    }
}

extension CurrencyScreenViewController {
    private func createSubviews() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backButton)]
        navigationItem.title = Constants.paimentTypeText
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 17, weight: .bold),
            .foregroundColor: UIColor.textPrimary
        ]
        addCurrencyCollectionView()
        addPaymentContainView()
        addAgreementStackView()
    }

    private func addCurrencyCollectionView() {
        view.addSubview(currencyCollectionView)
        NSLayoutConstraint.activate([
            currencyCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            currencyCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            currencyCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            ])
    }

    private func addPaymentContainView() {
        view.addSubview(paymentContainView)
        NSLayoutConstraint.activate([
            paymentContainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentContainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paymentContainView.topAnchor.constraint(equalTo: currencyCollectionView.bottomAnchor),
            paymentContainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }

    private func addAgreementStackView() {
        paymentContainView.addSubview(paymentStackView)
        NSLayoutConstraint.activate([
            paymentStackView.leadingAnchor.constraint(equalTo: paymentContainView.leadingAnchor, constant: 16),
            paymentStackView.trailingAnchor.constraint(equalTo: paymentContainView.trailingAnchor, constant: -16),
            paymentStackView.topAnchor.constraint(equalTo: paymentContainView.topAnchor, constant: 16),
            paymentStackView.bottomAnchor.constraint(equalTo: paymentContainView.bottomAnchor, constant: -16),
            paymentButton.heightAnchor.constraint(equalToConstant: 60)
            ])
    }
}

extension CurrencyScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension CurrencyScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.currencies.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCollectionViewCell.reuseIdentifier,
                                                      for: indexPath)
        guard let currencyCell = cell as? CurrencyCollectionViewCell else {
            return UICollectionViewCell()
        }
        let currency = viewModel.currencies[indexPath.row]
        currencyCell.configure(with: currency)
        return currencyCell
    }
}

extension CurrencyScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        7
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        7
    }
}