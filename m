From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP2+: gpmc-smsc911x: only register regulator for first instance
Date: Tue,  6 Mar 2012 16:39:31 -0800
Message-ID: <1331080771-30687-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:40414 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756654Ab2CGAjY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 19:39:24 -0500
Received: by mail-iy0-f182.google.com with SMTP id k25so12538406iah.27
        for <linux-omap@vger.kernel.org>; Tue, 06 Mar 2012 16:39:23 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Matt Porter <mporter@ti.com>

commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
regulators) added regulators which are registered during
gpmc_smsc911x_init().  However, some platforms (OMAP3/Overo) have more
than one instance of the SMSC911x and result in attempting to register
the same regulator more than once which causes a panic().

Fix this by only registering the regulator when the platform_data id
field is zero, indicating its the first instance.

Cc: Matt Porter <mporter@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Fix needed for v3.3.
Applies on top of Tony's fixes branch.

 arch/arm/mach-omap2/gpmc-smsc911x.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
index bbb870c..4d6f1c6 100644
--- a/arch/arm/mach-omap2/gpmc-smsc911x.c
+++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
@@ -101,10 +101,13 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
 
 	gpmc_cfg = board_data;
 
-	ret = platform_device_register(&gpmc_smsc911x_regulator);
-	if (ret < 0) {
-		pr_err("Unable to register smsc911x regulators: %d\n", ret);
-		return;
+	if (!gpmc_cfg) {
+		ret = platform_device_register(&gpmc_smsc911x_regulator);
+		if (ret < 0) {
+			pr_err("Unable to register smsc911x regulators: %d\n",
+			       ret);
+			return;
+		}
 	}
 
 	if (gpmc_cs_request(gpmc_cfg->cs, SZ_16M, &cs_mem_base) < 0) {
-- 
1.7.9.2

