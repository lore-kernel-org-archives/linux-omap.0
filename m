From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] ARM: dts: da850: Add interrupt-controller property to gpio
 node
Date: Wed, 24 May 2017 19:31:41 +0530
Message-ID: <1495634501-3246-1-git-send-email-j-keerthy@ti.com>
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
To: nsekhar@ti.com, linus.walleij@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, tony@atomide.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The gpio node has 144 gpios. Each gpio is capable of generating
an interrupt. Hence add interrupt-controller property to the gpio
node. With this in place one can use interrupts property in device
tree to request for the gpio interrupts.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Added LAKML list.
  * Chaned arm to upper case in $Subject

 arch/arm/boot/dts/da850.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 941d455..2693bd2 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -503,6 +503,8 @@
 			ti,ngpio = <144>;
 			ti,davinci-gpio-unbanked = <0>;
 			status = "disabled";
+			interrupt-controller;
+			#interrupt-cells = <2>;
 		};
 		pinconf: pin-controller@22c00c {
 			compatible = "ti,da850-pupd";
-- 
1.9.1
