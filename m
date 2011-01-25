From: David Lambert <dlambert@ti.com>
Subject: [PATCH v3 4/4] OMAP4: DMIC: Add DMIC codec platform devices
Date: Tue, 25 Jan 2011 16:01:02 -0600
Message-ID: <1295992862-6154-5-git-send-email-dlambert@ti.com>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55424 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753779Ab1AYWBj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 17:01:39 -0500
In-Reply-To: <1295992862-6154-1-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, David Lambert <dlambert@ti.com>

This creates the DMIC codec platform devices.

The platform devices create an instance of the driver during boot up.

Signed-off-by: David Lambert <dlambert@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index df5a425..e7745cf 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -505,6 +505,16 @@ static void __init omap_sfh7741prox_init(void)
 	}
 }
 
+static struct platform_device codec_dmic0 = {
+	.name   = "dmic-codec",
+	.id     = -1,
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

