From: Eliad Peller <eliad@wizery.com>
Subject: [PATCH v6 3/6] dt: bindings: add TI's wilink wireless device
Date: Thu, 12 Mar 2015 14:09:11 +0200
Message-ID: <1426162154-8716-4-git-send-email-eliad@wizery.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:41428 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbbCLMJh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2015 08:09:37 -0400
Received: by wiwl15 with SMTP id l15so19790764wiw.0
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2015 05:09:36 -0700 (PDT)
In-Reply-To: <1426162154-8716-1-git-send-email-eliad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Add device tree binding documentation for TI's wilink
(wl12xx and wl18xx) wlan chip.

Signed-off-by: Eliad Peller <eliad@wizery.com>
---
v6: add wl12xx, use IRQ_TYPE_LEVEL_HIGH

 .../devicetree/bindings/net/wireless/ti,wlcore.txt | 47 ++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt

diff --git a/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt b/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
new file mode 100644
index 0000000..2a3d90d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ti,wlcore.txt
@@ -0,0 +1,47 @@
+TI Wilink 6/7/8 (wl12xx/wl18xx) SDIO devices
+
+This node provides properties for controlling the wilink wireless device. The
+node is expected to be specified as a child node to the SDIO controller that
+connects the device to the system.
+
+Required properties:
+ - compatible: should be one of the following:
+    * "ti,wl1271"
+    * "ti,wl1273"
+    * "ti,wl1281"
+    * "ti,wl1283"
+    * "ti,wl1801"
+    * "ti,wl1805"
+    * "ti,wl1807"
+    * "ti,wl1831"
+    * "ti,wl1835"
+    * "ti,wl1837"
+ - interrupts : specifies attributes for the out-of-band interrupt.
+
+Optional properties:
+ - interrupt-parent : the phandle for the interrupt controller to which the
+	device interrupts are connected.
+ - ref-clock-frequency : ref clock frequency in Hz
+ - tcxo-clock-frequency : tcxo clock frequency in Hz
+
+Note: the *-clock-frequency properties assume internal clocks. In case of external
+clock, new bindings (for parsing the clock nodes) have to be added.
+
+Example:
+
+&mmc3 {
+	status = "okay";
+	vmmc-supply = <&wlan_en_reg>;
+	bus-width = <4>;
+	cap-power-off-card;
+	keep-power-in-suspend;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore@2 {
+		compatible = "ti,wl1835";
+		reg = <2>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
-- 
1.8.5.2.229.g4448466.dirty

