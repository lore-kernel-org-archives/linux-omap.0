From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 6/7] smartreflex fixes and clean-up for upcoming merge
 window
Date: Thu, 8 Mar 2012 12:53:29 -0800
Message-ID: <E1S5kMB-00014z-Fj@merlin.infradead.org>
References: <pull-1331240009-558004>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1331240009-558004>
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

This one contains clean-up and fixes for the smartreflex
so it can be eventually moved to live under drivers.
After this series, the next series will move this to
drivers.

As this depends on earlier fixes-non-critical merged
into arm-soc, this one is based on commit 149f1d5c
there. This would be probably best merged into driver
branch that would then depend on fixes-non-critical.


The following changes since commit 149f1d5c8d2fd6879cdf93ca70f1cb745e698a1e:
  Tony Lindgren (1):
        ARM: OMAP2+: Fix devexit for smartreflex when CONFIG_HOTPLUG is not set

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap sr

Felipe Balbi (4):
      ARM: OMAP3+: SmartReflex: add missing platform_set_drvdata()
      ARM: OMAP3+: SmartReflex: move late_initcall() closer to its argument
      ARM: OMAP3+: SmartReflex: misc cleanups
      ARM: OMAP3+: SmartReflex: micro-optimization for sanity check

Jean Pihet (2):
      ARM: OMAP3+: SmartReflex: fix the use of debugfs_create_* API
      ARM: OMAP3+: SmartReflex: fix error handling

Nishanth Menon (6):
      ARM: OMAP3+: SmartReflex: fix err interrupt disable sequence
      ARM: OMAP3+: SmartReflex Class3: disable errorgen before disable VP
      ARM: OMAP3+: SmartReflex: Add a shutdown hook
      ARM: OMAP3+: SmartReflex: Fix status masking in ERRCONFIG register
      ARM: OMAP3+: SmartReflex: clear ERRCONFIG_VPBOUNDINTST only on a need
      ARM: OMAP3+: hwmod: add SmartReflex IRQs

Shweta Gulati (1):
      ARM: OMAP3+: SmartReflex: use voltage domain name in device attributes

Tony Lindgren (1):
      Merge branch 'for_3.4/cleanup/sr' of git://git.kernel.org/.../khilman/linux-omap-pm into sr

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   31 +++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   19 ++-
 arch/arm/mach-omap2/smartreflex-class3.c     |    1 +
 arch/arm/mach-omap2/smartreflex.c            |  227 +++++++++++++++++++-------
 arch/arm/mach-omap2/smartreflex.h            |   10 +
 arch/arm/mach-omap2/sr_device.c              |   11 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 7 files changed, 229 insertions(+), 72 deletions(-)
