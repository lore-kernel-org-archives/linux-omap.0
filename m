From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 10/10] ARM: dts: OMAP4: Add clock nodes for AES/DES nodes
Date: Fri, 25 Apr 2014 18:02:48 -0500
Message-ID: <1398466968-29506-11-git-send-email-joelf@ti.com>
References: <1398466968-29506-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398466968-29506-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

AES/DES nodes have clock nodes in the clock tree, use them. Internal trees were
using hwmod, but now that clock nodes are there, we can use them instead and
upstream it.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 27fcac8..f19ffa8 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -806,6 +806,8 @@
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&sdma 111>, <&sdma 110>;
 			dma-names = "tx", "rx";
+			clocks = <&aes1_fck>;
+			clock-names = "fck";
 		};
 
 		des: des@480a5000 {
@@ -815,6 +817,8 @@
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			dmas = <&sdma 117>, <&sdma 116>;
 			dma-names = "tx", "rx";
+			clocks = <&des_fck>;
+			clock-names = "fck";
 		};
 
 		abb_mpu: regulator-abb-mpu {
-- 
1.7.9.5
