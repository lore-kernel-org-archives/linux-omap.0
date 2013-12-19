From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 8/9] arm: dts: am437x-gp-evm: Enable gpio.
Date: Thu, 19 Dec 2013 18:03:40 +0530
Message-ID: <1387456421-21379-9-git-send-email-sourav.poddar@ti.com>
References: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40939 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757031Ab3LSMec (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Dec 2013 07:34:32 -0500
In-Reply-To: <1387456421-21379-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com
Cc: balbi@ti.com, devicetree@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, mark.rutland@arm.com, afzal@ti.com, lokeshvutla@ti.com, Sourav Poddar <sourav.poddar@ti.com>

Enable gpio3, gpio4, it will be used by gpio matrix keys. Also,
can be used by othe peripherals.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 2e79bda..0dc248d 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -69,3 +69,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&ecap0_pins>;
 };
+
+&gpio3 {
+	status = "okay";
+};
+
+&gpio4 {
+	status = "okay";
+};
-- 
1.7.9.5

