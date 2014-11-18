From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 09/10] arm: boot: dts: imx53-tx53-x03x: switch over to new edt-ft5x06 compatible
Date: Tue, 18 Nov 2014 12:07:07 -0600
Message-ID: <1416334028-7766-9-git-send-email-balbi@ti.com>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53960 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754607AbaKRSHT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2014 13:07:19 -0500
In-Reply-To: <1416334028-7766-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, devicetree@vger.kernel.org

now that we have the new vendor-less edt-ft5x06
i2c_device_id, we can use it

Cc: <devicetree@vger.kernel.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/imx53-tx53-x03x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x03x.dts b/arch/arm/boot/dts/imx53-tx53-x03x.dts
index 3b73e81..27bf29d 100644
--- a/arch/arm/boot/dts/imx53-tx53-x03x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x03x.dts
@@ -211,7 +211,7 @@
 	};
 
 	polytouch: edt-ft5x06@38 {
-		compatible = "edt,edt-ft5x06";
+		compatible = "edt-ft5x06";
 		reg = <0x38>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_edt_ft5x06_1>;
-- 
2.1.0.GIT

