From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: OMAP2+: Add fixed regulator to omap2plus_defconfig
Date: Thu, 21 Nov 2013 10:51:05 -0800
Message-ID: <1385059866-10646-3-git-send-email-tony@atomide.com>
References: <1385059866-10646-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21457 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754685Ab3KUSvL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Nov 2013 13:51:11 -0500
In-Reply-To: <1385059866-10646-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

We do not have REGULATOR_FIXED selected if no boards are selected
and we boot with device tree. This can cause various devices to
fail.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 98a50c3..bfa80a1 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -173,6 +173,7 @@ CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65910=y
 CONFIG_TWL6040_CORE=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
-- 
1.8.1.1

