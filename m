From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 02/10] arm/dts: OMAP4: Add a main ocp entry bound to
	l3-noc driver
Date: Wed, 24 Aug 2011 15:09:08 +0200
Message-ID: <1314191356-10963-3-git-send-email-b-cousson@ti.com>
References: <1314191356-10963-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1314191356-10963-1-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: khilman-l0cyMroinI0@public.gmane.org, manjugk-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Used the main OCP node to add bindings with the l3_noc driver.
Remove l3_noc static device creation if CONFIG_OF is defined.

Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi  |    3 ++-
 arch/arm/mach-omap2/devices.c |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 97a3ea7..928a74c 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -64,10 +64,11 @@
 	 * hierarchy.
 	 */
 	ocp {
-		compatible = "simple-bus";
+		compatible = "ti,l3-noc", "arteris,noc", "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
+		hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
 
 		gic: interrupt-controller@48241000 {
 			compatible = "ti,omap4-gic", "arm,gic";
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2d4a199..5964650 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -70,6 +70,7 @@ static int __init omap3_l3_init(void)
 }
 postcore_initcall(omap3_l3_init);
 
+#ifndef CONFIG_OF
 static int __init omap4_l3_init(void)
 {
 	int l, i;
@@ -100,6 +101,7 @@ static int __init omap4_l3_init(void)
 	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
 }
 postcore_initcall(omap4_l3_init);
+#endif
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
-- 
1.7.0.4
