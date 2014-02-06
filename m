From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2+: AM43x: Enable in default config
Date: Thu, 6 Feb 2014 14:15:46 +0530
Message-ID: <1391676348-32339-2-git-send-email-lokeshvutla@ti.com>
References: <1391676348-32339-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51970 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbaBFIqU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Feb 2014 03:46:20 -0500
In-Reply-To: <1391676348-32339-1-git-send-email-lokeshvutla@ti.com>
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

