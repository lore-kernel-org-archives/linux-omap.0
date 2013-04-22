From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net-next PATCH 3/3] ARM: dts: AM33XX: add phy fixup for evm and evmsk boards
Date: Mon, 22 Apr 2013 23:50:38 +0530
Message-ID: <1366654838-26479-4-git-send-email-mugunthanvnm@ti.com>
References: <1366654838-26479-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35215 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546Ab3DVSU5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Apr 2013 14:20:57 -0400
In-Reply-To: <1366654838-26479-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Mugunthan V N <mugunthanvnm@ti.com>

As RGMII tx clock internal delay is not supported in AM335x, the same has
to be enabled in phy. This patch adds support for enabling tx clock internal
delay via phy debug registers

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts   |   10 ++++++++++
 arch/arm/boot/dts/am335x-evmsk.dts |   10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d649644..72805c5 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -244,3 +244,13 @@
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
 };
+
+&davinci_mdio {
+	phy-fixup-registers = <&atheros_txclk_delay_fixup>;
+
+	atheros_txclk_delay_fixup: atheros_txclk_delay_fixup {
+		phy-id = <0x4dd074>;
+		phy-mask = <0xfffffffe>;
+		fixup-registers = <0x1d 0x5 0x1e 0x100>;
+	};
+};
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index f297b85..f398cb3 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -256,3 +256,13 @@
 &cpsw_emac1 {
 	phy_id = <&davinci_mdio>, <1>;
 };
+
+&davinci_mdio {
+	phy-fixup-registers = <&atheros_txclk_delay_fixup>;
+
+	atheros_txclk_delay_fixup: atheros_txclk_delay_fixup {
+		phy-id = <0x4dd074>;
+		phy-mask = <0xfffffffe>;
+		fixup-registers = <0x1d 0x5 0x1e 0x100>;
+	};
+};
-- 
1.7.9.5

