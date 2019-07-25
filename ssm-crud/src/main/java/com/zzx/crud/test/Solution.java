package com.zzx.crud.test;

import java.util.ArrayList;
import java.util.Arrays;

public class Solution {
	
	public static void main(String[] args) {
		Solution s = new Solution();
		int[] pre = {1,2,4,7};
		int[] in = {4,7,2,1};
		TreeNode result = s.reConstructBinaryTree(pre,in);
		System.out.println(result.toString());

	}
    public TreeNode reConstructBinaryTree(int [] pre,int [] in) {
        if(pre.length==0&&in.length==0)
            return null;
        TreeNode result = new TreeNode(pre[0]);
        int index = indexOfRoot(in,pre[0]);

        result.left = reConstructBinaryTree(
            Arrays.copyOfRange(pre,1,index+1),
            Arrays.copyOfRange(in,0,index));
        
        result.right = reConstructBinaryTree(
            Arrays.copyOfRange(pre,index+1,pre.length),
            Arrays.copyOfRange(in,index+1,in.length));
        
        return result;
    }
    
    public int indexOfRoot(int[] in,int key){
        for(int i=0;i<in.length;i++){
            if(in[i]==key)
                return i;
        }
        return -1;
    }
}

class TreeNode {
	      int val;
	      TreeNode left;
	      TreeNode right;
	      TreeNode(int x) { val = x; }
	  }
	


