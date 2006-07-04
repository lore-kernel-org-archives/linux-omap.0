From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Framebuffer driver broken on OSK
Date: Tue, 04 Jul 2006 17:04:49 +0200
Message-ID: <44AA8391.7010708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: linux-omap-open-source@linux.omap.com, imre.deak@solidboot.com
List-Id: linux-omap@vger.kernel.org

Hi,

seems that framebuffer on OSK from recent git has some more 
trouble (not only the missing parameter from my last mail):

It crashes completely on OSK. Backlight of LCD is enabled, 
but then: See log below (low level debugging enabled, 
without no messages).

Any ideas?

Best regards

Dirk

...
<6>io scheduler anticipatory registered (default)
<6>omapfb: configured for panel osk
<6>omapfb: LCDC initialized
<4>omapfb omapfb: Pixel clock divider value is obsolete.
Try to set pixel_clock to 8000 and pcd to 0 in 
drivers/video/omap/lcd_osk.c.
<4>MUX: initialized PWL
<1>Unable to handle kernel paging request at virtual address 
00024900
<1>pgd = c0004000
<1>[00024900] *pgd=00000000
Internal error: Oops: 805 [#1]
Modules linked in:
CPU: 0
PC is at cfb_imageblit+0x1e0/0x488
LR is at 0x6
pc : [<c010fb0c>]    lr : [<00000006>]    Not tainted
sp : c02939f8  ip : c02a0000  fp : c0293a74
r10: 00000002  r9 : c02a0000  r8 : 00024900
r7 : 00000000  r6 : 00000000  r5 : c1af7800  r4 : 00000000
r3 : 00000000  r2 : 00000001  r1 : 00000000  r0 : 00000004
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  Segment kernel
Control: 5317F  Table: 10004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc0292198)
Stack: (0xc02939f8 to 0xc0294000)
39e0: 
c0220e58 c0293a
3a00: 00000008 00000000 00000000 00000000 c01e0390 00000000 
00000003 000000
3a20: c0293a2c c0022aa0 c0043c5c c0214eb0 0000001e c0293a90 
c022dea0 c02226
3a40: c022d120 a0000013 00000020 c0bd7a28 c0293acc c1af7800 
00000008 c0bd7a
3a60: 00000001 00000000 c0293ab4 c0293a78 c01055b4 c010f93c 
00000008 000000
3a80: 00000001 00000001 c02a0000 00000008 c0bc0be0 c01e00fc 
c1af6000 c1af78
3aa0: 00000001 c01a69c0 c0293b3c c0293ab8 c010539c c0105440 
00000002 c1af78
3ac0: 00000002 c01a69c0 000000ff 0000003b 00000001 c0bc0be0 
00000000 000000
3ae0: 00000138 00000008 00000008 00000007 00000000 c0293b01 
c01a69c0 c0293b
3b00: c004e6c4 c0043bf0 c0293b38 c0293b18 c0023184 00000007 
c1af7800 c02714
3b20: 00000720 00000002 c1af7808 00000000 c0293b78 c0293b40 
c00ffe60 c0104f
3b40: 00000007 00000000 c0104f00 c1af78a8 c0271420 c0229620 
0000003c 000000
3b60: ffffffff 00000028 ffffffc4 c0293b90 c0293b7c c012097c 
c00ffbbc 000000
3b80: c0271420 c0293bb0 c0293b94 c01221b4 c0120950 00000000 
c0271420 000000
3ba0: c0bf51e0 c0293bf0 c0293bb4 c0100ba8 c01220c8 00000028 
0000001e 000002
3bc0: 00000720 00000000 c0271420 00000028 c1af7800 c1af6000 
0000001e 000000
3be0: c022500c c0293c3c c0293bf4 c0100f58 c0100940 0000001e 
00000028 000000
3c00: c1af7808 0000001e c0271420 00000001 00000000 c0271420 
00000000 000000
3c20: 00000000 c02294ec ffffffff c0292000 c0293c5c c0293c40 
c0120f1c c0100c
3c40: 00000040 c0271420 00000000 00000000 c0293ca4 c0293c60 
c0122c00 c0120d
3c60: 00200200 00000001 0000003e 00000000 c01a6844 c01b9fb0 
c02283d0 000000
3c80: c0293e34 c1af7800 00000000 c1af7800 c0bd26a0 c1af7a3c 
c0293cb4 c0293c
3ca0: c0101118 c0122800 c0293db8 c0293cb8 c0101f8c c01010ac 
c0293cb4 c0059a
3cc0: c0293ce0 c02829a0 00000000 00000000 00000000 00000000 
00000000 c0220e
3ce0: c0293cfc c01dfb98 c0293d4c c0bda5c0 00000000 00000000 
c022d300 c0bf49
3d00: c0bda5c0 c0293d30 c0293d14 c0080108 c00f7ef8 c01ba004 
c0bf49e0 c0bf50
3d20: c0bda5e4 000000d0 c0281d40 60000013 c0293d58 c0293d40 
c00806cc c00f7e
3d40: ffffffef c1af9980 c01e0008 c0293d74 c0293d5c c00bf538 
c00bf54c ffffff
3d60: 00000000 000081a4 c0293d90 c0293d78 c00bf8a4 c00bf524 
ffffffef c01e00
3d80: c1af9980 c0293db8 c0293d94 c00bed64 c01dfd1c c0293e34 
00000005 000000
3da0: c1af7800 c0bd26a0 c1af7a3c c0293dd4 c0293dbc c0056efc 
c01016e4 000000
3dc0: c0293e34 c01dfdc8 c0293df0 c0293dd8 c00573c8 c0056ee4 
c0293dfc c1af78
3de0: 00000000 c0293e54 c0293df4 c0106454 c00573ac c01b9fd8 
00000000 000000
3e00: 00000063 000000f0 00000140 00013880 00000028 00000048 
00000001 000000
3e20: 00000028 00000001 00000000 00000000 00000020 c1af7800 
00000000 c0bd26
3e40: c0bd26a0 00000000 c0293eac c0293e58 c010cdb8 c010630c 
00000000 000000
3e60: 00000000 00000001 c0bd26a4 00000000 69293e6c 7265746e 
006c616e 000000
3e80: 00000000 c01d93c4 c01d92f8 00000000 c01e02bc 00000000 
00000000 000000
3ea0: c0293ebc c0293eb0 c010d054 c010c71c c0293ecc c0293ec0 
c010e9d4 c010d0
3ec0: c0293edc c0293ed0 c0130770 c010e9d0 c0293efc c0293ee0 
c012eeb8 c01307
3ee0: c01d93c4 c01d92f8 c012efa8 c01e02bc c0293f14 c0293f00 
c012f02c c012ee
3f00: 00000000 c0293f18 c0293f40 c0293f18 c012e86c c012efb8 
c01e42a0 c01e42
3f20: c01d9340 c01e02d0 c01e02bc c01e41a0 00000001 c0293f50 
c0293f44 c012ed
3f40: c012e834 c0293f78 c0293f54 c012e4c8 c012edbc c01e02bc 
c001def8 c02920
3f60: 00000001 00000000 00000000 c0293f8c c0293f7c c012f320 
c012e46c c001e4
3f80: c0293f9c c0293f90 c0130920 c012f29c c0293fac c0293fa0 
c010e9b8 c01308
3fa0: c0293ff4 c0293fb0 c00210b8 c010e9b4 00000000 00000000 
c002102c c004b8
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 
00000000 000000
3fe0: 00000000 00000000 00000000 c0293ff8 c004b8d8 c002103c 
00000000 000000
Backtrace:
[<c010f92c>] (cfb_imageblit+0x0/0x488) from [<c01055b4>] 
(soft_cursor+0x184)
[<c0105430>] (soft_cursor+0x0/0x198) from [<c010539c>] 
(bit_cursor+0x49c/0x)
[<c0104f00>] (bit_cursor+0x0/0x4b0) from [<c00ffe60>] 
(fbcon_cursor+0x2b4/0)
[<c00ffbac>] (fbcon_cursor+0x0/0x300) from [<c012097c>] 
(hide_cursor+0x3c/0)
[<c0120940>] (hide_cursor+0x0/0x90) from [<c01221b4>] 
(redraw_screen+0xfc/0)
  r5 = C0271420  r4 = 00000000
