From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v5 5/5] imx6q: Remove unconditional dependency on l2x0 L2 cache support
Date: Thu, 15 Dec 2011 15:53:54 +0000
Message-ID: <1323964434-6764-6-git-send-email-dave.martin@linaro.org>
References: <1323964434-6764-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1323964434-6764-1-git-send-email-dave.martin@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, Anton Vorontsov <avorontsov@mvista.com>, Barry Song <baohua.song@csr.com>, Catalin Marinas <catalin.marinas@arm.com>, Colin Cross <ccross@google.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-tegra@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Tony Lindgren <tony@atomide.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-omap@vger.kernel.org

The i.MX6 Quad SoC will work without the l2x0 L2 cache controller
support built into the kernel, so this patch removes the dependency
on CACHE_L2X0.

This makes the l2x0 support optional, so that it can be turned off
when desired for debugging purposes etc.

Since SOC_IMX6Q already depends on ARCH_IMX_V6_V7 and
ARCH_IMX_V6_V7 selects MIGHT_HAVE_CACHE_L2X0, there is no need to
select that option explicitly from SOC_IMX6Q.

Thanks to Shawn Guo for this suggestion.  [1]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074602.html

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
Changes:

v5: Don't select MIGHT_HAVE_CACHE_L2X0 directly from SOC_IMX6Q, but
    instead select implicitly via ARCH_IMX_V6_V7 (which we expect
    to be selected by other relevant SoCs).  Thanks to Shawn for
    this suggestion.


 arch/arm/mach-imx/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 29a3d61..1530678 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -609,7 +609,6 @@ comment "i.MX6 family:"
 config SOC_IMX6Q
 	bool "i.MX6 Quad support"
 	select ARM_GIC
-	select CACHE_L2X0
 	select CPU_V7
 	select HAVE_ARM_SCU
 	select HAVE_IMX_GPC
-- 
1.7.4.1

