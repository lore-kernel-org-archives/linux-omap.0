From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 3/5] ZOOM: DSS2: Mux changes to enable zoom display
Date: Fri, 20 Nov 2009 19:58:01 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940254331087@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50704 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbZKTO15 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 09:27:57 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKES0en024190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 08:28:02 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAKES0sT020387
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 19:58:00 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From d8dc84fb92a6083729599f1d45e467e66495fec7 Mon Sep 17 00:00:00 2001
From: Mukund Mittal <mmittal@ti.com>
Date: Tue, 10 Nov 2009 15:11:39 +0530
Subject: [PATCH] ZOOM: DSS2: Mux changes to enable zoom display

Changes made in mux files to enable display on zoom boards

Signed-off-by: Kishore Y <kishore.y@ti.com>
---
 arch/arm/mach-omap2/mux.c             |    5 +++++
 arch/arm/plat-omap/include/plat/mux.h |    3 +++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 714550f..86d6152 100755
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -549,6 +549,11 @@ MUX_CFG_34XX("AF13_3430_MMC3_DAT2", 0x5e8,
 MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
 		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
 
+MUX_CFG_34XX("C25_34XX_GPIO96", 0x110,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("T8_34XX_GPIO55", 0x0B6,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+
 /* SYS_NIRQ T2 INT1 */
 MUX_CFG_34XX("AF26_34XX_SYS_NIRQ", 0x1E0,
 		OMAP3_WAKEUP_EN | OMAP34XX_PIN_INPUT_PULLUP |
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index 86d8cad..59149f1 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -839,6 +839,9 @@ enum omap34xx_index {
 	AF13_3430_MMC3_DAT2,
 	AF13_3430_MMC3_DAT3,
 
+	C25_34XX_GPIO96,
+	T8_34XX_GPIO55,
+
 	/* SYS_NIRQ T2 INT1 */
 	AF26_34XX_SYS_NIRQ,
 };
-- 
1.5.4.3


Regards,
Kishore Y
Ph:- +918039813085

