From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/10] omap soc clean-up for v3.5 merge window
Date: Thu, 10 May 2012 11:39:17 -0700
Message-ID: <E1SSYH9-0005cy-0C@merlin.infradead.org>
References: <pull-1336675159-747052>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1336675159-747052>
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

The following changes since commit 7a8bcf067d2b11964cb83ce3d753ac2d3ab9843c:

  Merge branch 'devel-hwmod' into cleanup (2012-05-08 10:17:32 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-cleanup-for-v3.5

for you to fetch changes up to 2c65e7440d56b3b285d1c95563b4dcce8e40dea3:

  GPMC: add ECC control definitions (2012-05-10 09:39:47 -0700)

----------------------------------------------------------------
Clean up to make it easier to add support for new SoCs.

Note that these have a merge dependency to omap-devel-hwmod-for-v3.5
branch for the Makefile changes.

----------------------------------------------------------------
Kevin Hilman (2):
      ARM: OMAP: AM35xx: remove redunant cpu_is checks for AM3505
      ARM: OMAP: AM35xx: convert 3517 detection/flags to AM35xx

R Sricharan (1):
      ARM: OMAP2+: dma: Define dma capabilities register bitfields and use them.

Santosh Shilimkar (6):
      ARM: OMAP4: Don't compile cm2xxx_3xxx.c for OMAP4 only builds.
      ARM: OMAP2+: Clean up wrapping multiple objects in Makefile
      ARM: OMAP4: Remove un-used WakeupGen register defines.
      ARM: OMAP: dma: Make use of cpu_class_is_omap2() to avoid future patching.
      ARM: All OMAP2PLUS machines use omap2 directory so just add one entry
      ARM: OMAP4: Reduce the static IO mapping

Tarun Kanti DebBarma (1):
      ARM: OMAP2+: dmtimer: remove redundant sysconfig context restore

Tony Lindgren (2):
      Merge branch 'for_3.5/omap_misc_cleanup' of git://gitorious.org/omap-sw-develoment/linux-omap-dev into cleanup-soc
      Merge branch 'cleanup-soc' into cleanup

Yegor Yefremov (1):
      GPMC: add ECC control definitions

 arch/arm/Makefile                                 |    4 +-
 arch/arm/mach-omap2/Makefile                      |  167 ++++++++++-----------
 arch/arm/mach-omap2/dma.c                         |   11 +-
 arch/arm/mach-omap2/gpmc.c                        |   30 +++-
 arch/arm/mach-omap2/hsmmc.c                       |    8 +-
 arch/arm/mach-omap2/id.c                          |    7 +-
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |    8 -
 arch/arm/mach-omap2/io.c                          |   30 ----
 arch/arm/mach-omap2/iomap.h                       |   28 ----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c        |    2 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c       |    2 +-
 arch/arm/mach-omap2/usb-musb.c                    |    2 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c     |    2 +-
 arch/arm/plat-omap/dma.c                          |    4 +-
 arch/arm/plat-omap/dmtimer.c                      |    2 -
 arch/arm/plat-omap/include/plat/cpu.h             |    8 +
 arch/arm/plat-omap/include/plat/dma.h             |    5 +
 arch/arm/plat-omap/include/plat/dmtimer.h         |    1 -
 18 files changed, 137 insertions(+), 184 deletions(-)
