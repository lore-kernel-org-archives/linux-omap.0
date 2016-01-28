From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v4.5-rc1
Date: Thu, 28 Jan 2016 09:55:41 -0800
Message-ID: <20160128175540.GG19432@atomide.com>
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

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.5/fixes-rc1

for you to fetch changes up to ab342c77fa60a30fce4d4228f88fd1b7bf566055:

  ARM: dts: am57xx: sbc-am57x: correct Eth PHY settings (2016-01-27 09:19:31 -0800)

----------------------------------------------------------------
Fixes for omaps with the most intrusive stuff being read-only data
assembly fixes, the other things are mostly board related:

- A series of omap assembly code fixes to fix issues with rodata with
  ARM_KERNMEM_PERMS enabled. We had several places writing to rodata,
  which is bad. The fix in most cases is to load the value from data
  section using a pointer. Let's also enable ARM_KERNMEM_PERMS so
  DEBUG_RODATA gets selected by default. And while testing things,
  I also added few more loadable driver modules to the defconfig that
  I seem to need quite often.

- Fix a long standing omap5 RTC mystery and enable RTC where we need
  to ensure the SoC msecure pin is high so we can write to the RTC
  registers.

- Fix irq types for am437x

- A series of minor dts fixes for sbc-am57x and cl-som-am57x

- Fixes for torpedo dts to make WLAN behave and to remove a duplicate
  i2c rate entry

This series also includes few minor changes that are not stricly
fixes, but would be good to get in during the early -rc cycle:

- Remove legacy mailbox platform data that is no longer needed

- Add the pdata-quirks needed for the new pwm-omap-dmtimer so
  people can use it

- Enable ti,mbox-send-noirq that's needed by wkup_m3 driver

- Enable SPLIT and DWARF4 in omap2plus_defconfig as it makes the
  initramfs quite a bit smaller

----------------------------------------------------------------
Adam Ford (2):
      ARM: dts: Fix wl12xx missing clocks that cause hangs
      ARM: dts: LogicPD Torpedo: Revert Duplicative Entries

Dave Gerlach (1):
      ARM: dts: AM33xx: Add ti,mbox-send-noirq to wkup_m3 mailbox

Dmitry Lifshitz (6):
      ARM: dts: am57xx: sbc-am57x: fix SB-SOM EEPROM I2C address
      ARM: dts: am57xx: cl-som-am57x: set HOST mode for USB2
      ARM: dts: am57xx: cl-som-am57x: update SPI Flash frequency
      ARM: dts: am57xx: sbc-am57x: fix UART3 pinmux
      ARM: dts: am57xx: cl-som-am57x: fix CPSW EMAC pinmux
      ARM: dts: am57xx: sbc-am57x: correct Eth PHY settings

Felipe Balbi (1):
      ARM: omap2plus_defconfig: enable SPLIT and DWARF4

Grygorii Strashko (2):
      ARM: dts: am4372: fix irq type for arm twd and global timer
      ARM: dts: am437x: pixcir_tangoc: use correct flags for irq types

H. Nikolaus Schaller (1):
      ARM: dts: omap5-board-common: enable rtc and charging of backup battery

Keerthy (1):
      ARM: dts: AM4372: Add ti,mbox-send-noirq to wkup_m3 mailbox

Neil Armstrong (1):
      ARM: OMAP: Add PWM dmtimer platform data quirks

Suman Anna (1):
      ARM: OMAP2+: Remove legacy mailbox device instantiation

Tony Lindgren (8):
      ARM: dts: Fix omap5 PMIC control lines for RTC writes
      ARM: OMAP2+: Fix wait_dll_lock_timed for rodata
      ARM: OMAP2+: Fix l2dis_3630 for rodata
      ARM: OMAP2+: Fix save_secure_ram_context for rodata
      ARM: OMAP2+: Fix l2_inv_api_params for rodata
      ARM: OMAP2+: Fix ppa_zero_params and ppa_por_params for rodata
      ARM: omap2plus_defconfig: Enable ARM_KERNMEM_PERMS and few loadable modules
      Merge branch 'enable-devices' into omap-for-v4.5/fixes

 arch/arm/boot/dts/am33xx.dtsi              |  1 +
 arch/arm/boot/dts/am4372.dtsi              |  5 ++-
 arch/arm/boot/dts/am437x-gp-evm.dts        |  4 +-
 arch/arm/boot/dts/am43x-epos-evm.dts       |  2 +-
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts  | 12 +++---
 arch/arm/boot/dts/am57xx-sbc-am57x.dts     |  8 ++--
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi |  9 +----
 arch/arm/boot/dts/omap5-board-common.dtsi  | 33 ++++++++++++++++
 arch/arm/configs/omap2plus_defconfig       | 10 +++++
 arch/arm/mach-omap2/devices.c              | 28 --------------
 arch/arm/mach-omap2/pdata-quirks.c         | 23 +++++++++++
 arch/arm/mach-omap2/sleep34xx.S            | 61 +++++++++++++++---------------
 arch/arm/mach-omap2/sleep44xx.S            | 25 ++++++++----
 13 files changed, 130 insertions(+), 91 deletions(-)
