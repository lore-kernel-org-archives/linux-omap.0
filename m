From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 2/3] ARM: OMAP: Add fields to GPMC for OMAP3
Date: Wed, 06 Aug 2008 09:56:51 +0300
Message-ID: <48994B33.20006@nokia.com>
References: <4892C533.50904@nokia.com> <20080804140243.GG8885@atomide.com> <48994A83.8040904@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28350 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbYHFGzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 02:55:25 -0400
In-Reply-To: <48994A83.8040904@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Add fields wr_access and wr_data_mux_bus.

Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
---
 arch/arm/mach-omap2/gpmc.c       |    5 +++++
 include/asm-arm/arch-omap/gpmc.h |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 83984f7..3edcc17 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -217,6 +217,11 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG5, 24, 27, page_burst_access);
 
+	if (cpu_is_omap34xx()) {
+		GPMC_SET_ONE(GPMC_CS_CONFIG6, 16, 19, wr_data_mux_bus);
+		GPMC_SET_ONE(GPMC_CS_CONFIG6, 24, 28, wr_access);
+	}
+
 	/* caller is expected to have initialized CONFIG1 to cover
 	 * at least sync vs async
 	 */
diff --git a/include/asm-arm/arch-omap/gpmc.h b/include/asm-arm/arch-omap/gpmc.h
index 53dc246..2aa1920 100644
--- a/include/asm-arm/arch-omap/gpmc.h
+++ b/include/asm-arm/arch-omap/gpmc.h
@@ -84,6 +84,10 @@ struct gpmc_timings {
 	u16 access;		/* Start-cycle to first data valid delay */
 	u16 rd_cycle;		/* Total read cycle time */
 	u16 wr_cycle;		/* Total write cycle time */
+
+	/* The following are only on OMAP3430 */
+	u16 wr_access;		/* WRACCESSTIME */
+	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
 };
 
 extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
-- 
1.5.4.3

