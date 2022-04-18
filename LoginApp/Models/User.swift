//
//  User.swift
//  LoginApp
//
//  Created by Nasim Nozirov on 16.04.2022.
//

import Foundation

struct User {
    let userName: String
    let password: String
    let person: Person
    
    static func getUser() -> User {
        User(
            userName: "Nas",
            password: "ppp",
            person: Person(
                name: "Nasim",
                surName: "Nozirov",
                image: "iAm",
                aboutMe: """
    Привет, привет! мне 23! работаю Бариста и тренером по кофе. В ноябре я понял, что хочу стать разработчиком и вот после долгое раздумья, решил стать ios разработчиком. Я родом из Душанбе, сюда приехал на обучение в Универе.
    Мое хобби - это спорт и кофе ( правда на данный момент это толко уроки  в swiftBook 🤓)
    Приятно было с вами познакомиться! до встречи.
    """
            )
        )
    }
}

struct Person {
    let name: String
    let surName: String
    let image: String
    let aboutMe: String
    
    var fullName: String {
        "\(name) \(surName)"
    }
}
