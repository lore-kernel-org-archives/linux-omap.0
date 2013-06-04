From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net-next PATCH 5/8] ARM: OMAP2+: omap2plus_defconfig: Enable Atheros support
Date: Tue, 4 Jun 2013 11:40:08 +0530
Message-ID: <1370326212-17580-6-git-send-email-mugunthanvnm@ti.com>
References: <1370326212-17580-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35194 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759203Ab3FDGJv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jun 2013 02:09:51 -0400
In-Reply-To: <1370326212-17580-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, benoit.cousson@linaro.org, paul@pwsan.com, Mugunthan V N <mugunthanvnm@ti.com>

Enable Atheros 803X phy driver support in defconfig which is present in
AM335x EVM and EVM Starter Kit.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 435d69b..aa21009 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -283,3 +283,4 @@ CONFIG_SOC_OMAP5=y
 CONFIG_TI_DAVINCI_MDIO=y
 CONFIG_TI_DAVINCI_CPDMA=y
 CONFIG_TI_CPSW=y
+CONFIG_AT803X_PHY=y
-- 
1.7.9.5

