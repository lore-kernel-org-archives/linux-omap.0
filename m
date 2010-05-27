From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap3: Increase limit on bootarg 'mpurate'
Date: Thu, 27 May 2010 19:16:58 +0530
Message-ID: <1274968018-27333-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51991 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab0E0NrZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 May 2010 09:47:25 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4RDlLSH004967
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 08:47:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The value of mpurate is currently expected to be less
than 1000 when specified in MHz.

This patch raises this limit to 2000 to support 1GHz
capable processors. The new limit should be reasonable
for quite some time.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/plat-omap/clock.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 5261a09..7ea757e 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -175,6 +175,7 @@ EXPORT_SYMBOL(clk_get_parent);
 
 int __initdata mpurate;
 
+
 /*
  * By default we use the rate set by the bootloader.
  * You can override this with mpurate= cmdline option.
@@ -186,7 +187,7 @@ static int __init omap_clk_setup(char *str)
 	if (!mpurate)
 		return 1;
 
-	if (mpurate < 1000)
+	if (mpurate < 2000)
 		mpurate *= 1000000;
 
 	return 1;
-- 
1.6.6.1

