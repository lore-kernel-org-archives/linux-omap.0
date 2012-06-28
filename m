From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2: Overo: init I2C before MMC to fix MMC suspend/resume failure
Date: Thu, 28 Jun 2012 10:01:31 -0700
Message-ID: <1340902892-9542-2-git-send-email-khilman@ti.com>
References: <1340902892-9542-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:37603 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754274Ab2F1RBi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 13:01:38 -0400
Received: by dadm1 with SMTP id m1so3622469dad.22
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 10:01:37 -0700 (PDT)
In-Reply-To: <1340902892-9542-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

In order for suspend/resume dependencies to work correctly, I2C has to
be initialized (more specifically, registered with the driver core)
before MMC.  Without this, the MMC driver fails to adjust the VMMC
regulator (using i2c writes) during the suspend path.

Problem found testing suspend/resume on 3730/OveroSTORM platform.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/board-overo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 8fa2fc3..779734d 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -494,8 +494,8 @@ static void __init overo_init(void)
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
-	omap_hsmmc_init(mmc);
 	overo_i2c_init();
+	omap_hsmmc_init(mmc);
 	omap_display_init(&overo_dss_data);
 	omap_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params,
-- 
1.7.9.2

