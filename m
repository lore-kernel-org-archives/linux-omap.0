From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH] pwm: tipwmss: enable on TI DRA7x and AM437x
Date: Tue, 8 Sep 2015 20:44:05 +0530
Message-ID: <637af4e1754204dd81677a1290517202eec7f011.1441725097.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pwm-owner@vger.kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

TIPWMSS is present on TI's DRA7x and
AM437x SoCs. Enable its usage.

Instead of adding each SoC individually,
use the more generic ARCH_OMAP2PLUS
instead.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/pwm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index b1541f40fd8d..c446f367f18a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -319,7 +319,7 @@ config PWM_TEGRA
 
 config  PWM_TIECAP
 	tristate "ECAP PWM support"
-	depends on SOC_AM33XX || ARCH_DAVINCI_DA8XX
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX
 	help
 	  PWM driver support for the ECAP APWM controller found on AM33XX
 	  TI SOC
@@ -329,7 +329,7 @@ config  PWM_TIECAP
 
 config  PWM_TIEHRPWM
 	tristate "EHRPWM PWM support"
-	depends on SOC_AM33XX || ARCH_DAVINCI_DA8XX
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX
 	help
 	  PWM driver support for the EHRPWM controller found on AM33XX
 	  TI SOC
@@ -339,7 +339,7 @@ config  PWM_TIEHRPWM
 
 config  PWM_TIPWMSS
 	bool
-	default y if SOC_AM33XX && (PWM_TIECAP || PWM_TIEHRPWM)
+	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM)
 	help
 	  PWM Subsystem driver support for AM33xx SOC.
 
-- 
2.4.4.408.g16da57c
