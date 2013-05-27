From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 04/14] ARM: OMAP2+: AM43x: soc_is support
Date: Mon, 27 May 2013 20:05:51 +0530
Message-ID: <6bf3b1a4c215cc404262d107e69543b8d5ed005c.1369658705.git.afzal@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <cover.1369658705.git.afzal-l0cyMroinI0@public.gmane.org>
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
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Benoit Cousson <benoit.cousson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

soc_is support for AM43x family of SoC's. Only variant now is AM437x,
it is made as a subclass of AM43x.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/soc.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index fd4507b..f59fdcd 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -96,6 +96,15 @@
 # endif
 #endif
 
+#ifdef CONFIG_SOC_AM43XX
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME am43xx
+# endif
+#endif
+
 /*
  * Omap device type i.e. EMU/HS/TST/GP/BAD
  */
@@ -187,6 +196,7 @@ IS_OMAP_CLASS(44xx, 0x44)
 IS_AM_CLASS(35xx, 0x35)
 IS_OMAP_CLASS(54xx, 0x54)
 IS_AM_CLASS(33xx, 0x33)
+IS_AM_CLASS(43xx, 0x43)
 
 IS_TI_CLASS(81xx, 0x81)
 
@@ -202,6 +212,7 @@ IS_OMAP_SUBCLASS(543x, 0x543)
 IS_TI_SUBCLASS(816x, 0x816)
 IS_TI_SUBCLASS(814x, 0x814)
 IS_AM_SUBCLASS(335x, 0x335)
+IS_AM_SUBCLASS(437x, 0x437)
 
 #define cpu_is_omap24xx()		0
 #define cpu_is_omap242x()		0
@@ -214,6 +225,8 @@ IS_AM_SUBCLASS(335x, 0x335)
 #define soc_is_am35xx()			0
 #define soc_is_am33xx()			0
 #define soc_is_am335x()			0
+#define soc_is_am43xx()			0
+#define soc_is_am437x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
@@ -341,6 +354,13 @@ IS_OMAP_TYPE(3430, 0x3430)
 # define soc_is_am335x()		is_am335x()
 #endif
 
+#ifdef	CONFIG_SOC_AM43XX
+# undef soc_is_am43xx
+# undef soc_is_am437x
+# define soc_is_am43xx()		is_am43xx()
+# define soc_is_am437x()		is_am437x()
+#endif
+
 # if defined(CONFIG_ARCH_OMAP4)
 # undef cpu_is_omap44xx
 # undef cpu_is_omap443x
@@ -398,6 +418,9 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define AM335X_REV_ES2_0	(AM335X_CLASS | (0x1 << 8))
 #define AM335X_REV_ES2_1	(AM335X_CLASS | (0x2 << 8))
 
+#define AM437X_CLASS		0x43700000
+#define AM437X_REV_ES1_0	AM437X_CLASS
+
 #define OMAP443X_CLASS		0x44300044
 #define OMAP4430_REV_ES1_0	(OMAP443X_CLASS | (0x10 << 8))
 #define OMAP4430_REV_ES2_0	(OMAP443X_CLASS | (0x20 << 8))
-- 
1.7.12
