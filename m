From: mathieu.poirier@linaro.org
Subject: [PATCH 7/9] omap2plus: ensure that one of omap2/3/4 is selected
Date: Fri, 23 Mar 2012 11:13:54 -0600
Message-ID: <1332522836-29517-8-git-send-email-mathieu.poirier@linaro.org>
References: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1332522836-29517-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Random configurations can fail if none of the omap families
in mach-omap2 is selected. This patch automatically selects
omap2 if the user has not made any other choice.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0279e9e..b244e80 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -55,6 +55,16 @@ config ARCH_OMAP4
 	select USB_ARCH_HAS_EHCI
 	select ARM_CPU_SUSPEND if PM
 
+config ARCH_OMAP2_AUTO
+	bool
+	depends on !ARCH_OMAP3 && !ARCH_OMAP4
+	select ARCH_OMAP2
+	default y
+	help
+	  At least one of OMAP2/OMAP3/OMAP4 needs to be enabled, this
+	  selects OMAP2 if nothing else gets selected, to avoid non-building
+	  configurations.
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
-- 
1.7.5.4