[<c01220b8>] (redraw_screen+0x0/0x200) from [<c0100ba8>] 
(fbcon_prepare_log)
  r7 = C0BF51E0  r6 = 0000003C  r5 = C0271420  r4 = 00000000
[<c0100930>] (fbcon_prepare_logo+0x0/0x340) from 
[<c0100f58>] (fbcon_init+0)
[<c0100c70>] (fbcon_init+0x0/0x384) from [<c0120f1c>] 
(visual_init+0x174/0x)
[<c0120da8>] (visual_init+0x0/0x1cc) from [<c0122c00>] 
(take_over_console+0)
  r7 = 00000000  r6 = 00000000  r5 = C0271420  r4 = 00000040
[<c01227f0>] (take_over_console+0x0/0x5b4) from [<c0101118>] 
(fbcon_takeove)
[<c010109c>] (fbcon_takeover+0x0/0xe8) from [<c0101f8c>] 
(fbcon_event_notif)
[<c01016d4>] (fbcon_event_notify+0x0/0xad4) from 
[<c0056efc>] (notifier_cal)
[<c0056ed4>] (notifier_call_chain+0x0/0x54) from 
[<c00573c8>] (blocking_not)
  r6 = C01DFDC8  r5 = C0293E34  r4 = 00000005
[<c005739c>] (blocking_notifier_call_chain+0x0/0x40) from 
[<c0106454>] (reg)
  r6 = 00000000  r5 = C1AF7800  r4 = C0293DFC
