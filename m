From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v5 REPOST 0/5] Refactor common Kconfigs for easier maintenance
Date: Fri, 16 Dec 2011 16:35:27 +0000
Message-ID: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-sh@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Will Deacon <will.deacon@arm.com>, Daniel Walker <dwalker@fifo99.com>, John Linn <john.linn@xilinx.com>, Kukjin Kim <kgene.kim@samsung.com>, Magnus Damm <magnus.damm@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, David Brown <davidb@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, linux-arm-msm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, linux-samsung-soc@vger.kernel.org, Barry Song <baohua.song@csr.com>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>, Colin Cross <ccross@google.com>
List-Id: linux-omap@vger.kernel.org

[Expanding the CC list again so that affected people get a final
chance to comment -- David Brown pointed out that a few people/
ists were still missing.  This is otherwise a repost of v5 with
no changes.  Apologies to anyone who has already read this series.]

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
