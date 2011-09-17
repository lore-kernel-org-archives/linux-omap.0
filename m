From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap voltage cleanup for v3.2 merge window
Date: Fri, 16 Sep 2011 18:54:19 -0700
Message-ID: <20110917015419.GD2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:37949 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752904Ab1IQByW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 21:54:22 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

Please pull omap voltage cleanup series:

git://github.com/tmlind/linux.git voltage

This has a dependency to the cleanup part 1 series. As
this contains some voltage fixes too, it's a separate
series. You can either pull it into cleanup or keep it
separate.

Regards,

Tony


The following changes since commit ceb1c532ba6220900e61ec7073a9234661efa450:
  Tony Lindgren (1):
        Merge branch 'omap_chip_remove_cleanup_3.2' of git://git.pwsan.com/linux-2.6 into cleanup

are available in the git repository at:

  git://github.com/tmlind/linux.git voltage

Benoit Cousson (1):
      OMAP4: powerdomain data: add voltage domains

Kevin Hilman (48):
      OMAP2+: hwmod: remove unused voltagedomain pointer
      OMAP2+: voltage: move PRCM mod offets into VC/VP structures
      OMAP2+: voltage: move prm_irqst_reg from VP into voltage domain
      OMAP2+: voltage: start towards a new voltagedomain layer
      OMAP3: voltage: rename "mpu" voltagedomain to "mpu_iva"
      OMAP3: voltagedomain data: add wakeup domain
      OMAP3+: voltage: add scalable flag to voltagedomain
      OMAP2+: powerdomain: add voltagedomain to struct powerdomain
      OMAP2: add voltage domains and connect to powerdomains
      OMAP3: powerdomain data: add voltage domains
      OMAP2+: powerdomain: add voltage domain lookup during register
      OMAP2+: voltage: keep track of powerdomains in each voltagedomain
      OMAP2+: voltage: split voltage controller (VC) code into dedicated layer
      OMAP2+: voltage: move VC into struct voltagedomain, misc. renames
      OMAP2+: voltage: enable VC bypass scale method when VC is initialized
      OMAP2+: voltage: split out voltage processor (VP) code into new layer
      OMAP2+: VC: support PMICs with separate voltage and command registers
      OMAP2+: add PRM VP functions for checking/clearing VP TX done status
      OMAP3+ VP: replace transaction done check/clear with VP ops
      OMAP2+: PRM: add register access functions for VC/VP
      OMAP3+: voltage: convert to PRM register access functions
      OMAP3+: VC: cleanup i2c slave address configuration
      OMAP3+: VC: cleanup PMIC register address configuration
      OMAP3+: VC bypass: use fields from VC struct instead of PMIC info
      OMAP3+: VC: cleanup voltage setup time configuration
      OMAP3+: VC: move on/onlp/ret/off command configuration into common init
      OMAP3+: VC: abstract out channel configuration
      OMAP3+: voltage domain: move PMIC struct from vdd_info into struct voltagedomain
      OMAP3+: VC: make I2C config programmable with PMIC-specific settings
      OMAP3+: PM: VC: handle mutant channel config for OMAP4 MPU channel
      OMAP3+: VC: use last nominal voltage setting to get current_vsel
      OMAP3+: VP: cleanup: move VP instance into voltdm, misc. renames
      OMAP3+: voltage: remove unneeded debugfs interface
      OMAP3+: VP: struct omap_vp_common: replace shift with __ffs(mask)
      OMAP3+: VP: move SoC-specific sys clock rate retreival late init
      OMAP3+: VP: move timing calculation/config into VP init
      OMAP3+: VP: create VP helper function for updating error gain
      OMAP3+: VP: remove omap_vp_runtime_data
      OMAP3+: VP: move voltage scale function pointer into struct voltagedomain
      OMAP3+: VP: update_errorgain(): return error if VP
      OMAP3+: VP: remove unused omap_vp_get_curr_volt()
      OMAP3+: VP: combine setting init voltage into common function
      OMAP3+: voltage: rename scale and reset functions using voltdm_ prefix
      OMAP3+: voltage: move/rename curr_volt from vdd_info into struct voltagedomain
      OMAP3+: voltdm: final removal of omap_vdd_info
      OMAP3+: voltage: rename omap_voltage_get_nom_volt -> voltdm_get_voltage
      OMAP3+: voltage: update nominal voltage in voltdm_scale() not VC post-scale
      OMAP2+: VC: more registers are per-channel starting with OMAP5

Nishanth Menon (3):
      OMAP4: PM: TWL6030: fix uv to voltage for >0x39
      OMAP4: PM: TWL6030: address 0V conversions
      OMAP4: PM: TWL6030: add cmd register

Patrick Titiano (2):
      OMAP4: PM: TWL6030: fix voltage conversion formula
      OMAP4: PM: TWL6030: fix ON/RET/OFF voltages

Tero Kristo (1):
      omap: voltage: add a stub header file for external/regulator use

Todd Poynor (1):
      OMAP: VP: Explicitly mask VPVOLTAGE field

Tony Lindgren (1):
      Merge branch 'for_3.2/voltage-cleanup' of git://gitorious.org/khilman/linux-omap-pm into voltage

 arch/arm/mach-omap2/Makefile                     |    5 +-
 arch/arm/mach-omap2/io.c                         |    5 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c       |    4 +-
 arch/arm/mach-omap2/omap_twl.c                   |  107 ++-
 arch/arm/mach-omap2/pm.c                         |    6 +-
 arch/arm/mach-omap2/powerdomain.c                |   23 +
 arch/arm/mach-omap2/powerdomain.h                |   10 +
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c       |    2 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    2 +
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    4 +
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   16 +
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   16 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c               |   56 ++
 arch/arm/mach-omap2/prm2xxx_3xxx.h               |   12 +
 arch/arm/mach-omap2/prm44xx.c                    |   71 ++
 arch/arm/mach-omap2/prm44xx.h                    |   12 +
 arch/arm/mach-omap2/smartreflex-class3.c         |    4 +-
 arch/arm/mach-omap2/smartreflex.c                |   29 +-
 arch/arm/mach-omap2/sr_device.c                  |    2 +-
 arch/arm/mach-omap2/vc.c                         |  367 ++++++++
 arch/arm/mach-omap2/vc.h                         |   88 ++-
 arch/arm/mach-omap2/vc3xxx_data.c                |   31 +-
 arch/arm/mach-omap2/vc44xx_data.c                |   44 +-
 arch/arm/mach-omap2/voltage.c                    | 1088 ++++------------------
 arch/arm/mach-omap2/voltage.h                    |  138 ++--
 arch/arm/mach-omap2/voltagedomains2xxx_data.c    |   32 +
 arch/arm/mach-omap2/voltagedomains3xxx_data.c    |   83 +-
 arch/arm/mach-omap2/voltagedomains44xx_data.c    |   99 ++-
 arch/arm/mach-omap2/vp.c                         |  278 ++++++
 arch/arm/mach-omap2/vp.h                         |  133 ++--
 arch/arm/mach-omap2/vp3xxx_data.c                |   35 +-
 arch/arm/mach-omap2/vp44xx_data.c                |   47 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h     |    1 -
 arch/arm/plat-omap/include/plat/voltage.h        |   20 +
 34 files changed, 1599 insertions(+), 1271 deletions(-)
 create mode 100644 arch/arm/mach-omap2/vc.c
 create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
 create mode 100644 arch/arm/mach-omap2/vp.c
 create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
