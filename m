From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V4 3/6] ARM: dts: OMAP4: add clock nodes for CPU
Date: Fri, 12 Apr 2013 17:54:35 -0500
Message-ID: <1365807278-554-4-git-send-email-nm@ti.com>
References: <1365807278-554-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1365807278-554-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

OMAP443x, OMAP446x and OMAP447x platforms use dpll_mpu clock.
Add same to common definition.

Cc: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
RFC of this patch approach for OMAP3 was discussed in http://marc.info/?t=136370325600009&r=1&w=2
along with the detailed context as to why this is an intermediate step.

previous revisions of cpufreq-cpu0 support do not use this approach.
[Probably belongs to Benoit's tree]

 arch/arm/boot/dts/omap4.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 2a56428..1c6d969 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -31,6 +31,8 @@
 		cpu@0 {
 			compatible = "arm,cortex-a9";
 			next-level-cache = <&L2>;
+			clocks = <&dpll_mpu>;
+			clock-names = "cpu";
 		};
 		cpu@1 {
 			compatible = "arm,cortex-a9";
@@ -106,6 +108,11 @@
 			ti,hwmods = "counter_32k";
 		};
 
+		dpll_mpu: dpll_mpu {
+			#clock-cells = <0>;
+			compatible = "ti,omap-clock";
+		};
+
 		omap4_pmx_core: pinmux@4a100040 {
 			compatible = "ti,omap4-padconf", "pinctrl-single";
 			reg = <0x4a100040 0x0196>;
-- 
1.7.9.5
