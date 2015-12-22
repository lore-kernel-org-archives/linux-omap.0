From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: dts: Add NAND support for dm8148-evm
Date: Tue, 22 Dec 2015 08:10:45 -0800
Message-ID: <1450800645-10766-4-git-send-email-tony@atomide.com>
References: <1450800645-10766-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1450800645-10766-1-git-send-email-tony@atomide.com>
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

Add NAND support for dm8148-evm.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8148-evm.dts | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index e070862..862977f 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -35,6 +35,62 @@
 	phy-mode = "rgmii";
 };
 
+&gpmc {
+	ranges = <0 0 0x04000000 0x01000000>;	/* CS0: 16MB for NAND */
+
+	nand@0,0 {
+		linux,mtd-name= "micron,mt29f2g16aadwp";
+		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ti,nand-ecc-opt = "bch8";
+		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-on-ns = <6>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-on-ns = <0>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-on-ns = <0>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wait-on-read = "true";
+		gpmc,wait-on-write = "true";
+		gpmc,bus-turnaround-ns = <0>;
+		gpmc,cycle2cycle-delay-ns = <0>;
+		gpmc,clk-activation-ns = <0>;
+		gpmc,wait-monitoring-ns = <0>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+		partition@0 {
+			label = "X-Loader";
+			reg = <0 0x80000>;
+		};
+		partition@0x80000 {
+			label = "U-Boot";
+			reg = <0x80000 0x1c0000>;
+		};
+		partition@0x1c0000 {
+			label = "Environment";
+			reg = <0x240000 0x40000>;
+		};
+		partition@0x280000 {
+			label = "Kernel";
+			reg = <0x280000 0x500000>;
+		};
+		partition@0x780000 {
+			label = "Filesystem";
+			reg = <0x780000 0xf880000>;
+		};
+	};
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&sd1_pins>;
-- 
2.6.2
