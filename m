From: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 REPOST 5/5] imx6q: Remove unconditional dependency on l2x0 L2 cache support
Date: Wed, 14 Dec 2011 11:39:41 +0000
Message-ID: <1323862781-3465-6-git-send-email-dave.martin@linaro.org>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1323862781-3465-1-git-send-email-dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Anton Vorontsov <avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, John Linn <john.linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The i.MX6 Quad SoC will work without the l2x0 L2 cache controller
support built into the kernel, so this patch removes the dependency
on CACHE_L2X0 and selects MIGHT_HAVE_CACHE_L2X0 instead.

This makes the l2x0 support optional, so that it can be turned off
when desired for debugging purposes etc.

Thanks to Shawn Guo for this suggestion. [1]

Signed-off-by: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html
---
 arch/arm/mach-imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a3d61..1fb93f2 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -609,13 +609,13 @@ comment "i.MX6 family:"
 config SOC_IMX6Q
 	bool "i.MX6 Quad support"
 	select ARM_GIC
-	select CACHE_L2X0
 	select CPU_V7
 	select HAVE_ARM_SCU
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
 	select HAVE_SMP
+	select MIGHT_HAVE_CACHE_L2X0
 	select USE_OF
 
 	help
-- 
1.7.4.1
