From: George Cherian <george.cherian@ti.com>
Subject: [PATCH] arm: dts: AM43x: Add usb_otg_hs node
Date: Fri, 28 Jun 2013 12:14:47 +0530
Message-ID: <1372401887-19422-1-git-send-email-george.cherian@ti.com>
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
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: afzal@ti.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, balbi@ti.com, a-kishore@ti.com, benoit.cousson@linaro.org, George Cherian <george.cherian@ti.com>
List-Id: linux-omap@vger.kernel.org

Adds device node for HS USB Host module for AM437x

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 This patch is on top of 
 git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.11/dts

 arch/arm/boot/dts/am4372.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ddc1df7..e4f5eb8 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -64,5 +64,24 @@
 			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
 			reg = <0x44e86000 0x40>;
 		};
+
+		usb_otg_hs1: am4372_dwc3@48380000 {
+			compatible = "ti,am437x-dwc3";
+			reg = <0x48380000 0x1ff>;
+			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <1>;
+			ranges;
+
+			dwc3@48390000 {
+				compatible = "synopsys,dwc3";
+				reg = <0x48390000 0xcfff>;
+				interrupts = <GIC_SPI  168 IRQ_TYPE_LEVEL_HIGH>;
+				tx-fifo-resize;
+			};
+
+		};
+
 	};
 };
-- 
1.8.1.4
