From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/8] ehci: adding mux pin for EHCI phy reset line
Date: Fri, 10 Jul 2009 14:47:08 +0530
Message-ID: <1247217434-6309-2-git-send-email-ajay.gupta@ti.com>
References: <1247217434-6309-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41151 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752267AbZGJJRd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jul 2009 05:17:33 -0400
In-Reply-To: <1247217434-6309-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

GPIO135 is used as EHCI (port2) phy reset pin on Multi Media Daughter card
connected to OMAP3EVM.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Resubmitting so that all the patches are together.

 arch/arm/mach-omap2/mux.c             |    2 ++
 arch/arm/plat-omap/include/mach/mux.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 026c4fc..80547cf 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -472,6 +472,8 @@ MUX_CFG_34XX("G25_34XX_GPIO86_OUT", 0x0fc,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("AG4_34XX_GPIO134_OUT", 0x160,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
+MUX_CFG_34XX("AF4_34XX_GPIO135_OUT", 0x162,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("AE4_34XX_GPIO136_OUT", 0x164,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("AF6_34XX_GPIO140_UP", 0x16c,
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 85a6217..498fa0c 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -846,6 +846,7 @@ enum omap34xx_index {
 	L8_34XX_GPIO63,
 	G25_34XX_GPIO86_OUT,
 	AG4_34XX_GPIO134_OUT,
+	AF4_34XX_GPIO135_OUT,
 	AE4_34XX_GPIO136_OUT,
 	AF6_34XX_GPIO140_UP,
 	AE6_34XX_GPIO141,
-- 
1.6.2.4

