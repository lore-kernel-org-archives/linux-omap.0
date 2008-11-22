From: Paul Walmsley <paul@pwsan.com>
Subject: MMC oops on BeagleBoard with pm-20081119
Date: Fri, 21 Nov 2008 20:41:11 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0811212036560.28747@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44798 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711AbYKVDlN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 22:41:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com


Hi,

This oops shows up shortly after logging in on BeagleBoard running 
pm-20081119; posting here in case anyone recognizes what's going on.
/ is on a SanDisk SD Plus 4GB MMC card.


- Paul

(none) login: root
Unhandled fault: external abort on non-linefetch (0x1808) at 0xd809c104
Internal error: : 1808 [#1]                                            
Modules linked in:                                                     
CPU: 0    Not tainted  (2.6.27-omap1-00115-g4fa9d04 #334)              
PC is at omap_mmc_request+0x64/0x264                                   
LR is at mmc_wait_for_req+0xf0/0x108                                   
pc : [<c01ee034>]    lr : [<c01e7754>]    psr: a0000013                
sp : c7bd9dd0  ip : c7bd9e20  fp : c7bd9e1c                            
r10: 00000000  r9 : 00000000  r8 : c7964c70                            
r7 : c7bd9e58  r6 : c7bff000  r5 : c7bff000  r4 : c7bff1c0             
r3 : 00200200  r2 : 00000020  r1 : d809c000  r0 : c7bff000             
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel    
Control: 00c5387f  Table: 87bac018  DAC: 00000017                      
Process mmcqd (pid: 282, stack limit = 0xc7bd82e0)                     
Stack: (0xc7bd9dd0 to 0xc7bda000)                                      
9dc0:                                     c7964df0 00000400 c7bd9e2c c7bd9de8 
9de0: c0157604 c0169dd8 00002000 c78c4800 00000000 c7bd9e58 00000000 c7bff000 
9e00: c7bd2800 c7964c70 00000000 00000000 c7bd9e4c c7bd9e20 c01e7754 c01edfdc 
9e20: c7bd9e4c 00000000 c7bd9e28 c7bd9e28 c7bd9ec4 c7bd9ec4 c7964c70 c79748a4 
9e40: c7bd9fb4 c7bd9e50 c01ec90c c01e7670 c79748a0 00000001 c7bd9e6c c7bd9ec4 
9e60: c7bd9e98 c7bd9e24 c01e77e8 00000012 00243dd2 00000000 00000000 00000000 
9e80: 00000000 000000b5 00000000 00000000 c7bd9ec4 c7bd9e58 0000000c 00000000 
9ea0: 00000000 00000000 00000000 00000000 0000049d 00000000 00000000 00000000 
9ec0: c7bd9e58 05f5e100 00000000 00000200 00000020 00000000 00000200 00000000 
9ee0: c7bd9e98 c7bd9e58 00000001 c7973e40 c7964c70 c7964cb4 c7854520 00000000 
9f00: c7bd9f24 c7bd9f10 c0152854 c0165530 c7964c70 c785453c c7bd9f44 c7bd9f28 
9f20: c7bd9f44 c7bd9f30 c0152900 c01514ac c7854520 c7964c70 c7bd9f6c c7bd9f48 
9f40: c015b090 c01528e4 c7bd8000 c7bd44b8 c7854520 00000000 c7964c70 00000001 
9f60: c7bd9f94 c7bd9f70 c015b87c c015afa8 c79748a4 c78dc918 c7bd8000 c79748ac 
9f80: c7964c70 c78dc918 c7bd9fb4 c79748a4 c7964c70 c7bd8000 c79748ac c78dc918 
9fa0: 00000000 00000000 c7bd9fdc c7bd9fb8 c01ed34c c01ec748 c79748a4 c01ed298 
9fc0: 00000000 00000000 00000000 00000000 c7bd9ff4 c7bd9fe0 c0060f1c c01ed2a4 
9fe0: 00000000 00000000 00000000 c7bd9ff8 c0050eb4 c0060ed4 00000000 00000000 
Backtrace:                                                                    
[<c01edfd0>] (omap_mmc_request+0x0/0x264) from [<c01e7754>] 
(mmc_wait_for_req+0xf0/0x108)
[<c01e7664>] (mmc_wait_for_req+0x0/0x108) from [<c01ec90c>] 
(mmc_blk_issue_rq+0x1d0/0x54c)
 r6:c79748a4 r5:c7964c70 r4:c7bd9ec4                                                      
[<c01ec73c>] (mmc_blk_issue_rq+0x0/0x54c) from [<c01ed34c>] 
(mmc_queue_thread+0xb4/0xdc)  
[<c01ed298>] (mmc_queue_thread+0x0/0xdc) from [<c0060f1c>] 
(kthread+0x54/0x80)            
 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c01ed298                              
r4:c79748a4                                                                               
[<c0060ec8>] (kthread+0x0/0x80) from [<c0050eb4>] (do_exit+0x0/0x6b8)                     
 r5:00000000 r4:00000000                                                                  
Code: 0a000076 e593200c e5933008 e1833802 (e5813104)                                      
---[ end trace 973b612179e34ae5 ]---                                                      



