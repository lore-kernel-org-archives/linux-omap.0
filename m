From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv3 8/8] ARM: dts: AM33xx: Add mailbox node
Date: Tue, 6 Aug 2013 16:40:41 -0500
Message-ID: <1375825241-18335-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39772 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756718Ab3HFVrZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Aug 2013 17:47:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

The mailbox DT node data has been added for AM33xx device, with
information added currently for communicating with WkupM3
processor. The usr_id value in the DT node reflects the value
used for MPU like the rest of the SoCs. The driver logic will
be adjusted to account for the WkupM3 usr_id within the code.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 38b446b..413dfa56 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -249,6 +249,17 @@
 			status = "disabled";
 		};
 
+		mailbox: mailbox@480C8000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x480C8000 0x200>;
+			interrupts = <77>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <8>;
+			ti,mbox-names = "wkup_m3";
+			ti,mbox-data = <0 0 0 0>;
+		};
+
 		timer1: timer@44e31000 {
 			compatible = "ti,am335x-timer-1ms";
 			reg = <0x44e31000 0x400>;
-- 
1.8.3.3

