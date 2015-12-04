From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/7] ARM: dts: Add mmc device entries for dm814x
Date: Thu,  3 Dec 2015 17:25:32 -0800
Message-ID: <1449192335-10137-5-git-send-email-tony@atomide.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449192335-10137-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Add mmc device entries for dm814x.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm814x.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 9d81980e..18a8f0d 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -183,6 +183,28 @@
 				ti,hwmods = "timer3";
 			};
 
+			mmc1: mmc@60000 {
+				compatible = "ti,omap4-hsmmc";
+				ti,hwmods = "mmc1";
+				dmas = <&edma 24 0
+					&edma 25 0>;
+				dma-names = "tx", "rx";
+				interrupts = <64>;
+				interrupt-parent = <&intc>;
+				reg = <0x60000 0x1000>;
+			};
+
+			mmc2: mmc@1d8000 {
+				compatible = "ti,omap4-hsmmc";
+				ti,hwmods = "mmc2";
+				dmas = <&edma 2 0
+					&edma 3 0>;
+				dma-names = "tx", "rx";
+				interrupts = <28>;
+				interrupt-parent = <&intc>;
+				reg = <0x1d8000 0x1000>;
+			};
+
 			control: control@140000 {
 				compatible = "ti,dm814-scm", "simple-bus";
 				reg = <0x140000 0x20000>;
@@ -279,6 +301,15 @@
 			reg = <0x48200000 0x1000>;
 		};
 
+		/* Board must configure evtmux with edma_xbar for EDMA */
+		mmc3: mmc@47810000 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc3";
+			interrupts = <29>;
+			interrupt-parent = <&intc>;
+			reg = <0x47810000 0x1000>;
+		};
+
 		edma: edma@49000000 {
 			compatible = "ti,edma3-tpcc";
 			ti,hwmods = "tpcc";
-- 
2.6.2
