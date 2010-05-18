From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] omap4: Add i2c board support on omap4430 sdp
 platform
Date: Mon, 17 May 2010 19:59:17 -0700
Message-ID: <20100518025917.GI5818@atomide.com>
References: <1273652851-14147-1-git-send-email-santosh.shilimkar@ti.com>
 <1273652851-14147-2-git-send-email-santosh.shilimkar@ti.com>
 <20100518025257.GG5818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49294 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab0ERC7U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 May 2010 22:59:20 -0400
Content-Disposition: inline
In-Reply-To: <20100518025257.GG5818@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

* Tony Lindgren <tony@atomide.com> [100517 19:47]:
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [100512 01:22]:
> > This patch adds the i2c board support for OMAP4430 SDP platform. The
> > necessary drivers support patch is posted earlier.
> > 
> > https://patchwork.kernel.org/patch/80659/
> >
> > --- a/arch/arm/plat-omap/i2c.c
> > +++ b/arch/arm/plat-omap/i2c.c
> > @@ -35,6 +35,7 @@
> >  #define OMAP2_I2C_BASE1		0x48070000
> >  #define OMAP2_I2C_BASE2		0x48072000
> >  #define OMAP2_I2C_BASE3		0x48060000
> > +#define OMAP2_I2C_BASE4		0x48350000
> >  
> >  static const char name[] = "i2c_omap";
> >  
> > @@ -54,9 +55,16 @@ static struct resource i2c_resources[][2] = {
> >  #if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> >  	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
> >  #endif
> > +#if	defined(CONFIG_ARCH_OMAP4)
> > +	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, OMAP44XX_IRQ_I2C2) },
> > +#endif
> >  #if	defined(CONFIG_ARCH_OMAP3)
> >  	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
> >  #endif
> > +#if	defined(CONFIG_ARCH_OMAP4)
> > +	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, OMAP44XX_IRQ_I2C3) },
> > +	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE4, OMAP44XX_IRQ_I2C4) },
> > +#endif
> >  };
> >  
> >  #define I2C_DEV_BUILDER(bus_id, res, data)		\
> 
> The above breaks omap3_defconfig. You'll end up with all of the above
> in the array, and as the code is using the array index as the key,
> you end up with wrong resources.
> 
> I've posted a fix for that in the MMC series and updated your
> patch accordingly.

In general, I won't be fixing or merging patches that break
omap3_defconfig BTW. So please everybody, make sure you test 
with omap3_defconfig.

Regards,

Tony
