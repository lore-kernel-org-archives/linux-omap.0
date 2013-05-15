From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv2 1/3] arm: introduce config HAS_BANDGAP
Date: Wed, 15 May 2013 10:58:46 -0400
Message-ID: <1368629928-6723-2-git-send-email-eduardo.valentin@ti.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Introduce HAS_BANDGAP config entry. This config is a
boolean value so that arch code can flag is they
feature a bandgap device.

This config entry follows the same idea behind
ARCH_HAS_CPUFREQ.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/Kconfig            | 3 +++
 arch/arm/mach-omap2/Kconfig | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d423d58..bcbdec9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -174,6 +174,9 @@ config ARCH_HAS_CPUFREQ
 	  and that the relevant menu configurations are displayed for
 	  it.
 
+config ARCH_HAS_BANDGAP
+	bool
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f49cd51..8620ab5 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -4,6 +4,7 @@ config ARCH_OMAP
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4/5 SoCs with device tree support" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
 	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
-- 
1.8.2.1.342.gfa7285d
