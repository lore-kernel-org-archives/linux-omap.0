From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 0/5] Handle non-secure L2C initialization on Exynos4
Date: Wed, 11 Jun 2014 17:30:07 +0200
Message-ID: <1402500612-4778-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Laura Abbott <lauraa@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Robin Holt <holt@sgi.com>, Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-omap@vger.kernel.org

This series intends to add support for L2 cache on Exynos4 SoCs on boards
running under secure firmware, which requires certain initialization steps
to be done with help of firmware, as selected registers are writable only
from secure mode.

First three patches extend existing support for secure write in L2C driver
to account for design of secure firmware running on Exynos. Namely:
 1) direct read access to certain registers is needed on Exynos, because
    secure firmware calls set several registers at once,
 2) not all boards are running secure firmware, so .write_sec callback
    needs to be installed in Exynos firmware ops initialization code,
 3) write access to {DATA,TAG}_LATENCY_CTRL registers fron non-secure world
    is not allowed and so must use l2c_write_sec as well.
Those patches might affect other platforms using .write_sec callback, so
I'd like to kindly ask any interested people for testing.

Further two patches add impelmentation of .write_sec for Exynos secure
firmware and necessary DT nodes to enable L2 cache.

Tested on Exynos4210-based Universal C210 board (without secure firmware)
and Exynos4412-based TRATS2 board (with secure firmware).

Tomasz Figa (5):
  ARM: mm: cache-l2x0: Add base address argument to write_sec callback
  ARM: Get outer cache .write_sec callback from mach_desc only if not
    NULL
  ARM: mm: cache-l2x0: Use l2c_write_sec() for LATENCY_CTRL registers
  ARM: EXYNOS: Add .write_sec outer cache callback for L2C-310
  ARM: dts: exynos4: Add nodes for L2 cache controller

 arch/arm/boot/dts/exynos4210.dtsi  |  9 ++++++
 arch/arm/boot/dts/exynos4x12.dtsi  |  9 ++++++
 arch/arm/include/asm/mach/arch.h   |  3 +-
 arch/arm/include/asm/outercache.h  |  2 +-
 arch/arm/kernel/irq.c              |  3 +-
 arch/arm/mach-exynos/firmware.c    | 61 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-highbank/highbank.c  |  3 +-
 arch/arm/mach-omap2/omap4-common.c |  3 +-
 arch/arm/mach-ux500/cache-l2x0.c   |  3 +-
 arch/arm/mm/cache-l2x0.c           | 10 +++----
 10 files changed, 95 insertions(+), 11 deletions(-)

-- 
1.9.3
