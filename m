From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] memory: omap-gpmc: Add support for AAD timings
Date: Mon, 28 Dec 2015 14:39:20 +0100
Message-ID: <1451309961-7247-2-git-send-email-narmstrong@baylibre.com>
References: <1451309961-7247-1-git-send-email-narmstrong@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451309961-7247-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, Robert ABEL <rabel@cit-ec.uni-bielefeld.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Neil Armstrong <narmstrong@baylibre.com>
List-Id: linux-omap@vger.kernel.org

In order to support extended timings parameters on hardware supporting the
"AAD" mode like the AM335x or DM816x, add these entries into the GPMC driver
if the hardware is capable.

Tested on DM816x and AM335x.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/memory/omap-gpmc.c | 30 ++++++++++++++++++++++++++++++
 include/linux/omap-gpmc.h  |  5 +++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 6515dfc..21825dd 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -541,9 +541,20 @@ static void gpmc_cs_show_timings(int cs, const char *desc)
 	GPMC_GET_TICKS(GPMC_CS_CONFIG3,  0,  3, "adv-on-ns");
 	GPMC_GET_TICKS(GPMC_CS_CONFIG3,  8, 12, "adv-rd-off-ns");
 	GPMC_GET_TICKS(GPMC_CS_CONFIG3, 16, 20, "adv-wr-off-ns");
+	if (gpmc_capability & GPMC_HAS_MUX_AAD) {
+		GPMC_GET_TICKS(GPMC_CS_CONFIG3, 4, 6, "adv-aad-mux-on-ns");
+		GPMC_GET_TICKS(GPMC_CS_CONFIG3, 24, 26,
+				"adv-aad-mux-rd-off-ns");
+		GPMC_GET_TICKS(GPMC_CS_CONFIG3, 28, 30,
+				"adv-aad-mux-wr-off-ns");
+	}
 
 	GPMC_GET_TICKS(GPMC_CS_CONFIG4,  0,  3, "oe-on-ns");
 	GPMC_GET_TICKS(GPMC_CS_CONFIG4,  8, 12, "oe-off-ns");
+	if (gpmc_capability & GPMC_HAS_MUX_AAD) {
+		GPMC_GET_TICKS(GPMC_CS_CONFIG4,  4,  6, "oe-aad-mux-on-ns");
+		GPMC_GET_TICKS(GPMC_CS_CONFIG4, 13, 15, "oe-aad-mux-off-ns");
+	}
 	GPMC_GET_TICKS(GPMC_CS_CONFIG4, 16, 19, "we-on-ns");
 	GPMC_GET_TICKS(GPMC_CS_CONFIG4, 24, 28, "we-off-ns");
 
@@ -734,9 +745,18 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t,
 	GPMC_SET_ONE(GPMC_CS_CONFIG3,  0,  3, adv_on);
 	GPMC_SET_ONE(GPMC_CS_CONFIG3,  8, 12, adv_rd_off);
 	GPMC_SET_ONE(GPMC_CS_CONFIG3, 16, 20, adv_wr_off);
+	if (gpmc_capability & GPMC_HAS_MUX_AAD) {
+		GPMC_SET_ONE(GPMC_CS_CONFIG3,  4,  6, adv_aad_mux_on);
+		GPMC_SET_ONE(GPMC_CS_CONFIG3, 24, 26, adv_aad_mux_rd_off);
+		GPMC_SET_ONE(GPMC_CS_CONFIG3, 28, 30, adv_aad_mux_wr_off);
+	}
 
 	GPMC_SET_ONE(GPMC_CS_CONFIG4,  0,  3, oe_on);
 	GPMC_SET_ONE(GPMC_CS_CONFIG4,  8, 12, oe_off);
+	if (gpmc_capability & GPMC_HAS_MUX_AAD) {
+		GPMC_SET_ONE(GPMC_CS_CONFIG4,  4,  6, oe_aad_mux_on);
+		GPMC_SET_ONE(GPMC_CS_CONFIG4, 13, 15, oe_aad_mux_off);
+	}
 	GPMC_SET_ONE(GPMC_CS_CONFIG4, 16, 19, we_on);
 	GPMC_SET_ONE(GPMC_CS_CONFIG4, 24, 28, we_off);
 
@@ -1722,6 +1742,12 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 	of_property_read_u32(np, "gpmc,adv-on-ns", &gpmc_t->adv_on);
 	of_property_read_u32(np, "gpmc,adv-rd-off-ns", &gpmc_t->adv_rd_off);
 	of_property_read_u32(np, "gpmc,adv-wr-off-ns", &gpmc_t->adv_wr_off);
+	of_property_read_u32(np, "gpmc,adv-aad-mux-on-ns",
+			     &gpmc_t->adv_aad_mux_on);
+	of_property_read_u32(np, "gpmc,adv-aad-mux-rd-off-ns",
+			     &gpmc_t->adv_aad_mux_rd_off);
+	of_property_read_u32(np, "gpmc,adv-aad-mux-wr-off-ns",
+			     &gpmc_t->adv_aad_mux_wr_off);
 
 	/* WE signal timings */
 	of_property_read_u32(np, "gpmc,we-on-ns", &gpmc_t->we_on);
@@ -1730,6 +1756,10 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
 	/* OE signal timings */
 	of_property_read_u32(np, "gpmc,oe-on-ns", &gpmc_t->oe_on);
 	of_property_read_u32(np, "gpmc,oe-off-ns", &gpmc_t->oe_off);
+	of_property_read_u32(np, "gpmc,oe-aad-mux-on-ns",
+			     &gpmc_t->oe_aad_mux_on);
+	of_property_read_u32(np, "gpmc,oe-aad-mux-off-ns",
+			     &gpmc_t->oe_aad_mux_off);
 
 	/* access and cycle timings */
 	of_property_read_u32(np, "gpmc,page-burst-access-ns",
diff --git a/include/linux/omap-gpmc.h b/include/linux/omap-gpmc.h
index 7dee0014..d833eb4 100644
--- a/include/linux/omap-gpmc.h
+++ b/include/linux/omap-gpmc.h
@@ -51,6 +51,9 @@ struct gpmc_timings {
 	u32 adv_on;		/* Assertion time */
 	u32 adv_rd_off;		/* Read deassertion time */
 	u32 adv_wr_off;		/* Write deassertion time */
+	u32 adv_aad_mux_on;	/* ADV assertion time for AAD */
+	u32 adv_aad_mux_rd_off;	/* ADV read deassertion time for AAD */
+	u32 adv_aad_mux_wr_off;	/* ADV write deassertion time for AAD */
 
 	/* WE signals timings corresponding to GPMC_CONFIG4 */
 	u32 we_on;		/* WE assertion time */
@@ -59,6 +62,8 @@ struct gpmc_timings {
 	/* OE signals timings corresponding to GPMC_CONFIG4 */
 	u32 oe_on;		/* OE assertion time */
 	u32 oe_off;		/* OE deassertion time */
+	u32 oe_aad_mux_on;	/* OE assertion time for AAD */
+	u32 oe_aad_mux_off;	/* OE deassertion time for AAD */
 
 	/* Access time and cycle time timings corresponding to GPMC_CONFIG5 */
 	u32 page_burst_access;	/* Multiple access word delay */
-- 
1.9.1
