From: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>
Subject: [PATCH 0/2] ARM: use const and __initconst for smp_operations (with
 refactoring hisi)
Date: Sun, 15 Nov 2015 10:39:51 +0900
Message-ID: <1447551593-22246-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michal
List-Id: linux-omap@vger.kernel.org


1/2: minor refactoring for mach-hisi
2/2: use const ... __initconst for smp_operations

I hope 2/2 will be reviewed by sub-arch maintainers.
Please issue Acked-by if it is OK.

I hope this series will be applied to ARM-SOC.



Masahiro Yamada (2):
  ARM: hisi: do not export smp_operations structures
  ARM: use const and __initconst for smp_operations

 arch/arm/common/mcpm_platsmp.c       | 2 +-
 arch/arm/include/asm/psci.h          | 2 +-
 arch/arm/kernel/psci_smp.c           | 2 +-
 arch/arm/mach-alpine/platsmp.c       | 2 +-
 arch/arm/mach-axxia/platsmp.c        | 2 +-
 arch/arm/mach-bcm/bcm63xx_smp.c      | 2 +-
 arch/arm/mach-bcm/kona_smp.c         | 2 +-
 arch/arm/mach-bcm/platsmp-brcmstb.c  | 2 +-
 arch/arm/mach-berlin/platsmp.c       | 2 +-
 arch/arm/mach-exynos/common.h        | 2 +-
 arch/arm/mach-exynos/platsmp.c       | 2 +-
 arch/arm/mach-hisi/core.h            | 3 ---
 arch/arm/mach-hisi/platmcpm.c        | 2 +-
 arch/arm/mach-hisi/platsmp.c         | 6 +++---
 arch/arm/mach-imx/common.h           | 4 ++--
 arch/arm/mach-imx/platsmp.c          | 4 ++--
 arch/arm/mach-keystone/keystone.h    | 2 +-
 arch/arm/mach-keystone/platsmp.c     | 2 +-
 arch/arm/mach-mediatek/platsmp.c     | 4 ++--
 arch/arm/mach-mvebu/armada-370-xp.h  | 2 +-
 arch/arm/mach-mvebu/platsmp-a9.c     | 4 ++--
 arch/arm/mach-mvebu/platsmp.c        | 2 +-
 arch/arm/mach-omap2/common.h         | 2 +-
 arch/arm/mach-omap2/omap-smp.c       | 2 +-
 arch/arm/mach-prima2/common.h        | 2 +-
 arch/arm/mach-prima2/platsmp.c       | 2 +-
 arch/arm/mach-qcom/platsmp.c         | 6 +++---
 arch/arm/mach-realview/core.h        | 2 +-
 arch/arm/mach-realview/platsmp.c     | 2 +-
 arch/arm/mach-rockchip/platsmp.c     | 2 +-
 arch/arm/mach-shmobile/r8a7779.h     | 2 +-
 arch/arm/mach-shmobile/r8a7790.h     | 2 +-
 arch/arm/mach-shmobile/r8a7791.h     | 2 +-
 arch/arm/mach-shmobile/setup-emev2.c | 2 +-
 arch/arm/mach-shmobile/sh73a0.h      | 2 +-
 arch/arm/mach-shmobile/smp-emev2.c   | 2 +-
 arch/arm/mach-shmobile/smp-r8a7779.c | 2 +-
 arch/arm/mach-shmobile/smp-r8a7790.c | 2 +-
 arch/arm/mach-shmobile/smp-r8a7791.c | 2 +-
 arch/arm/mach-shmobile/smp-sh73a0.c  | 2 +-
 arch/arm/mach-socfpga/platsmp.c      | 4 ++--
 arch/arm/mach-spear/generic.h        | 2 +-
 arch/arm/mach-spear/platsmp.c        | 2 +-
 arch/arm/mach-sti/platsmp.c          | 2 +-
 arch/arm/mach-sti/smp.h              | 2 +-
 arch/arm/mach-sunxi/platsmp.c        | 4 ++--
 arch/arm/mach-tegra/common.h         | 2 +-
 arch/arm/mach-tegra/platsmp.c        | 2 +-
 arch/arm/mach-uniphier/platsmp.c     | 2 +-
 arch/arm/mach-ux500/platsmp.c        | 2 +-
 arch/arm/mach-vexpress/core.h        | 2 +-
 arch/arm/mach-vexpress/platsmp.c     | 2 +-
 arch/arm/mach-zx/platsmp.c           | 2 +-
 arch/arm/mach-zynq/common.h          | 2 +-
 arch/arm/mach-zynq/platsmp.c         | 2 +-
 55 files changed, 64 insertions(+), 67 deletions(-)

-- 
1.9.1
