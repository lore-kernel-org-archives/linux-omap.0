From: Sanjeev Premi <premi@ti.com>
Subject: [RFC] omap3: Fix incorrect restore pointer
Date: Fri, 19 Mar 2010 15:53:00 +0530
Message-ID: <1268994180-25170-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40182 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab0CSKXZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Mar 2010 06:23:25 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2JANMsr002877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 05:23:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Due to check for absolute omap_rev() values against
ES3.0 and ES3.1, the restore pointer for OMAP3630 is
incorrectly assigned.

The problem may be observed with OMAP3430 ES3.1.1
as well.

Submitting this as RFC because I have only compiled
with changes. Haven't yet tried on EVM. Will submit
formal patch after testing.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/control.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 43f8a33..575593b 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -213,13 +213,16 @@ void omap3_save_scratchpad_contents(void)
 
 	/* Populate the Scratchpad contents */
 	scratchpad_contents.boot_config_ptr = 0x0;
-	if (omap_rev() != OMAP3430_REV_ES3_0 &&
-					omap_rev() != OMAP3430_REV_ES3_1)
+
+	if (!cpu_is_omap3630() &&
+		(cpu_is_34xx() &&
+			(omap_rev() < OMAP3430_REV_ES3_0)))
 		scratchpad_contents.public_restore_ptr =
 			virt_to_phys(get_restore_pointer());
 	else
 		scratchpad_contents.public_restore_ptr =
 			virt_to_phys(get_es3_restore_pointer());
+
 	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
 		scratchpad_contents.secure_ram_restore_ptr = 0x0;
 	else
-- 
1.6.6.1

