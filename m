From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] OMAP: fix gpmc nand setup when no timings supplied
Date: Mon, 19 Apr 2010 12:50:18 +0300
Message-ID: <1271670618-5671-1-git-send-email-mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:52429 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650Ab0DSJvU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Apr 2010 05:51:20 -0400
Received: from [62.90.235.247] (helo=zimbra-mta.compulab.co.il)
	by compulab.site5.com with esmtp (Exim 4.69)
	(envelope-from <mike@compulab.co.il>)
	id 1O3ndO-0001iu-SW
	for linux-omap@vger.kernel.org; Mon, 19 Apr 2010 04:51:19 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.compulab.co.il (Postfix) with ESMTP id C6C3D9A028A
	for <linux-omap@vger.kernel.org>; Mon, 19 Apr 2010 12:51:17 +0300 (IDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mike Rapoport <mike@compulab.co.il>

The gpmc nand infrastructure crashes when there no timing structure
supplied in the omap_nand_platform_data. Adding check for
gpmc_nand_data->gpmc_t pointer validity resolves the crash and allows to
continue nand initialization without modifying gpmc timings.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/gpmc-nand.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 64d74f0..3629da3 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -83,6 +83,11 @@ static int gpmc_nand_setup(void)
 {
 	struct device *dev = &gpmc_nand_device.dev;
 
+	if (!gpmc_nand_data->gpmc_t) {
+		dev_info(dev, "Keeping gpmc timings\n");
+		return 0;
+	}
+
 	/* Set timings in GPMC */
 	if (omap2_nand_gpmc_retime() < 0) {
 		dev_err(dev, "Unable to set gpmc timings\n");
-- 
1.6.6.2

