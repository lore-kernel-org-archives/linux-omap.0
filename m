From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH] ARM: OMAP2+: Fix undefined reference to omap_secure_init
Date: Wed, 22 Jan 2020 12:20:17 -0500
Message-ID: <20200122172017.4791-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dan Murphy <dmurphy@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

omap_secure_init() is now called from all OMAP2+ platforms during their
init_early() call. This function is in omap-secure.o so include that
in the build for these platforms.

Fixes: db711893eac8 ("ARM: OMAP2+: Add omap_secure_init callback hook for secure initialization")
Reported-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/mach-omap2/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f07cfda85156..e1135b9d67c6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -16,11 +16,11 @@ hwmod-common				= omap_hwmod.o omap_hwmod_reset.o \
 clock-common				= clock.o
 secure-common				= omap-smc.o omap-secure.o
 
-obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
+obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += $(hwmod-common) $(secure-common)
-obj-$(CONFIG_SOC_AM33XX) += $(hwmod-common)
-obj-$(CONFIG_SOC_OMAP5)	 += $(hwmod-common) $(secure-common)
+obj-$(CONFIG_SOC_AM33XX) += $(hwmod-common) $(secure-common)
+obj-$(CONFIG_SOC_OMAP5)  += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_AM43XX) += $(hwmod-common) $(secure-common)
 obj-$(CONFIG_SOC_DRA7XX) += $(hwmod-common) $(secure-common)
 
-- 
2.17.1
