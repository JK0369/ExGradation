//
//  ViewController.swift
//  ExGradation
//
//  Created by 김종권 on 2024/07/21.
//

import UIKit

class ViewController: UIViewController {
    private let topGradientView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isUserInteractionEnabled = false
        return v
    }()
    private lazy var topGradientLayer = {
        let layer = CAGradientLayer()
        let color = UIColor.white
        layer.colors = [
            color,
            color.withAlphaComponent(0.4),
            color.withAlphaComponent(0.7),
            color.withAlphaComponent(0.0),
        ].map(\.cgColor)
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        return layer
    }()
    private lazy var tableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        t.dataSource = self
        return t
    }()
    
    private let items = (0...100).map(String.init)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTopGradient()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topGradientLayer.frame = topGradientView.bounds
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTopGradient() {
        guard !view.subviews.contains(topGradientView) else { return }
        view.addSubview(topGradientView)
        view.bringSubviewToFront(topGradientView)
        topGradientView.layer.addSublayer(topGradientLayer)
        
        NSLayoutConstraint.activate([
            topGradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topGradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topGradientView.topAnchor.constraint(equalTo: tableView.topAnchor),
            topGradientView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        items.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}
