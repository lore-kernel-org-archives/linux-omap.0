From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 322/671] ARM: dts: logicpd-som-lv: Fix MMC1 card detect
Date: Thu, 16 Jan 2020 11:59:20 -0500
Message-ID: <20200116170509.12787-59-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388959AbgAPRGg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:36 -0500
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Adam Ford <aford173@gmail.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 6a38df676a0a06bfc7ff8607ac62ccd6d95969ad ]

The card detect pin was incorrectly using IRQ_TYPE_LEVEL_LOW
instead of GPIO_ACTIVE_LOW when reading the state of the CD pin.

This was previosly fixed on Torpedo, but missed on the SOM-LV

Fixes: 5cb8b0fa55a9 ("ARM: dts: Move most of logicpd-som-lv-37xx-devkit.dts to logicpd-som-lv-baseboard.dtsi")
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi b/arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi
index 4990ed90dcea..3e39b9a1f35d 100644
--- a/arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv-baseboard.dtsi
@@ -153,7 +153,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	wp-gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;		/* gpio_126 */
-	cd-gpios = <&gpio4 14 IRQ_TYPE_LEVEL_LOW>;		/* gpio_110 */
+	cd-gpios = <&gpio4 14 GPIO_ACTIVE_LOW>;			/* gpio_110 */
 	vmmc-supply = <&vmmc1>;
 	bus-width = <4>;
 	cap-power-off-card;
-- 
2.20.1
