From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 2/8] ARM: OMAP2+: omap2plus_defconfig: Enable tps65910 PMIC
Date: Fri, 14 Dec 2012 11:02:58 +0530
Message-ID: <1355463184-16283-3-git-send-email-anilkumar@ti.com>
References: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44721 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756Ab2LNFdd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 00:33:33 -0500
In-Reply-To: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

AM335X-EVM and AM335X-EVMSK devices have tps65910 PMIC regulator, one
has to manually enable this support to use regulators. So this patch
enables tps65910 mfd and regulator driver in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 19b7311..27bf465 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -133,10 +133,12 @@ CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
 CONFIG_MFD_TPS65217=y
+CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
+CONFIG_REGULATOR_TPS65910=y
 CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_MODE_HELPERS=y
-- 
1.7.9.5

