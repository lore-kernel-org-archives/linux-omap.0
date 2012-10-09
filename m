From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/5] omap pm fixes for v3.7-rc1
Date: Tue, 9 Oct 2012 11:46:26 -0700
Message-ID: <E1TLepY-0002mz-97@merlin.infradead.org>
References: <pull-1349808387-617119>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1349808387-617119>
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

The following changes since commit 5e090ed7af10729a396a25df43d69a236e789736:

  Merge tag 'soc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-10-07 20:55:16 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc1/fixes-pm-signed

for you to fetch changes up to fce680e9faaa8acc0ab0a931c5fa823b581cbab0:

  Merge tag 'for_3.7-fixes-pm' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.7-rc1/fixes-pm (2012-10-08 15:57:41 -0700)

----------------------------------------------------------------

>From Kevin Hilman <khilman@deeprootsystems.com>:

OMAP PM related fixes for v3.7-rc

----------------------------------------------------------------
Jean Pihet (2):
      ARM: OMAP: SmartReflex: select CONFIG_POWER_SUPPLY in Kconfig
      ARM: OMAP: SmartReflex: fix error path in init function

Tony Lindgren (1):
      Merge tag 'for_3.7-fixes-pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.7-rc1/fixes-pm

Wei Yongjun (4):
      ARM: OMAP: fix return value check in beagle_opp_init()
      ARM: OMAP: omap_device: fix return value check in omap_device_build_ss()
      ARM: OMAP2+: SmartReflex: fix return value check in sr_dev_init()
      ARM: OMAP2+: PM: fix return value check in omap2_set_init_voltage()

 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/pm.c                |    2 +-
 arch/arm/mach-omap2/sr_device.c         |    2 +-
 arch/arm/plat-omap/Kconfig              |    1 +
 arch/arm/plat-omap/omap_device.c        |    2 +-
 drivers/power/avs/smartreflex.c         |    8 ++++----
 6 files changed, 9 insertions(+), 8 deletions(-)
