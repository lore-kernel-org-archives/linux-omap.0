From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Boot failure on OMAP 3430 SDP
Date: Fri, 20 Jun 2008 20:03:31 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB022BE46296@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:52884 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672AbYFTOdo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jun 2008 10:33:44 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "jouni.hogander@nokia.com" <jouni.hogander@nokia.com>, Paul Walmsley <paul@pwsan.com>

Hi all,

Commit 5b36d70fa08f09de161487fe7f6e04200ffb8d71 breaks boot on OMAP3430 SDP. Reversing the patch allows the boot to work.

Bootlog and the patch are shown below.

Regards,
Anand

================================================

commit 5b36d70fa08f09de161487fe7f6e04200ffb8d71
Author: Jouni Hogander <jouni.hogander@nokia.com>
Date:   Mon Jun 9 12:32:40 2008 +0300

    PRCM: OMAP3: Fix to wrongly modified omap2_clk_wait_ready

    omap2_clk_wait_ready was wrongly modified to check
    registers contents. This fix changes it back to check
    addresses.

    Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
    Acked-by: Paul Walmsley <paul@pwsan.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d3ab537..ed15868 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -246,8 +246,8 @@ static void omap2_clk_wait_ready(struct clk *clk)
        /* REVISIT: What are the appropriate exclusions for 34XX? */
        /* OMAP3: ignore DSS-mod clocks */
        if (cpu_is_omap34xx() &&
-           ((reg & ~0xff) == cm_read_mod_reg(OMAP3430_DSS_MOD, 0) ||
-            (((reg & ~0xff) == cm_read_mod_reg(CORE_MOD, 0)) &&
+           ((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, 0) ||
+            (((reg & ~0xff) == (__force u32)OMAP34XX_CM_REGADDR(CORE_MOD, 0)) &&
              clk->enable_bit == OMAP3430_EN_SSI_SHIFT)))
                return;

==============================================================================
<6>omapfb: configured for panel sdp2430
<6>omapfb: DISPC version 3.0 initialized
<1>Unhandled fault: external abort on non-linefetch (0x1028) at 0xd80504a0
Internal error: : 1028 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.26-rc6-omap1 #4)
PC is at omap_dispc_enable_plane+0x40/0x68
LR is at omap2_clk_enable+0x5c/0x9c
pc : [<c017f948>]    lr : [<c0035ce4>]    psr: 60000013
sp : c7c1ddd8  ip : c034c534  fp : c7c1ddf4
r10: 00000000  r9 : c7d16000  r8 : 00000001
r7 : c7d16004  r6 : c037848c  r5 : 00000001  r4 : 00000000
r3 : c029dab0  r2 : 000000a0  r1 : d8050400  r0 : 00000000
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387f  Table: 80004018  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc7c1c2e0)
Stack: (0xc7c1ddd8 to 0xc7c1e000)
ddc0:                                                       c7d7fc00 c0378424
dde0: c7d7fe30 c7d16004 c7c1de4c c7c1ddf8 c017e888 c017f914 c7c1de30 c7c1de30
de00: c7c1de2c c7d16000 c00d9c04 69c1de30 7265746e 006c616e 00000000 00000000
de20: c7c1de5c c034e418 c034e4c0 c035ceb0 c035ceb0 c0360bd0 00000000 c0023bdc
de40: c7c1de5c c7c1de50 c017ebec c017e380 c7c1de6c c7c1de60 c0181354 c017ebc0
de60: c7c1de7c c7c1de70 c01a134c c018134c c7c1de9c c7c1de80 c01a0708 c01a1338
de80: c034e418 c034e4c0 c035ceb0 c035ceb0 c7c1debc c7c1dea0 c01a0800 c01a0644
dea0: 00000000 c7c1dec4 c01a07b4 c035ceb0 c7c1deec c7c1dec0 c019fd80 c01a07c0
dec0: 00000000 c7c037d8 c7c037d8 c034e460 00000000 c035ceb0 00000000 c7c6c9e0
dee0: c7c1defc c7c1def0 c01a0550 c019fd40 c7c1df2c c7c1df00 c01a020c c01a053c
df00: c02fd3ea c035ceb0 00000000 c0024000 c035ceb0 00000000 c0019364 c7c1c000
df20: c7c1df54 c7c1df30 c01a09f4 c01a0170 c0024000 00000000 00000000 c0019364
df40: c7c1c000 c0023bdc c7c1df64 c7c1df58 c01a15d4 c01a0968 c7c1df74 c7c1df68
df60: c0019378 c01a1574 c7c1dff4 c7c1df78 c0008928 c0019370 00050000 01004000
df80: c7c1c000 00000000 c7c1df00 c7c1df98 c004bf3c c004bc04 00000000 00000000
dfa0: 00000000 c7c1dfb0 c002bac4 c004bf24 00000000 00000000 c0008888 c0051ecc
dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 c7c1dff8 c0051ecc c0008894 ffffffff ffffffff
Backtrace:
[<c017f908>] (omap_dispc_enable_plane+0x0/0x68) from [<c017e888>] (omapfb_do_probe+0x514/0x840)
 r7:c7d16004 r6:c7d7fe30 r5:c0378424 r4:c7d7fc00
[<c017e374>] (omapfb_do_probe+0x0/0x840) from [<c017ebec>] (omapfb_register_panel+0x38/0x40)
[<c017ebb4>] (omapfb_register_panel+0x0/0x40) from [<c0181354>] (sdp2430_panel_probe+0x14/0x20)
[<c0181340>] (sdp2430_panel_probe+0x0/0x20) from [<c01a134c>] (platform_drv_probe+0x20/0x24)
[<c01a132c>] (platform_drv_probe+0x0/0x24) from [<c01a0708>] (driver_probe_device+0xd0/0x17c)
[<c01a0638>] (driver_probe_device+0x0/0x17c) from [<c01a0800>] (__driver_attach+0x4c/0x70)
 r7:c035ceb0 r6:c035ceb0 r5:c034e4c0 r4:c034e418
[<c01a07b4>] (__driver_attach+0x0/0x70) from [<c019fd80>] (bus_for_each_dev+0x4c/0x84)
 r7:c035ceb0 r6:c01a07b4 r5:c7c1dec4 r4:00000000
[<c019fd34>] (bus_for_each_dev+0x0/0x84) from [<c01a0550>] (driver_attach+0x20/0x28)
 r7:c7c6c9e0 r6:00000000 r5:c035ceb0 r4:00000000
[<c01a0530>] (driver_attach+0x0/0x28) from [<c01a020c>] (bus_add_driver+0xa8/0x214)
[<c01a0164>] (bus_add_driver+0x0/0x214) from [<c01a09f4>] (driver_register+0x98/0x120)
 r8:c7c1c000 r7:c0019364 r6:00000000 r5:c035ceb0 r4:c0024000
[<c01a095c>] (driver_register+0x0/0x120) from [<c01a15d4>] (platform_driver_register+0x6c/0x88)
[<c01a1568>] (platform_driver_register+0x0/0x88) from [<c0019378>] (sdp2430_panel_drv_init+0x14/0x1c)
[<c0019364>] (sdp2430_panel_drv_init+0x0/0x1c) from [<c0008928>] (kernel_init+0xa0/0x230)
[<c0008888>] (kernel_init+0x0/0x230) from [<c0051ecc>] (do_exit+0x0/0x5fc)
Code: e59f302c e5961000 e3a00000 e7932104 (e7923001)
<4>---[ end trace da227214a82491b7 ]---
<0>Kernel panic - not syncing: Attempted to kill init!


