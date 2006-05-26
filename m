From: Eduardo Gallofin <egallofin@yahoo.com>
Subject: Kernel panics on OSK5912
Date: Thu, 25 May 2006 23:32:40 -0700 (PDT)
Message-ID: <20060526063240.84781.qmail@web52306.mail.yahoo.com>
References: <20060525233101.8F65E8062E@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060525233101.8F65E8062E@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi, 

  I got a problem with the 2.6.16 kernel running on my
OSK. It panics after (or when) running init. I'm not
sure what the problem is and MontaVista's kernel works
fine with my rootfs.

  The same kernel and rootfs, however, works with our
other OSK5912 board.... 

 Here's the log and backtrace of the problem.
Appreciate your help on this.

------------------

IP-Config: Got DHCP answer from 0.0.0.0, my address is
157.184.66.207
IP-Config: Complete:
      device=eth0, addr=157.184.66.207,
mask=255.255.255.0, gw=157.184.66.1,
     host=dhcp-826-16, domain=lrdc.lexmark.com,
nis-domain=(none),
     bootserver=0.0.0.0, rootserver=157.184.66.135,
rootpath=
Looking up port of RPC 100003/2 on 157.184.66.135
Looking up port of RPC 100005/1 on 157.184.66.135
VFS: Mounted root (nfs filesystem).
Freeing init memory: 116K
Unable to handle kernel paging request at virtual
address ae2b4c35
pgd = c0004000
[ae2b4c35] *pgd=00000000
Internal error: Oops: 1 [#1]
Modules linked in:
CPU: 0
PC is at __wake_up_common+0x28/0x7c
LR is at 0xae2b4c35
pc : [<c003d610>]    lr : [<ae2b4c35>]    Not tainted
sp : c1d49e00  ip : c1d49e2c  fp : c1d49e28
r10: 00000003  r9 : c1d49e44  r8 : 00000000
r7 : c0374580  r6 : c1d8f4e0  r5 : c0000070  r4 :
00000001
r3 : 00000000  r2 : 00000001  r1 : 00000003  r0 :
c0000070
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  Segment
kernel
Control: 5317F  Table: 10004000  DAC: 00000017
Process rpciod/0 (pid: 704, stack limit = 0xc1d48198)
Stack: (0xc1d49e00 to 0xc1d4a000)
9e00: 80000013 00000000 c1d8f4e0 c0374580 c03746c0
00000000 00001000 c1d49e40
9e20: c1d49e2c c003d690 c003d5f8 c1d49e44 c02ba180
c1d49e58 c1d49e44 c0055d8c
9e40: c003d674 c02ba180 00000000 c1d49e6c c1d49e5c
c005fbbc c0055d60 c1d8f4e0
9e60: c1d49e9c c1d49e70 c00c75b8 c005fb80 c1d49ee4
c1d49ea0 c1d49e84 c1d8f4e0
9e80: 00000000 c02ba180 c0374580 c03746c0 c1d49ec4
c1d49ea0 c00c7e8c c00c75ac
9ea0: c0374580 c0374584 c03746ec 00001000 c03746d0
00000000 c1d49ee8 c1d49ec8
9ec0: c00c7f78 c00c7d90 00000000 c0374580 00001000
00000000 c0374584 c1d49f0c
9ee0: c1d49eec c00c6f00 c00c7eb4 c0374584 20000013
00000000 c03745ec c1d79da0
9f00: c1d49f20 c1d49f10 c01cd66c c00c6e9c c0374584
c1d49f40 c1d49f24 c01cd74c
9f20: c01cd648 c1d79da0 20000013 c01cd928 c1d79da8
c1d49f50 c1d49f44 c01cd938
9f40: c01cd6c8 c1d49f70 c1d49f54 c0051bac c01cd938
c1d79db0 c1d79da8 c1d49f90
9f60: 00000001 c1d49fc4 c1d49f74 c0051d18 c0051b08
ffffffff ffffffff 00000001
9f80: 00000000 c003d5d0 00010000 00000000 00000000
c0320580 c003d5d0 00100100
9fa0: 00200200 c1d48000 c02e1da0 c1d79da0 c0051c04
fffffffc c1d49ff4 c1d49fc8
9fc0: c00557c4 c0051c14 00000001 ffffffff ffffffff
00000000 00000000 00000000
9fe0: 00000000 00000000 00000000 c1d49ff8 c0043800
c0055748 00000000 00000000
Backtrace:
[<c003d5e8>] (__wake_up_common+0x0/0x7c) from
[<c003d690>] (__wake_up+0x2c/0x34)
[<c003d664>] (__wake_up+0x0/0x34) from [<c0055d8c>]
(__wake_up_bit+0x3c/0x40)
 r4 = C02BA180
[<c0055d50>] (__wake_up_bit+0x0/0x40) from
[<c005fbbc>] (unlock_page+0x4c/0x58)
[<c005fb70>] (unlock_page+0x0/0x58) from [<c00c75b8>]
(nfs_readpage_release+0x1c/0xa0)
 r4 = C1D8F4E0
[<c00c759c>] (nfs_readpage_release+0x0/0xa0) from
[<c00c7e8c>] (nfs_readpage_result_full+0x10c/0x124)
 r8 = C03746C0  r7 = C0374580  r6 = C02BA180  r5 =
00000000
 r4 = C1D8F4E0
[<c00c7d80>] (nfs_readpage_result_full+0x0/0x124) from
[<c00c7f78>] (nfs_readpage_result+0xd4/0xe0)
[<c00c7ea4>] (nfs_readpage_result+0x0/0xe0) from
[<c00c6f00>] (nfs_read_done+0x74/0x78)
 r8 = C0374584  r7 = 00000000  r6 = 00001000  r5 =
C0374580
 r4 = 00000000
[<c00c6e8c>] (nfs_read_done+0x0/0x78) from
[<c01cd66c>] (rpc_exit_task+0x34/0x80)
 r8 = C1D79DA0  r7 = C03745EC  r6 = 00000000  r5 =
20000013
 r4 = C0374584
[<c01cd638>] (rpc_exit_task+0x0/0x80) from
[<c01cd74c>] (__rpc_execute+0x94/0x224)
 r4 = C0374584
[<c01cd6b8>] (__rpc_execute+0x0/0x224) from
[<c01cd938>] (rpc_async_schedule+0x10/0x14)
 r7 = C1D79DA8  r6 = C01CD928  r5 = 20000013  r4 =
C1D79DA0
[<c01cd928>] (rpc_async_schedule+0x0/0x14) from
[<c0051bac>] (run_workqueue+0xb4/0x10c)
[<c0051af8>] (run_workqueue+0x0/0x10c) from
[<c0051d18>] (worker_thread+0x114/0x168)
 r7 = 00000001  r6 = C1D49F90  r5 = C1D79DA8  r4 =
C1D79DB0
[<c0051c04>] (worker_thread+0x0/0x168) from
[<c00557c4>] (kthread+0x8c/0xb8)
 r8 = FFFFFFFC  r7 = C0051C04  r6 = C1D79DA0  r5 =
C02E1DA0
 r4 = C1D48000
[<c0055738>] (kthread+0x0/0xb8) from [<c0043800>]
(do_exit+0x0/0x38c)
 r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 =
00000000
 r4 = 00000000
Code: e1a0a001 e1a04002 e1a08003 e59b9004 (e59e7000)


------------


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
