From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/2] arm: configs: omap2plus_defconfig: enable TPS62362 regulator
Date: Thu, 19 Feb 2015 12:03:55 -0600
Message-ID: <1424369035-26423-2-git-send-email-balbi@ti.com>
References: <1424369035-26423-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59587 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbbBSSFB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2015 13:05:01 -0500
In-Reply-To: <1424369035-26423-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

This regulator is used on AM437x Industrial Development Kit.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index b7386524c356..8ff1a988c0f4 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -248,6 +248,7 @@ CONFIG_TWL6040_CORE=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_TI_ABB=y
+CONFIG_REGULATOR_TPS62360=m
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
-- 
2.3.0

