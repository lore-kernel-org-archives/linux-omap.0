From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
Date: Thu, 4 Feb 2016 20:20:17 +0200
Message-ID: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2188619779947433021=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--===============2188619779947433021==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

This patch intended to fix following cases: 
- SoC-A has ARM GT, defines DT node for ARM GT and selects ARM_GLOBAL_TIMER
statically in Kconfig file. SoC-B has ARM GT and defines DT node for ARM GT,
but do not selects ARM_GLOBAL_TIMER statically in Kconfig file. In case of
multiplatform build ARM GT will be implicitly enabled for SoC-B.

- There is no way to disable ARM GT without modifying Kconfig file,
once ARM_GLOBAL_TIMER is selected statically in Kconfig file.

Hence, fix above case by defining both HAVE_ARM_GLOBAL_TIMER and
ARM_GLOBAL_TIMER as recommended by 'Adding common features and make
the usage configurable' section in kconfig-language.txt. All places in
ARM folder where ARM_GLOBAL_TIMER was used now replaced on
HAVE_ARM_GLOBAL_TIMER.

Cc: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Coquelin <maxime.coquelin-qxv4g6HH51o@public.gmane.org>
Cc: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Cc: Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: "Sören Brinkmann" <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Signed-off-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-bcm/Kconfig      | 4 ++--
 arch/arm/mach-hisi/Kconfig     | 2 +-
 arch/arm/mach-imx/Kconfig      | 2 +-
 arch/arm/mach-rockchip/Kconfig | 2 +-
 arch/arm/mach-sti/Kconfig      | 2 +-
 arch/arm/mach-uniphier/Kconfig | 2 +-
 arch/arm/mach-vexpress/Kconfig | 2 +-
 arch/arm/mach-zx/Kconfig       | 2 +-
 arch/arm/mach-zynq/Kconfig     | 2 +-
 drivers/clocksource/Kconfig    | 7 ++++++-
 10 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7ef1214..d4d079a7 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -14,7 +14,7 @@ config ARCH_BCM_IPROC
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select COMMON_CLK_IPROC
 	select CLKSRC_MMIO
 	select ARCH_REQUIRE_GPIOLIB
@@ -156,7 +156,7 @@ config ARCH_BCM_63XX
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select CACHE_L2X0
 	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index a3b091a..251bb03 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -28,7 +28,7 @@ config ARCH_HIP01
        depends on ARCH_MULTI_V7
        select HAVE_ARM_SCU if SMP
        select HAVE_ARM_TWD if SMP
-       select ARM_GLOBAL_TIMER
+       select HAVE_ARM_GLOBAL_TIMER
        help
          Support for Hisilicon HIP01 SoC family
 
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 15df34fb..7ea4c65 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -600,7 +600,7 @@ choice
 	config VF_USE_ARM_GLOBAL_TIMER
 		bool "Use ARM Global Timer"
 		depends on ARCH_MULTI_V7
-		select ARM_GLOBAL_TIMER
+		select HAVE_ARM_GLOBAL_TIMER
 		select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 		help
 		  Use the ARM Global Timer as clocksource
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index cef42fd..a53b787 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -14,7 +14,7 @@ config ARCH_ROCKCHIP
 	select DW_APB_TIMER_OF
 	select REGULATOR if PM
 	select ROCKCHIP_TIMER
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	help
 	  Support for Rockchip's Cortex-A9 Single-to-Quad-Core-SoCs
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index a196d14..c799f9d 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -3,7 +3,7 @@ menuconfig ARCH_STI
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select ST_IRQCHIP
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select CLKSRC_ST_LPC
 	select PINCTRL
 	select PINCTRL_ST
diff --git a/arch/arm/mach-uniphier/Kconfig b/arch/arm/mach-uniphier/Kconfig
index 82dddee..81bdf77 100644
--- a/arch/arm/mach-uniphier/Kconfig
+++ b/arch/arm/mach-uniphier/Kconfig
@@ -2,7 +2,7 @@ config ARCH_UNIPHIER
 	bool "Socionext UniPhier SoCs"
 	depends on ARCH_MULTI_V7
 	select ARM_AMBA
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select ARM_GIC
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 398a297..e89941d 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,7 +5,7 @@ menuconfig ARCH_VEXPRESS
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select ARM_TIMER_SP804
 	select COMMON_CLK_VERSATILE
 	select HAVE_ARM_SCU if SMP
diff --git a/arch/arm/mach-zx/Kconfig b/arch/arm/mach-zx/Kconfig
index 209c979..e84b0c2 100644
--- a/arch/arm/mach-zx/Kconfig
+++ b/arch/arm/mach-zx/Kconfig
@@ -11,7 +11,7 @@ if ARCH_ZX
 config SOC_ZX296702
 	def_bool y
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER
+	select HAVE_ARM_GLOBAL_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PM_GENERIC_DOMAINS if PM
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index fd0aeeb..3165720 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -5,7 +5,7 @@ config ARCH_ZYNQ
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
-	select ARM_GLOBAL_TIMER if !CPU_FREQ
+	select HAVE_ARM_GLOBAL_TIMER if !CPU_FREQ
 	select CADENCE_TTC_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 33db740..9fcb5a8 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -206,9 +206,14 @@ config ARM_ARCH_TIMER_EVTSTREAM
 	  This must be disabled for hardware validation purposes to detect any
 	  hardware anomalies of missing events.
 
-config ARM_GLOBAL_TIMER
+config HAVE_ARM_GLOBAL_TIMER
 	bool
+
+config ARM_GLOBAL_TIMER
+	bool "Support for ARM global timer unit"
 	select CLKSRC_OF if OF
+	default y
+	depends on HAVE_ARM_GLOBAL_TIMER
 	help
 	  This options enables support for the ARM global timer unit
 
-- 
2.7.0



--===============2188619779947433021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============2188619779947433021==--
