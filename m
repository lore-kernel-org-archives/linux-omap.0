From: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 0/5] Refactor common Kconfigs for easier maintenance
Date: Thu, 15 Dec 2011 15:53:49 +0000
Message-ID: <1323964434-6764-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Anton Vorontsov <avorontsov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Colin Cross <ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Haojian Zhuang <haojian.zhuang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, John Linn <john.linn-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Common Kconfig options which depend on a long list of board- and
SoC- specific Kconfigs can be cumbersome to maintain, leading to
annoying merge conflicts (although rather trivial ones).

This series factors out the dependencies of CACHE_L2X0 and SMP so
that the knowledge about when these can be enabled is moved to the
relevant board/SoC Kconfig files instead.  New
MIGHT_HAVE_CACHE_L2X0 and HAVE_SMP options are defined to mediate
the dependencies.

This series has been substantially reworked compared with the
previous post, and is now in two parts:

  * The first two patches simply refactor the way the Kconfig
    options for CACHE_L2X0 and SMP are implemented, without
    making any other changes.

  * The final three patches apply functional changes suggested by
    the contributors to this series, to make the config
    dependencies more correct for some specific boards.


Thanks to Rob Herring, Shawn Guo and Russell King for their
contributions to this series.  Thanks also to David Brown for
pointing out the lack of a comprehensive CC list.


I have briefly build-tested on some of the affected boards, but any
further reviews or Tested-Bys would be much appreciated.


Dave Martin (5):
  ARM: l2x0/pl310: Refactor Kconfig to be more maintainable
  ARM: SMP: Refactor Kconfig to be more maintainable
  omap4: Unconditionally require l2x0 L2 cache controller support
  highbank: Unconditionally require l2x0 L2 cache controller support
  imx6q: Remove unconditional dependency on l2x0 L2 cache support

 arch/arm/Kconfig               |   26 ++++++++++++++++++++++----
 arch/arm/mach-exynos/Kconfig   |    2 ++
 arch/arm/mach-imx/Kconfig      |    2 +-
 arch/arm/mach-msm/Kconfig      |    1 +
 arch/arm/mach-omap2/Kconfig    |    2 ++
 arch/arm/mach-realview/Kconfig |    9 +++++++++
 arch/arm/mach-vexpress/Kconfig |    2 ++
 arch/arm/mm/Kconfig            |   23 ++++++++++++++++-------
 arch/arm/plat-mxc/Kconfig      |    1 +
 9 files changed, 56 insertions(+), 12 deletions(-)

-- 
1.7.4.1
