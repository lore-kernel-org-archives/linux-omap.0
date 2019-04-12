From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] ti-sysc driver changes for omaps for v5.2
Date: Fri, 12 Apr 2019 10:02:06 -0700
Message-ID: <pull-1555087688-487222@atomide.com-2>
References: <pull-1555087688-487222@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1555087688-487222@atomide.com>
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

The following changes since commit 8b30919a4e3c7aba32dd72e8208147a6496cb16c:

  ARM: OMAP2+: Handle reset quirks for dynamically allocated modules (2019-03-26 11:26:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/ti-sysc-signed

for you to fetch changes up to d59b60564cbfe77d85c2f51b29941d8ed14984d1:

  bus: ti-sysc: Add generic enable/disable functions (2019-04-09 08:58:48 -0700)

----------------------------------------------------------------
Driver changes for ti-sysc for v5.2 merge window

This series of changes for ti-sysc interconnect target module driver
gets us to the point where we can actually drop legacy platform data
for many devices in favor of device tree data.

To do this, we improve ti-sysc driver not to rely on platform data
callbacks to manage module clocks, and handle more quirks needed for
some devices. Also few minor fixes are needed, but were considered
not needed to be sent separately as they only show up with this series.

Then we drop several thousands of lines of legacy platform data for
omap4, omap5, dra7, am335x and am437x. We drop platform data for mmc,
i2c, gpio and uart devices to start with as those are typically
easily tested on all devices. In case of unexpected issues, we can just
add back the legacy platform data for a single device type if needed.

Finally we add initial support for enabling and disabling some devices
without legacy platform data callbacks. I was planning on sending the
dropping of legacy platform data as a separate series, but already
applied Roger's patch on top and pushed it out.

Note that this series depends on related SoC and is based on those.

----------------------------------------------------------------
Colin Ian King (1):
      Documentation: bus: ti-sysc: fix spelling mistakes "multipe" and "interconnet"

Roger Quadros (1):
      bus: ti-sysc: Add generic enable/disable functions

Tony Lindgren (31):
      bus: ti-sysc: Fix sysc_unprepare() when no clocks have been allocated
      bus: ti-sysc: Handle missed no-idle property in addition to no-idle-on-init
      bus: ti-sysc: Make functions static
      bus: ti-sysc: Move legacy platform data idling into separate functions
      bus: ti-sysc: Add separate functions for handling clocks
      bus: ti-sysc: Enable all clocks directly during init to read revision
      bus: ti-sysc: Allocate mdata as needed and do platform data based init later
      bus: ti-sysc: Manage clocks for the interconnect target module in all cases
      bus: ti-sysc: Move rstctrl reset to happen later
      bus: ti-sysc: Add support for early quirks based on register address
      bus: ti-sysc: Add quirk handling for external optional functional clock
      bus: ti-sysc: Pass clockactivity quirk to platform functions
      bus: ti-sysc: Handle swsup idle mode quirks
      bus: ti-sysc: Detect DMIC for debugging
      ARM: OMAP2+: Drop mmc platform data for omap4
      ARM: OMAP2+: Drop i2c platform data for omap4
      ARM: OMAP2+: Drop gpio platform data for omap4
      ARM: OMAP2+: Drop uart platform data for omap4
      ARM: OMAP2+: Drop mmc platform data for am330x and am43xx
      ARM: OMAP2+: Drop i2c platform data for am33xx and am43xx
      ARM: OMAP2+: Drop gpio platform data for am33xx and am43xx
      ARM: OMAP2+: Drop uart platform data for am33xx and am43xx
      ARM: OMAP2+: Drop mmc platform data for omap5
      ARM: OMAP2+: Drop i2c platform data for omap5
      ARM: OMAP2+: Drop gpio platform data for omap5
      ARM: OMAP2+: Drop uart platform data for omap5
      ARM: OMAP2+: Drop mmc platform data for dra7
      ARM: OMAP2+: Drop i2c platform data for dra7
      ARM: OMAP2+: Drop gpio platform data for dra7
      ARM: OMAP2+: Drop uart platform data for dra7
      ARM: OMAP2+: Drop mcspi platform data for omap4

 Documentation/devicetree/bindings/bus/ti-sysc.txt  |   6 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  10 +
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  29 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c       | 103 ---
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 253 -------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  64 --
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 113 ---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 737 ------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         | 746 ------------------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 841 ---------------------
 drivers/bus/ti-sysc.c                              | 661 +++++++++++++---
 include/linux/platform_data/ti-sysc.h              |   9 +-
 12 files changed, 569 insertions(+), 3003 deletions(-)
