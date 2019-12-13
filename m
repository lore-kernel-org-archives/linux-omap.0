From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v5.5-rc cycle
Date: Fri, 13 Dec 2019 08:35:40 -0800
Message-ID: <pull-1576254925-709310@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: soc@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.5/fixes-rc1-signed

for you to fetch changes up to e709ed70d122e94cb426b1e1f905829eae19a009:

  bus: ti-sysc: Fix missing reset delay handling (2019-12-12 08:20:10 -0800)

----------------------------------------------------------------
Fixes for omap variants for v5.5-rc1 cycle

This series of changes contains fixes for issues recently noticed:

- The ti-sysc interconnect target module driver needs fixes for
  mstandby quirk handling and reset delay

- We need to configure am335x-sancloud-bbe to use rgmii-id mode because of
  the phy changes done earlier

- NET_SWITCHDEV is no longer selected in Kconfig but a dependency and we
  must enable CONFIG_NET_SWITCHDEV to have TI_CPSW_SWITCHDEV

- We are still relying on DEBUG_FS at least for PM configuration, let's
  add it back

- We need to update compatible for am437x-gp/epos-evm because of the
  recent changes to use generic panels

----------------------------------------------------------------
Grygorii Strashko (1):
      ARM: omap2plus_defconfig: enable NET_SWITCHDEV

Mans Rullgard (1):
      ARM: dts: am335x-sancloud-bbe: fix phy mode

Tomi Valkeinen (1):
      ARM: dts: am437x-gp/epos-evm: fix panel compatible

Tony Lindgren (3):
      bus: ti-sysc: Fix missing force mstandby quirk handling
      ARM: omap2plus_defconfig: Add back DEBUG_FS
      bus: ti-sysc: Fix missing reset delay handling

 arch/arm/boot/dts/am335x-sancloud-bbe.dts | 2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts       | 2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts      | 2 +-
 arch/arm/configs/omap2plus_defconfig      | 4 +++-
 drivers/bus/ti-sysc.c                     | 7 ++++++-
 include/linux/platform_data/ti-sysc.h     | 1 +
 6 files changed, 13 insertions(+), 5 deletions(-)
