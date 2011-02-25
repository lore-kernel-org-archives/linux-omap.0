From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: Initialize iva only if available
Date: Fri, 25 Feb 2011 18:57:20 +0530
Message-ID: <1298640440-4527-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52359 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755669Ab1BYN11 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:27:27 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1PDRNg1017597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 25 Feb 2011 07:27:26 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

IVA device is not present in many OMAP3 variants.

This patch ensures that initialization is tied to
the presence of IVA on the device.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/pm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index d5a102c..6e4eb7f 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -83,7 +83,9 @@ static int _init_omap_device(char *name, struct device **new_dev)
 static void omap2_init_processor_devices(void)
 {
 	_init_omap_device("mpu", &mpu_dev);
-	_init_omap_device("iva", &iva_dev);
+	if (omap3_has_iva())
+		_init_omap_device("iva", &iva_dev);
+
 	if (cpu_is_omap44xx()) {
 		_init_omap_device("l3_main_1", &l3_dev);
 		_init_omap_device("dsp", &dsp_dev);
-- 
1.7.2.2

