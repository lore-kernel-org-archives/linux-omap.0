From: Ben Gamari <bgamari.foss@gmail.com>
Subject: [PATCH] beagledaq: Hack in cs_gpios
Date: Tue, 30 Aug 2011 09:52:23 -0400
Message-ID: <1314712343-27367-1-git-send-email-bgamari.foss@gmail.com>
References: <1314712254-27199-1-git-send-email-bgamari.foss@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41887 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab1H3Nwa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Aug 2011 09:52:30 -0400
Received: by qyk34 with SMTP id 34so4497065qyk.19
        for <linux-omap@vger.kernel.org>; Tue, 30 Aug 2011 06:52:29 -0700 (PDT)
In-Reply-To: <1314712254-27199-1-git-send-email-bgamari.foss@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raju Sana <venkat.rajuece@gmail.com>
Cc: beagleboard@googlegroups.com, linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, Ben Gamari <bgamari.foss@gmail.com>

---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 ++--
 arch/arm/mach-omap2/devices.c           |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 67999da..481c1a9 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -661,8 +661,8 @@ static struct spi_board_info beagledaq_mcspi_board_info[] = {
 	},
 };
 
-static int mcspi3_cs_gpios[4];
-static int mcspi4_cs_gpios[4];
+int mcspi3_cs_gpios[4];
+int mcspi4_cs_gpios[4];
 
 static void __init beagledaq_init(void)
 {
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5b8ca68..6808251 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -341,6 +341,9 @@ struct omap_device_pm_latency omap_mcspi_latency[] = {
 	},
 };
 
+extern int mcspi3_cs_gpios[4];
+extern int mcspi4_cs_gpios[4];
+
 static int omap_mcspi_init(struct omap_hwmod *oh, void *unused)
 {
 	struct omap_device *od;
@@ -369,6 +372,18 @@ static int omap_mcspi_init(struct omap_hwmod *oh, void *unused)
 			return -EINVAL;
 	}
 
+	/* HACK: Not enough time to figure out how to export cs_gpios from
+	 * board file to driver correctly */
+	if (spi_num == 2) {
+		// Setup McSPI3 cs_gpios
+		pdata->num_cs = 4;
+		pdata->cs_gpios = mcspi3_cs_gpios;
+	} else if (spi_num == 3) {
+		// Setup McSPI4 cs_gpios
+		pdata->num_cs = 4;
+		pdata->cs_gpios = mcspi4_cs_gpios;
+	}
+
 	spi_num++;
 	od = omap_device_build(name, spi_num, oh, pdata,
 				sizeof(*pdata),	omap_mcspi_latency,
-- 
1.7.4.1

