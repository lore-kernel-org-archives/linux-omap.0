From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH V2 1/4] ARM: OMAP2+: AM43x: enable in default config
Date: Fri, 7 Feb 2014 15:51:23 +0530
Message-ID: <1391768486-2134-2-git-send-email-lokeshvutla@ti.com>
References: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35679 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbaBGKWE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Feb 2014 05:22:04 -0500
In-Reply-To: <1391768486-2134-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, linux@arm.linux.org.uk, rnayak@ti.com, nsekhar@ti.com, lokeshvutla@ti.com

From: Afzal Mohammed <afzal@ti.com>

Enable AM43x SoC in omap2plus_defconfig

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3a0b53d..364ba38 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -28,6 +28,7 @@ CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
 CONFIG_SOC_AM33XX=y
+CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
-- 
1.7.9.5

