From: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 4/5] highbank: Unconditionally require l2x0 L2 cache controller support
Date: Thu, 15 Dec 2011 15:53:53 +0000
Message-ID: <1323964434-6764-5-git-send-email-dave.martin@linaro.org>
References: <1323964434-6764-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1323964434-6764-1-git-send-email-dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Anton Vorontsov <avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, John Linn <john.linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

If running in the Normal World on a TrustZone-enabled SoC, Linux
does not have complete control over the L2 cache controller
configuration.  The kernel cannot work reliably on such platforms
without the l2x0 cache support code built in.

This patch unconditionally enables l2x0 support for the Highbank
SoC.

Thanks to Rob Herring for this suggestion.  [1]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html

Signed-off-by: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Acked-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index eca82f9..1792146 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -340,12 +340,12 @@ config ARCH_HIGHBANK
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
+	select CACHE_L2X0
 	select CLKDEV_LOOKUP
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU
 	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	select USE_OF
 	help
 	  Support for the Calxeda Highbank SoC based boards.
-- 
1.7.4.1
