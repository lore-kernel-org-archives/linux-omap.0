From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: Problem booting in OMAP H3 1710
Date: Mon, 24 Jul 2006 11:27:09 -0400
Message-ID: <44C4E6CD.3020303@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hello folks,

I'm trying to boot a kernel image to OMAP H3 1710 generated from
linux-omap-2.6.git (v2.6.17-omap1) tree, but I'm having the following
problem (kernel panic) below.

This kernel image it's with 'Kernel low-level debugging functions' support.

Is there anybody having the same problem ?

Thanks in advance,

Carlos.

...

<6>omapfb: configured for panel h3
<6>omapfb: LCDC initialized
<1>Unable to handle kernel paging request at virtual address 00009600
<1>pgd = c0004000
<1>[00009600] *pgd=00000000
Internal error: Oops: 805 [#1]
Modules linked in:
CPU: 0
PC is at cfb_imageblit+0x210/0x49c
LR is at 0x6
pc : [<c01000b8>]    lr : [<00000006>]    Not tainted
sp : c02b39e4  ip : c02c0000  fp : c02b3a54
r10: 00000002  r9 : c02c0000  r8 : 00000000
r7 : c01f75a8  r6 : 00000000  r5 : c034f800  r4 : 00009600
r3 : 00000000  r2 : 00000007  r1 : 00000002  r0 : 00000004
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: 5317F  Table: 10004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc02b2198)
Stack: (0xc02b39e4 to 0xc02b4000)
39e0:          c02b39f0 c0024a04 c002e828 c0232470 0000001e c02b3a60
0000001f
3a00: c0232470 c02b3a2c c02b3a14 c01f75a8 00000003 00000001 00009600
00000008
3a20: 00000000 00000000 00000000 c02c0000 c02e7468 00000008 c02b3aac
c034f800
3a40: 00000000 c02e7460 c02b3a9c c02b3a58 c00f598c c00ffeb8 00000008
00000001
3a60: 00000000 00000001 00000001 00000000 00000000 00000008 c030bb80
c01f7440
3a80: c0351e00 00000000 00000001 c01b742c c02b3b1c c02b3aa0 c00f5698
c00f580c
3aa0: 00000000 00000002 c034f800 00000033 c0040001 c030bb80 00000000
00000000
3ac0: 00000050 00000008 00000008 00000000 00000000 c0043001 c01b742c
c02b3ae8
3ae0: c0024db0 c0043204 00000032 000000f0 ffffffff c034f800 00000000
c0291420
3b00: 00000002 00000000 c034f808 c0351e00 c02b3b58 c02b3b20 c00f24d8
c00f51f0
3b20: 00000000 00000000 c034f8a8 00000000 c0291420 c02459f8 00000000
00000000
3b40: 00000000 c02430dc c02df960 c02b3b70 c02b3b5c c01104a4 c00f21d8
00000000
3b60: c0291420 c02b3b90 c02b3b74 c01108c8 c011047c 00000000 c02430dc
c0291420
3b80: 00000258 c02b3bd4 c02b3b94 c00ef8a0 c01107d0 00000140 00000000
0000012c
3ba0: 00000720 00000028 0000001e c0291420 c034f800 c0351e00 00000028
0000001e
3bc0: c0291420 c02413cc c02b3c1c c02b3bd8 c00f0154 c00ef628 0000001e
00000028
3be0: 00000000 0000001e 00000028 00000001 00000000 c0291420 00000000
00000000
3c00: 00000000 c01b73b0 00000000 0000003e c02b3c3c c02b3c20 c0110ae8
c00efe7c
3c20: 00000040 c0291420 00000000 00000000 c02b3c78 c02b3c40 c0112798
c01109f4
3c40: c02b2000 c01c95e8 00000000 00000001 c02430f8 c01f6f34 00000000
c024318c
3c60: 00000000 00000001 c03129b0 c02b3c90 c02b3c7c c00ef55c c01124f8
00000001
3c80: 00000000 c02b3dac c02b3c94 c00f49a8 c00ef4f4 c02b3cf8 c02b3cac
c02b3d1c
3ca0: c02b3cac c004d878 c01b3144 00000000 c02b3cb0 c02b3cb0 c004d758
c02b3cdc
3cc0: c02a26e0 00000000 00000000 00000000 00000000 00000000 c023d594
c02b3cf8
3ce0: c01f6e2c c02b3d34 c0308d60 00000000 00000000 fffffffe 00000000
c02b3cfc
3d00: c02b3cfc c01c967c c02de9e0 c02df0b3 c02b3d74 c02b3d20 c00eab8c
c0072ca0
3d20: 00000000 000007aa c030e000 c01c967c c030bae0 c01f6e2c ffffffef
c02b3d64
3d40: c02b3d4c c00aeb64 c00aeb78 ffffffef 00000000 000081a4 c02b3d80
c02b3d68
3d60: c00aec50 c00aeb50 ffffffef c01f7224 c032458c c02b3da8 c02b3d84
c00ae81c
3d80: c01b3eec c01f6f40 c02b3df0 00000005 c024318c 00000000 00000001
c03129b0
3da0: c02b3dc8 c02b3db0 c004af40 c00f407c 00000005 c02b3df0 c01f6fe4
c02b3de4
3dc0: c02b3dcc c004b0a4 c004af18 c02b3df8 c034f800 00000000 c02b3e4c
c02b3de8
3de0: c00f75dc c004b088 c01c960c 00000000 c034f800 c02b3e28 00000000
00000072
3e00: 000000f0 00000140 00014585 0000000e 0000003c 00000001 00000000
0000000c
3e20: 00000001 00000000 00000000 00000020 00000000 00000000 c034f8a8
c03129a0
3e40: c02b3e9c c02b3e50 c00fd888 c00f749c c02b3ed0 c02b3e60 00000000
00000007
3e60: 65746e69 6c616e72 00000000 00000000 c02b3e00 c01eefc8 00000000
00000000
3e80: c01f74ac 00000000 00000000 00000000 c02b3eac c02b3ea0 c00fdb08
c00fd1c4
3ea0: c02b3ebc c02b3eb0 c00fef24 c00fdad4 c02b3ecc c02b3ec0 c012089c
c00fef20
3ec0: c02b3eec c02b3ed0 c011ea38 c012088c c01ef094 c01eefc8 c011eb2c
c01f74ac
3ee0: c02b3f04 c02b3ef0 c011ebac c011e9bc 00000000 c02b3f08 c02b3f30
c02b3f08
3f00: c011de98 c011eb3c c01fb690 c01fb690 c01ef010 c01f74c0 c01f74ac
c02b2000
3f20: c01fb590 c02b3f40 c02b3f34 c011ec2c c011de58 c02b3f68 c02b3f44
c011e400
3f40: c011ec1c c01f74ac c001ebb8 c02b2000 c001f154 00000000 c001ec38
c02b3f80
3f60: c02b3f6c c011f0d8 c011e3a4 c011f050 00000000 c02b3f90 c02b3f84
c012099c
3f80: c011f050 c02b3fa0 c02b3f94 c00fef80 c0120940 c02b3ff4 c02b3fa4
c00230f8
3fa0: c00fef7c 00000001 c0023dc4 c003a244 00000000 00000000 c0023058
c00403f0
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
3fe0: 00000000 00000000 00000000 c02b3ff8 c00403f0 c0023068 e1dc20b2
e3520003
Backtrace:
[<c00ffea8>] (cfb_imageblit+0x0/0x49c) from [<c00f598c>]
(soft_cursor+0x190/0x1a4)
[<c00f57fc>] (soft_cursor+0x0/0x1a4) from [<c00f5698>]
(bit_cursor+0x4b8/0x4cc)
[<c00f51e0>] (bit_cursor+0x0/0x4cc) from [<c00f24d8>]
(fbcon_cursor+0x310/0x340)
[<c00f21c8>] (fbcon_cursor+0x0/0x340) from [<c01104a4>]
(hide_cursor+0x38/0x88)
[<c011046c>] (hide_cursor+0x0/0x88) from [<c01108c8>]
(redraw_screen+0x108/0x1f0)
 r5 = C0291420  r4 = 00000000
