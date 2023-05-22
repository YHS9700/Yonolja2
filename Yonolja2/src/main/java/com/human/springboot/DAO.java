package com.human.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DAO {
	ArrayList<DTO> test();
	void insert(String x1, String x2);
}
