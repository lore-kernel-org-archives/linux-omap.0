From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC/PATCH 03/14] OMAP3: beagle: don't touch omap_device internals
Date: Tue, 09 Aug 2011 19:10:21 +0500
Message-ID: <1312897232-4792-4-git-send-email-manjugk@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>

Board code should not touch omap_device internals.  To get the MPU/IVA devices,
use existing APIs: omap2_get_mpu_device(), omap2_get_iva_device().

Signed-off-by: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   27 ++++++++++++---------------
 1 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 213c4cd..7905c8d 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -529,25 +529,24 @@ static void __init beagle_opp_init(void)
 		return;
 	}
 
-	/* Custom OPP enabled for XM */
-	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
-		struct omap_hwmod *mh = omap_hwmod_lookup("mpu");
-		struct omap_hwmod *dh = omap_hwmod_lookup("iva");
-		struct device *dev;
+	/* Custom OPP enabled for all xM versions */
+	if (cpu_is_omap3630()) {
+		struct device *mpu_dev, *iva_dev;
+
+		mpu_dev = omap2_get_mpuss_device();
+		iva_dev = omap2_get_iva_device();
 
-		if (!mh || !dh) {
+		if (!mpu_dev || !iva_dev) {
 			pr_err("%s: Aiee.. no mpu/dsp devices? %p %p\n",
-				__func__, mh, dh);
+				__func__, mpu_dev, iva_dev);
 			return;
 		}
 		/* Enable MPU 1GHz and lower opps */
-		dev = &mh->od->pdev.dev;
-		r = opp_enable(dev, 800000000);
+		r = opp_enable(mpu_dev, 800000000);
 		/* TODO: MPU 1GHz needs SR and ABB */
 
 		/* Enable IVA 800MHz and lower opps */
-		dev = &dh->od->pdev.dev;
-		r |= opp_enable(dev, 660000000);
+		r |= opp_enable(iva_dev, 660000000);
 		/* TODO: DSP 800MHz needs SR and ABB */
 		if (r) {
 			pr_err("%s: failed to enable higher opp %d\n",
@@ -556,10 +555,8 @@ static void __init beagle_opp_init(void)
 			 * Cleanup - disable the higher freqs - we dont care
 			 * about the results
 			 */
-			dev = &mh->od->pdev.dev;
-			opp_disable(dev, 800000000);
-			dev = &dh->od->pdev.dev;
-			opp_disable(dev, 660000000);
+			opp_disable(mpu_dev, 800000000);
+			opp_disable(iva_dev, 660000000);
 		}
 	}
 	return;
-- 
1.7.1
