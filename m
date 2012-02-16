From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH v2] cpufreq: OMAP driver depends CPUfreq tables
Date: Thu, 16 Feb 2012 10:30:27 -0800
Message-ID: <1329417027-3254-1-git-send-email-khilman@ti.com>
References: <1329333709-29964-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1329333709-29964-1-git-send-email-khilman@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>, cpufreq@vger.kernel.org
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

The OMAP driver depends on CPUfreq table support for creating a table
of frequencies from the OPP layer.  Ensure that it's build to avoid
link-time errors.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
[khilman@ti.com: make user-selectable, but default y]
Tested-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
This version changes the new Kconfig option to be user-selectable, but
keeps the default value to be y whenever ARCH_OMAP2PLUS is enabled.
I've also tested this one with various Kconfig options.

 drivers/cpufreq/Kconfig.arm |    5 +++++
 drivers/cpufreq/Makefile    |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index e0664fe..82f1aa9 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -2,6 +2,11 @@
 # ARM CPU Frequency scaling drivers
 #
 
+config ARM_OMAP2PLUS_CPUFREQ
+	bool "TI OMAP2+"
+	default ARCH_OMAP2PLUS
+	select CPU_FREQ_TABLE
+
 config ARM_S3C64XX_CPUFREQ
 	bool "Samsung S3C64XX"
 	depends on CPU_S3C6410
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ac000fa..fda94c7 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -44,7 +44,7 @@ obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
 obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
 obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
-obj-$(CONFIG_ARCH_OMAP2PLUS)            += omap-cpufreq.o
+obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o
 
 ##################################################################################
 # PowerPC platform drivers
-- 
1.7.9