[<c01107c0>] (redraw_screen+0x0/0x1f0) from [<c00ef8a0>]
(fbcon_prepare_logo+0x288/0x340)
 r7 = 00000258  r6 = C0291420  r5 = C02430DC  r4 = 00000000
[<c00ef618>] (fbcon_prepare_logo+0x0/0x340) from [<c00f0154>]
(fbcon_init+0x2e8/0x37c)
[<c00efe6c>] (fbcon_init+0x0/0x37c) from [<c0110ae8>]
(visual_init+0x104/0x15c)
[<c01109e4>] (visual_init+0x0/0x15c) from [<c0112798>]
(take_over_console+0x2b0/0x3f0)
 r7 = 00000000  r6 = 00000000  r5 = C0291420  r4 = 00000040
[<c01124e8>] (take_over_console+0x0/0x3f0) from [<c00ef55c>]
(fbcon_takeover+0x78/0xd0)
[<c00ef4e4>] (fbcon_takeover+0x0/0xd0) from [<c00f49a8>]
(fbcon_event_notify+0x93c/0xb0c)
 r5 = 00000000  r4 = 00000001
[<c00f406c>] (fbcon_event_notify+0x0/0xb0c) from [<c004af40>]
(notifier_call_chain+0x38/0x50)
[<c004af08>] (notifier_call_chain+0x0/0x50) from [<c004b0a4>]
(blocking_notifier_call_chain+0x2c/0x40)
 r6 = C01F6FE4  r5 = C02B3DF0  r4 = 00000005
