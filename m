From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 5/10] OPP layer and additional cleanups
Date: Thu, 31 Dec 2009 18:59:19 +0530
Message-ID: <1262266159.20175.181.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46982 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752183AbZLaN30 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Dec 2009 08:29:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Remove struct omap_opp pointers. The book keeping of OPPs are now
encapsulated within the OPP layer.

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 952d506..67a1850 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -52,12 +52,6 @@ int omap_board_config_size;
 /* used by omap-smp.c and board-4430sdp.c */
 void __iomem *gic_cpu_base_addr;
 
-#ifdef CONFIG_OMAP_PM_NONE
-struct omap_opp *mpu_opps;
-struct omap_opp *dsp_opps;
-struct omap_opp *l3_opps;
-#endif
-
 static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
 {
 	struct omap_board_config_kernel *kinfo = NULL;


