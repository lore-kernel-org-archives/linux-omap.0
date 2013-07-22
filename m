From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 3/5] ARM: dts: OMAP2+: Add mailbox nodes
Date: Mon, 22 Jul 2013 16:26:55 -0500
Message-ID: <1374528415-59554-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49757 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932388Ab3GVVd3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jul 2013 17:33:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Suman Anna <s-anna@ti.com>

The mailbox DT node data has been added for OMAP2420,
OMAP2430, OMAP3430/OMAP3630, OMAP44xx devices. Data
for OMAP5 and other SoCs will be added separately.

The mailbox static device initialization logic is also
adjusted for a DT boot.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap2420.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/omap2430.dtsi | 11 +++++++++++
 arch/arm/boot/dts/omap3.dtsi    | 11 +++++++++++
 arch/arm/boot/dts/omap4.dtsi    | 11 +++++++++++
 arch/arm/mach-omap2/devices.c   |  2 +-
 5 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index c8f9c55..43081e9 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -114,6 +114,18 @@
 			dma-names = "tx", "rx";
 		};
 
+		mailbox: mailbox@48094000 {
+			compatible = "ti,omap2-mailbox";
+			reg = <0x48094000 0x200>;
+			interrupts = <26>, /* DSP Interrupt */
+				     <34>; /* IVA Interrupt */
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <6>;
+			ti,mbox-names = "dsp", "iva";
+			ti,mbox-data = <0 1 0 0>, <2 3 1 3>;
+		};
+
 		timer1: timer@48028000 {
 			compatible = "ti,omap2420-timer";
 			reg = <0x48028000 0x400>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index c535a5a..55c4236 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -175,6 +175,17 @@
 			dma-names = "tx", "rx";
 		};
 
+		mailbox: mailbox@48094000 {
+			compatible = "ti,omap2-mailbox";
+			reg = <0x48094000 0x200>;
+			interrupts = <26>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <4>;
+			ti,mbox-num-fifos = <6>;
+			ti,mbox-names = "dsp";
+			ti,mbox-data = <0 1 0 0>;
+		};
+
 		timer1: timer@49018000 {
 			compatible = "ti,omap2420-timer";
 			reg = <0x49018000 0x400>;
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 7d95cda..7278656 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -386,6 +386,17 @@
 			dma-names = "tx", "rx";
 		};
 
+		mailbox: mailbox@48094000 {
+			compatible = "ti,omap2-mailbox";
+			reg = <0x48094000 0x200>;
+			interrupts = <26>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <2>;
+			ti,mbox-num-fifos = <2>;
+			ti,mbox-names = "dsp";
+			ti,mbox-data = <0 1 0 0>;
+		};
+
 		timer1: timer@48318000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x48318000 0x400>;
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..66f11a3 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -523,6 +523,17 @@
 			};
 		};
 
+		mailbox: mailbox@4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4a0f4000 0x200>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mailbox";
+			ti,mbox-num-users = <3>;
+			ti,mbox-num-fifos = <8>;
+			ti,mbox-names = "mbox-ipu", "mbox-dsp";
+			ti,mbox-data = <0 1 0 0>, <3 2 0 0>;
+		};
+
 		timer1: timer@4a318000 {
 			compatible = "ti,omap3430-timer";
 			reg = <0x4a318000 0x80>;
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 3c1279f..0afdf6f 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -562,10 +562,10 @@ static int __init omap2_init_devices(void)
 	omap_init_audio();
 	omap_init_camera();
 	omap_init_hdmi_audio();
-	omap_init_mbox();
 	/* If dtb is there, the devices will be created dynamically */
 	if (!of_have_populated_dt()) {
 		omap_init_dmic();
+		omap_init_mbox();
 		omap_init_mcpdm();
 		omap_init_mcspi();
 		omap_init_sham();
-- 
1.8.3.3

