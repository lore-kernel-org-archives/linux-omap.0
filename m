From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 2/2]OMAP: Disable internal I2C pull-ups in OMAP3630
Date: Tue, 8 Jun 2010 13:04:39 +0300
Message-ID: <20100608100437.GP15515@atomide.com>
References: <1267211687-23551-1-git-send-email-m-sonasath@ti.com>
 <CD8CC2B65FEE304DA95744A5472698F202D3F744A2@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55983 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab0FHKEj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 06:04:39 -0400
Content-Disposition: inline
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F202D3F744A2@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sonasath, Moiz" <m-sonasath@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pais, Allen" <allen.pais@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>

Hi,

* Sonasath, Moiz <m-sonasath@ti.com> [100323 00:40]:
> Tony,
> 
> > -----Original Message-----
> > From: Sonasath, Moiz
> > Sent: Friday, February 26, 2010 1:15 PM
> > To: linux-omap@vger.kernel.org
> > Cc: tony@atomide.com; Sonasath, Moiz; Pais, Allen; Pandita, Vikram
> > Subject: [PATCH V3 2/2]OMAP: Disable internal I2C pull-ups in OMAP3630
> > 
> > From: Moiz Sonasath <m-sonasath@ti.com>
> > 
> > This patch disables the newly introduced internal pull-up feature in
> > OMAP3630, to use only the external HW resitor >= 470 Ohm for the
> > assured functionality in HS mode.
> > 
> > While testing the I2C in High Speed mode, it was discovered that
> > without a proper pull-up resitor, there is data corruption during
> > multi-byte transfers. RTC(time_set) test case was used for testing.
> > 
> > From the analysis done, it was concluded that ideally we need a pull-up
> > of 1.6 K Ohm (recomended) or atleast 470 Ohm or greater for assured
> > performance in HS mode.
> > 
> > Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
> > Signed-off-by: Allen Pais <allen.pais@ti.com>
> > Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> 
> I did resend this patch as per our last conversation, Can you please take this patch in?

Sorry for the delay, here's some more info on this issue. So it looks
like starting with 3630 there are dedicated pull-up for all the I2C buses.
And the pull values are configurable with software.

Because of this, 3630 boards should have the mux register pull-ups disabled,
and only use the dedicated I2C pull-ups. In theory external pull-ups should
not be needed. The value configured for the dedicated I2C pull-ups depends
on the connected I2C device, and the number of devices.

So it looks like we should do the following changes:

- Disable mux register pull-ups on 3630 and later

- Allow setting the dedicated I2C pull-up values from board-*.c files
  for 3630 and later

- Warn if the dedicated pull-up values are not configured on 3630 and
  later

- Allow disabling the dedicated I2C pull-up values on 3630 and later
  in case external pull-up resistors are being used.

Comments?

Regards,

