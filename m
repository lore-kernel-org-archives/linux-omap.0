From: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/6] ARM: AM43xx: Introduce a separate soc_is function for am438x series of SoCs
Date: Mon, 10 Aug 2015 14:58:23 +0530
Message-ID: <1439198906-31189-4-git-send-email-j-keerthy@ti.com>
References: <1439198906-31189-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1439198906-31189-1-git-send-email-j-keerthy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org
Cc: galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

EPOS evms are fitted with a separate family of am43xx SoCs and are named
am438x series. Adding a separate soc_is function to identify that
particular series of SoCs. This can be done to avoid unnecessarily
registering hwmods like rtc when not needed on EPOS evms.

Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
---
 Documentation/devicetree/bindings/arm/omap/omap.txt | 3 +++
 arch/arm/mach-omap2/board-generic.c                 | 1 +
 arch/arm/mach-omap2/id.c                            | 2 ++
 arch/arm/mach-omap2/soc.h                           | 7 +++++--
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
index 9f4e513..4269c13 100644
--- a/Documentation/devicetree/bindings/arm/omap/omap.txt
+++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
@@ -100,6 +100,9 @@ SoCs:
 - AM4372
   compatible = "ti,am4372", "ti,am43"
 
+- AM438x
+  compatible = "ti,am438x", "ti,am43"
+
 Boards:
 
 - OMAP3 BeagleBoard : Low cost community board
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 34ff14b..3d70d6a 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -266,6 +266,7 @@ MACHINE_END
 #ifdef CONFIG_SOC_AM43XX
 static const char *const am43_boards_compat[] __initconst = {
 	"ti,am4372",
+	"ti,am438x",
 	"ti,am43",
 	NULL,
 };
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index e3f713f..1bab9f5 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -228,6 +228,8 @@ static void __init omap3_cpuinfo(void)
 		cpu_name =  "AM335X";
 	} else if (soc_is_am437x()) {
 		cpu_name =  "AM437x";
+	} else if (soc_is_am438x()) {
+		cpu_name =  "AM438X";
 	} else if (cpu_is_ti814x()) {
 		cpu_name = "TI814X";
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index f97654d..feb27fd 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -238,6 +238,7 @@ IS_AM_SUBCLASS(437x, 0x437)
 #define soc_is_am335x()			0
 #define soc_is_am43xx()			0
 #define soc_is_am437x()			0
+#define soc_is_am438x()			0
 #define cpu_is_omap44xx()		0
 #define cpu_is_omap443x()		0
 #define cpu_is_omap446x()		0
@@ -371,8 +372,10 @@ IS_OMAP_TYPE(3430, 0x3430)
 #ifdef	CONFIG_SOC_AM43XX
 # undef soc_is_am43xx
 # undef soc_is_am437x
-# define soc_is_am43xx()		is_am43xx()
-# define soc_is_am437x()		is_am437x()
+# undef soc_is_am438x
+# define soc_is_am43xx()		of_machine_is_compatible("ti,am43")
+# define soc_is_am437x()		of_machine_is_compatible("ti,am4372")
+# define soc_is_am438x()		of_machine_is_compatible("ti,am438x")
 #endif
 
 # if defined(CONFIG_ARCH_OMAP4)
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
