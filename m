From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/6] omap dmtimer changes for v3.6 merge window
Date: Sun, 1 Jul 2012 02:01:16 -0700
Message-ID: <E1SlGHr-0003yE-SF@merlin.infradead.org>
References: <pull-1341133277-501333>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1341133277-501333>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-devel-dmtimer-for-v3.6

for you to fetch changes up to c59b537d87068be8c357a0150f6172a2dc8cdf82:

  ARM: OMAP2+: Simplify dmtimer clock aliases (2012-06-14 02:39:47 -0700)

----------------------------------------------------------------
Here are some omap dmtimer changes to make it easier to add
device tree support for dmtimer by simplifying the platform
data structure used by dmtimr.

----------------------------------------------------------------
Jon Hunter (12):
      ARM: OMAP: Remove unnecessary clk structure
      ARM: OMAP2+: Remove unused max number of timers definition
      ARM: OMAP2+: Add dmtimer platform function to reserve systimers
      ARM: OMAP: Add DMTIMER capability variable to represent timer features
      ARM: OMAP2+: HWMOD: Correct timer device attributes
      ARM: OMAP2+: Fix external clock support for dmtimers
      ARM: OMAP: Remove loses_context variable from timer platform data
      ARM: OMAP: Remove timer function pointer for context loss counter
      ARM: OMAP: Add flag to indicate if a timer needs a manual reset
      ARM: OMAP1: Fix dmtimer support
      ARM: OMAP2+: Move dmtimer clock set function to dmtimer driver
      ARM: OMAP2+: Simplify dmtimer clock aliases

 arch/arm/mach-omap1/timer.c                        |    3 +-
 arch/arm/mach-omap2/clock2420_data.c               |   39 +------
 arch/arm/mach-omap2/clock2430_data.c               |   39 +------
 arch/arm/mach-omap2/clock3xxx_data.c               |   26 +----
 arch/arm/mach-omap2/clock44xx_data.c               |   34 +++---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    8 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   10 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 --
 arch/arm/mach-omap2/timer.c                        |   82 +--------------
 arch/arm/plat-omap/dmtimer.c                       |  111 +++++++++++++++-----
 arch/arm/plat-omap/include/plat/dmtimer.h          |   22 +---
 11 files changed, 118 insertions(+), 262 deletions(-)
