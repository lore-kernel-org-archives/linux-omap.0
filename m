From: CF Adad <cfadad@rocketmail.com>
Subject: Problems in the DaVinci EMAC driver & AM35xx?
Date: Wed, 13 Jun 2012 15:38:52 -0700 (PDT)
Message-ID: <1339627132.52592.YahooMailNeo@web125204.mail.ne1.yahoo.com>
Reply-To: CF Adad <cfadad@rocketmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm29-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.43]:48957 "HELO
	nm29-vm0.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752650Ab2FMWiy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 18:38:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

All,

I believe I may have uncovered a problem in the DaVinci EMAC driver as =
it is used on the AM35xx. I suspect this is likely related to the slab =
crashing I reported here (http://thread.gmane.org/gmane.linux.ports.arm=
=2Eomap/78039/). Your help and thoughts on this would be greatly apprec=
iated.
and=20
*A QUICK BACKSTORY:*

We've been working with AM3517 modules (CM-T3517 and TAM3517) for about=
 6 months now, and in that time have tried many different versions of O=
S software. We started with the 2.6.37 kernel supported by TI's PSP and=
 quickly migrated through 3.2, 3.3, 3.4, and as of yeterday, 3.5rc1. In=
 that same time, we've tried several versions of both bootloaders as we=
