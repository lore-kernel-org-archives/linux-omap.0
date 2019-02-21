From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] two am335x ethernet phy mode fixes for v5.0-rc cycle
Date: Thu, 21 Feb 2019 08:44:18 -0800
Message-ID: <pull-1550767433-845690@atomide.com>
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
To: arm@kernel.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 50d6b3cf9403879911e06d69c7ef41e43f8f7b4b:

  ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug (2019-02-07 07:48:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.0/fixes-rc7-signed

for you to fetch changes up to 0661465ec86e8ae28f09a04e51425c486d64dfb1:

  Merge branch 'am335x-phy-fixes' into omap-for-v5.0/fixes-v2 (2019-02-19 08:47:17 -0800)

----------------------------------------------------------------
Two am335x ethernet phy mode fixes for v5.0-rc cycle

Recent changes with commit cd28d1d6e52e: ("net: phy: at803x: Disable phy
delay for RGMII mode") broke Ethernet on am335x-evmsk, and turns out some
device driver fixes are needed.

Even without the driver fixes, am335x needs to run in rgmii-id mode instead
rgmii-txid mode. Things have been working based on luck as the broken driver
has been configuring rgmii-id mode. Let's fix that as that way things work
as they're supposed to work from hardware wiring point of view.

----------------------------------------------------------------
Peter Ujfalusi (2):
      ARM: dts: am335x-evmsk: Fix PHY mode for ethernet
      ARM: dts: am335x-evm: Fix PHY mode for ethernet

Tony Lindgren (1):
      Merge branch 'am335x-phy-fixes' into omap-for-v5.0/fixes-v2

 arch/arm/boot/dts/am335x-evm.dts   | 2 +-
 arch/arm/boot/dts/am335x-evmsk.dts | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
