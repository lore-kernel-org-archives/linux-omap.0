From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.4-rc2
Date: Wed, 25 Nov 2015 14:37:04 -0800
Message-ID: <20151125223704.GV2517@atomide.com>
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

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.4/fixes-rc2

for you to fetch changes up to 918af9f941af9995fcaa7ef1eb67c433a492e2b3:

  ARM: OMAP4+: SMP: use lockless clkdm/pwrdm api in omap4_boot_secondary (2015-11-25 11:03:20 -0800)

----------------------------------------------------------------
Fixes for omaps for v4.4-rc cycle:

- A series of audio changes for dra7 that missed the merge window but turned
  out to be necessary to fix a boot time imprecise external abort error and to
  getaudio working

- Fix l4 related boot time errors for dm81xx

- Use lockless cldm/pwrdm api in omap4_boot_secondary

- Remove t410 custom abort handler that is no longer needed and may
  hide other critical errors

- Mark cpuidle tracepoints as _rcuidle

- Fix module alias for omap-ocp2scp

----------------------------------------------------------------
Axel Lin (1):
      bus: omap-ocp2scp: Fix module alias

Grygorii Strashko (1):
      ARM: OMAP4+: SMP: use lockless clkdm/pwrdm api in omap4_boot_secondary

Jisheng Zhang (1):
      ARM: OMAP2+: PM: Denote the cpuidle tracepoints as _rcuidle()

Lucas Stach (1):
      ARM: OMAP2+: remove custom abort handler for t410

Neil Armstrong (1):
      arm: omap2+: add missing HWMOD_NO_IDLEST in 81xx hwmod data

Peter Ujfalusi (3):
      ARM: dts: dra7: Fix McASP3 node regarding to clocks
      ARM: OMAP2+: hwmod: Add hwmod flag for HWMOD_OPT_CLKS_NEEDED
      ARM: OMAP: DRA7: hwmod: Add data for McASP3

Tony Lindgren (2):
      Merge branch 'x15-audio-fixes' into omap-for-v4.4/fixes
      Merge branch '81xx' into omap-for-v4.4/fixes

 arch/arm/boot/dts/dra7.dtsi                |  4 +-
 arch/arm/mach-omap2/omap-smp.c             |  6 +--
 arch/arm/mach-omap2/omap_hwmod.c           | 66 ++++++++++++++++--------------
 arch/arm/mach-omap2/omap_hwmod.h           |  3 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 56 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |  3 ++
 arch/arm/mach-omap2/pdata-quirks.c         | 29 -------------
 arch/arm/mach-omap2/pm34xx.c               |  4 +-
 drivers/bus/omap-ocp2scp.c                 |  2 +-
 9 files changed, 106 insertions(+), 67 deletions(-)
