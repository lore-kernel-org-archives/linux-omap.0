From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/3] Minor OMAP DTS fixes
Date: Tue, 22 Apr 2014 17:23:34 -0500
Message-ID: <1398205417-1575-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59433 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbaDVWYI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 18:24:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Tony, Benoit,

This series includes couple of minor fixes in the OMAP DTS files. The patches
are based on 3.15-rc2.

The first patch fixes the only WARN_ON trace present during kernel boot on
OMAP5 uEVM, and this has been present since some time now. 
[    0.045578] ------------[ cut here ]------------
[    0.045598] WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2538 _init+0x1c0/0x3dc()
[    0.045605] omap_hwmod: mailbox: doesn't have mpu register target base
[    0.045611] Modules linked in:
[    0.045625] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.15.0-rc2-00001-gb5e85a0 #45
[    0.045653] [<c0015724>] (unwind_backtrace) from [<c00120f4>] (show_stack+0x10/0x14)
[    0.045672] [<c00120f4>] (show_stack) from [<c05a1ccc>] (dump_stack+0x78/0x94)
[    0.045686] [<c05a1ccc>] (dump_stack) from [<c0042a74>] (warn_slowpath_common+0x6c/0x8c)
[    0.045698] [<c0042a74>] (warn_slowpath_common) from [<c0042b28>] (warn_slowpath_fmt+0x30/0x40)
[    0.045710] [<c0042b28>] (warn_slowpath_fmt) from [<c0803b40>] (_init+0x1c0/0x3dc)
[    0.045724] [<c0803b40>] (_init) from [<c0029c8c>] (omap_hwmod_for_each+0x34/0x5c)
[    0.045736] [<c0029c8c>] (omap_hwmod_for_each) from [<c08042b0>] (__omap_hwmod_setup_all+0x24/0x40)
[    0.045748] [<c08042b0>] (__omap_hwmod_setup_all) from [<c00088b8>] (do_one_initcall+0x34/0x160)
[    0.045761] [<c00088b8>] (do_one_initcall) from [<c07f7bf4>] (kernel_init_freeable+0xfc/0x1c8)
[    0.045772] [<c07f7bf4>] (kernel_init_freeable) from [<c059c4f4>] (kernel_init+0x8/0xe4)
[    0.045784] [<c059c4f4>] (kernel_init) from [<c000eaa8>] (ret_from_fork+0x14/0x2c)
[    0.045826] ---[ end trace c25fc521f2569d3c ]---

The last patch eliminates the following traces on AM3517 based boards.
[    0.418496] platform iva.2: Cannot lookup hwmod 'iva'
[    0.454352] platform 48094000.mailbox: Cannot lookup hwmod 'mailbox'
[    0.460610] platform 480bd400.mmu: Cannot lookup hwmod 'mmu_isp'
[    0.464065] platform 480c9000.smartreflex: Cannot lookup hwmod 'smartreflex_mpu_iva'

There are a few other such traces remaining, but these are all on valid nodes.
[    0.420275] platform 480c5000.aes: Cannot lookup hwmod 'aes'
[    0.462403] platform 480c3000.sham: Cannot lookup hwmod 'sham'
[    0.463246] platform 480cb000.smartreflex: Cannot lookup hwmod 'smartreflex_core'
[    0.477243] platform 480ab000.usb_otg_hs: Cannot lookup hwmod 'usb_otg_hs'

regards
Suman

Suman Anna (3):
  ARM: dts: OMAP5: Add mailbox dt node to fix boot warning
  ARM: dts: OMAP2: Fix interrupts for OMAP2420 mailbox
  ARM: dts: AM3517: Disable absent IPs inherited from OMAP3

 arch/arm/boot/dts/am3517.dtsi   | 16 ++++++++++++++++
 arch/arm/boot/dts/omap2.dtsi    |  7 -------
 arch/arm/boot/dts/omap2420.dtsi |  8 ++++++++
 arch/arm/boot/dts/omap2430.dtsi |  7 +++++++
 arch/arm/boot/dts/omap3.dtsi    |  2 +-
 arch/arm/boot/dts/omap5.dtsi    |  7 +++++++
 6 files changed, 39 insertions(+), 8 deletions(-)

-- 
1.9.2

