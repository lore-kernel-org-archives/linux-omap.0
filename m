From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/3] ARM: OMAP2: AM43XX: Modify optimize string comparisons in soc_is calls
Date: Mon, 7 Sep 2015 12:35:28 +0530
Message-ID: <1441609528-20344-4-git-send-email-j-keerthy@ti.com>
References: <1441609528-20344-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441609528-20344-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Currently everytime soc_is calls are made, firstly device tree nodes
are parsed and then string comparisons are made to determine the
soc version. Optimizing it to be done one time and store the result.
Use the stored value in all the subsequent checks for soc_is calls.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/id.c  | 11 +++++++++++
 arch/arm/mach-omap2/soc.h | 10 ++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 28acdb1..3de8015 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -61,6 +61,16 @@ void init_dra_soc_id(void)
 		soc_ids |= DRA72X;
 }
 
+void init_am43_soc_id(void)
+{
+	if (of_machine_is_compatible("ti,am43"))
+		soc_ids |= AM43XX;
+	if (of_machine_is_compatible("ti,am4372"))
+		soc_ids |= AM437X;
+	if (of_machine_is_compatible("ti,am438x"))
+		soc_ids |= AM438X;
+}
+
 int check_soc_version(unsigned long id)
 {
 	return soc_ids & id;
@@ -357,6 +367,7 @@ void __init omap3xxx_check_revision(void)
 	u16 hawkeye;
 	u8 rev;
 
+	init_am43_soc_id();
 	/*
 	 * We cannot access revision registers on ES1.0.
 	 * If the processor type is Cortex-A8 and the revision is 0x0
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index 4b0a532..1c116e4 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -132,6 +132,9 @@
 #define DRA7XX				BIT(0)
 #define	DRA74X				BIT(1)
 #define DRA72X				BIT(2)
+#define AM43XX				BIT(3)
+#define AM437X				BIT(4)
+#define AM438X				BIT(5)
 
 int check_soc_version(unsigned long id);
 int omap_type(void);
@@ -247,6 +250,7 @@ IS_AM_SUBCLASS(437x, 0x437)
 #define soc_is_am335x()			0
 #define soc_is_am43xx()			0
 #define soc_is_am437x()			0
+#define soc_is_am438x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
@@ -380,8 +384,10 @@ IS_OMAP_TYPE(3430, 0x3430)
 #ifdef	CONFIG_SOC_AM43XX
 # undef soc_is_am43xx
 # undef soc_is_am437x
-# define soc_is_am43xx()		is_am43xx()
-# define soc_is_am437x()		is_am437x()
+# undef soc_is_am438x
+# define soc_is_am43xx()		check_soc_version(AM43XX)
+# define soc_is_am437x()		check_soc_version(AM437X)
+# define soc_is_am438x()		check_soc_version(AM438X)
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
