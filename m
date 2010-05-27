From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2] omap3: Increase limit on bootarg 'mpurate'
Date: Thu, 27 May 2010 19:24:46 +0530
Message-ID: <1274968486-27825-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46018 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858Ab0E0NzC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 May 2010 09:55:02 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4RDsxjK023161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 08:55:01 -0500
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
v2: Removed a newline introduced in earlier patch
---
 arch/arm/plat-omap/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 5261a09..4fd1e15 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -186,7 +186,7 @@ static int __init omap_clk_setup(char *str)
 	if (!mpurate)
 		return 1;
 
-	if (mpurate < 1000)
+	if (mpurate < 2000)
 		mpurate *= 1000000;
 
 	return 1;
-- 
1.6.6.1

