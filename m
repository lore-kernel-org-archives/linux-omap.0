From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 6/6] omap3: beagle: get rid of unused omap2/omap4 specific code/data
Date: Tue, 21 Dec 2010 19:20:04 +0100
Message-ID: <1292955604-8809-7-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44940 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab0LUSVC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 13:21:02 -0500
In-Reply-To: <1292955604-8809-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Petazzoni <tpetazzoni@ti.com>, Thomas Petazzoni <t-petazzoni@ti.com>

From: Thomas Petazzoni <tpetazzoni@ti.com>

Using the new condsections infrastructure, get rid of the unused
code/data for OMAP2 and OMAP4 when booting on BeagleBoard OMAP3.

Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 14f4224..900964a 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
+#include <linux/condsections.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -581,6 +582,9 @@ static void __init omap3_beagle_init(void)
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
 
 	beagle_display_init();
+
+	free_unused_cond_section("omap2");
+	free_unused_cond_section("omap4");
 }
 
 MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
-- 
1.7.0.4

