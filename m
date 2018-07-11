From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/5] soc changes for omaps for v4.19
Date: Wed, 11 Jul 2018 06:19:05 -0700
Message-ID: <pull-1531314878-371161@atomide.com-2>
References: <pull-1531314878-371161@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1531314878-371161@atomide.com>
In-Reply-To: <pull-1531314878-371161@atomide.com>
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

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.19/soc-signed

for you to fetch changes up to 8c5a916f4c8815196cc8a86b9582ca89422aac25:

  ARM: OMAP2+: sleep33/43xx: Add RTC-Mode support (2018-07-09 23:01:34 -0700)

----------------------------------------------------------------
SoC updates for omaps for v4.19 merge window

These changes are mostly PM related changes for am335x and
am437x to support RTC only suspend mode. Some of the clock
and driver related chances are still pending so it's not
yet fully functional.

Also included is a change for PM debug sysfs entry to use
DEFINE_SHOW_ATTRIBUTE.

----------------------------------------------------------------
Andy Shevchenko (1):
      ARM: OMAP2+: reuse DEFINE_SHOW_ATTRIBUTE() macro

Dave Gerlach (2):
      ARM: hwmod: RTC: Don't assume lock/unlock will be called with irq enabled
      ARM: OMAP2+: sleep33/43xx: Make sleep actions configurable

Keerthy (1):
      ARM: OMAP2+: sleep33/43xx: Add RTC-Mode support

 arch/arm/mach-omap2/omap_hwmod_reset.c |  12 ++--
 arch/arm/mach-omap2/pm-asm-offsets.c   |   2 +
 arch/arm/mach-omap2/pm-debug.c         |  37 ++---------
 arch/arm/mach-omap2/pm33xx-core.c      |  20 ++++--
 arch/arm/mach-omap2/sleep33xx.S        |  52 +++++++++++++++-
 arch/arm/mach-omap2/sleep43xx.S        | 110 +++++++++++++++++++++++++++++++--
 drivers/soc/ti/pm33xx.c                |  16 ++++-
 include/linux/platform_data/pm33xx.h   |  29 ++++++++-
 8 files changed, 229 insertions(+), 49 deletions(-)
