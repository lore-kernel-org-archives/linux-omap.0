From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 07/10] arm: boot: dts: am437x-sk: switch over to new edt-ft5306 compatible
Date: Tue, 18 Nov 2014 12:07:05 -0600
Message-ID: <1416334028-7766-7-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34037 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753627AbaKRSHR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 13:07:17 -0500
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, devicetree@vger.kernel.org

now that we have the new vendor-less edt-ft5306
i2c_device_id, we can use it

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 859ff3d..26133cb 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -404,7 +404,7 @@
 
 	edt-ft5306@38 {
 		status = "okay";
-		compatible = "edt,edt-ft5306", "edt,edt-ft5x06";
+		compatible = "edt-ft5306", "edt-ft5x06";
 		pinctrl-names = "default";
 		pinctrl-0 = <&edt_ft5306_ts_pins>;
 
-- 
2.1.0.GIT