[<c01062fc>] (register_framebuffer+0x0/0x180) from 
[<c010cdb8>] (omapfb_do_)
  r6 = 00000000  r5 = C0BD26A0  r4 = C0BD26A0
[<c010c70c>] (omapfb_do_probe+0x0/0x900) from [<c010d054>] 
(omapfb_register)
[<c010d00c>] (omapfb_register_panel+0x0/0x5c) from 
[<c010e9d4>] (osk_panel_)
[<c010e9c0>] (osk_panel_probe+0x0/0x20) from [<c0130770>] 
(platform_drv_pro)
[<c0130750>] (platform_drv_probe+0x0/0x24) from [<c012eeb8>] 
(driver_probe_)
[<c012ee3c>] (driver_probe_device+0x0/0xcc) from 
[<c012f02c>] (__driver_att)
  r7 = C01E02BC  r6 = C012EFA8  r5 = C01D92F8  r4 = C01D93C4
[<c012efa8>] (__driver_attach+0x0/0xe4) from [<c012e86c>] 
(bus_for_each_dev)
  r5 = C0293F18  r4 = 00000000
[<c012e824>] (bus_for_each_dev+0x0/0x80) from [<c012edcc>] 
(driver_attach+0)
  r7 = 00000001  r6 = C01E41A0  r5 = C01E02BC  r4 = C01E02D0
[<c012edac>] (driver_attach+0x0/0x28) from [<c012e4c8>] 
(bus_add_driver+0x6)
[<c012e45c>] (bus_add_driver+0x0/0x124) from [<c012f320>] 
(driver_register+)
[<c012f28c>] (driver_register+0x0/0xa4) from [<c0130920>] 
(platform_driver_)
  r4 = C001E444
[<c01308b4>] (platform_driver_register+0x0/0x88) from 
[<c010e9b8>] (osk_pan)
[<c010e9a4>] (osk_panel_drv_init+0x0/0x1c) from [<c00210b8>] 
(init+0x8c/0x2)
[<c002102c>] (init+0x0/0x270) from [<c004b8d8>] 
(do_exit+0x0/0x95c)
  r7 = 00000000  r6 = 00000000  r5 = 00000000  r4 = 00000000
Code: e51b1060 028ee008 e0013003 e0233007 (e7883004)
  <0>Kernel panic - not syncing: Attempted to kill init!
