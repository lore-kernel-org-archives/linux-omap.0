From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/3] ARM: dts: omap4: add aes2 instance
Date: Tue, 13 Jun 2017 16:45:48 +0300
Message-ID: <1497361550-4735-2-git-send-email-t-kristo@ti.com>
References: <1497361550-4735-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497361550-4735-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: sebastian.reichel@collabora.co.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

OMAP4 has AES2 instance, so add its integration data under DT.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 589690e..00e7656 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -909,6 +909,15 @@
 			dma-names = "tx", "rx";
 		};
 
+		aes2: aes@4b701000 {
+			compatible = "ti,omap4-aes";
+			ti,hwmods = "aes2";
+			reg = <0x4b701000 0xa0>;
+			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&sdma 114>, <&sdma 113>;
+			dma-names = "tx", "rx";
+		};
+
 		des: des@480a5000 {
 			compatible = "ti,omap4-des";
 			ti,hwmods = "des";
-- 
1.9.1