[<c004b078>] (blocking_notifier_call_chain+0x0/0x40) from [<c00f75dc>]
(register_framebuffer+0x150/0x178)
 r6 = 00000000  r5 = C034F800  r4 = C02B3DF8
[<c00f748c>] (register_framebuffer+0x0/0x178) from [<c00fd888>]
(omapfb_do_probe+0x6d4/0x8bc)
 r7 = C03129A0  r6 = C034F8A8  r5 = 00000000  r4 = 00000000
[<c00fd1b4>] (omapfb_do_probe+0x0/0x8bc) from [<c00fdb08>]
(omapfb_register_panel+0x44/0x58)
[<c00fdac4>] (omapfb_register_panel+0x0/0x58) from [<c00fef24>]
(h3_panel_probe+0x14/0x20)
[<c00fef10>] (h3_panel_probe+0x0/0x20) from [<c012089c>]
(platform_drv_probe+0x20/0x24)
[<c012087c>] (platform_drv_probe+0x0/0x24) from [<c011ea38>]
(driver_probe_device+0x8c/0xd4)
[<c011e9ac>] (driver_probe_device+0x0/0xd4) from [<c011ebac>]
(__driver_attach+0x80/0xe0)
 r7 = C01F74AC  r6 = C011EB2C  r5 = C01EEFC8  r4 = C01EF094
[<c011eb2c>] (__driver_attach+0x0/0xe0) from [<c011de98>]
(bus_for_each_dev+0x50/0x84)
 r5 = C02B3F08  r4 = 00000000
[<c011de48>] (bus_for_each_dev+0x0/0x84) from [<c011ec2c>]
(driver_attach+0x20/0x28)
 r7 = C01FB590  r6 = C02B2000  r5 = C01F74AC  r4 = C01F74C0
[<c011ec0c>] (driver_attach+0x0/0x28) from [<c011e400>]
(bus_add_driver+0x6c/0x138)
[<c011e394>] (bus_add_driver+0x0/0x138) from [<c011f0d8>]
(driver_register+0x98/0xa8)
[<c011f040>] (driver_register+0x0/0xa8) from [<c012099c>]
(platform_driver_register+0x6c/0x88)
 r4 = 00000000
[<c0120930>] (platform_driver_register+0x0/0x88) from [<c00fef80>]
(h3_panel_drv_init+0x14/0x1c)
[<c00fef6c>] (h3_panel_drv_init+0x0/0x1c) from [<c00230f8>]
(init+0xa0/0x268)
[<c0023058>] (init+0x0/0x268) from [<c00403f0>] (do_exit+0x0/0x7ac)
Code: e0033006 e0233008 028cc001 03a0e008 (e4843004)
 <0>Kernel panic - not syncing: Attempted to kill init!
