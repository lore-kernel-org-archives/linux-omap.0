From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Sat, 08 Nov 2008 09:52:22 +0200 (EET)
Message-ID: <20081108.095222.170326950.Hiroshi.DOYU@nokia.com>
References: <E1KyhT7-0002fS-6K@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:51938 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbYKHHwb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Nov 2008 02:52:31 -0500
In-Reply-To: <E1KyhT7-0002fS-6K@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rick@efn.org
Cc: linux-omap@vger.kernel.org

Hi Rick,

From: "ext Rick Bronson" <rick@efn.org>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Fri, 07 Nov 2008 22:38:49 -0800

>   Here is the output from
> 
> sudo modprobe bridgedriver base_img=ddspbase_tiomap3430.dof64P GT_str="**=01234567" 
> 
> http://www.efn.org/~rick/pub/dsp.txt

For me, the following part looks suspicious.

544  KF - 0: KFILE_Open: pszFileName ddspbase_tiomap3430.dof64P, pszMode rb          
545  MM - 0: MEM_Calloc: cBytes 0x20 type 0x1                                        
546  MM - 0: MEM_Free: pMemBufs 0xc68ca1b8                                           
547  KF - 0: KFILE_Tell: hFile 0x0                                                   
548  KF - 0: KFILE_Seek:invalid file handle                                          
                        ^^^^^^^^^^^^^^^^^^^^
549  KF - 0: KFILE_Seek: hFile 0x0, lOffset 0x0, cOrigin 0x0                         
550  KF - 0: KFILE_Seek:invalid file handle                                          
551  MM - 0: MEM_Calloc: cBytes 0x14 type 0x0                                        
552  MM - 0: MEM_Calloc: cBytes 0x34c        type 0x0                                
553  KF - 0: KFILE_Read: buffer 0xc6889a3c, cSize 0x1,cCount 0x38, hFile 0x0         
554  KF - 0: KFILE_Read: invalid file handle                                         
                         ^^^^^^^^^^^^^^^^^^^
555  DL - 0: Error reading File Headers from input stream                            
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
556  DL - 0: DBLL_open: Dynamic_Load_Module failed: 0x1                              
557  DL - 0: DBLL_close: lib: 0xc68879d8                                             

It seems to have failed to open a file, "ddspbase_tiomap3430.dof64P".

   Hiroshi DOYU
