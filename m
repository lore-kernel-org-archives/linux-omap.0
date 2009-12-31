From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 4/10] OPP layer and additional cleanups.
Date: Thu, 31 Dec 2009 18:59:16 +0530
Message-ID: <1262266156.20175.180.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40817 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbZLaN3X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Dec 2009 08:29:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Remove unnecessary forward declaration of struct omap_opp.


diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 6c77b03..7e5319f 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -268,7 +268,6 @@ extern void omap_writew(u16 v, u32 pa);
 extern void omap_writel(u32 v, u32 pa);
 
 struct omap_sdrc_params;
-struct omap_opp;
 
 extern void omap1_map_common_io(void);
 extern void omap1_init_common_hw(void);


