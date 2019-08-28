From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 3/4] drop more legacy pdata for omaps for v5.4
Date: Wed, 28 Aug 2019 11:34:51 -0700
Message-ID: <pull-1567016893-318461@atomide.com-3>
References: <pull-1567016893-318461@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1567016893-318461@atomide.com>
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

The following changes since commit 5b63fb90adb95a178ad403e1703f59bf1ff2c16b:

  ARM: dts: Fix incomplete dts data for am3 and am4 mmc (2019-08-13 04:03:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.4/ti-sysc-drop-pdata-take2-signed

for you to fetch changes up to 1170f235834bfb858f691670b127f8673af5923b:

  ARM: dts: Drop legacy custom hwmods property for dra7 gpio (2019-08-26 10:59:25 -0700)

----------------------------------------------------------------
Drop legacy platform data omap variants for v5.4

We can now drop more platform data in favor of dts data for most
devices like cpsw, gpio, i2c, mmc, uart and watchdog.

In general we can do this by dropping legacy "ti,hwmods" custom dts
property, and the platform data assuming the related dts data is correct.
This is best done as single patch as otherwise we'd have to revert two
patches in case of any unexpected issues, and we're just removing data.

Fro cpsw, before we can do this, we need to configure the cpsw mdio clocks
properly in dts though in the first patch. For omap4 i2c, we've already
dropped the platform data earlier, but have been still allocting it
dynamically based on the dts data based on the "ti,hwmods" property, but
that is no longer needed. For d2d, we are missing the dts data, so we
first add it and then drop the platform data.

For dra7, we drop platform data and "ti,hwmods" for mcasp and mcspi.
We've already dropped platform data earlier for gpio, i2c, mmc, and
uart so we just need to drop "ti,hwmods" property for those.

Note that this branch is based on earlier ti-sysc-fixes branch.

----------------------------------------------------------------
Tony Lindgren (13):
      ARM: dts: Add fck for cpsw mdio for omap variants
      ARM: OMAP2+: Drop legacy platform data for cpsw on am3 and am4
      ARM: OMAP2+: Drop legacy platform data for cpsw on dra7
      ARM: dts: Drop custom hwmod property for omap4 i2c
      ARM: OMAP2+: Drop legacy watchdog platform data for omap4
      ARM: dts: Configure d2d dts data for omap4
      ARM: OMAP2+: Drop legacy platform data for omap4 d2d
      ARM: OMAP2+: Drop legacy platform data for dra7 mcspi
      ARM: OMAP2+: Drop legacy platform data for dra7 mcasp
      ARM: dts: Drop legacy custom hwmods property for dra7 uart
      ARM: dts: Drop legacy custom hwmods property for dra7 i2c
      ARM: dts: Drop legacy custom hwmods property for dra7 mmc
      ARM: dts: Drop legacy custom hwmods property for dra7 gpio

 arch/arm/boot/dts/am33xx-l4.dtsi                   |   4 +-
 arch/arm/boot/dts/am437x-l4.dtsi                   |   6 +-
 arch/arm/boot/dts/dra7-l4.dtsi                     |  43 +-
 arch/arm/boot/dts/omap4-l4-abe.dtsi                |   1 -
 arch/arm/boot/dts/omap4-l4.dtsi                    |  39 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |   3 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |   6 -
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  50 ---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   9 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |   9 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 115 -----
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 475 ---------------------
 12 files changed, 36 insertions(+), 724 deletions(-)
