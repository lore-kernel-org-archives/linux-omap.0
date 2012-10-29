From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: AM33xx: add support for reboot
Date: Mon, 29 Oct 2012 09:56:06 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB50652@DBDE01.ent.ti.com>
References: <1351448275-23509-1-git-send-email-zonque@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EB50073@DBDE01.ent.ti.com>
 <508E5121.9020304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55304 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758019Ab2J2J4V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Oct 2012 05:56:21 -0400
In-Reply-To: <508E5121.9020304@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "Nori, Sekhar" <nsekhar@ti.com>, "Mohammed, Afzal" <afzal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 29, 2012 at 15:19:21, Daniel Mack wrote:
> On 29.10.2012 05:31, Hiremath, Vaibhav wrote:
> > On Sun, Oct 28, 2012 at 23:47:55, Daniel Mack wrote:
> >> This patch adds the ability to reboot am33xx-based systems.
> >>
> >> Signed-off-by: Daniel Mack <zonque@gmail.com>
> >> ---
> >>  arch/arm/mach-omap2/board-generic.c | 1 +
> >>  arch/arm/mach-omap2/prcm.c          | 6 ++++++
> >>  2 files changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> >> index 601ecdf..6a69ceb 100644
> >> --- a/arch/arm/mach-omap2/board-generic.c
> >> +++ b/arch/arm/mach-omap2/board-generic.c
> >> @@ -114,6 +114,7 @@ DT_MACHINE_START(AM33XX_DT, "Generic AM33XX (Flattened Device Tree)")
> >>  	.init_machine	= omap_generic_init,
> >>  	.timer		= &omap3_am33xx_timer,
> >>  	.dt_compat	= am33xx_boards_compat,
> >> +	.restart	= omap_prcm_restart,
> >>  MACHINE_END
> >>  #endif
> >>  
> >> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> >> index 0f51e03..8a3068a 100644
> >> --- a/arch/arm/mach-omap2/prcm.c
> >> +++ b/arch/arm/mach-omap2/prcm.c
> >> @@ -32,6 +32,7 @@
> >>  #include "clock2xxx.h"
> >>  #include "cm2xxx_3xxx.h"
> >>  #include "prm2xxx_3xxx.h"
> >> +#include "prm33xx.h"
> >>  #include "prm44xx.h"
> >>  #include "prminst44xx.h"
> >>  #include "cminst44xx.h"
> >> @@ -72,6 +73,11 @@ void omap_prcm_restart(char mode, const char *cmd)
> >>  		omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
> >>  	} else if (cpu_is_omap44xx()) {
> >>  		omap4_prminst_global_warm_sw_reset(); /* never returns */
> >> +	} else if (soc_is_am33xx()) {
> >> +		prcm_offs = AM33XX_PRM_DEVICE_MOD;
> >> +		omap2_prm_set_mod_reg_bits(OMAP4430_RST_GLOBAL_COLD_SW_MASK,
> >> +					   prcm_offs,
> >> +					   AM33XX_PRM_RSTCTRL_OFFSET);
> > 
> > This is not clean way of handling it, we should have something similar to 
> > omap4. Also we should use warm-reset here instead of cold.
> > 
> > I have quickly created patch, can you please review and test is?
> > I have tested it on AM335x EVM and Bone platform.
> 
> Works for me as well, thanks!
> 
> You can take my
> 
>   Tested-by: Daniel Mack <zonque@gmail.com>
> 

Thanks Daniel for confirming. I will send out this patch ASAP with your 
tested by.

Thanks,
Vaibhav


