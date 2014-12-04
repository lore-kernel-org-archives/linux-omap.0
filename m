From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] ARM: dts: am437x-sk-evm: Hook dcdc2 as the cpu0-supply
Date: Thu, 4 Dec 2014 09:24:39 -0600
Message-ID: <1417706679-22294-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40532 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932375AbaLDPZA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2014 10:25:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Dave Gerlach <d-gerlach@ti.com>, Felipe Balbi <balbi@ti.com>

From: Dave Gerlach <d-gerlach@ti.com>

Hook dcdc2 as the cpu0-supply.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 87aa4f3..f7f77a7 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -611,3 +611,7 @@
 &wdt {
 	status = "okay";
 };
+
+&cpu {
+	cpu0-supply = <&dcdc2>;
+};
-- 
2.1.0.GIT