Tony

 
> > ---
> >  arch/arm/mach-omap2/i2c.c                 |   24 ++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/control.h |   14 ++++++++++++++
> >  2 files changed, 38 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
> > index 789ca8c..2e6eb28 100644
> > --- a/arch/arm/mach-omap2/i2c.c
> > +++ b/arch/arm/mach-omap2/i2c.c
> > @@ -22,6 +22,7 @@
> >  #include <plat/cpu.h>
> >  #include <plat/i2c.h>
> >  #include <plat/mux.h>
> > +#include <plat/control.h>
> > 
> >  #include "mux.h"
> > 
> > @@ -52,5 +53,28 @@ int __init omap_register_i2c_bus(int bus_id, u32
> > clkrate,
> >  		omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
> >  	}
> > 
> > +	/* Disable OMAP 3630 internal pull-ups for all I2Ci */
> > +	if (cpu_is_omap3630() &&
> > !(omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1) &
> > OMAP3630_PRG_I2C1_PULLUPRESX)) {
> > +
> > +		u32 prog_io;
> > +
> > +		prog_io = omap_ctrl_readl(OMAP343X_CONTROL_PROG_IO1);
> > +		/* Program (bit 19)=1 to disable internal pull-up on I2C1 */
> > +		prog_io |= OMAP3630_PRG_I2C1_PULLUPRESX;
> > +		/* Program (bit 0)=1 to disable internal pull-up on I2C2 */
> > +		prog_io |= OMAP3630_PRG_I2C2_PULLUPRESX;
> > +		omap_ctrl_writel(prog_io, OMAP343X_CONTROL_PROG_IO1);
> > +
> > +		prog_io = omap_ctrl_readl(OMAP36XX_CONTROL_PROG_IO2);
> > +		/* Program (bit 7)=1 to disable internal pull-up on I2C3 */
> > +		prog_io |= OMAP3630_PRG_I2C3_PULLUPRESX;
> > +		omap_ctrl_writel(prog_io, OMAP36XX_CONTROL_PROG_IO2);
> > +
> > +		prog_io = omap_ctrl_readl(OMAP36XX_CONTROL_PROG_IO_WKUP1);
> > +		/* Program (bit 5)=1 to disable internall pull-up on I2C4(SR)
> > */
> > +		prog_io |= OMAP3630_PRG_SR_PULLUPRESX;
> > +		omap_ctrl_writel(prog_io, OMAP36XX_CONTROL_PROG_IO_WKUP1);
> > +	}
> > +
> >  	return omap_plat_register_i2c_bus(bus_id, clkrate, info, len);
> >  }
> > diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-
> > omap/include/plat/control.h
> > index 2074473..9e58d8e 100644
> > --- a/arch/arm/plat-omap/include/plat/control.h
> > +++ b/arch/arm/plat-omap/include/plat/control.h
> > @@ -169,6 +169,9 @@
> >  #define AM35XX_CONTROL_IP_SW_RESET      (OMAP2_CONTROL_GENERAL + 0x0328)
> >  #define AM35XX_CONTROL_IPSS_CLK_CTRL    (OMAP2_CONTROL_GENERAL + 0x032C)
> > 
> > +/* 36xx-only CONTROL_GENERAL register offsets */
> > +#define OMAP36XX_CONTROL_PROG_IO2       (OMAP2_CONTROL_GENERAL + 0x0198)
> > +
> >  /* 34xx PADCONF register offsets */
> >  #define OMAP343X_PADCONF_ETK(i)		(OMAP2_CONTROL_PADCONFS + 0x5a8
> > + \
> >  						(i)*2)
> > @@ -200,6 +203,9 @@
> >  #define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP +
> > 0x014)
> >  #define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP +
> > 0x018)
> > 
> > +/* 36xx-only GENERAL_WKUP register offsets */
> > +#define OMAP36XX_CONTROL_PROG_IO_WKUP1 (OMAP343X_CONTROL_GENERAL_WKUP +
> > 0x020)
> > +
> >  /* 34xx D2D idle-related pins, handled by PM core */
> >  #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
> >  #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
> > @@ -250,6 +256,8 @@
> >  #define OMAP2_PBIASLITEVMODE0		(1 << 0)
> > 
> >  /* CONTROL_PROG_IO1 bits */
> > +#define OMAP3630_PRG_I2C2_PULLUPRESX    (1 << 0)
> > +#define OMAP3630_PRG_I2C1_PULLUPRESX	(1 << 19)
> >  #define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)
> > 
> >  /* CONTROL_IVA2_BOOTMOD bits */
> > @@ -257,6 +265,12 @@
> >  #define OMAP3_IVA2_BOOTMOD_MASK		(0xf << 0)
> >  #define OMAP3_IVA2_BOOTMOD_IDLE		(0x1 << 0)
> > 
> > +/* CONTROL_PROG_IO2 bits on omap3630 */
> > +#define OMAP3630_PRG_I2C3_PULLUPRESX    (1 << 7)
> > +
> > +/* CONTROL_PROG_IO_WKUP1 bits on omap3630 */
> > +#define OMAP3630_PRG_SR_PULLUPRESX    (1 << 5)
> > +
> >  /* CONTROL_PADCONF_X bits */
> >  #define OMAP3_PADCONF_WAKEUPEVENT0	(1 << 15)
> >  #define OMAP3_PADCONF_WAKEUPENABLE0	(1 << 14)
> > --
> > 1.5.6.3
> 
