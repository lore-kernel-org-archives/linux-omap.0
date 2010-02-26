From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] omap: i2c: Add i2c support on omap4 platform
Date: Fri, 26 Feb 2010 10:27:31 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C43BF6C3@dbde02.ent.ti.com>
References: <1266597180-25139-1-git-send-email-santosh.shilimkar@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C42E10AD@dbde02.ent.ti.com>
 <20100225214703.GJ28173@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37101 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935264Ab0BZE5s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 23:57:48 -0500
In-Reply-To: <20100225214703.GJ28173@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>, Cory Maccarrone <darkstar6262@gmail.com>

Tony,
> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, February 26, 2010 3:17 AM
> To: Shilimkar, Santosh
> Cc: ben-linux@fluff.org; linux-omap@vger.kernel.org; linux-i2c@vger.kernel.org; Syed, Rafiuddin; Cory
> Maccarrone
> Subject: Re: [PATCH] omap: i2c: Add i2c support on omap4 platform
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100222 21:58]:
> > Ben,
> > Did you happen to look at this ?
> 
> Santosh, can you please also please clarify which omaps this
> patch has been tested on?
> 
This patch is tested on OMAP3430 SDP and OMAP4430 SDP with regular defconfig
builds and multi-omap build.
> 
> > > -----Original Message-----
> > > From: Shilimkar, Santosh
> > > Sent: Friday, February 19, 2010 10:03 PM
> > > To: ben-linux@fluff.org
> > > Cc: linux-omap@vger.kernel.org; linux-i2c@vger.kernel.org; Shilimkar, Santosh; Syed, Rafiuddin;
> Cory
> > > Maccarrone
> > > Subject: [PATCH] omap: i2c: Add i2c support on omap4 platform
> > >
> > > This patch is rebased version of earlier post to add I2C
> > > driver support to OMAP4 platform. On OMAP4, all
> > > I2C register address offsets are changed from OMAP1/2/3 I2C.
> > > In order to not have #ifdef's at various places in code,
> > > as well as to support multi-OMAP build, an array is created
> > > to hold the register addresses with it's offset.
> > >
> > > This patch was submitted, reviewed and acked on mailing list
> > > already. For more details refer below link
> > > http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg02281.html
> > >
> > > This updated verion has a depedancy on "Add support for 16-bit registers"
> > > posted on linux-omap. Below is the patch-works link for the same
> > >
> > > http://patchwork.kernel.org/patch/72295/
> > >
> > > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
> > > Reviewed-by: Paul Walmsley <paul@pwsan.com>
> > > Reviewed-by: Tony Lindgren <tony@atomide.com>
> > > Cc: Ben Dooks <ben-linux@fluff.org>
> > > Cc: Cory Maccarrone <darkstar6262@gmail.com>
> > > ---
> > >  drivers/i2c/busses/i2c-omap.c |  146 ++++++++++++++++++++++++++++++++---------
> > >  1 files changed, 114 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> > > index 9c3ce4d..7c15496 100644
> > > --- a/drivers/i2c/busses/i2c-omap.c
> > > +++ b/drivers/i2c/busses/i2c-omap.c
> > > @@ -44,29 +44,37 @@
> > >  /* I2C controller revisions present on specific hardware */
> > >  #define OMAP_I2C_REV_ON_2430		0x36
> > >  #define OMAP_I2C_REV_ON_3430		0x3C
> > > +#define OMAP_I2C_REV_ON_4430		0x40
> > >
> > >  /* timeout waiting for the controller to respond */
> > >  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> > >
> > > -#define OMAP_I2C_REV_REG		0x00
> > > -#define OMAP_I2C_IE_REG			0x01
> > > -#define OMAP_I2C_STAT_REG		0x02
> > > -#define OMAP_I2C_IV_REG			0x03
> > >  /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
> > > -#define OMAP_I2C_WE_REG			0x03
> > > -#define OMAP_I2C_SYSS_REG		0x04
> > > -#define OMAP_I2C_BUF_REG		0x05
> > > -#define OMAP_I2C_CNT_REG		0x06
> > > -#define OMAP_I2C_DATA_REG		0x07
> > > -#define OMAP_I2C_SYSC_REG		0x08
> > > -#define OMAP_I2C_CON_REG		0x09
> > > -#define OMAP_I2C_OA_REG			0x0a
> > > -#define OMAP_I2C_SA_REG			0x0b
> > > -#define OMAP_I2C_PSC_REG		0x0c
> > > -#define OMAP_I2C_SCLL_REG		0x0d
> > > -#define OMAP_I2C_SCLH_REG		0x0e
> > > -#define OMAP_I2C_SYSTEST_REG		0x0f
> > > -#define OMAP_I2C_BUFSTAT_REG		0x10
> > > +enum {
> > > +	OMAP_I2C_REV_REG = 0,
> > > +	OMAP_I2C_IE_REG,
> > > +	OMAP_I2C_STAT_REG,
> > > +	OMAP_I2C_IV_REG,
> > > +	OMAP_I2C_WE_REG,
> > > +	OMAP_I2C_SYSS_REG,
> > > +	OMAP_I2C_BUF_REG,
> > > +	OMAP_I2C_CNT_REG,
> > > +	OMAP_I2C_DATA_REG,
> > > +	OMAP_I2C_SYSC_REG,
> > > +	OMAP_I2C_CON_REG,
> > > +	OMAP_I2C_OA_REG,
> > > +	OMAP_I2C_SA_REG,
> > > +	OMAP_I2C_PSC_REG,
> > > +	OMAP_I2C_SCLL_REG,
> > > +	OMAP_I2C_SCLH_REG,
> > > +	OMAP_I2C_SYSTEST_REG,
> > > +	OMAP_I2C_BUFSTAT_REG,
> > > +	OMAP_I2C_REVNB_LO,
> > > +	OMAP_I2C_REVNB_HI,
> > > +	OMAP_I2C_IRQSTATUS_RAW,
> > > +	OMAP_I2C_IRQENABLE_SET,
> > > +	OMAP_I2C_IRQENABLE_CLR,
> > > +};
> > >
> > >  /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
> > >  #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
> > > @@ -169,6 +177,7 @@ struct omap_i2c_dev {
> > >  	u32			speed;		/* Speed of bus in Khz */
> > >  	u16			cmd_err;
> > >  	u8			*buf;
> > > +	u8			*regs;
> > >  	size_t			buf_len;
> > >  	struct i2c_adapter	adapter;
> > >  	u8			fifo_size;	/* use as flag and value
> > > @@ -187,15 +196,64 @@ struct omap_i2c_dev {
> > >  	u16			westate;
> > >  };
> > >
> > > +const static u8 reg_map[] = {
> > > +	[OMAP_I2C_REV_REG] = 0x00,
> > > +	[OMAP_I2C_IE_REG] = 0x01,
> > > +	[OMAP_I2C_STAT_REG] = 0x02,
> > > +	[OMAP_I2C_IV_REG] = 0x03,
> > > +	[OMAP_I2C_WE_REG] = 0x03,
> > > +	[OMAP_I2C_SYSS_REG] = 0x04,
> > > +	[OMAP_I2C_BUF_REG] = 0x05,
> > > +	[OMAP_I2C_CNT_REG] = 0x06,
> > > +	[OMAP_I2C_DATA_REG] = 0x07,
> > > +	[OMAP_I2C_SYSC_REG] = 0x08,
> > > +	[OMAP_I2C_CON_REG] = 0x09,
> > > +	[OMAP_I2C_OA_REG] = 0x0a,
> > > +	[OMAP_I2C_SA_REG] = 0x0b,
> > > +	[OMAP_I2C_PSC_REG] = 0x0c,
> > > +	[OMAP_I2C_SCLL_REG] = 0x0d,
> > > +	[OMAP_I2C_SCLH_REG] = 0x0e,
> > > +	[OMAP_I2C_SYSTEST_REG] = 0x0f,
> > > +	[OMAP_I2C_BUFSTAT_REG] = 0x10,
> > > +};
> > > +
> > > +const static u8 omap4_reg_map[] = {
> > > +	[OMAP_I2C_REV_REG] = 0x04,
> > > +	[OMAP_I2C_IE_REG] = 0x2c,
> > > +	[OMAP_I2C_STAT_REG] = 0x28,
> > > +	[OMAP_I2C_IV_REG] = 0x34,
> > > +	[OMAP_I2C_WE_REG] = 0x34,
> > > +	[OMAP_I2C_SYSS_REG] = 0x90,
> > > +	[OMAP_I2C_BUF_REG] = 0x94,
> > > +	[OMAP_I2C_CNT_REG] = 0x98,
> > > +	[OMAP_I2C_DATA_REG] = 0x9c,
> > > +	[OMAP_I2C_SYSC_REG] = 0x20,
> > > +	[OMAP_I2C_CON_REG] = 0xa4,
> > > +	[OMAP_I2C_OA_REG] = 0xa8,
> > > +	[OMAP_I2C_SA_REG] = 0xac,
> > > +	[OMAP_I2C_PSC_REG] = 0xb0,
> > > +	[OMAP_I2C_SCLL_REG] = 0xb4,
> > > +	[OMAP_I2C_SCLH_REG] = 0xb8,
> > > +	[OMAP_I2C_SYSTEST_REG] = 0xbC,
> > > +	[OMAP_I2C_BUFSTAT_REG] = 0xc0,
> > > +	[OMAP_I2C_REVNB_LO] = 0x00,
> > > +	[OMAP_I2C_REVNB_HI] = 0x04,
> > > +	[OMAP_I2C_IRQSTATUS_RAW] = 0x24,
> > > +	[OMAP_I2C_IRQENABLE_SET] = 0x2c,
> > > +	[OMAP_I2C_IRQENABLE_CLR] = 0x30,
> > > +};
> > > +
> > >  static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
> > >  				      int reg, u16 val)
> > >  {
> > > -	__raw_writew(val, i2c_dev->base + (reg << i2c_dev->reg_shift));
> > > +	__raw_writew(val, i2c_dev->base +
> > > +			(i2c_dev->regs[reg] << i2c_dev->reg_shift));
> > >  }
> > >
> > >  static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
> > >  {
> > > -	return __raw_readw(i2c_dev->base + (reg << i2c_dev->reg_shift));
> > > +	return __raw_readw(i2c_dev->base +
> > > +				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
> > >  }
> > >
> > >  static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> > > @@ -264,7 +322,11 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
> > >  	WARN_ON(dev->idle);
> > >
> > >  	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> > > -	omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
> > > +	if (dev->rev >= OMAP_I2C_REV_ON_4430)
> > > +		omap_i2c_write_reg(dev, OMAP_I2C_IRQENABLE_CLR, 1);
> > > +	else
> > > +		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
> > > +
> > >  	if (dev->rev < OMAP_I2C_REV_2) {
> > >  		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
> > >  	} else {
> > > @@ -329,7 +391,9 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> > >  			 * REVISIT: Some wkup sources might not be needed.
> > >  			 */
> > >  			dev->westate = OMAP_I2C_WE_ALL;
> > > -			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
> > > +			if (dev->rev < OMAP_I2C_REV_ON_4430)
> > > +				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
> > > +								dev->westate);
> > >  		}
> > >  	}
> > >  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
> > > @@ -356,7 +420,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
> > >  			psc = fclk_rate / 12000000;
> > >  	}
> > >
> > > -	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> > > +	if (!(cpu_class_is_omap1() || cpu_is_omap2420())) {
> > >
> > >  		/*
> > >  		 * HSI2C controller internal clk rate should be 19.2 Mhz for
> > > @@ -746,9 +810,12 @@ complete:
> > >  				if (dev->buf_len) {
> > >  					*dev->buf++ = w;
> > >  					dev->buf_len--;
> > > -					/* Data reg from 2430 is 8 bit wide */
> > > -					if (!cpu_is_omap2430() &&
> > > -							!cpu_is_omap34xx()) {
> > > +					/*
> > > +					 * Data reg in 2430, omap3 and
> > > +					 * omap4 is 8 bit wide
> > > +					 */
> > > +					if (cpu_class_is_omap1() ||
> > > +							cpu_is_omap2420()) {
> > >  						if (dev->buf_len) {
> > >  							*dev->buf++ = w >> 8;
> > >  							dev->buf_len--;
> > > @@ -786,9 +853,12 @@ complete:
> > >  				if (dev->buf_len) {
> > >  					w = *dev->buf++;
> > >  					dev->buf_len--;
> > > -					/* Data reg from  2430 is 8 bit wide */
> > > -					if (!cpu_is_omap2430() &&
> > > -							!cpu_is_omap34xx()) {
> > > +					/*
> > > +					 * Data reg in 2430, omap3 and
> > > +					 * omap4 is 8 bit wide
> > > +					 */
> > > +					if (cpu_class_is_omap1() ||
> > > +							cpu_is_omap2420()) {
> > >  						if (dev->buf_len) {
> > >  							w |= *dev->buf++ << 8;
> > >  							dev->buf_len--;
> > > @@ -897,6 +967,8 @@ omap_i2c_probe(struct platform_device *pdev)
> > >
> > >  	if (cpu_is_omap7xx())
> > >  		dev->reg_shift = 1;
> > > +	else if (cpu_is_omap44xx())
> > > +		dev->reg_shift = 0;
> > >  	else
> > >  		dev->reg_shift = 2;
> > >
> > > @@ -911,11 +983,16 @@ omap_i2c_probe(struct platform_device *pdev)
> > >  	if ((r = omap_i2c_get_clocks(dev)) != 0)
> > >  		goto err_iounmap;
> > >
> > > +	if (cpu_is_omap44xx())
> > > +		dev->regs = (u8 *) omap4_reg_map;
> > > +	else
> > > +		dev->regs = (u8 *) reg_map;
> > > +
> > >  	omap_i2c_unidle(dev);
> > >
> > >  	dev->rev = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> > >
> > > -	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> > > +	if (!(cpu_class_is_omap1() || cpu_is_omap2420())) {
> > >  		u16 s;
> > >
> > >  		/* Set up the fifo size - Get total size */
> > > @@ -927,8 +1004,13 @@ omap_i2c_probe(struct platform_device *pdev)
> > >  		 * size. This is to ensure that we can handle the status on int
> > >  		 * call back latencies.
> > >  		 */
> > > -		dev->fifo_size = (dev->fifo_size / 2);
> > > -		dev->b_hw = 1; /* Enable hardware fixes */
> > > +		if (dev->rev >= OMAP_I2C_REV_ON_4430) {
> > > +			dev->fifo_size = 0;
> > > +			dev->b_hw = 0; /* Disable hardware fixes */
> > > +		} else {
> > > +			dev->fifo_size = (dev->fifo_size / 2);
> > > +			dev->b_hw = 1; /* Enable hardware fixes */
> > > +		}
> > >  	}
> > >
> > >  	/* reset ASAP, clearing any IRQs */
> > > --
> > > 1.6.0.4
> >
