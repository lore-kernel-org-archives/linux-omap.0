From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/2] ARM: dts: omap5: Add dr_mode for dwc3
Date: Tue, 15 Oct 2013 11:19:59 +0530
Message-ID: <1381816199-7966-1-git-send-email-kishon@ti.com>
References: <52580F34.8030809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <52580F34.8030809@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, George Cherian <george.cherian@ti.com>, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tony@atomide.com, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

From: George Cherian <george.cherian@ti.com>

Added dr_mode property in dwc3 and set its default mode to device.
Currently dwc3 driver doesn't have support for OTG mode. So explicitly
setting to peripheral even dwc3 is a OTG controller since OMAP5 has
already got an EHCI host.

Signed-off-by: George Cherian <george.cherian@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v1:
Changed the commit log to explain why dr_mode was not set to OTG.
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 6d0a1d5..ef598af 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -652,6 +652,7 @@
 				reg = <0x4a030000 0x10000>;
 				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 				usb-phy = <&usb2_phy>, <&usb3_phy>;
+				dr_mode = "peripheral";
 				tx-fifo-resize;
 			};
 		};
-- 
1.7.10.4
