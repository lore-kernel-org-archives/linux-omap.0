From: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/4] arm: dts: add dm816x missing #mbox-cells
Date: Thu, 22 Oct 2015 11:19:10 +0200
Message-ID: <5628AA0E.1080205@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, fisaksen@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add missing #mbox-cells for dm816x mbox DT node.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 3c99cfa..a7a34e4 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -218,6 +218,7 @@
 			reg = <0x480c8000 0x2000>;
 			interrupts = <77>;
 			ti,hwmods = "mailbox";
+			#mbox-cells = <1>;
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
 			mbox_dsp: mbox_dsp {
-- 
1.9.1
