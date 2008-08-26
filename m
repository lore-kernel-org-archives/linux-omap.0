From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: JFFS2 Issue on OMAP5912
Date: Mon, 25 Aug 2008 21:17:13 -0500
Message-ID: <48B367A9.3070200@css-design.us>
References: <20080714203900.06mfu97lp2twssso@webmail.mistralsolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:39911 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753751AbYHZCRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Aug 2008 22:17:15 -0400
In-Reply-To: <20080714203900.06mfu97lp2twssso@webmail.mistralsolutions.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: suresh@mistralsolutions.com
Cc: linux-omap@vger.kernel.org

Suresh,

I had flagged this for follow up and am just now getting around to it.  
Did you resolve this?  We had similar problems and found that a later 
kernel seemed to solve this issue.  However we had another unrelated 
issue and had to revert back until we have more time to address.  Our 
"quick fix" was to move to cramfs with a small partition of JFFS for 
configuration.  This seemed to behave much better and if it failed, we 
would restore it at boot time from a default set of config files. 

Steve

suresh@mistralsolutions.com wrote:
> Hi All,
>
> Our products (based on OMAP5912) use the JFFS2 file system. When we 
> shipped it everything seemed to be working fine. Out of thousands of 
> boards we have shipped some (around 10) have come back to us which 
> seem to have some JFFS2 issues. The kernel log of those boards which 
> have the issue is pasted below. Its taken from one of our boards but 
> other boards also issue similar messages. Some stop at
>
> <SNIP>
> JFFS2 warning: (1) jffs2_do_read_inode_internal: no data nodes found 
> for ino #67
> JFFS2 notice: (1) jffs2_do_read_inode_internal: but it has children so 
> we fake some modes for it
> Warning: unable to open an initial console
> .
> [Then some more JFFS2 warning and notice for other ino #]
> .
> Kernel panic - not syncing: Attempted to kill init!
> </SNIP>
>
> I noted that the data nodes missing are in directories /etc, /bin and 
> /dev.
>
> Some of the boards boot (not till our application) and give the 
> following message
>
> <SNIP>
> Please press Enter to activate this console.
> [And when I press Enter...]
> Node CRC 3f0c112c != calculated CRC c7347649 for node at 05dbece0
> Node CRC 3f0c112c != calculated CRC c7347649 for node at 05dbece
> [and this is recurring]
> </SNIP>
>
> We are using 2.6.16-rc3 and Samsung OneNAND.
>
> There was an issue related to JFFS2 cleanmarkers on the kernel that's 
> running on these boards. The JFFS2 driver did not understand the 
> fragmented OOB of the oneNAND and it always wrote the wrong 
> cleanmarker and read the wrong one during boot (because of which it 
> would erase the blocks once again). We have now fixed it but this fix 
> was not on the boards which have been returned (with these JFFS2 
> issues). Also to write the JFFS2 filesystem instead of using the 
> mkfs.jffs2 and nandwrite tools, designers of these system were using 
> nftl_format and a rsync to copy the file to the JFFS2 partition. We 
> will be fixing this also very soon.
>
> Would the above mentioned factors have been the cause of the issue? If 
> not what else could be leading to these. Please point me in some 
> direction so that I can start debugging this.
>
> Thanks in advance,
>
> Best Regards,
> Suresh
>
> PS:  Some of the boards had very different logs comapred to this one. 
> Please let me know if it would help to send them.
>
> Kernel log follows.....
> -------------------------------
>
> JFFS2 warning: (1) jffs2_do_read_inode_internal: no data nodes found 
> for ino #67
> JFFS2 notice: (1) jffs2_do_read_inode_internal: but it has children so 
> we fake some modes
> for it
> JFFS2 warning: (648) jffs2_do_read_inode_internal: no data nodes found 
> for ino #2
> JFFS2 notice: (648) jffs2_do_read_inode_internal: but it has children 
> so we fake some
> modes for it
> JFFS2 warning: (648) jffs2_do_read_inode_internal: no data nodes found 
> for ino #217
> JFFS2 notice: (648) jffs2_do_read_inode_internal: but it has children 
> so we fake some
> modes for it
> JFFS2 warning: (1) jffs2_do_read_inode_internal: no data nodes found 
> for ino #2
> JFFS2 notice: (1) jffs2_do_read_inode_internal: but it has children so 
> we fake some modes
> for it
> JFFS2 warning: (648) jffs2_do_read_inode_internal: no data nodes found 
> for ino #222
> JFFS2 notice: (648) jffs2_do_read_inode_internal: but it has children 
> so we fake some
> modes for it
> JFFS2 warning: (648) jffs2_do_read_inode_internal: no data nodes found 
> for ino #297
> JFFS2 notice: (648) jffs2_do_read_inode_internal: but it has children 
> so we fake some
> modes for it
> JFFS2 warning: (648) jffs2_do_read_inode_internal: no data nodes found 
> for ino #552
> JFFS2 notice: (648) jffs2_do_read_inode_internal: but it has children 
> so we fake some
> modes for it
> JFFS2 warning: (1) jffs2_do_read_inode_internal: no data nodes found 
> for ino #217
> JFFS2 notice: (1) jffs2_do_read_inode_internal: but it has children so 
> we fake some modes
> for it
> JFFS2 warning: (648) jffs2_do_read_inode_internal: no data nodes found 
> for ino #576
> JFFS2 notice: (648) jffs2_do_read_inode_internal: but it has children 
> so we fake some
> modes for it
> JFFS2 warning: (648) jffs2_do_read_inode_internal: no data nodes found 
> for ino #577
> JFFS2 notice: (648) jffs2_do_read_inode_internal: but it has children 
> so we fake some
> modes for it
> JFFS2 warning: (1) jffs2_do_read_inode_internal: no data nodes found 
> for ino #552
> JFFS2 notice: (1) jffs2_do_read_inode_internal: but it has children so 
> we fake some modes
> for it
> init started:  BusyBox v1.1.2 multi-call binary
> mount: Cannot read /proc/mounts: No such file or directory
> Executing Sys Startup
> Starting RAMDISK: OK
> Executing Board Startup
> JFFS2 warning: (664) jffs2_do_read_inode_internal: no data nodes found 
> for ino #222
> JFFS2 notice: (664) jffs2_do_read_inode_internal: but it has children 
> so we fake some
> modes for it
> Starting loopback: Loading Board Driver... OK
> Unable to handle kernel NULL pointer dereference at virtual address 
> 00000010
> pgd = c1884000
> [00000010] *pgd=11877031, *pte=00000000, *ppte=00000000
> Internal error: Oops: 17 [#1]
> Modules linked in:
> CPU: 0
> PC is at jffs2_truncate_fragtree+0xb8/0xec
> LR is at jffs2_truncate_fragtree+0x24/0xec
> pc : [<c00e947c>]    lr : [<c00e93e8>]    Not tainted
> sp : c1895bfc  ip : 00000000  fp : c1895c1c
> r10: c1d98ae8  r9 : c1f9dd44  r8 : c1c2d800
> r7 : c1f9dd58  r6 : 0000182c  r5 : 00000000  r4 : 00000000
> r3 : 00000000  r2 : 0000182c  r1 : 0000182c  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment user
> Control: 5317F  Table: 11884000  DAC: 00000015
> Process S09board (pid: 670, stack limit = 0xc1894194)
> Stack: (0xc1895bfc to 0xc1896000)
> 5be0:                                                                
> 00000000
> 5c00: c1895c44 00000000 c1d40e58 c1895d14 c1895c9c c1895c20 c00ecdf8 
> c00e93d4
> 5c20: c1895c44 c1895d14 00000001 00000000 c1f7f000 00000000 c1f9dd54 
> c1d98ae8
> 5c40: c1c2d800 00000044 c1d40e58 0000055c 000200d2 00000000 0000055c 
> 00000000
> 5c60: 00000000 00000000 c1d40e58 ffffffeb c033d820 c1f9dd44 c1894000 
> c1895ca8
> 5c80: c1845ae4 c1c2d800 c1c2d8e8 000004ea c1895cf8 c1895ca0 c00ed444 
> c00ebd34
> 5ca0: c1895cac c1895d14 c0023510 00000009 000670e6 c0278d30 c1895ce8 
> c1895cc8
> 5cc0: c0054068 00005401 c0330bc0 c1cbf000 c1f9dd70 c1c2d600 c1d3b915 
> c1845ae4
> 5ce0: c1d3b900 c1f9dd70 000004ea c1895d80 c1895cfc c00f3e74 c00ed27c 
> c1895d3c
> 5d00: c1895d0c c005470c c1c2d800 c1f9dd44 00000000 e0021985 00000044 
> 98f7fb1d
> 5d20: 000004ea 00000009 000081ed 00000000 0000182c 480866e1 47b647e0 
> 480866e1
> 5d40: 00000000 00000000 00000000 00000000 00000000 a024050e c1f9dd70 
> c1c2d600
> 5d60: c1d3b915 c1845ae4 c1d3b900 c1d3fad8 000004ea c1895db0 c1895d84 
> c00e70ac
> 5d80: c00f3e00 00000000 fffffff4 c1845ae4 c1d3fad8 c1d3fb48 c1895efc 
> c1895df8
> 5da0: c1895df0 c1895de0 c1895db4 c0085114 c00e6f80 c02f22a0 00000000 
> c1895efc
> 5dc0: c1d3fad8 c1895e30 00000001 c1895df0 c031800c c1895e2c c1895de4 
> c0085c48
> 5de0: c0085068 c0135d58 c033d820 00000101 c02f22a0 c1c9e324 c4bf50b9 
> 00000006
> 5e00: c0318006 c1894000 c1895efc c0318000 c1895e30 00000001 c1894000 
> c0318000
> 5e20: c1895e90 c1895e30 c00861c0 c0085350 c1c9e514 c02f22a0 c00254f0 
> 00000000
> 5e40: c1885000 00000101 00000001 00000000 c1850e8c c1d42360 c1d42390 
> 00000002
> 5e60: c033d820 c1895f74 00000001 00000000 c038c500 c1894000 c1895efc 
> 00000001
> 5e80: 00000000 c1895ebc c1895e94 c0086508 c0086140 c1895ebc ffffff9c 
> c0318000
> 5ea0: 00000001 c1895efc 000a6a60 c1895fb0 c1895edc c1895ec0 c0086644 
> c008628c
> 5ec0: 00000001 c0318000 000aa3d0 c1895efc c1895ef4 c1895ee0 c00866a8 
> c0086600
> 5ee0: 00000001 00000000 c1895f5c c1895ef8 c008221c c0086694 00000001 
> c1c9e324
> 5f00: c02f22a0 c00254f0 00000000 c1885000 00000101 00000001 00000000 
> c1850e8c
> 5f20: c1d42360 c1d42390 00000002 c033d820 c1895f74 00000001 00000000 
> c038c500
> 5f40: c1c2d200 c0318000 000aa3d0 fffffff4 c1895f84 c1895f60 c0083004 
> c00821fc
> 5f60: c0318000 000aa3d0 c1895fb0 c0318000 c001eea4 000aa3d0 c1895fa4 
> c1895f88
> 5f80: c00233d8 c0082fcc 000a0510 000aa248 00000000 0000000b 00000000 
> c1895fa8
> 5fa0: c001ed00 c00233ac 000a0510 000aa248 000aa058 000a6a60 000aa3d0 
> 000a194c
> 5fc0: 000a0510 000aa248 00000000 000a6a60 000aa058 00000000 000aa3d0 
> ffffffff
> 5fe0: 400adedc be9961c4 00029258 400adee4 20000010 000aa058 400ac314 
> 400ac51c
> Backtrace:
> [<c00e93c4>] (jffs2_truncate_fragtree+0x0/0xec) from [<c00ecdf8>]
> (jffs2_do_read_inode_internal+0x10d4/0x148c)
>  r8 = C1895D14  r7 = C1D40E58  r6 = 00000000  r5 = C1895C44
>  r4 = 00000000
> [<c00ebd24>] (jffs2_do_read_inode_internal+0x0/0x148c) from [<c00ed444>]
> (jffs2_do_read_inode+0x1d8/0x1f4)
> [<c00ed26c>] (jffs2_do_read_inode+0x0/0x1f4) from [<c00f3e74>]
> (jffs2_read_inode+0x84/0x358)
> [<c00f3df0>] (jffs2_read_inode+0x0/0x358) from [<c00e70ac>] 
> (jffs2_lookup+0x13c/0x184)
> [<c00e6f70>] (jffs2_lookup+0x0/0x184) from [<c0085114>] 
> (do_lookup+0xbc/0x170)
> [<c0085058>] (do_lookup+0x0/0x170) from [<c0085c48>] 
> (__link_path_walk+0x908/0xdf0)
> [<c0085340>] (__link_path_walk+0x0/0xdf0) from [<c00861c0>] 
> (link_path_walk+0x90/0x14c)
> [<c0086130>] (link_path_walk+0x0/0x14c) from [<c0086508>] 
> (do_path_lookup+0x28c/0x2ac)
>  r7 = 00000000  r6 = 00000001  r5 = C1895EFC  r4 = C1894000
> [<c008627c>] (do_path_lookup+0x0/0x2ac) from [<c0086644>]
> (__path_lookup_intent_open+0x54/0x94)
> [<c00865f0>] (__path_lookup_intent_open+0x0/0x94) from [<c00866a8>]
> (path_lookup_open+0x24/0x2c)
>  r7 = C1895EFC  r6 = 000AA3D0  r5 = C0318000  r4 = 00000001
> [<c0086684>] (path_lookup_open+0x0/0x2c) from [<c008221c>] 
> (open_exec+0x30/0xe0)
> [<c00821ec>] (open_exec+0x0/0xe0) from [<c0083004>] 
> (do_execve+0x48/0x1cc)
>  r7 = FFFFFFF4  r6 = 000AA3D0  r5 = C0318000  r4 = C1C2D200
> [<c0082fbc>] (do_execve+0x0/0x1cc) from [<c00233d8>] 
> (sys_execve+0x3c/0x5c)
> [<c002339c>] (sys_execve+0x0/0x5c) from [<c001ed00>] 
> (ret_fast_syscall+0x0/0x2c)
>  r7 = 0000000B  r6 = 00000000  r5 = 000AA248  r4 = 000A0510
> Code: e5903008 e3530000 15900008 1afffffb (e5902010)
>  Segmentation fault
> Starting oled:
> Please press Enter to activate this console. <1>Unable to handle 
> kernel NULL pointer
> dereference at virtual address 00000010
> pgd = c0004000
> [00000010] *pgd=00000000
> Internal error: Oops: 17 [#2]
> Modules linked in:
> CPU: 0
> PC is at jffs2_truncate_fragtree+0xb8/0xec
> LR is at jffs2_truncate_fragtree+0x24/0xec
> pc : [<c00e947c>]    lr : [<c00e93e8>]    Not tainted
> sp : c1c89c98  ip : 00000000  fp : c1c89cb8
> r10: c1f57dd8  r9 : c1e3ec00  r8 : c1c2d800
> r7 : c1e3ec14  r6 : 00000226  r5 : 00000000  r4 : 00000000
> r3 : 00000000  r2 : 00000226  r1 : 00000226  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
> Control: 5317F  Table: 11D44000  DAC: 00000017
> Process jffs2_gcd_mtd5 (pid: 648, stack limit = 0xc1c88194)
> Stack: (0xc1c89c98 to 0xc1c8a000)
> 9c80:                                                       00000000 
> c1c89ce0
> 9ca0: 00000000 c00182f4 c1c89d40 c1c89d38 c1c89cbc c00ecdf8 c00e93d4 
> c1c89ce0
> 9cc0: c1c89d40 00000001 00000000 c18f5000 00000000 c1e3ec10 c1f57dd8 
> c1c2d800
> 9ce0: 00000044 c00182f4 00000270 c00ea718 00000000 00000270 00000000 
> c1c2d800
> 9d00: 00000000 c00182f4 c1e3ec00 c1c2d800 c1e3ec00 00000000 c1ccc350 
> c1c2d800
> 9d20: 00000000 00000000 c1c2d800 c1c89da0 c1c89d3c c00ed218 c00ebd34 
> c1c88000
> 9d40: e0021985 00000044 98f7fb1d 000004e2 00000008 000081ff 00000000 
> 00000226
> 9d60: 480866e1 47b64197 480866e1 00000000 00000000 00000000 00000000 
> 00000000
> 9d80: e9016178 c1ccc350 c1c88000 00000000 c1c2d82c c1c89f58 c1c89da4 
> c00f0c38
> 9da0: c00ed1c0 c1c89ee4 c1c89dc8 c1c89db8 c0084d64 c0092bcc fffffffe 
> c1c89e14
> 9dc0: c1c89dcc c0086120 c0084d44 fffffeff fffbffff 00000101 c02f27a0 
> c1c9e704
> 9de0: 01c000e1 00000004 c022e05d c1c88000 c1c89e14 c1c89e00 c0092bd8 
> c0134310
> 9e00: fffffffe c1c89ee4 c1c89e78 c1c89e18 c0086270 c0092bcc c02f56e4 
> c02f27a0
> 9e20: c02edd60 c033d0a8 c1c89fc0 00000101 00000001 00000000 c003ab08 
> c003aa04
> 9e40: 00000000 c033d040 c1c89fb8 c1c89f24 00000001 00000000 c03304e0 
> c1c88000
> 9e60: 00000000 c01edb44 00000000 00000020 c0372493 c1c89e35 c1c89e84 
> c0078aac
> 9e80: c004eb48 fffffffe c1c89ea4 c1c89e98 c0084db0 c0078a78 c1c89ec4 
> c1c89ea8
> 9ea0: c0086678 2708e444 c1c89ed4 c1c89eb8 c0039e54 c0039c94 c02edd60 
> ef9747c6
> 9ec0: 00000001 c02edd60 c1c89f04 c1c89ed8 c1c89ef4 c1c89ee0 c0047988 
> c1ee38f8
> 9ee0: c1c89f5c 00000000 c1c89f08 c1c89f08 c1c89efc c0047d28 c0047c68 
> c1c89f38
> 9f00: c1c89f0c c0048424 c0047d1c 00000000 20000013 c03722e0 c03724d4 
> c1c89f5c
> 9f20: 00000000 00000000 c1c89f44 c1c89f48 20000013 c1c88000 c1c2d800 
> 00000000
> 9f40: 00000000 00000000 00000000 c1c89ff4 c1c89f5c c00f35a4 c00f0abc 
> 00000001
> 9f60: 00000000 00000080 00000000 00000000 00000010 00408002 00400006 
> c033d854
> 9f80: 00034277 c033d948 7b15acc7 00000001 c1c89fc0 00000020 00000000 
> 00000000
> 9fa0: 00000000 c1c89fb0 c001ed84 c003a2c4 00000000 c1c2d800 c00f3488 
> c0040210
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
> 00000000
> 9fe0: 00000000 00000000 00000000 c1c89ff8 c0040210 c00f3498 ffff6fba 
> ffffdfff
> Backtrace:
> [<c00e93c4>] (jffs2_truncate_fragtree+0x0/0xec) from [<c00ecdf8>]
> (jffs2_do_read_inode_internal+0x10d4/0x148c)
>  r8 = C1C89D40  r7 = C00182F4  r6 = 00000000  r5 = C1C89CE0
>  r4 = 00000000
> [<c00ebd24>] (jffs2_do_read_inode_internal+0x0/0x148c) from [<c00ed218>]
> (jffs2_do_crccheck_inode+0x68/0xbc)
> [<c00ed1b0>] (jffs2_do_crccheck_inode+0x0/0xbc) from [<c00f0c38>]
> (jffs2_garbage_collect_pass+0x18c/0x1884)
>  r7 = C1C2D82C  r6 = 00000000  r5 = C1C88000  r4 = C1CCC350
> [<c00f0aac>] (jffs2_garbage_collect_pass+0x0/0x1884) from [<c00f35a4>]
> (jffs2_garbage_collect_thread+0x11c/0x144)
> [<c00f3488>] (jffs2_garbage_collect_thread+0x0/0x144) from [<c0040210>]
> (do_exit+0x0/0x770)
>  r6 = 00000000  r5 = 00000000  r4 = 00000000
> Code: e5903008 e3530000 15900008 1afffffb (e5902010)
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

