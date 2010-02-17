From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 16/24] omap4: Add i2c support on omap4 platform
Date: Wed, 17 Feb 2010 10:34:20 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF8273@dbde02.ent.ti.com>
References: <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-16-git-send-email-santosh.shilimkar@ti.com>
 <20100216185050.GN21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53716 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab0BQFEq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 00:04:46 -0500
In-Reply-To: <20100216185050.GN21755@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ben@fluff.org.uk" <ben@fluff.org.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "paul@pwsan.com" <paul@pwsan.com>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>, Ben Dooks <ben-linux@fluff.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, February 17, 2010 12:21 AM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; ben@fluff.org.uk; sameo@linux.intel.com; lrg@slimlogic.co.uk;
> paul@pwsan.com; Syed, Rafiuddin; Ben Dooks
> Subject: Re: [PATCH 16/24] omap4: Add i2c support on omap4 platform
> 
> * Santosh Shilimkar <santosh.shilimkar@ti.com> [100216 07:55]:
> > This patch is rebased version of earlier post to add I2C
> > driver support to OMAP4 platform. On OMAP4, all
> > I2C register address offsets are changed from OMAP1/2/3 I2C.
> > In order to not have #ifdef's at various places in code,
> > as well as to support multi-OMAP build, an array is created
> > to hold the register addresses with it's offset.
> >
> > This patch was submitted, reviewed and acked on mailing list
> > already. For more details refer below link
> > http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg02281.html
> >
> > This version updated on top of 16 bit support added as part of
> > the commit "8bb209278e555a626f9637e844fe4c1b90e849f6"
> >
> > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> > CC: Tony Lindgren <tony@atomide.com>
> > CC: Ben Dooks <ben-linux@fluff.org>
> > ---
> >  arch/arm/plat-omap/i2c.c      |   17 ++++-
> >  drivers/i2c/busses/i2c-omap.c |  148 ++++++++++++++++++++++++++++++++---------
> >  2 files changed, 131 insertions(+), 34 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> > index 96d2781..f18d757 100644
> > --- a/arch/arm/plat-omap/i2c.c
> > +++ b/arch/arm/plat-omap/i2c.c
> > @@ -53,9 +53,15 @@ static struct resource i2c_resources[][2] = {
> >  #if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> >  	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_24XX_I2C2_IRQ) },
> >  #endif
> > +#if	defined(CONFIG_ARCH_OMAP4)
> > +	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE2, INT_44XX_I2C2_IRQ) },
> > +#endif
> >  #if	defined(CONFIG_ARCH_OMAP3)
> >  	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_34XX_I2C3_IRQ) },
> >  #endif
> > +#if	defined(CONFIG_ARCH_OMAP4)
> > +	{ I2C_RESOURCE_BUILDER(OMAP2_I2C_BASE3, INT_44XX_I2C3_IRQ) },
> > +#endif
> >  };
> 
> This is OK, but..
> 
> >  #define I2C_DEV_BUILDER(bus_id, res, data)		\
> > @@ -72,10 +78,11 @@ static struct resource i2c_resources[][2] = {
> >  static u32 i2c_rate[ARRAY_SIZE(i2c_resources)];
> >  static struct platform_device omap_i2c_devices[] = {
> >  	I2C_DEV_BUILDER(1, i2c_resources[0], &i2c_rate[0]),
> > -#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> > +#if	defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> > +	defined(CONFIG_ARCH_OMAP4)
> >  	I2C_DEV_BUILDER(2, i2c_resources[1], &i2c_rate[1]),
> >  #endif
> > -#if	defined(CONFIG_ARCH_OMAP3)
> > +#if	defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> >  	I2C_DEV_BUILDER(3, i2c_resources[2], &i2c_rate[2]),
> >  #endif
> >  };
> 
> .. the ifdefs above can be simplified to ifdef CONFIG_ARCH_OMAP2PLUS.
> That is, with the patches already queued into omap for-next.
YEP
> 
> > @@ -370,7 +434,11 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> >  			internal_clk = 9600;
> >  		else
> >  			internal_clk = 4000;
> > -		fclk_rate = clk_get_rate(dev->fclk) / 1000;
> > +		/* FIXME: Remove this once clock framework is available*/
> > +		if (dev->rev >= OMAP_I2C_REV_ON_4430)
> > +			fclk_rate = 96000;
> > +		else
> > +			fclk_rate = clk_get_rate(dev->fclk) / 1000;
> >
> >  		/* Compute prescaler divisor */
> >  		psc = fclk_rate / internal_clk;
> 
> Sounds like this part should no longer be needed?
> 
Yes. I missed this
> >  					*dev->buf++ = w;
> >  					dev->buf_len--;
> > -					/* Data reg from 2430 is 8 bit wide */
> > +					/* Data reg in 2430, omap3 and
> > +					 * omap4 is 8 bit wide
> > +					 */
> >  					if (!cpu_is_omap2430() &&
> > -							!cpu_is_omap34xx()) {
> > +							!cpu_is_omap34xx() &&
> > +							!cpu_is_omap44xx()) {
> >  						if (dev->buf_len) {
> >  							*dev->buf++ = w >> 8;
> >  							dev->buf_len--;
> 
> How about change this to if (cpu_class_is_omap1() || cpu_is_omap2420())?
> That way it does not need to be patched for new omaps.
> 
> > @@ -786,9 +857,12 @@ complete:
> >  				if (dev->buf_len) {
> >  					w = *dev->buf++;
> >  					dev->buf_len--;
> > -					/* Data reg from  2430 is 8 bit wide */
> > +					/* Data reg in 2430, omap3 and
> > +					 * omap4 is 8 bit wide
> > +					 */
> >  					if (!cpu_is_omap2430() &&
> > -							!cpu_is_omap34xx()) {
> > +							!cpu_is_omap34xx() &&
> > +							!cpu_is_omap44xx()) {
> >  						if (dev->buf_len) {
> >  							w |= *dev->buf++ << 8;
> >  							dev->buf_len--;
> 
> Here too.
> 
> >  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> >
> > -	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> > +	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
> >  		u16 s;
> >
> >  		/* Set up the fifo size - Get total size */
> 
> And here too.
> 
> Regards,
> 
> Tony
