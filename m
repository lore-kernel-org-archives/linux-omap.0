From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap twl cleanup for v3.1 merge window
Date: Fri, 8 Jul 2011 06:01:02 -0700
Message-ID: <20110708130102.GB5783@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:39233 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751564Ab1GHNBJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 09:01:09 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

Please pull TWL cleanup from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git cleanup-part-2

This can be pulled into your omap/cleanup. It will cause a minor
merge conflict with omap/board.

I've attached a conflict resolution patch too, it's trivial execpt
note that .vdac needs to be removed in board-rx51-peripherals.c.

If this conflict causes problems for you, I can also base this series
on omap/board.

Regards,

Tony


The following changes since commit 48cb1258e8b0f8c81cfb699b42326c5b2147b3f8:
  Tony Lindgren (1):
        Merge branch 'for_3.1/pm-misc' of git://git.kernel.org/.../khilman/linux-omap-pm into devel-cleanup

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git cleanup-part-2

Jarkko Nikula (2):
      omap: mcbsp: Remove rx_/tx_word_length variables
      omap: mcbsp: Remove port number enums

Peter Ujfalusi (4):
      OMAP: New twl-common for common TWL configuration
      OMAP4: Move common twl6030 configuration to twl-common
      OMAP3: Move common twl configuration to twl-common
      OMAP3: Move common regulator configuration to twl-common

Tony Lindgren (1):
      Merge branch 'peter/topic/for-tony_mach-cleanup' of git://gitorious.org/omap-audio/linux-audio into cleanup-part-2

 arch/arm/mach-omap1/mcbsp.c                  |    4 +-
 arch/arm/mach-omap2/Makefile                 |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c          |   89 +-------
 arch/arm/mach-omap2/board-4430sdp.c          |  141 +-----------
 arch/arm/mach-omap2/board-cm-t35.c           |   51 +----
 arch/arm/mach-omap2/board-devkit8000.c       |   38 +---
 arch/arm/mach-omap2/board-igep0020.c         |   44 +---
 arch/arm/mach-omap2/board-ldp.c              |   15 +-
 arch/arm/mach-omap2/board-omap3beagle.c      |   62 +-----
 arch/arm/mach-omap2/board-omap3evm.c         |   70 +------
 arch/arm/mach-omap2/board-omap3pandora.c     |   62 +-----
 arch/arm/mach-omap2/board-omap3stalker.c     |   72 +------
 arch/arm/mach-omap2/board-omap3touchbook.c   |   61 +----
 arch/arm/mach-omap2/board-omap4panda.c       |  146 +-----------
 arch/arm/mach-omap2/board-overo.c            |   61 +-----
 arch/arm/mach-omap2/board-rm680.c            |    8 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |   40 +---
 arch/arm/mach-omap2/board-zoom-peripherals.c |   89 +-------
 arch/arm/mach-omap2/common-board-devices.c   |   21 --
 arch/arm/mach-omap2/common-board-devices.h   |   26 +--
 arch/arm/mach-omap2/twl-common.c             |  304 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/twl-common.h             |   59 +++++
 arch/arm/plat-omap/include/plat/mcbsp.h      |   12 +-
 arch/arm/plat-omap/mcbsp.c                   |    3 -
 24 files changed, 492 insertions(+), 988 deletions(-)
 create mode 100644 arch/arm/mach-omap2/twl-common.c
 create mode 100644 arch/arm/mach-omap2/twl-common.h

--WIyZ46R2i8wDzkSu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="resolve.patch"

--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@@ -572,75 -395,10 +509,62 @@@ static struct regulator_init_data sdp44
  	},
  };
  
 +static struct regulator_init_data sdp4430_vana = {
 +	.constraints = {
 +		.min_uV			= 2100000,
 +		.max_uV			= 2100000,
 +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 +					| REGULATOR_MODE_STANDBY,
 +		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
 +					| REGULATOR_CHANGE_STATUS,
 +	},
 +};
 +
 +static struct regulator_init_data sdp4430_vcxio = {
 +	.constraints = {
 +		.min_uV			= 1800000,
 +		.max_uV			= 1800000,
 +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 +					| REGULATOR_MODE_STANDBY,
 +		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
 +					| REGULATOR_CHANGE_STATUS,
 +	},
 +};
 +
 +static struct regulator_init_data sdp4430_vdac = {
 +	.constraints = {
 +		.min_uV			= 1800000,
 +		.max_uV			= 1800000,
 +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 +					| REGULATOR_MODE_STANDBY,
 +		.valid_ops_mask	 = REGULATOR_CHANGE_MODE
 +					| REGULATOR_CHANGE_STATUS,
 +	},
 +};
 +
 +static struct regulator_init_data sdp4430_vusb = {
 +	.constraints = {
 +		.min_uV			= 3300000,
 +		.max_uV			= 3300000,
 +		.apply_uV		= true,
 +		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 +					| REGULATOR_MODE_STANDBY,
 +		.valid_ops_mask	 =	REGULATOR_CHANGE_MODE
 +					| REGULATOR_CHANGE_STATUS,
 +	},
 +};
 +
 +static struct regulator_init_data sdp4430_clk32kg = {
 +	.constraints = {
 +		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
 +		.always_on		= true,
 +	},
 +};
 +
  static struct twl4030_platform_data sdp4430_twldata = {
- 	.irq_base	= TWL6030_IRQ_BASE,
- 	.irq_end	= TWL6030_IRQ_END,
- 
  	/* Regulators */
- 	.vmmc		= &sdp4430_vmmc,
- 	.vpp		= &sdp4430_vpp,
  	.vusim		= &sdp4430_vusim,
- 	.vana		= &sdp4430_vana,
- 	.vcxio		= &sdp4430_vcxio,
- 	.vdac		= &sdp4430_vdac,
- 	.vusb		= &sdp4430_vusb,
  	.vaux1		= &sdp4430_vaux1,
- 	.vaux2		= &sdp4430_vaux2,
- 	.vaux3		= &sdp4430_vaux3,
- 	.clk32kg	= &sdp4430_clk32kg,
- 	.usb		= &omap4_usbphy_data
  };
  
  static struct i2c_board_info __initdata sdp4430_i2c_3_boardinfo[] = {
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@@ -916,13 -761,7 +884,12 @@@ static struct twl4030_platform_data rx5
  	.vaux2			= &rx51_vaux2,
  	.vaux4			= &rx51_vaux4,
  	.vmmc1			= &rx51_vmmc1,
 +	.vpll1			= &rx51_vpll1,
 +	.vpll2			= &rx51_vpll2,
  	.vsim			= &rx51_vsim,
- 	.vdac			= &rx51_vdac,
 +	.vintana1		= &rx51_vintana1,
 +	.vintana2		= &rx51_vintana2,
 +	.vintdig		= &rx51_vintdig,
  	.vio			= &rx51_vio,
  };
  

--WIyZ46R2i8wDzkSu--
