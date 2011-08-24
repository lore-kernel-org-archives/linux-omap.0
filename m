From: Benoit Cousson <b-cousson@ti.com>
Subject: [RFC PATCH 5/7] OMAP4: board-panda: Remove DT support from regular board
Date: Wed, 24 Aug 2011 12:17:18 +0200
Message-ID: <1314181040-22807-6-git-send-email-b-cousson@ti.com>
References: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58838 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666Ab1HXKTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 06:19:12 -0400
In-Reply-To: <1314181040-22807-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, manjugk@ti.com, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>

In order to avoid conflict with the new omap4-dt.c board file,
remove the .dt_compat entry from the pandaboard regular board
file.
Any DT work for OMAP4 will have to be done on the generic DT
board file to avoid breaking the legacy board support until
DT migration is done.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1c583c7..9aaa960 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -581,11 +581,6 @@ static void __init omap4_panda_map_io(void)
 	omap44xx_map_common_io();
 }
 
-static const char *omap4_panda_match[] __initdata = {
-	"ti,omap4-panda",
-	NULL,
-};
-
 MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	/* Maintainer: David Anders - Texas Instruments Inc */
 	.boot_params	= 0x80000100,
@@ -595,5 +590,4 @@ MACHINE_START(OMAP4_PANDA, "OMAP4 Panda board")
 	.init_irq	= gic_init_irq,
 	.init_machine	= omap4_panda_init,
 	.timer		= &omap4_timer,
-	.dt_compat	= omap4_panda_match,
 MACHINE_END
-- 
1.7.0.4

