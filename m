From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] soc changes for omaps for v4.16, part 2
Date: Fri, 22 Dec 2017 10:14:24 -0800
Message-ID: <pull-1513966338-859035@atomide.com>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit fdf3632938a646c13f7407f2f8c33ff81eed9c76:

  Merge branch '4.15-rc1-clkctrl-mach-omap2' of https://github.com/t-kristo/linux-pm into omap-for-v4.16/soc (2017-12-11 07:46:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.16/soc-pt2-signed

for you to fetch changes up to 234c91d4a350835df8362f6bc968ccf052c60d58:

  ARM: OMAP2+: dra762: Register package specific hwmod (2017-12-21 07:05:15 -0800)

----------------------------------------------------------------
Second set of SoC changes for omaps for v4.16 merge window

We can now drop some more of legacy platform data for omap3 as
it's been booting in device tree only mode for quite a while now.
This clock related data is coming from device tree configured
clocks now.

The other changes add support for detecting new dra762 SoC variant.

----------------------------------------------------------------
Lokesh Vutla (2):
      ARM: OMAP2+: dra762: Add support for device package identification
      ARM: OMAP2+: dra762: Register package specific hwmod

Tony Lindgren (1):
      ARM: OMAP2+: Drop unused legacy data for prcm_reg_id and module_bit

 arch/arm/mach-omap2/cm-regbits-24xx.h              |  81 -----------
 arch/arm/mach-omap2/cm-regbits-34xx.h              | 162 ---------------------
 arch/arm/mach-omap2/id.c                           |  17 ++-
 arch/arm/mach-omap2/omap_hwmod.h                   |   6 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  28 ----
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  64 --------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 132 +----------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  27 +++-
 arch/arm/mach-omap2/soc.h                          |  16 ++
 10 files changed, 51 insertions(+), 496 deletions(-)
