From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v4.8-rc cycle
Date: Tue, 16 Aug 2016 08:47:40 -0700
Message-ID: <20160816154740.bq3nuqz44tglcdxf@atomide.com>
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
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.8/fixes-rc2

for you to fetch changes up to 73912188a6663192063dc29362039997f4deb580:

  Merge branch 'dts-fixes' into omap-for-v4.8/fixes (2016-08-15 09:16:45 -0700)

----------------------------------------------------------------
Fixes for omaps for v4.8-rc cycle, mostly a series of four fixes for
am335x RTC zero offset for clkctrl register. Also few other fixes:

- Add missing sysc information for DSI as at least n950 needs it for
  the working display

- Fix old elm-id properties that cause nand boot to not work

- Fix overo gpmc nand cs0 range

- FIx overo gpmc nand on boards with ethernet

- Fix logicpd torpedo nand ready pin nand interrupt configuration

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: logicpd-torpedo-som: Provide NAND ready pin
      ARM: dts: logicpd-somlv: Fix NAND device nodes

Dave Gerlach (4):
      ARM: OMAP4+: hwmod: Add hwmod flag for HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET
      ARM: OMAP2+: AM33XX: Add HWMOD_OMAP4_ZERO_CLKCTRL_OFFSET flag to rtc hwmod
      ARM: OMAP4+: Have _omap4_wait_target_* check for valid clkctrl_offs
      ARM: OMAP4+: CM: Remove redundant checks for clkctrl_offs of zero

Johan Hovold (2):
      ARM: dts: overo: fix gpmc nand cs0 range
      ARM: dts: overo: fix gpmc nand on boards with ethernet

Sebastian Reichel (1):
      ARM: OMAP3: hwmod data: Add sysc information for DSI

Teresa Remmet (1):
      ARM: dts: am335x: Update elm phandle binding

Tony Lindgren (2):
      Merge branch 'omap-for-v4.8/soc' into omap-for-v4.8/fixes
      Merge branch 'dts-fixes' into omap-for-v4.8/fixes

 arch/arm/boot/dts/am335x-baltos.dtsi                    |  2 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi                  |  2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi               |  2 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi                   | 11 ++++++-----
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi              |  1 +
 arch/arm/boot/dts/omap3-overo-base.dtsi                 |  4 +++-
 arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi    |  2 --
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi          |  2 --
 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi       |  3 ---
 arch/arm/mach-omap2/cm33xx.c                            |  6 ------
 arch/arm/mach-omap2/cminst44xx.c                        |  6 ------
 arch/arm/mach-omap2/omap_hwmod.c                        |  8 ++++++++
 arch/arm/mach-omap2/omap_hwmod.h                        |  4 ++++
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  2 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c              | 12 ++++++++++++
 15 files changed, 39 insertions(+), 28 deletions(-)
