From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/8] ARM: dra762: Add support for device identification
Date: Sat, 12 Aug 2017 09:35:59 +0530
Message-ID: <20170812040605.21259-3-lokeshvutla@ti.com>
References: <20170812040605.21259-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170812040605.21259-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Praneeth Bajjuri <praneeth-l0cyMroinI0@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add ID code detection for dra762 SoC.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/id.c  | 9 +++++++++
 arch/arm/mach-omap2/soc.h | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e2274a162b74..16cb1c195fd8 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -663,6 +663,15 @@ void __init dra7xxx_check_revision(void)
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0xff;
 	switch (hawkeye) {
+	case 0xbb50:
+		switch (rev) {
+		case 0:
+		default:
+			omap_revision = DRA762_REV_ES1_0;
+			break;
+		}
+		break;
+
 	case 0xb990:
 		switch (rev) {
 		case 0:
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 2aa01c270898..754cd0fc0e7b 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -167,6 +167,7 @@ IS_TI_SUBCLASS(816x, 0x816)
 IS_TI_SUBCLASS(814x, 0x814)
 IS_AM_SUBCLASS(335x, 0x335)
 IS_AM_SUBCLASS(437x, 0x437)
+IS_DRA_SUBCLASS(76x, 0x76)
 IS_DRA_SUBCLASS(75x, 0x75)
 IS_DRA_SUBCLASS(72x, 0x72)
 
@@ -185,6 +186,7 @@ IS_DRA_SUBCLASS(72x, 0x72)
 #define soc_is_omap54xx()		0
 #define soc_is_omap543x()		0
 #define soc_is_dra7xx()			0
+#define soc_is_dra76x()			0
 #define soc_is_dra74x()			0
 #define soc_is_dra72x()			0
 
@@ -314,9 +316,11 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #if defined(CONFIG_SOC_DRA7XX)
 #undef soc_is_dra7xx
+#undef soc_is_dra76x
 #undef soc_is_dra74x
 #undef soc_is_dra72x
 #define soc_is_dra7xx()	is_dra7xx()
+#define soc_is_dra76x()	is_dra76x()
 #define soc_is_dra74x()	is_dra75x()
 #define soc_is_dra72x()	is_dra72x()
 #endif
@@ -386,6 +390,7 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define OMAP5432_REV_ES2_0	(OMAP54XX_CLASS | (0x32 << 16) | (0x20 << 8))
 
 #define DRA7XX_CLASS		0x07000000
+#define DRA762_REV_ES1_0	(DRA7XX_CLASS | (0x62 << 16) | (0x10 << 8))
 #define DRA752_REV_ES1_0	(DRA7XX_CLASS | (0x52 << 16) | (0x10 << 8))
 #define DRA752_REV_ES1_1	(DRA7XX_CLASS | (0x52 << 16) | (0x11 << 8))
 #define DRA752_REV_ES2_0	(DRA7XX_CLASS | (0x52 << 16) | (0x20 << 8))
-- 
2.13.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
