From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/10] ARM: dts: Fix dm814x pinctrl address and mask
Date: Tue,  1 Dec 2015 15:38:23 -0800
Message-ID: <1449013103-23238-11-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449013103-23238-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Otherwise pinctrl won't work.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 68b156b..7bd1961 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -207,11 +207,11 @@
 
 				pincntl: pinmux@800 {
 					compatible = "pinctrl-single";
-					reg = <0x800 0xc38>;
+					reg = <0x800 0x438>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					pinctrl-single,register-width = <32>;
-					pinctrl-single,function-mask = <0x300ff>;
+					pinctrl-single,function-mask = <0x707ff>;
 				};
 			};
 
-- 
2.6.2
