From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v2.6.32-rc4
Date: Wed, 14 Oct 2009 17:33:42 -0700
Message-ID: <20091015003341.GG14531@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Linus,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Regards,

Tony


The following changes since commit 161291396e76e0832c08f617eb9bd364d1648148:
  Linus Torvalds (1):
        Linux 2.6.32-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus

Aaro Koskinen (1):
      omap: RX-51: Drop I2C-1 speed to 2200

Anuj Aggarwal (1):
      omap: SDMA: Fixing bug in omap_dma_set_global_params()

Jarkko Nikula (1):
      omap: McBSP: Fix incorrect receiver stop in omap_mcbsp_stop

Kalle Jokiniemi (1):
      OMAP: Fix race condition with autodeps

Paul Walmsley (1):
      OMAP2xxx clock: set up clockdomain pointer in struct clk

Sanjeev Premi (1):
      omap: CONFIG_ISP1301_OMAP redefined in Beagle defconfig

Teerth Reddy (1):
      omap: Initialization of SDRC params on Zoom2

Tony Lindgren (1):
      Merge branch '2_6_32rc4_fixes' of git://git.pwsan.com/linux-2.6 into omap-fixes-for-linus

 arch/arm/configs/omap3_beagle_defconfig      |    1 -
 arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
 arch/arm/mach-omap2/board-zoom2.c            |    4 +-
 arch/arm/mach-omap2/clock24xx.c              |    1 +
 arch/arm/mach-omap2/clockdomain.c            |   74 +++++++++++++++----------
 arch/arm/plat-omap/dma.c                     |   15 +++--
 arch/arm/plat-omap/mcbsp.c                   |    2 +-
 7 files changed, 59 insertions(+), 40 deletions(-)
