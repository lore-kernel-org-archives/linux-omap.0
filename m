From: sricharan <r.sricharan@ti.com>
Subject: [PATCH 1/5] OMAP4: hsmmc: Initialise the mmc mux pins
Date: Mon, 15 Nov 2010 13:08:01 +0530
Message-ID: <1289806685-20688-2-git-send-email-r.sricharan@ti.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39685 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945Ab0KOHf2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Nov 2010 02:35:28 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAF7ZPAf026153
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 01:35:27 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAF7ZO9a024066
	for <linux-omap@vger.kernel.org>; Mon, 15 Nov 2010 13:05:24 +0530 (IST)
In-Reply-To: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Use the mux framework to initialise the mmc mux pins.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/devices.c |   83 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index eaf3799..56b1ac9 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -784,6 +784,89 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 		 * For MMC3 the pins need to be muxed in the board-*.c files
 		 */
 	}
+
+	if (cpu_is_omap44xx()) {
+		switch (controller_nr) {
+		case 0:
+			/* MMC 1 */
+			omap_mux_init_signal("sdmmc1_clk.sdmmc1_clk",
+						OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc1_cmd.sdmmc1_cmd",
+						OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc1_dat0.sdmmc1_dat0",
+						OMAP_PIN_INPUT_PULLUP);
+			if (mmc_controller->slots[0].caps &
+				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
+				omap_mux_init_signal("sdmmc1_dat1.sdmmc1_dat1",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat2.sdmmc1_dat2",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat3.sdmmc1_dat3",
+						OMAP_PIN_INPUT_PULLUP);
+			}
+			if (mmc_controller->slots[0].caps &
+						MMC_CAP_8_BIT_DATA) {
+				omap_mux_init_signal("sdmmc1_dat4.sdmmc1_dat4",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat5.sdmmc1_dat5",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat6.sdmmc1_dat6",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc1_dat7.sdmmc1_dat7",
+						OMAP_PIN_INPUT_PULLUP);
+			}
+			break;
+		case 1:
+			/* MMC2 */
+			omap_mux_init_signal("gpmc_noe.sdmmc2_clk",
+						OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("gpmc_nwe.sdmmc2_cmd",
+						OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("gpmc_ad0.sdmmc2_dat0",
+						OMAP_PIN_INPUT_PULLUP);
+			if (mmc_controller->slots[0].caps &
+				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
+				omap_mux_init_signal("gpmc_ad1.sdmmc2_dat1",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("gpmc_ad2.sdmmc2_dat2",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("gpmc_ad3.sdmmc2_dat3",
+						OMAP_PIN_INPUT_PULLUP);
+			}
+			if (mmc_controller->slots[0].caps &
+							MMC_CAP_8_BIT_DATA) {
+				omap_mux_init_signal("gpmc_ad4.sdmmc2_dat4",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("gpmc_ad5.sdmmc2_dat5",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("gpmc_ad6.sdmmc2_dat6",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("gpmc_ad7.sdmmc2_dat7",
+						OMAP_PIN_INPUT_PULLUP);
+			}
+			break;
+		case 4:
+			/* MMC5 only for omap4 */
+			omap_mux_init_signal("sdmmc5_clk.sdmmc5_clk",
+						OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc5_cmd.sdmmc5_cmd",
+						OMAP_PIN_INPUT_PULLUP);
+			omap_mux_init_signal("sdmmc5_dat0.sdmmc5_dat0",
+						OMAP_PIN_INPUT_PULLUP);
+			if (mmc_controller->slots[0].caps &
+				MMC_CAP_4_BIT_DATA) {
+				omap_mux_init_signal("sdmmc5_dat1.sdmmc5_dat1",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc5_dat2.sdmmc5_dat2",
+						OMAP_PIN_INPUT_PULLUP);
+				omap_mux_init_signal("sdmmc5_dat3.sdmmc5_dat3",
+						OMAP_PIN_INPUT_PULLUP);
+			}
+			break;
+		default:
+			break;
+		}
+	}
 }
 
 void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
-- 
1.7.0.4

