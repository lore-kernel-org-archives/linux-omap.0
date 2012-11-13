From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 4/6] omap pm updates for v3.8 merge window
Date: Tue, 13 Nov 2012 11:11:32 -0800
Message-ID: <20121113191132.GG6801@atomide.com>
References: <pull-1352828737-887235>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:20047 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754296Ab2KMTLg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 14:11:36 -0500
Content-Disposition: inline
In-Reply-To: <pull-1352828737-887235>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/pm-signed

for you to fetch changes up to 46bf4a562207c5ebd24e1dde5e5ee326cd3d6b91:

  Merge tag 'for_3.8-pm-voltage' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-v3.8/pm (2012-11-06 17:06:37 -0800)

----------------------------------------------------------------

PM updates for omaps via Kevin Hilman <khilman@deeprootsystems.com>:

- Minor pr_warn() cleanup for OMAP2+ Voltage Processor (VP)

- OMAP: SmartReflex: pass device-independent data via platform_data

- OMAP voltage layer updates towards supporting auto-retention/auto-off

----------------------------------------------------------------
Jean Pihet (2):
      ARM: OMAP: hwmod: align the SmartReflex fck names
      ARM: OMAP: SmartReflex: pass device dependent data via platform data

Nishanth Menon (2):
      ARM: OMAP2+: PM: VP: minor pr_warn updates
      ARM: OMAP3+: PM: VP: use uV for max and min voltage limits

Tero Kristo (13):
      ARM: OMAP: voltage: renamed vp_vddmin and vp_vddmax fields
      ARM: OMAP3+: voltage: introduce omap vc / vp params for voltagedomains
      ARM: OMAP3: VC: calculate ramp times
      ARM: OMAP4: voltage: add support for VOLTSETUP_x_OFF register
      ARM: OMAP4: VC: calculate ramp times
      ARM: OMAP: add support for oscillator setup
      ARM: OMAP3+: vp: use new vp_params for calculating vddmin and vddmax
      ARM: OMAP3+: voltage: use oscillator data to calculate setup times
      ARM: OMAP: TWL: change the vddmin / vddmax voltages to spec
      ARM: OMAP3+: voltage: remove unused volt_setup_time parameter
      ARM: OMAP4: vc: fix channel configuration
      ARM: OMAP4: VC: setup I2C parameters based on board data
      ARM: OMAP4: TWL: enable high speed mode for PMIC communication

Tony Lindgren (3):
      Merge tag 'for_3.8-cleanup-pm' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.8/pm
      Merge tag 'for_3.8-pm-sr' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.8/pm
      Merge tag 'for_3.8-pm-voltage' of git://git.kernel.org/.../khilman/linux-omap-pm into omap-for-v3.8/pm

Vishwanath Sripathy (1):
      ARM: OMAP4: OPP: add OMAP4460 definitions

 arch/arm/mach-omap2/clock33xx_data.c          |  12 +-
 arch/arm/mach-omap2/clock3xxx_data.c          |  12 +-
 arch/arm/mach-omap2/clock44xx_data.c          |   6 +-
 arch/arm/mach-omap2/control.h                 |   1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   8 +-
 arch/arm/mach-omap2/omap_opp_data.h           |   9 +-
 arch/arm/mach-omap2/omap_twl.c                |  73 +----
 arch/arm/mach-omap2/opp4xxx_data.c            |  98 +++++-
 arch/arm/mach-omap2/pm.c                      |  30 ++
 arch/arm/mach-omap2/pm.h                      |  10 +
 arch/arm/mach-omap2/sr_device.c               |  13 +
 arch/arm/mach-omap2/vc.c                      | 451 ++++++++++++++++++++++++--
 arch/arm/mach-omap2/vc.h                      |   8 +-
 arch/arm/mach-omap2/vc3xxx_data.c             |  22 ++
 arch/arm/mach-omap2/vc44xx_data.c             |  28 ++
 arch/arm/mach-omap2/voltage.h                 |  44 ++-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |   5 +
 arch/arm/mach-omap2/voltagedomains44xx_data.c |  23 +-
 arch/arm/mach-omap2/vp.c                      |  19 +-
 arch/arm/mach-omap2/vp.h                      |   7 +
 arch/arm/mach-omap2/vp3xxx_data.c             |  10 +
 arch/arm/mach-omap2/vp44xx_data.c             |  15 +
 drivers/power/avs/smartreflex.c               |  54 +--
 include/linux/power/smartreflex.h             |  14 +-
 24 files changed, 792 insertions(+), 180 deletions(-)
