package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import util.DBUtil;

public class CommonDao {
	/**
	 * 执行数据库的增删改操作
	 */
	public int executeUpdate(String sql, Object... values) {
		/*
		 * 1、连接数据库 2、创建适配器 3、给占位符赋值 4、发送SQL语句 5、释放资源
		 */
		Connection conn = null;
		PreparedStatement pstm = null;
		try {
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement(sql);
			// 给占位符
			if (values != null && values.length > 0) {
				for (int i = 0; i < values.length; i++) {
					pstm.setObject(i + 1, values[i]);
				}
			}
			int i = pstm.executeUpdate();
			return i;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(null, pstm, conn);
		}
		return -1;
	}

	/**
	 * 执行查询
	 * 
	 * @param sql
	 * @param values
	 * @return
	 */
	public List<Map<String, Object>> executeQuery(String sql, Object... values) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstm = null;
		try {
			conn = DBUtil.getConnection();
			pstm = conn.prepareStatement(sql);
			// 非空验证
			if (values != null && values.length > 0) {
				for (int i = 0; i < values.length; i++) {
					pstm.setObject(i + 1, values[i]);
				}
			}
			rs = pstm.executeQuery();
			// 元数据:描述性的数据，说明书
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			while (rs.next()) {
				// 防止资源浪费
				Map<String, Object> map = new HashMap<String, Object>(columnCount);
				for (int i = 0; i < columnCount; i++) {
					// getColumnLabel()获取的是结果集中列的名称，
					// 如果给列定义了别名，则获得别名
					// getColumnName:始终获取真实列名
					// 获取列名
					String columnName = rsmd.getColumnLabel(i + 1);
					// 获取列的值
					Object obj = rs.getObject(i + 1);
					// 将每一列的值保存到map容器
					map.put(columnName, obj);
				}
				list.add(map);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, pstm, conn);
		}
		return null;
	}
}
