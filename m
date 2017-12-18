From: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/3] ARM: dra762: Add support for device package identification
Date: Mon, 18 Dec 2017 11:50:01 +0530
Message-ID: <20171218062003.9024-2-lokeshvutla@ti.com>
References: <20171218062003.9024-1-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171218062003.9024-1-lokeshvutla-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

dra762 comes in two packages:
- ABZ: Pin compatible package with DRA742 and DDR@1333MHz
- ACD: High performance(OPP_PLUS) package with new IPs

Both the above packages uses the same IDCODE hence needs to
differentiate using package information in DIE_ID_2.
Add support for the same.

Signed-off-by: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/id.c  | 17 +++++++++++++++--
 arch/arm/mach-omap2/soc.h | 16 ++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index df2c29edbbcd..68ba5f472f6b 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -657,8 +657,11 @@ void __init dra7xxx_check_revision(void)
 {
 	u32 idcode;
 	u16 hawkeye;
-	u8 rev;
+	u8 rev, package;
+	struct omap_die_id odi;
 
+	omap_get_die_id(&odi);
+	package = (odi.id_2 >> 16) & 0x3;
 	idcode = read_tap_reg(OMAP_TAP_IDCODE);
 	hawkeye = (idcode >> 12) & 0xffff;
 	rev = (idcode >> 28) & 0xff;
@@ -667,7 +670,17 @@ void __init dra7xxx_check_revision(void)
 		switch (rev) {
 		case 0:
 		default:
-			omap_revision = DRA762_REV_ES1_0;
+			switch (package) {
+			case 0x2:
+				omap_revision = DRA762_ABZ_REV_ES1_0;
+				break;
+			case 0x3:
+				omap_revision = DRA762_ACD_REV_ES1_0;
+				break;
+			default:
+				omap_revision = DRA762_REV_ES1_0;
+				break;
+			}
 			break;
 		}
 		break;
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 28fa1f8d8363..050891e055a4 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -143,6 +143,14 @@ static inline int is_dra ##subclass (void)		\
 	return (GET_OMAP_SUBCLASS == (id)) ? 1 : 0;	\
 }
 
+#define GET_DRA_PACKAGE		(omap_rev() & 0xff)
+
+#define IS_DRA_SUBCLASS_PACKAGE(subclass, package, id)			\
+static inline int is_dra ##subclass ##_ ##package (void)		\
+{									\
+	return (is_dra ##subclass () && GET_DRA_PACKAGE == id) ? 1 : 0;	\
+}
+
 IS_OMAP_CLASS(24xx, 0x24)
 IS_OMAP_CLASS(34xx, 0x34)
 IS_OMAP_CLASS(44xx, 0x44)
@@ -168,6 +176,8 @@ IS_TI_SUBCLASS(814x, 0x814)
 IS_AM_SUBCLASS(335x, 0x335)
 IS_AM_SUBCLASS(437x, 0x437)
 IS_DRA_SUBCLASS(76x, 0x76)
+IS_DRA_SUBCLASS_PACKAGE(76x, abz, 2)
+IS_DRA_SUBCLASS_PACKAGE(76x, acd, 3)
 IS_DRA_SUBCLASS(75x, 0x75)
 IS_DRA_SUBCLASS(72x, 0x72)
 
@@ -317,10 +327,14 @@ IS_OMAP_TYPE(3430, 0x3430)
 #if defined(CONFIG_SOC_DRA7XX)
 #undef soc_is_dra7xx
 #undef soc_is_dra76x
+#undef soc_is_dra76x_abz
+#undef soc_is_dra76x_acd
 #undef soc_is_dra74x
 #undef soc_is_dra72x
 #define soc_is_dra7xx()	is_dra7xx()
 #define soc_is_dra76x()	is_dra76x()
+#define soc_is_dra76x_abz()	is_dra76x_abz()
+#define soc_is_dra76x_acd()	is_dra76x_acd()
 #define soc_is_dra74x()	is_dra75x()
 #define soc_is_dra72x()	is_dra72x()
 #endif
@@ -391,6 +405,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 #define DRA7XX_CLASS		0x07000000
 #define DRA762_REV_ES1_0	(DRA7XX_CLASS | (0x62 << 16) | (0x10 << 8))
+#define DRA762_ABZ_REV_ES1_0	(DRA762_REV_ES1_0 | (2 << 0))
+#define DRA762_ACD_REV_ES1_0	(DRA762_REV_ES1_0 | (3 << 0))
 #define DRA752_REV_ES1_0	(DRA7XX_CLASS | (0x52 << 16) | (0x10 << 8))
 #define DRA752_REV_ES1_1	(DRA7XX_CLASS | (0x52 << 16) | (0x11 << 8))
 #define DRA752_REV_ES2_0	(DRA7XX_CLASS | (0x52 << 16) | (0x20 << 8))
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
