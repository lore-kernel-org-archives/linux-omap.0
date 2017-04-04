From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v4 4/8] ARM: dts: n8x0: Add vendor prefix to retu node
Date: Tue,  4 Apr 2017 11:30:32 -0400
Message-ID: <20170404153036.6651-5-javier@osg.samsung.com>
References: <20170404153036.6651-1-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170404153036.6651-1-javier@osg.samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Javier Martinez Canillas <javier@osg.samsung.com>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The retu device node doesn't have a vendor prefix
in its compatible string, fix it by adding one.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/omap2420-n8x0-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
index 1b06430c8013..91886231e5a8 100644
--- a/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
+++ b/arch/arm/boot/dts/omap2420-n8x0-common.dtsi
@@ -16,7 +16,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			retu: retu@1 {
-				compatible = "retu";
+				compatible = "nokia,retu";
 				interrupt-parent = <&gpio4>;
 				interrupts = <12 IRQ_TYPE_EDGE_RISING>;
 				reg = <0x1>;
-- 
2.9.3
