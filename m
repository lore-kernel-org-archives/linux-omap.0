From: David Lambert <dlambert@ti.com>
Subject: [PATCH 5/5] MAP4: DMIC: Add DMIC codec platform devices
Date: Mon, 27 Dec 2010 22:17:06 -0600
Message-ID: <1293509826-23253-6-git-send-email-dlambert@ti.com>
References: <1293509826-23253-1-git-send-email-dlambert@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59043 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab0L1ERn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Dec 2010 23:17:43 -0500
In-Reply-To: <1293509826-23253-1-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, David Lambert <dlambert@ti.com>

This creates the DMIC codec platform devices.

The platform devices create an instance of the driver during boot up.

Signed-off-by: David Lambert <dlambert@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index df5a425..bf271e5 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -505,6 +505,16 @@ static void __init omap_sfh7741prox_init(void)
 	}
 }
 
+static struct platform_device codec_dmic0 = {
+	.name   = "dmic-codec",
+	.id     = 0,
+};
+
+static inline void omap_dmic_init(void)
+{
+	platform_device_register(&codec_dmic0);
+}
+
 static void __init omap_4430sdp_init(void)
 {
 	int status;
@@ -528,6 +538,7 @@ static void __init omap_4430sdp_init(void)
 		spi_register_board_info(sdp4430_spi_board_info,
 				ARRAY_SIZE(sdp4430_spi_board_info));
 	}
+	omap_dmic_init();
 }
 
 static void __init omap_4430sdp_map_io(void)
-- 
1.7.0.4