ll. One consistent factor we've noticed is a relatively odd DaVinci EMA=
C performance issue. Using just basic iperf ("iperf -s" on one side, "i=
perf -c <IP>" on the other), we noted that whenever we used our DaVinci=
 EMAC port on the AM3517, we saw poor performance when connecting AM351=
7 EMAC <=3D> AM3517 EMAC, but great performance when connecting the EMA=
C to another, non-EMAC Ethernet device. Here is a real example capture:

------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
{{ DaVinci EMAC server, PC client }}


[=A0 4] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44452
[ ID] Interval=A0=A0=A0=A0=A0=A0 Transfer=A0=A0=A0=A0 Bandwidth
[=A0 4]=A0 0.0-10.1 sec=A0=A0=A0 114 MBytes=A0 94.1 Mbits/sec
[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44459
[=A0 5]=A0 0.0-10.1 sec=A0=A0=A0 114 MBytes=A0 94.0 Mbits/sec
[=A0 4] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44467
[=A0 4]=A0 0.0-10.1 sec=A0=A0=A0 113 MBytes=A0 94.1 Mbits/sec
[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44474
[=A0 5]=A0 0.0-10.1 sec=A0=A0=A0 114 MBytes=A0 94.1 Mbits/sec
[=A0 4] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44481
[=A0 4]=A0 0.0-10.1 sec=A0=A0=A0 114 MBytes=A0 94.1 Mbits/sec
[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.40 port =
44488
[=A0 5]=A0 0.0- 9.8 sec=A0=A0=A0 110 MBytes=A0 94.1 Mbits/sec

{{ same DaVinci EMAC server, still running, just changed to DaVinci EMA=
C client }}

[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.74 port =
37325
[=A0 5]=A0 0.0-10.4 sec=A0 73.9 MBytes=A0 59.6 Mbits/sec
[=A0 6] local 192.168.2.192 port 5001 connected with 192.168.2.74 port =
37326
[=A0 6]=A0 0.0-10.8 sec=A0 61.5 MBytes=A0 47.8 Mbits/sec
[=A0 5] local 192.168.2.192 port 5001 connected with 192.168.2.74 port =
37327
[=A0 5]=A0 0.0-10.3 sec=A0 64.6 MBytes=A0 52.6 Mbits/sec
[=A0 6] local 192.168.2.192 port 5001 connected with 192.168.2.74 port =
37328
[=A0 6]=A0 0.0-10.0 sec=A0 78.2 MBytes=A0 65.5 Mbits/sec

See how the data rates drop from high 80s - 90s+ Mbps down into the 50s=
+ Mbps?=A0 Despite that data rate slowdown, we only show having dropped=
 1 packet. There are no errors or xruns reported. We've long been frust=
rated by this, but not having time to invest in it, we were willing to =
accept the slower performance for the time being. As we upgraded versio=
ns of Linux, we hoped that perhaps it would simply get better. Unfortun=
ately it did not.

*NOW FOR THE "BUG"?:*

Several months ago, we started seeing that slab error that is being dis=
cussed on this list (http://thread.gmane.org/gmane.linux.ports.arm.omap=
/78039/). The error was generic enough that we could not put our finger=
 on it. We could not figure out a way of reliably reproducing it. We as=
sumed something in our software immediately, and spent the last several=
 months constantly updating our BSP to include the latest bootloaders a=
nd Linux sources. However, that never made it go away. It was a very sp=
oradic error. Some days the boards would crash constantly with it, and =
then mysteriously weeks would pass without incident. Right when we star=
ted to think our latest kernel update had killed it, it would come roar=
ing back

Last week was one of those weeks where the issues came roaring back. Si=
nce they coincided with us enabling the EMAC from within u-boot, we tur=
ned our attention to the EMAC immediately and started running constant =
iperf loop tests against it. For a while, it seemed it could create the=
 slab error relatively easily, but then as fast as it came, it disappea=
red again.

Today I was running a combination test of iperf and the stress utility =
(http://weather.ou.edu/~apw/projects/stress/), and even with relatively=
 mild stress loads I was seeing other memory allocation crashes being b=
lamed on the EMAC. (For those that have read the other thread, my SMSC =
LAN911x port has been disabled in the bootloaders and kernel for these =
tests. So, it cannot play a role here.)=A0 We saw several errors on two=
 different platforms and across both the 3.4rc6 and 3.5rc1 kernels. All=
 the different errors are reported below.=20

I'm definitely not a Linux memory management expert, but it's looking l=
ike the Davinci EMAC driver, at least as it pertains to the AM35xx plat=
form, may be malfunctioning a bit???=A0 I can provide any additional in=
formation that you all would find helpful.

Our tests are simple:
=46or iperf: One side does "iperf -s" or "iperf -s -D" if running in th=
e back ground is desired, while the other side runs "iperf -c <IP of se=
rver>".=A0 We are looping them in a script like:

1.=A0 #!/bin/sh
2.=A0 set -x
3.=A0 while [ 1 ]
4.=A0 do
5. =A0 =A0 iperf -c <IP>
6. =A0 =A0 sleep 1
7.=A0 done

=46or stress:=A0 We're running the command lines you see (such as "stre=
ss --cpu 8 --io 4 --vm 1 --vm-bytes 150M --hdd 2 --hdd-bytes 150M --tim=
eout 60s").=A0 We're also running those in a script just like above, wi=
th the stress line replacing line #5 obviously.


THANKS IN ADVANCE!!!


*CRASHES AND DUMPS:*

This one happened on BOTH Linux 3.4rc6 and 3.5rc1. You can see the stre=
ss command for this particular error there. We eventually eased that ba=
ck to:
"stress --cpu 8 --io 4 --vm 1 --vm-bytes 150M --hdd 2 --hdd-bytes 150M =
--timeout 60s".
-----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-------------------------

+ /home/root/stress --cpu 24 --io 10 --vm 9 --vm-bytes 25M --hdd 2 --hd=
d-bytes 150M --timeout 60
stress: info: [21812] dispatching hogs: 24 cpu, 10 io, 9 vm, 2 hdd
[61010.621826] stress: page allocation failure: order:0, mode:0x120
[61010.628173] Backtrace:
[61010.630767] [<c0011d6c>] (dump_backtrace+0x0/0x114) from [<c039cb8c>=
] (dump_stack+0x20/0x24)
[61010.639648]=A0 r6:cd9fc000 r5:00000000 r4:00000120 r3:c052fed8
[61010.645599] [<c039cb6c>] (dump_stack+0x0/0x24) from [<c009c304>] (wa=
rn_alloc_failed+0xd8/0x11c)
[61010.654754] [<c009c22c>] (warn_alloc_failed+0x0/0x11c) from [<c009e9=
18>] (__alloc_pages_nodemask+0x508/0x678)
[61010.665161]=A0 r3:cd9fdcf4 r2:00000000
[61010.668914]=A0 r7:c051ef60 r6:00000000 r5:00000000 r4:00000120
[61010.674896] [<c009e410>] (__alloc_pages_nodemask+0x0/0x678) from [<c=
0309458>] (netdev_alloc_frag+0xa4/0xdc)
[61010.685119] [<c03093b4>] (netdev_alloc_frag+0x0/0xdc) from [<c030a42=
8>] (__netdev_alloc_skb+0x78/0xd0)
[61010.694885]=A0 r7:00000000 r6:7b4c2a43 r5:cfa50000 r4:00000700
[61010.700866] [<c030a3b0>] (__netdev_alloc_skb+0x0/0xd0) from [<c02a07=
70>] (emac_rx_alloc+0x28/0x64)
[61010.710266]=A0 r6:7b4c2a43 r5:cd95e300 r4:cfa50000 r3:cfa50440
[61010.716217] [<c02a0748>] (emac_rx_alloc+0x0/0x64) from [<c02a1670>] =
(emac_rx_handler+0x74/0x11c)
[61010.725463]=A0 r4:cfa50000 r3:059e8859
[61010.729217] [<c02a15fc>] (emac_rx_handler+0x0/0x11c) from [<c02a2968=
>] (__cpdma_chan_free+0xc8/0xe0)
[61010.738830]=A0 r6:cfa6f5c0 r5:60000113 r4:cfa5bac0
[61010.743682] [<c02a28a0>] (__cpdma_chan_free+0x0/0xe0) from [<c02a2a4=
c>] (__cpdma_chan_process+0xcc/0x104)
[61010.753723] [<c02a2980>] (__cpdma_chan_process+0x0/0x104) from [<c02=
a35b8>] (cpdma_chan_process+0x4c/0x64)
[61010.763885]=A0 r7:00000040 r6:00000040 r5:cfa6f5c0 r4:00000000
[61010.769836] [<c02a356c>] (cpdma_chan_process+0x0/0x64) from [<c02a1b=
44>] (emac_poll+0x9c/0x208)
[61010.778961]=A0 r6:00000001 r5:00000001 r4:cfa5044c r3:00000001
[61010.784912] [<c02a1aa8>] (emac_poll+0x0/0x208) from [<c0314340>] (ne=
t_rx_action+0xb0/0x1a8)
[61010.793701]=A0 r8:c0531130 r7:0000012c r6:00000040 r5:00000001 r4:cf=
a5044c
[61010.793701] r3:c02a1aa8
[61010.803314] [<c0314290>] (net_rx_action+0x0/0x1a8) from [<c0035778>]=
 (__do_softirq+0xb0/0x1d8)
[61010.812347] [<c00356c8>] (__do_softirq+0x0/0x1d8) from [<c0035c7c>] =
(irq_exit+0x8c/0x94)
[61010.820861] [<c0035bf0>] (irq_exit+0x0/0x94) from [<c000f010>] (hand=
le_IRQ+0x44/0x94)
[61010.829101]=A0 r4:c05499b8 r3:c00764a4
[61010.832855] [<c000efcc>] (handle_IRQ+0x0/0x94) from [<c00085b4>] (om=
ap3_intc_handle_irq+0x68/0x78)
[61010.842285]=A0 r6:c055cbbc r5:cd9fdfb0 r4:fa200000 r3:00000044
[61010.848236] [<c000854c>] (omap3_intc_handle_irq+0x0/0x78) from [<c00=
0e480>] (__irq_usr+0x40/0x60)
[61010.857543] Exception stack(0xcd9fdfb0 to 0xcd9fdff8)
[61010.862854] dfa0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 b6e474c0 0000=
0000 00000001 00000000
[61010.871459] dfc0: 00000000 00000000 0000e538 0000e530 0000000e 0000e=
478 00000014 00000000
[61010.880035] dfe0: 0000e4a8 befbbb58 00008adc b6d4d71c 60000010 fffff=
fff
[61010.886993]=A0 r7:0000e530 r6:ffffffff r5:60000010 r4:b6d4d71c
[61010.892913] Mem-info:
[61010.895324] Normal per-cpu:
[61010.898254] CPU=A0=A0=A0 0: hi:=A0=A0 90, btch:=A0 15 usd:=A0 10
[61010.903289] active_anon:57090 inactive_anon:60 isolated_anon:0
[61010.903289]=A0 active_file:853 inactive_file:324 isolated_file:0
[61010.903289]=A0 unevictable:0 dirty:0 writeback:0 unstable:0
[61010.903289]=A0 free:2251 slab_reclaimable:679 slab_unreclaimable:692
[61010.903289]=A0 mapped:245 shmem:77 pagetables:350 bounce:0
[61010.933258] Normal free:9004kB min:2028kB low:2532kB high:3040kB act=
ive_anon:228360kB inactive_anon:240kB active_file:3412kB inacto
[61010.974212] lowmem_reserve[]: 0 0 0
[61010.977905] Normal: 1589*4kB 331*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*=
256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 9004kB
[61010.989044] 1254 total pagecache pages
[61011.003723] 65536 pages of RAM
[61011.006927] 2574 free pages
[61011.009857] 2234 reserved pages
[61011.013153] 1371 slab pages
[61011.016082] 4367 pages shared
[61011.019195] 0 pages swap cached
[61011.022613] ------------[ cut here ]------------
[61011.027557] WARNING: at drivers/net/ethernet/ti/davinci_emac.c:997 e=
mac_rx_alloc+0x5c/0x64()
[61011.036437] Modules linked in:
[61011.039642] Backtrace:
[61011.042236] [<c0011d6c>] (dump_backtrace+0x0/0x114) from [<c039cb8c>=
] (dump_stack+0x20/0x24)
[61011.051147]=A0 r6:c02a07a4 r5:00000009 r4:00000000 r3:c052fed8
[61011.057098] [<c039cb6c>] (dump_stack+0x0/0x24) from [<c002eb3c>] (wa=
rn_slowpath_common+0x5c/0x74)
[61011.066467] [<c002eae0>] (warn_slowpath_common+0x0/0x74) from [<c002=
eb80>] (warn_slowpath_null+0x2c/0x34)
[61011.076538]=A0 r8:0000003c r7:00000000 r6:7b4c2a43 r5:cd95e300 r4:00=
000000
[61011.076538] r3:00000009
[61011.086151] [<c002eb54>] (warn_slowpath_null+0x0/0x34) from [<c02a07=
a4>] (emac_rx_alloc+0x5c/0x64)
[61011.095611] [<c02a0748>] (emac_rx_alloc+0x0/0x64) from [<c02a1670>] =
(emac_rx_handler+0x74/0x11c)
[61011.104858]=A0 r4:cfa50000 r3:059e8859
[61011.108642] [<c02a15fc>] (emac_rx_handler+0x0/0x11c) from [<c02a2968=
>] (__cpdma_chan_free+0xc8/0xe0)
[61011.118255]=A0 r6:cfa6f5c0 r5:60000113 r4:cfa5bac0
[61011.123138] [<c02a28a0>] (__cpdma_chan_free+0x0/0xe0) from [<c02a2a4=
c>] (__cpdma_chan_process+0xcc/0x104)
[61011.133239] [<c02a2980>] (__cpdma_chan_process+0x0/0x104) from [<c02=
a35b8>] (cpdma_chan_process+0x4c/0x64)
[61011.143402]=A0 r7:00000040 r6:00000040 r5:cfa6f5c0 r4:00000000
[61011.149383] [<c02a356c>] (cpdma_chan_process+0x0/0x64) from [<c02a1b=
44>] (emac_poll+0x9c/0x208)
[61011.158538]=A0 r6:00000001 r5:00000001 r4:cfa5044c r3:00000001
[61011.164520] [<c02a1aa8>] (emac_poll+0x0/0x208) from [<c0314340>] (ne=
t_rx_action+0xb0/0x1a8)
[61011.173339]=A0 r8:c0531130 r7:0000012c r6:00000040 r5:00000001 r4:cf=
a5044c
[61011.173339] r3:c02a1aa8
[61011.182952] [<c0314290>] (net_rx_action+0x0/0x1a8) from [<c0035778>]=
 (__do_softirq+0xb0/0x1d8)
[61011.192016] [<c00356c8>] (__do_softirq+0x0/0x1d8) from [<c0035c7c>] =
(irq_exit+0x8c/0x94)
[61011.200561] [<c0035bf0>] (irq_exit+0x0/0x94) from [<c000f010>] (hand=
le_IRQ+0x44/0x94)
[61011.208801]=A0 r4:c05499b8 r3:c00764a4
[61011.212585] [<c000efcc>] (handle_IRQ+0x0/0x94) from [<c00085b4>] (om=
ap3_intc_handle_irq+0x68/0x78)
[61011.222015]=A0 r6:c055cbbc r5:cd9fdfb0 r4:fa200000 r3:00000044
[61011.227996] [<c000854c>] (omap3_intc_handle_irq+0x0/0x78) from [<c00=
0e480>] (__irq_usr+0x40/0x60)
[61011.237335] Exception stack(0xcd9fdfb0 to 0xcd9fdff8)
[61011.242645] dfa0:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 b6e474c0 0000=
0000 00000001 00000000
[61011.251281] dfc0: 00000000 00000000 0000e538 0000e530 0000000e 0000e=
478 00000014 00000000
[61011.259887] dfe0: 0000e4a8 befbbb58 00008adc b6d4d71c 60000010 fffff=
fff
[61011.266845]=A0 r7:0000e530 r6:ffffffff r5:60000010 r4:b6d4d71c
[61011.272827] ---[ end trace c901cd47c92f77fb ]---

Then on our Development Platform (Technexion Twister board in this case=
), running the same 3.4rc6, this happened IMMEDIATELY after rebooting:
-----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-----------

[=A0=A0 40.027679] Unable to handle kernel NULL pointer dereference at =
virtual addc
[=A0=A0 40.036285] pgd =3D ce568000
[=A0=A0 40.039154] [0000000c] *pgd=3D8e4b9831, *pte=3D00000000, *ppte=3D=
00000000
[=A0=A0 40.045776] Internal error: Oops: 17 [#1] ARM
[=A0=A0 40.050354] Modules linked in:
[=A0=A0 40.053588] CPU: 0=A0=A0=A0 Not tainted=A0 (3.4.0-rc6 #4)
[=A0=A0 40.058532] PC is at tcp_rcv_established+0x34/0x65c
[=A0=A0 40.063690] LR is at tcp_v4_do_rcv+0xbc/0x1bc
[=A0=A0 40.068267] pc : [<c032b4d8>]=A0=A0=A0 lr : [<c0331ee0>]=A0=A0=A0=
 psr: 600f0013
[=A0=A0 40.068267] sp : cfb71c98=A0 ip : cfb71cc8=A0 fp : cfb71cc4
[=A0=A0 40.080322] r10: 00000001=A0 r9 : 00002000=A0 r8 : c052b256
[=A0=A0 40.085815] r7 : 00000000=A0 r6 : ce62d0c0=A0 r5 : 00000000=A0 r=
4 : ce4b2500
[=A0=A0 40.092681] r3 : 00000000=A0 r2 : 0000003a=A0 r1 : c9011080=A0 r=
0 : ce4b2500
[=A0=A0 40.099548] Flags: nZCv=A0 IRQs on=A0 FIQs on=A0 Mode SVC_32=A0 =
ISA ARM=A0 Segment user
[=A0=A0 40.107025] Control: 10c5387d=A0 Table: 8e568019=A0 DAC: 0000001=
5
[=A0=A0 40.113067] Process iperf (pid: 807, stack limit =3D 0xcfb702f0)
[=A0=A0 40.119201] Stack: (0xcfb71c98 to 0xcfb72000)
[=A0=A0 40.123779] 1c80:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ce62dc00 000005c8
[=A0=A0 40.132385] 1ca0: c052b256 ce62d0c0 ce4b2500 00000000 00000000 c=
052b256 cfb71cfc cfb71cc8
[=A0=A0 40.140991] 1cc0: c0331ee0 c032b4b0 cfb71cec cfb71cd8 c0055a20 c=
037d5a4 00000000 c037d9a0
[=A0=A0 40.149597] 1ce0: ce62d0c0 ce4b2500 00000000 00000000 cfb71d24 c=
fb71d00 c02e2ba8 c0331e30
[=A0=A0 40.158172] 1d00: cfb2c0c0 000003b8 000003b8 ce4b281c ce4b2500 0=
0000000 cfb71d84 cfb71d28
[=A0=A0 40.166778] 1d20: c0322244 c02e2b3c c028668c c02871f8 00000001 c=
0026964 cfb71d54 00000001
[=A0=A0 40.175384] 1d40: cfb71ecc ce42f3c0 00000000 00000000 c028565c 7=
fffffff 04000000 c05280d8
[=A0=A0 40.183990] 1d60: cfb71ecc 00000000 cf5e6200 00000000 cfb71ecc 0=
0002000 cfb71dbc cfb71d88
[=A0=A0 40.192596] 1d80: c03401cc c0321fd0 00000000 00000000 cfb71d9c c=
0285718 00000001 00000000
[=A0=A0 40.201171] 1da0: cfb71dec 00000000 00000000 00000000 cfb71eb4 c=
fb71dc0 c02df95c c034018c
[=A0=A0 40.209777] 1dc0: 00000000 cfb71dd0 c0034a8c c0034128 00000000 0=
0002000 cf5e6200 0000000a
[=A0=A0 40.218383] 1de0: 00000000 cfb71ecc c007602c cfb70000 00000044 c=
0034f18 c0503338 cfb70000
[=A0=A0 40.226989] 1e00: 00000044 00000000 cfb71e2c cfb71e18 00000000 0=
0000001 ffffffff 00000000
[=A0=A0 40.235595] 1e20: 00000000 00000000 00000000 00000000 ce42f3c0 f=
a200000 00000000 00000000
[=A0=A0 40.244171] 1e40: cfb71e6c cfb71e50 cfb71dc8 c000f098 c02e1780 a=
0000013 ffffffff cfb71ea4
[=A0=A0 40.252777] 1e60: cfb71f8c cfb71e70 c000e3c0 c0008564 cf5e6200 c=
02e17f8 cfb71ec4 cfae30c0
[=A0=A0 40.261383] 1e80: 00002000 c02dfb04 cfb71ebc 00002000 cf5e6200 0=
0000000 cfb71ee8 00000000
[=A0=A0 40.269989] 1ea0: cfb70000 0001c470 cfb71f8c cfb71eb8 c02e17b4 c=
02df8b0 cfb71f0c fffffff7
[=A0=A0 40.278594] 1ec0: 00000001 0001e470 00000000 cfb71ee8 00000080 c=
fb71ec4 00000001 00000000
[=A0=A0 40.287170] 1ee0: 00000000 cfb70000 00000044 c0034f18 c0503338 c=
fb70000 00000044 00000000
[=A0=A0 40.295776] 1f00: cfb71f24 cfb71f10 c0034f18 c0079244 c007603c c=
051ab2c cfb71f44 cfb71f28
[=A0=A0 40.304382] 1f20: c000f0d0 c0034ea0 00000044 fa200000 cfb71f68 c=
052d560 cfb71f64 cfb71f48
[=A0=A0 40.312988] 1f40: c00085cc c000f098 c000e938 80000013 ffffffff c=
fb71f9c 00000000 cfb71f68
[=A0=A0 40.321594] 1f60: c000e3c0 c0008564 0001c458 0001e478 0001c470 0=
0000123 c000e9c4 00000000
[=A0=A0 40.330169] 1f80: cfb71fa4 cfb71f90 c02e182c c02e1728 00000000 0=
0000000 00000000 cfb71fa8
[=A0=A0 40.338775] 1fa0: c000e780 c02e1810 0001c458 0001e478 00000000 0=
001c470 00002000 00000000
[=A0=A0 40.347381] 1fc0: 0001c458 0001e478 0001c470 00000123 00fea9f8 0=
0000000 00000fb8 b64d6f9c
[=A0=A0 40.355987] 1fe0: 00000000 b64d6da0 b6e85fe4 b6e85ff4 80000010 0=
0000000 00000000 00000000
[=A0=A0 40.364562] Backtrace:
[=A0=A0 40.367156] [<c032b4a4>] (tcp_rcv_established+0x0/0x65c) from [<=
c0331ee0>] (tcp_v4_do_rcv+0xbc/0x1bc)
[=A0=A0 40.376861]=A0 r8:c052b256 r7:00000000 r6:00000000 r5:ce4b2500 r=
4:ce62d0c0
[=A0=A0 40.383941] [<c0331e24>] (tcp_v4_do_rcv+0x0/0x1bc) from [<c02e2b=
a8>] (release_sock+0x78/0xe0)
[=A0=A0 40.392883]=A0 r7:00000000 r6:00000000 r5:ce4b2500 r4:ce62d0c0
[=A0=A0 40.398864] [<c02e2b30>] (release_sock+0x0/0xe0) from [<c0322244=
>] (tcp_recvmsg+0x280/0x864)
[=A0=A0 40.407745] [<c0321fc4>] (tcp_recvmsg+0x0/0x864) from [<c03401cc=
>] (inet_recvmsg+0x4c/0x60)
[=A0=A0 40.416564] [<c0340180>] (inet_recvmsg+0x0/0x60) from [<c02df95c=
>] (sock_recvmsg+0xb8/0xd8)
[=A0=A0 40.425323]=A0 r6:00000000 r5:00000000 r4:00000000
[=A0=A0 40.430206] [<c02df8a4>] (sock_recvmsg+0x0/0xd8) from [<c02e17b4=
>] (sys_recvfrom+0x98/0xe8)
[=A0=A0 40.438995] [<c02e171c>] (sys_recvfrom+0x0/0xe8) from [<c02e182c=
>] (sys_recv+0x28/0x30)
[=A0=A0 40.447418] [<c02e1804>] (sys_recv+0x0/0x30) from [<c000e780>] (=
ret_fast_syscall+0x0/0x30)
[=A0=A0 40.456115] Code: e5901314 e1a04000 e7c0201f e5c023ac (e595200c)
[=A0=A0 40.462615] ---[ end trace b41eca898abf2dd4 ]---
[=A0=A0 40.467468] Kernel panic - not syncing: Fatal exception in inter=
rupt


After a power-cycle reboot, as soon as I re-enabled the iperf server, w=
hich had a client already waiting to run, it threw the dreaded SLAB err=
or, and faulted the EMAC for it:
-----------------------------------------------------------------------=
-----------------------------------------------------------------------=
-----------

$ iperf -s -D
------------------------------------------------------------
Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
Running Iperf Server as a daemon
The Iperf daemon process ID : 814
root@sc-hd1u-tam3517:~# [=A0=A0 36.567047] ------------[ cut here ]----=
--------
[=A0=A0 36.571929] kernel BUG at mm/slab.c:3175!
[=A0=A0 36.576141] Internal error: Oops - BUG: 0 [#1] ARM
[=A0=A0 36.581176] Modules linked in:
[=A0=A0 36.584381] CPU: 0=A0=A0=A0 Not tainted=A0 (3.4.0-rc6 #4)
[=A0=A0 36.589355] PC is at cache_alloc_refill+0x13c/0x534
[=A0=A0 36.594482] LR is at kmem_cache_alloc+0x10c/0x11c
[=A0=A0 36.599426] pc : [<c037a610>]=A0=A0=A0 lr : [<c00c3b84>]=A0=A0=A0=
 psr: 60000093
[=A0=A0 36.599456] sp : ce945a60=A0 ip : 0000003e=A0 fp : ce945aa4
[=A0=A0 36.611511] r10: 00000014=A0 r9 : cf80d7c0=A0 r8 : 0000000a
[=A0=A0 36.617004] r7 : 00100100=A0 r6 : cf813480=A0 r5 : 00200200=A0 r=
4 : cf829400
[=A0=A0 36.623870] r3 : cfb0e040=A0 r2 : 00000001=A0 r1 : 00000014=A0 r=
0 : 00000014
[=A0=A0 36.630706] Flags: nZCv=A0 IRQs off=A0 FIQs on=A0 Mode SVC_32=A0=
 ISA ARM=A0 Segment user
[=A0=A0 36.638305] Control: 10c5387d=A0 Table: 8e910019=A0 DAC: 0000001=
5
[=A0=A0 36.644348] Process iperf (pid: 815, stack limit =3D 0xce9442f0)
[=A0=A0 36.650482] Stack: (0xce945a60 to 0xce946000)
[=A0=A0 36.655059] 5a60: cf813490 00000020 00000020 00000000 00000020 c=
f813488 c03141f0 00000020
[=A0=A0 36.663665] 5a80: 60000013 cf80d7c0 00000020 c02e7bac c052b080 c=
f80d7c0 ce945ad4 ce945aa8
[=A0=A0 36.672271] 5aa0: c00c3b84 c037a4e0 cf9ee000 00000008 cf9ee000 0=
0000020 cf80d7c0 00000634
[=A0=A0 36.680877] 5ac0: c02e812c 00000000 ce945afc ce945ad8 c02e7bac c=
00c3a84 cf9ee000 cfb33e40
[=A0=A0 36.689453] 5ae0: 039586f6 00000000 000005ea cfb33e40 ce945b14 c=
e945b00 c02e812c c02e7b7c
[=A0=A0 36.698059] 5b00: cf9ee480 cf9ee000 ce945b2c ce945b18 c02843d4 c=
02e810c 00009b52 cf9ee000
[=A0=A0 36.706665] 5b20: ce945b54 ce945b30 c02852d4 c02843b8 c0017b30 c=
02e8828 cfa2c940 cfa2c940
[=A0=A0 36.715270] 5b40: 60000013 cfa31440 ce945b7c ce945b58 c02865b4 c=
028526c cfa2c940 00000000
[=A0=A0 36.723876] 5b60: d26d0fc0 d08d0660 cf9ee000 ce944000 ce945b9c c=
e945b80 c028668c c0286510
[=A0=A0 36.732452] 5b80: 00000023 cfa31440 00000040 00000040 ce945bbc c=
e945ba0 c02871f8 c02865cc
[=A0=A0 36.741058] 5ba0: 00000001 cf9ee48c 00010001 00000001 ce945be4 c=
e945bc0 c02857a8 c02871b8
[=A0=A0 36.749664] 5bc0: c028570c cf9ee48c 00000001 00000040 0000012c c=
0501978 ce945c1c ce945be8
[=A0=A0 36.758270] 5be0: c02f1dbc c0285718 ce945be8 ffff7c46 ffffffff 0=
0000001 00000003 0000000c
[=A0=A0 36.766876] 5c00: c053e390 c053e38c 00000b50 ce944000 ce945c64 c=
e945c20 c0034a1c c02f1d18
[=A0=A0 36.775451] 5c20: cfb0e180 ce8d5084 17762052 0000000a c053e380 0=
0000101 ce945c68 60000013
[=A0=A0 36.784057] 5c40: ce929864 ce894d40 00000020 c052b256 00000b50 0=
0000001 ce945c7c ce945c68
[=A0=A0 36.792663] 5c60: c0034ca0 c0034978 0000000a ce944000 ce945c94 c=
e945c80 c0034e1c c0034c54
[=A0=A0 36.801269] 5c80: ce9c9500 ce929864 ce945cc4 ce945c98 c032b9bc c=
0034d78 ce87e2c0 000005c8
[=A0=A0 36.809875] 5ca0: c053e380 ce894d40 ce9c9500 cea3c3c0 00000000 c=
052b256 ce945cfc ce945cc8
[=A0=A0 36.818481] 5cc0: c0331ee0 c032b4b0 ce945cec ce945cd8 c0034ca0 c=
0034978 00000008 ce944000
[=A0=A0 36.827056] 5ce0: ce894d40 ce9c9500 cea3c3c0 00000000 ce945d24 c=
e945d00 c02e2ba8 c0331e30
[=A0=A0 36.835662] 5d00: ce944000 cea66440 ce9c953c ce9c981c ce9c9500 0=
0000000 ce945d84 ce945d28
[=A0=A0 36.844268] 5d20: c0322300 c02e2b3c c0026964 c0017fe0 ce945d54 c=
e945d40 c028565c 00000001
[=A0=A0 36.852874] 5d40: ce945ecc cea66440 00000000 000014b0 c0285794 7=
fffffff c028570c c05280d8
[=A0=A0 36.861480] 5d60: ce945ecc 00000000 cf5e36c0 00000000 ce945ecc 0=
0002000 ce945dbc ce945d88
[=A0=A0 36.870056] 5d80: c03401cc c0321fd0 00000000 00000000 ce945d9c c=
0034a8c 00000100 00000000
[=A0=A0 36.878662] 5da0: 00000003 00000000 00000000 00000000 ce945eb4 c=
e945dc0 c02df95c c034018c
[=A0=A0 36.887268] 5dc0: 00000000 0000000a c053e380 00000100 00000000 0=
0002000 cf5e36c0 c0034f18
[=A0=A0 36.895874] 5de0: 00000000 ce945ecc 00000044 00000000 ce945e14 c=
e945e00 c0034f18 c0079244
[=A0=A0 36.904449] 5e00: c007603c c051ab2c ce945e34 ce945e18 00000000 0=
0000001 ffffffff 00000000
[=A0=A0 36.913055] 5e20: 00000000 00000000 00000000 00000000 cea66440 c=
000f098 00000000 00000000
[=A0=A0 36.921661] 5e40: ffffffff ce945e8c ce945dc8 ce945e58 c000e3c0 c=
0008564 cfba7ac0 c03ad080
[=A0=A0 36.930267] 5e60: c03ad080 cfba7ac0 ce945ebc ce945ec0 00000000 c=
02e17f8 00000000 ce944000
[=A0=A0 36.938873] 5e80: 0001c470 c02dfb04 ce945ebc 00002000 cf5e36c0 0=
0000000 ce945ee8 00000000
[=A0=A0 36.947448] 5ea0: ce944000 0001c470 ce945f8c ce945eb8 c02e17b4 c=
02df8b0 c0034a8c fffffff7
[=A0=A0 36.956054] 5ec0: 00000001 0001e0b8 000003b8 ce945ee8 00000080 c=
e945ec4 00000001 00000000
[=A0=A0 36.964660] 5ee0: 00000000 c0034f18 c0503338 ce944000 00000044 0=
0000000 ce945f1c ce945f08
[=A0=A0 36.973266] 5f00: c0034f18 c0079244 c007603c c051ab2c ce945f3c c=
e945f20 c000f0d0 c0034ea0
[=A0=A0 36.981872] 5f20: 00000044 fa200000 ce945f60 c052d560 ce945f5c c=
e945f40 c00085cc c000f098
[=A0=A0 36.990447] 5f40: c000e780 20000013 ffffffff ce945f94 00000000 c=
e945f60 c000e3c0 c0008564
[=A0=A0 36.999053] 5f60: 00002000 00000000 0001c458 0001e478 0001c470 0=
0000123 c000e9c4 00000000
[=A0=A0 37.007659] 5f80: ce945fa4 ce945f90 c02e182c c02e1728 00000000 0=
0000000 00000000 ce945fa8
[=A0=A0 37.016265] 5fa0: c000e780 c02e1810 0001c458 0001e478 00000000 0=
001c470 00002000 00000000
[=A0=A0 37.024871] 5fc0: 0001c458 0001e478 0001c470 00000123 036b4730 0=
0000000 000010f8 b6472f9c
[=A0=A0 37.033447] 5fe0: 00000000 b6472da0 b6e21fe4 b6e21ff4 80000010 0=
0000000 18631b25 4609c480
[=A0=A0 37.042053] Backtrace:
[=A0=A0 37.044647] [<c037a4d4>] (cache_alloc_refill+0x0/0x534) from [<c=
00c3b84>] (kmem_cache_alloc+0x10c/0x11c)
[=A0=A0 37.054626] [<c00c3a78>] (kmem_cache_alloc+0x0/0x11c) from [<c02=
e7bac>] (__alloc_skb+0x3c/0xfc)
[=A0=A0 37.063781] [<c02e7b70>] (__alloc_skb+0x0/0xfc) from [<c02e812c>=
] (__netdev_alloc_skb+0x2c/0x54)
[=A0=A0 37.073059] [<c02e8100>] (__netdev_alloc_skb+0x0/0x54) from [<c0=
2843d4>] (emac_rx_alloc+0x28/0x64)
[=A0=A0 37.082458]=A0 r4:cf9ee000 r3:cf9ee480
[=A0=A0 37.086242] [<c02843ac>] (emac_rx_alloc+0x0/0x64) from [<c02852d=
4>] (emac_rx_handler+0x74/0x11c)
[=A0=A0 37.095489]=A0 r4:cf9ee000 r3:00009b52
[=A0=A0 37.099273] [<c0285260>] (emac_rx_handler+0x0/0x11c) from [<c028=
65b4>] (__cpdma_chan_free+0xb0/0xbc)
[=A0=A0 37.108856]=A0 r6:cfa31440 r5:60000013 r4:cfa2c940
[=A0=A0 37.113739] [<c0286504>] (__cpdma_chan_free+0x0/0xbc) from [<c02=
8668c>] (__cpdma_chan_process+0xcc/0x104)
[=A0=A0 37.123809] [<c02865c0>] (__cpdma_chan_process+0x0/0x104) from [=
<c02871f8>] (cpdma_chan_process+0x4c/0x64)
[=A0=A0 37.133941]=A0 r7:00000040 r6:00000040 r5:cfa31440 r4:00000023
[=A0=A0 37.139923] [<c02871ac>] (cpdma_chan_process+0x0/0x64) from [<c0=
2857a8>] (emac_poll+0x9c/0x208)
[=A0=A0 37.149078]=A0 r6:00000001 r5:00010001 r4:cf9ee48c r3:00000001
[=A0=A0 37.155059] [<c028570c>] (emac_poll+0x0/0x208) from [<c02f1dbc>]=
 (net_rx_action+0xb0/0x1a8)
[=A0=A0 37.163818]=A0 r8:c0501978 r7:0000012c r6:00000040 r5:00000001 r=
4:cf9ee48c
[=A0=A0 37.170715] r3:c028570c
[=A0=A0 37.173461] [<c02f1d0c>] (net_rx_action+0x0/0x1a8) from [<c0034a=
1c>] (__do_softirq+0xb0/0x1d8)
[=A0=A0 37.182525] [<c003496c>] (__do_softirq+0x0/0x1d8) from [<c0034ca=
0>] (do_softirq+0x58/0x64)
[=A0=A0 37.191223] [<c0034c48>] (do_softirq+0x0/0x64) from [<c0034e1c>]=
 (local_bh_enable+0xb0/0xc0)
[=A0=A0 37.200073]=A0 r4:ce944000 r3:0000000a
[=A0=A0 37.203857] [<c0034d6c>] (local_bh_enable+0x0/0xc0) from [<c032b=
9bc>] (tcp_rcv_established+0x518/0x65c)
[=A0=A0 37.213745]=A0 r5:ce929864 r4:ce9c9500
[=A0=A0 37.217529] [<c032b4a4>] (tcp_rcv_established+0x0/0x65c) from [<=
c0331ee0>] (tcp_v4_do_rcv+0xbc/0x1bc)
[=A0=A0 37.227203]=A0 r8:c052b256 r7:00000000 r6:cea3c3c0 r5:ce9c9500 r=
4:ce894d40
[=A0=A0 37.234283] [<c0331e24>] (tcp_v4_do_rcv+0x0/0x1bc) from [<c02e2b=
a8>] (release_sock+0x78/0xe0)
[=A0=A0 37.243225]=A0 r7:00000000 r6:cea3c3c0 r5:ce9c9500 r4:ce894d40
[=A0=A0 37.249206] [<c02e2b30>] (release_sock+0x0/0xe0) from [<c0322300=
>] (tcp_recvmsg+0x33c/0x864)
[=A0=A0 37.258087] [<c0321fc4>] (tcp_recvmsg+0x0/0x864) from [<c03401cc=
>] (inet_recvmsg+0x4c/0x60)
[=A0=A0 37.266906] [<c0340180>] (inet_recvmsg+0x0/0x60) from [<c02df95c=
>] (sock_recvmsg+0xb8/0xd8)
[=A0=A0 37.275665]=A0 r6:00000000 r5:00000000 r4:00000000
[=A0=A0 37.280548] [<c02df8a4>] (sock_recvmsg+0x0/0xd8) from [<c02e17b4=
>] (sys_recvfrom+0x98/0xe8)
[=A0=A0 37.289337] [<c02e171c>] (sys_recvfrom+0x0/0xe8) from [<c02e182c=
>] (sys_recv+0x28/0x30)
[=A0=A0 37.297760] [<c02e1804>] (sys_recv+0x0/0x30) from [<c000e780>] (=
ret_fast_syscall+0x0/0x30)
[=A0=A0 37.306457] Code: e5930010 e5991018 e1500001 3a00000e (e7f001f2)
[=A0=A0 37.312927] ---[ end trace 3d0484470996ac0b ]---
[=A0=A0 37.317810] Kernel panic - not syncing: Fatal exception in inter=
rupt
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
