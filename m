From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/3] omap4: Add i2c board support on omap4430 sdp
 platform
Date: Tue, 18 May 2010 10:59:47 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C558BC62@dbde02.ent.ti.com>
References: <1273652851-14147-1-git-send-email-santosh.shilimkar@ti.com>
 <1273652851-14147-2-git-send-email-santosh.shilimkar@ti.com>
 <20100518025257.GG5818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38331 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753975Ab0ERF3y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 01:29:54 -0400
In-Reply-To: <20100518025257.GG5818@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, May 18, 2010 8:23 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; Krishnamoorthy, Balaji T
> Subject: Re: [PATCH 1/3] omap4: Add i2c board support on omap4430 sdp platform
> 
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
> 
OK

