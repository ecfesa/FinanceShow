package com.FS.FinanceShow_demo.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "category")
public class Category{

    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name= "NAME", nullable = false, unique = true)
    private String name;

    @ManyToOne
    @JoinColumn(name = "USER_FOREING_KEY", nullable = false)
    private User user;

    public Category(){}

    public Category(Long id, String name){
        this.id = id;
        this.name = name;
    }

    public Long getId(){
        return this.id;
    }

    public void setId(Long id){
        this.id = id;
    }

    public String getName(){
        return this.name;
    }

    public void setName(String name){
        this.name = name;
    }

    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}

