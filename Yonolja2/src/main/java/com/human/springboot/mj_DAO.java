package com.human.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface mj_DAO {
	
	void addData(String name, String data);
	void deleteData(String name, String data);
	void updateData(String name, String data);
	ArrayList<mj_DTO> getData();
	
	
	ArrayList<mj_bookDTO> getBooks(int room_seq);
	
}
