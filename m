From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 07/13] Documentation: devicetree: add bindings for TI PRUSS
Date: Sun, 29 Jun 2014 18:21:41 +0200
Message-ID: <1404058907-21112-8-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:61823 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbaF2QWE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:22:04 -0400
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 Documentation/devicetree/bindings/misc/ti,pruss.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/ti,pruss.txt

diff --git a/Documentation/devicetree/bindings/misc/ti,pruss.txt b/Documentation/devicetree/bindings/misc/ti,pruss.txt
new file mode 100644
index 0000000..4eacc41
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/ti,pruss.txt
@@ -0,0 +1,19 @@
+TI Programmable Real-Time Unit Sub System (PRUSS)
+
+Required properties:
+- compatible :
+	- "ti,pruss-v1" - for PRUv1 as found on the OMAPL138/DA850/AM18xx SoC families
+	- "ti,pruss-v2" - for PRUv2 as found on the AM33xx SoC family
+- ti,hwmods: Name of the hwmod associated to the PRUSS
+- reg: Address range of rtc register set
+- interrupts: host event interrupts in order
+- interrupt-parent: phandle for the interrupt controller
+
+Example:
+pruss: pruss@4a300000 {
+	compatible = "ti,pruss-v2";
+	ti,hwmods = "pruss";
+	reg = <0x4a300000 0x080000>;
+	interrupts = <20 21 22 23 24 25 26 27>;
+	interrupt-parent = <&intc>;
+};
-- 
2.0.0

