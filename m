From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 4/8] ARM: omap2: gpmc-nand: Print something useful on CS request failure
Date: Tue, 12 Feb 2013 12:18:21 -0300
Message-ID: <1360682305-20935-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45380 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933181Ab3BLPSa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Feb 2013 10:18:30 -0500
In-Reply-To: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Afzal Mohammed <afzal@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

If CS request fails the current error message is rather unhelpful.
Fix it by printing the failing chip select and the error code.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc-nand.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index afc1e8c..e50e438 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -122,7 +122,8 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 	err = gpmc_cs_request(gpmc_nand_data->cs, NAND_IO_SIZE,
 				(unsigned long *)&gpmc_nand_resource[0].start);
 	if (err < 0) {
-		dev_err(dev, "Cannot request GPMC CS\n");
+		dev_err(dev, "Cannot request GPMC CS %d, error %d\n",
+			gpmc_nand_data->cs, err);
 		return err;
 	}
 
-- 
1.7.8.6

