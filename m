From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/6] ti-sysc changes for v4.17
Date: Mon,  5 Mar 2018 10:11:04 -0800
Message-ID: <pull-1520273005-304551@atomide.com-4>
References: <pull-1520273005-304551@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1520273005-304551@atomide.com>
In-Reply-To: <pull-1520273005-304551@atomide.com>
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

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.17/ti-sysc-signed

for you to fetch changes up to 695eea3d2c7f3e70e852226c338d464a6251c70b:

  ARM: OMAP2+: Enable ti-sysc to use device tree data for smartreflex (2018-02-28 20:03:21 -0800)

----------------------------------------------------------------
Driver changes for ti-sysc for v4.17

This series of changes enables the use device tree based sysconfig
data for ti-sysc driver. As we already have SmartReflex data configured,
we use that as the first driver to enable. To do that in a way where
SmartReflex is not probed twice, we need to prepare the SmartReflex
driver before flipping dts data on for it in the last patch of the
series.

To avoid regressions, we are checking the passed dts data against
existing platform data since we still have it available. Then after the
dts files are converted, we can simply drop the related platform data
at some point in the future.

----------------------------------------------------------------
Tony Lindgren (13):
      ARM: OMAP2+: Prepare to pass auxdata for smartreflex
      bus: ti-sysc: Add fck clock alias for children with notifier_block
      bus: ti-sysc: Add suspend and resume handling
      bus: ti-sysc: Handle stdout-path for debug console
      bus: ti-sysc: Improve handling for no-reset-on-init and no-idle-on-init
      bus: ti-sysc: Remove unnecessary debugging statements
      bus: ti-sysc: Add support for platform data callbacks
      bus: ti-sysc: Handle some devices in omap_device compatible way
      ARM: OMAP2+: Add functions to allocate module data from device tree
      ARM: OMAP2+: Add checks for device tree based sysconfig data
      ARM: OMAP2+: Try to parse earlycon from parent too
      PM / AVS: SmartReflex: Prepare to use device tree based probing
      ARM: OMAP2+: Enable ti-sysc to use device tree data for smartreflex

 arch/arm/mach-omap2/board-n8x0.c      |   4 +-
 arch/arm/mach-omap2/omap_device.c     |   5 +
 arch/arm/mach-omap2/omap_hwmod.c      | 418 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod.h      |   7 +
 arch/arm/mach-omap2/pdata-quirks.c    |  54 +++-
 arch/arm/mach-omap2/sr_device.c       |  27 +-
 drivers/bus/ti-sysc.c                 | 526 +++++++++++++++++++++++++++++++---
 drivers/power/avs/smartreflex.c       |  41 ++-
 include/linux/platform_data/ti-sysc.h |  50 ++++
 include/linux/power/smartreflex.h     |  10 +-
 10 files changed, 1086 insertions(+), 56 deletions(-)
