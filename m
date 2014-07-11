From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 03/10] ARM: dts: AM33xx: Add mailbox node
Date: Fri, 11 Jul 2014 16:44:36 -0500
Message-ID: <1405115083-52977-4-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51003 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbaGKVpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jul 2014 17:45:38 -0400
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

The mailbox DT node data has been added for AM33xx device.
The mailbox IP in AM33xx is similar to the version found in
OMAP4+ devices.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..3a0a161 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -347,6 +347,15 @@
 			status = "disabled";
 		};
 
+		mailbox: mailbox@480C8000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x480C8000 0x200>;
+			interrupts = <77>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <8>;
+		};
+
 		timer1: timer@44e31000 {
 			compatible = "ti,am335x-timer-1ms";
 			reg = <0x44e31000 0x400>;
-- 
2.0.0

