From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/2] omap fixes against v3.12-rc1
Date: Wed, 18 Sep 2013 13:59:02 -0700
Message-ID: <2373.72159394926$1379537985@news.gmane.org>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/fixes-signed

for you to fetch changes up to e942cc06e2d183975dd47d8da9e569316cb870ea:

  ARM: OMAP2+: mux: fix trivial typo in name (2013-09-18 12:02:01 -0700)

----------------------------------------------------------------
omap fixes for build warnings and cpuidle, and
a few trivial typo fixes.

----------------------------------------------------------------
Anoop Thomas Mathew (1):
      ARM: OMAP4 SMP: Corrected a typo fucntions to functions

Fabio Estevam (1):
      ARM: mach-omap2: gpmc: Fix warning when CONFIG_ARM_LPAE=y

Jingoo Han (1):
      mailbox: remove unnecessary platform_set_drvdata()

Phil Carmody (1):
      ARM: OMAP2+: mux: fix trivial typo in name

Tony Lindgren (1):
      ARM: OMAP4: Fix clock_get error for GPMC during boot

Vladimir Murzin (1):
      ARM: OMAP4: cpuidle: fix: call cpu_cluster_pm_exit conditionally

Wei Yongjun (1):
      ARM: OMAP: fix return value check in omap_device_build_from_dt()

 arch/arm/mach-omap2/cclock44xx_data.c | 2 +-
 arch/arm/mach-omap2/cpuidle44xx.c     | 2 +-
 arch/arm/mach-omap2/gpmc.c            | 4 ++--
 arch/arm/mach-omap2/mux34xx.c         | 2 +-
 arch/arm/mach-omap2/omap-smp.c        | 2 +-
 arch/arm/mach-omap2/omap_device.c     | 2 +-
 drivers/mailbox/mailbox-omap2.c       | 1 -
 7 files changed, 7 insertions(+), 8 deletions(-)
