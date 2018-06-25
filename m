From: Adam Ford <aford173@gmail.com>
Subject: [RFC 4/5] ARM: dts: AM35x: Change MUSB from omap2430 to am35xx
Date: Sun, 24 Jun 2018 19:12:32 -0500
Message-ID: <20180625001233.9785-5-aford173@gmail.com>
References: <20180625001233.9785-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180625001233.9785-1-aford173@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: adam.ford@logicpd.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, b-liu@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The glue that connects the AM35xx is not the same as the OMAP3.
With the AM35xx-MUSB now available in device tree, point to that
glue instead of omap3.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index ca294914bbb1..c17cfe6a2132 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -18,7 +18,7 @@
 
 	ocp@68000000 {
 		am35x_otg_hs: am35x_otg_hs@5c040000 {
-			compatible = "ti,omap3-musb";
+			compatible = "ti,am35xx-musb";
 			ti,hwmods = "am35x_otg_hs";
 			status = "disabled";
 			reg = <0x5c040000 0x1000>;
-- 
2.17.1
