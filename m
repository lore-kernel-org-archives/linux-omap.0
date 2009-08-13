From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: [PATCH 09/10] OMAP3: Add debug observablity (debobs) Kconfig item
Date: Thu, 13 Aug 2009 09:52:38 -0700
Message-ID: <1250182359-18830-10-git-send-email-khilman@deeprootsystems.com>
References: <1250182359-18830-1-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-2-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-3-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-4-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-5-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-6-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-7-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-8-git-send-email-khilman@deeprootsystems.com>
 <1250182359-18830-9-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1250182359-18830-9-git-send-email-khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---
 arch/arm/mach-omap2/Makefile |    3 +++
 arch/arm/plat-omap/Kconfig   |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 735bae5..cc515a4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -44,6 +44,9 @@ iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
 
 obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
 
+# Debobs
+obj-$(CONFIG_OMAP3_DEBOBS)	+= debobs.o
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index efe85d0..4e90a36 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -143,6 +143,13 @@ config OMAP_32K_TIMER
 
 endchoice
 
+config OMAP3_DEBOBS
+	bool "OMAP3 Debug observability support"
+	depends on ARCH_OMAP3 && DEBUG_FS
+	default n
+	help
+	  Use ETK pads for debug observability
+
 config OMAP_32K_TIMER_HZ
        int "Kernel internal timer frequency for 32KHz timer"
        range 32 1024
-- 
1.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
