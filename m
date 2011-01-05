From: tom.leiming@gmail.com
Subject: [PATCH] arm: omap4: panda: remove usb_nop_xceiv_register(v1)
Date: Wed,  5 Jan 2011 22:03:21 +0800
Message-ID: <1294236201-4114-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55823 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab1AEODp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 09:03:45 -0500
Received: by iyi12 with SMTP id 12so13932338iyi.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Jan 2011 06:03:45 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, arm-kernel@lists.infradead.org, Ming Lei <tom.leiming@gmail.com>

From: Ming Lei <tom.leiming@gmail.com>

Panda uses both twl6030 otg phy(vbus, id) and internal
phy(data lines, DP/DM), so removes usb_nop_xceiv_register to make
twl6030 otg driver working since current otg code only supports
one global transceiver. Otherwise, musb doesn't work without
the remove.

Reviewd-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
v1: fix commit log pointed by Felipe.
---
 arch/arm/mach-omap2/board-omap4panda.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1ecd0a6..802ae20 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -374,8 +374,6 @@ static void __init omap4_panda_init(void)
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
-	/* OMAP4 Panda uses internal transceiver so register nop transceiver */
-	usb_nop_xceiv_register();
 	omap4_ehci_init();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
-- 
1.7.3

