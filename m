From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 20/24] twl6030: add base addr for ID0, ID1, ID2
Date: Fri, 19 Feb 2010 14:33:41 -0800
Message-ID: <20100219223340.GF21755@atomide.com>
References: <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-17-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-18-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-19-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-20-git-send-email-santosh.shilimkar@ti.com>
 <20100219114142.GD10255@sortiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58587 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664Ab0BSWcw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Feb 2010 17:32:52 -0500
Content-Disposition: inline
In-Reply-To: <20100219114142.GD10255@sortiz.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, ben@fluff.org.uk, lrg@slimlogic.co.uk, paul@pwsan.com, Balaji T K <balajitk@ti.com>

* Samuel Ortiz <sameo@linux.intel.com> [100219 03:37]:
> On Tue, Feb 16, 2010 at 09:28:11PM +0530, Santosh Shilimkar wrote:
> > From: Balaji T K <balajitk@ti.com>
> > 
> > Add base address for generic slave ID0, ID1, ID2
> > and introduced one more entry to align RTC module number between
> > twl4030 and twl6030
> Tony, I'm taking this patch. Please let me know if you prefer it to go through
> your tree.

OK thanks. I prefer that it goes in via your tree.

Regards,

Tony
 
> Cheers,
> Samuel.
> 
>  
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Balaji T K <balajitk@ti.com>
> > ---
> >  drivers/mfd/twl-core.c  |    7 +++++--
> >  include/linux/i2c/twl.h |    5 +++++
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index 2a76065..d820e87 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -204,6 +204,7 @@
> >  /* subchip/slave 3 0x4B - AUDIO */
> >  #define TWL6030_BASEADD_AUDIO		0x0000
> >  #define TWL6030_BASEADD_RSV		0x0000
> > +#define TWL6030_BASEADD_ZERO		0x0000
> >  
> >  /* Few power values */
> >  #define R_CFG_BOOT			0x05
> > @@ -319,9 +320,11 @@ static struct twl_mapping twl6030_map[] = {
> >  	{ SUB_CHIP_ID1, TWL6030_BASEADD_CHARGER },
> >  	{ SUB_CHIP_ID1, TWL6030_BASEADD_GASGAUGE },
> >  	{ SUB_CHIP_ID1, TWL6030_BASEADD_PWM },
> > -	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> > -	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> > +	{ SUB_CHIP_ID0, TWL6030_BASEADD_ZERO },
> > +	{ SUB_CHIP_ID1, TWL6030_BASEADD_ZERO },
> >  
> > +	{ SUB_CHIP_ID2, TWL6030_BASEADD_ZERO },
> > +	{ SUB_CHIP_ID2, TWL6030_BASEADD_ZERO },
> >  	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> >  	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> >  	{ SUB_CHIP_ID2, TWL6030_BASEADD_RSV },
> > diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> > index bf1c5be..fcf9286 100644
> > --- a/include/linux/i2c/twl.h
> > +++ b/include/linux/i2c/twl.h
> > @@ -80,6 +80,11 @@
> >  #define TWL_MODULE_PM_MASTER	TWL4030_MODULE_PM_MASTER
> >  #define TWL_MODULE_PM_RECEIVER	TWL4030_MODULE_PM_RECEIVER
> >  #define TWL_MODULE_RTC		TWL4030_MODULE_RTC
> > +#define TWL_MODULE_PWM		TWL4030_MODULE_PWM0
> > +
> > +#define TWL6030_MODULE_ID0	0x0D
> > +#define TWL6030_MODULE_ID1	0x0E
> > +#define TWL6030_MODULE_ID2	0x0F
> >  
> >  #define GPIO_INTR_OFFSET	0
> >  #define KEYPAD_INTR_OFFSET	1
> > -- 
> > 1.6.0.4
> > 
> 
> -- 
> Intel Open Source Technology Centre
> http://oss.intel.com/
