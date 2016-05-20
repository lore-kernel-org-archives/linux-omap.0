From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] ARM: dts: DRA74x: fix DSS PLL2 addresses
Date: Fri, 20 May 2016 13:13:33 +0300
Message-ID: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

DSS's 'pll2_clkctrl' and 'pll2' have wrong addresses in the dra74x.dtsi
file. Video PLL2 has not been used so wrong addresses went unnoticed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/boot/dts/dra74x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 4220eeffc65a..5e06020f450b 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -107,8 +107,8 @@
 	reg = <0x58000000 0x80>,
 	      <0x58004054 0x4>,
 	      <0x58004300 0x20>,
-	      <0x58005054 0x4>,
-	      <0x58005300 0x20>;
+	      <0x58009054 0x4>,
+	      <0x58009300 0x20>;
 	reg-names = "dss", "pll1_clkctrl", "pll1",
 		    "pll2_clkctrl", "pll2";
 
-- 
2.5.0
