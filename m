From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/2] omap cleanup for v3.8 merge window
Date: Mon, 17 Dec 2012 11:10:47 -0800
Message-ID: <E1Tkg5i-0007xW-K5@merlin.infradead.org>
References: <pull-1355771447-111279>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1355771447-111279>
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

The following changes since commit 2b8318881ddbcb67c5e8d2178b42284749442222:

  Merge tag 'fbdev-for-3.8' of git://gitorious.org/linux-omap-dss2/linux (2012-12-15 13:03:48 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-for-merge-window-signed

for you to fetch changes up to f64d204b5cf21b282445ba2fa357d970028c9f52:

  arch/arm/mach-omap2/dpll3xxx.c: drop if around WARN_ON (2012-12-17 10:50:41 -0800)

----------------------------------------------------------------
Here are few more patches to finish the omap changes for
multiplatform conversion that are not strictly fixes, but
were too complex to do with the dependencies during the
merge window. Those are to move of serial-omap.h to
platform_data, and the removal of remaining cpu_is_omap
macro usage outside mach-omap2.

Then there are several trivial fixes for typos and few
minimal omap2plus_defconfig updates.

----------------------------------------------------------------
AnilKumar Chimata (1):
      ARM: OMAP2+: omap2plus_defconfig: Add tps65217 support

Javier Martinez Canillas (2):
      ARM: OMAP2+: enable devtmpfs and devtmpfs automount
      ARM: OMAP2+: omap2plus_defconfig: enable twl4030 SoC audio

Jon Hunter (1):
      ARM: OMAP2+: PMU: Remove unused header

Julia Lawall (1):
      arch/arm/mach-omap2/dpll3xxx.c: drop if around WARN_ON

Peter Ujfalusi (1):
      ARM: OMAP2+: omap_twl: Change TWL4030_MODULE_PM_RECEIVER to TWL_MODULE_PM_RECEIVER

Srinivas Kandagatla (1):
      ARM/omap: use module_platform_driver macro

Tony Lindgren (3):
      MAINTAINERS: Add an entry for omap related .dts files
      ARM: OMAP: Split fb.c to remove last remaining cpu_is_omap usage
      ARM: OMAP2+: Drop plat/cpu.h for omap2plus

Wei Yongjun (1):
      ARM: OMAP4: remove duplicated include from omap_hwmod_44xx_data.c

YOSHIFUJI Hideaki (1):
      OMAP2: Fix a typo - replace regist with register.

 MAINTAINERS                                |  9 ++++
 arch/arm/configs/omap2plus_defconfig       |  5 ++
 arch/arm/mach-omap1/Makefile               |  2 +-
 arch/arm/mach-omap1/fb.c                   | 80 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile               |  2 +-
 arch/arm/mach-omap2/control.h              |  2 +-
 arch/arm/mach-omap2/dpll3xxx.c             |  3 +-
 arch/arm/mach-omap2/drm.c                  |  1 -
 arch/arm/mach-omap2/dss-common.c           |  3 +-
 arch/arm/{plat-omap => mach-omap2}/fb.c    | 50 +------------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  1 -
 arch/arm/mach-omap2/omap_twl.c             |  8 +--
 arch/arm/mach-omap2/pmu.c                  |  2 -
 arch/arm/mach-omap2/prm2xxx.c              |  3 +-
 arch/arm/mach-omap2/prm3xxx.c              |  3 +-
 arch/arm/plat-omap/Makefile                |  2 +-
 arch/arm/plat-omap/dmtimer.c               | 13 +----
 arch/arm/plat-omap/include/plat/cpu.h      |  4 --
 drivers/media/platform/omap3isp/isp.c      |  2 -
 drivers/power/avs/smartreflex.c            |  2 -
 20 files changed, 109 insertions(+), 88 deletions(-)
 create mode 100644 arch/arm/mach-omap1/fb.c
 rename arch/arm/{plat-omap => mach-omap2}/fb.c (76%)
