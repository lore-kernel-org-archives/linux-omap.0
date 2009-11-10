From: chudson@kionix.com
Subject: [RFC PATCH 3/3] mach-omap2:mux support for kxte9 accelerometer on OMAP ZoomII
Date: Tue, 10 Nov 2009 13:28:49 -0500
Message-ID: <1257877729-25647-3-git-send-email-chudson@kionix.com>
References: <1257877729-25647-1-git-send-email-chudson@kionix.com>
 <1257877729-25647-2-git-send-email-chudson@kionix.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from barracuda.kionix.com ([205.232.90.213]:33701 "EHLO
	mail.kionix.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755938AbZKJS2a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 13:28:30 -0500
In-Reply-To: <1257877729-25647-2-git-send-email-chudson@kionix.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, Chris Hudson <chudson@kionix.com>

From: Chris Hudson <chudson@kionix.com>

This patch alters mux.c and mux.h to allow gpio configuration in support of the 
kxte9 accelerometer on the OMAP ZoomII platform.

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 arch/arm/mach-omap2/mux.c             |    2 ++
 arch/arm/plat-omap/include/plat/mux.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 32c953e..1158315 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,6 +486,8 @@ MUX_CFG_34XX("AF5_34XX_GPIO142", 0x170,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("AE5_34XX_GPIO143", 0x172,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+MUX_CFG_34XX("Y21_34XX_GPIO156", 0x18c,
+		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
 MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index f3c1d8a..c17905a 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -803,6 +803,7 @@ enum omap34xx_index {
 	AE6_34XX_GPIO141,
 	AF5_34XX_GPIO142,
 	AE5_34XX_GPIO143,
+	Y21_34XX_GPIO156,
 	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
 
-- 
1.5.4.3

