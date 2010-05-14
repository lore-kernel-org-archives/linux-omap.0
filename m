From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH 1/2] omap: 3630: introduce CHIP_GE_3630ES1_1
Date: Fri, 14 May 2010 17:36:06 +0530
Message-ID: <1273838767-16638-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59157 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756791Ab0ENMGM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 08:06:12 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4EC68lU032420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 07:06:11 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

Introduce CHIP_GE_3630ES1_1 macro to cover 3630ES1.1 and later
silicon reviesions. (Currently this is set to 3630 ES1.1 only).

This is needed for at least one feature that is broken in
3630ES1.0 but exists on older (3430 ES3.1) and newer revisions.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
Okay with me to fold this into the patch [1] that adds
3630 silicon revision support.

[1] https://patchwork.kernel.org/patch/95684/

 arch/arm/plat-omap/include/plat/cpu.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-omap-2.6/arch/arm/plat-omap/include/plat/cpu.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/plat/cpu.h
+++ linux-omap-2.6/arch/arm/plat-omap/include/plat/cpu.h
@@ -431,6 +431,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 					 CHIP_IS_OMAP3630ES1)
 #define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1 | \
 					 CHIP_IS_OMAP3630ES1)
+#define CHIP_GE_OMAP3630ES1_1		(CHIP_IS_OMAP3630ES1_1)
 
 
 int omap_chip_is(struct omap_chip_id oci);
