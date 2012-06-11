From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
Date: Mon, 11 Jun 2012 19:32:00 +0530
Message-ID: <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
References: <cover.1339419244.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48417 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab2FKORl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:17:41 -0400
In-Reply-To: <cover.1339419244.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Configure busturnaround, cycle2cycledelay, waitmonitoringtime,
clkactivationtime in gpmc_cs_set_timings(). This is done so
that boards can configure these parameters of gpmc in Kernel
instead of relying on bootloader.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc.c             |    6 ++++++
 arch/arm/plat-omap/include/plat/gpmc.h |    6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 578fd4c..517953f 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -313,6 +313,12 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
 
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 0, 3, bus_turnaround);
+	GPMC_SET_ONE(GPMC_CS_CONFIG6, 8, 11, cycle2cycle_delay);
+
+	GPMC_SET_ONE(GPMC_CS_CONFIG1, 18, 19, wait_monitoring);
+	GPMC_SET_ONE(GPMC_CS_CONFIG1, 25, 26, clk_activation);
+
 	if (cpu_is_omap34xx()) {
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
 		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index 2e6e259..802fb22 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -128,6 +128,12 @@ struct gpmc_timings {
 	u16 rd_cycle;		/* Total read cycle time */
 	u16 wr_cycle;		/* Total write cycle time */
 
+	u16 bus_turnaround;
+	u16 cycle2cycle_delay;
+
+	u16 wait_monitoring;
+	u16 clk_activation;
+
 	/* The following are only on OMAP3430 */
 	u16 wr_access;		/* WRACCESSTIME */
 	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
-- 
1.7.10.2

