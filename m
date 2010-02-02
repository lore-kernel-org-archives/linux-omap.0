From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] [I2C-OMAP] Add support for 16-bit registers
Date: Mon, 1 Feb 2010 16:07:36 -0800
Message-ID: <20100202000736.GM22747@atomide.com>
References: <1260669242-29865-1-git-send-email-darkstar6262@gmail.com>
 <6cb013311001090947m2268833cv3784f469dc8b861d@mail.gmail.com>
 <20100109183321.GH2879@atomide.com>
 <6cb013311001091035x54321b3aqb814f476200980af@mail.gmail.com>
 <20100112012814.GK5055@atomide.com>
 <6cb013311001111750m17430092p8d9bd1102152db8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6cb013311001111750m17430092p8d9bd1102152db8b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [100111 17:49]:
> On Mon, Jan 11, 2010 at 5:28 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >
> > Applied to omap-testing with the following fix. Can you please merge
> > it into your original patch?
> >
> 
> Done, I've attached the new patch to here.  I've tested it and it
> works perfectly.

Here's my ack for this patch:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> 
> - Cory
> 
> 
> From 7c693afce8ffa3978b4fcecc56cd7d4a9d9d3b75 Mon Sep 17 00:00:00 2001
> From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date: Sat, 5 Dec 2009 22:00:25 -0800
> Subject: [PATCH] [I2C-OMAP] Add support for 16-bit registers
> 
> The current i2c-omap driver is set up for 32-bit registers, which
> corresponds to most OMAP devices.  However, OMAP730/850 based
> devices use a 16-bit register size.
> 
> This change modifies the driver to perform a runtime CPU type check
> to determine the register sizes, and uses a bit shift of either 1
> or 2 bits to compute the proper register sizes for all registers.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   45 +++++++++++++++++++++++-----------------
>  1 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0037e31..9c3ce4d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -49,24 +49,24 @@
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
> 
>  #define OMAP_I2C_REV_REG		0x00
> -#define OMAP_I2C_IE_REG			0x04
> -#define OMAP_I2C_STAT_REG		0x08
> -#define OMAP_I2C_IV_REG			0x0c
> +#define OMAP_I2C_IE_REG			0x01
> +#define OMAP_I2C_STAT_REG		0x02
> +#define OMAP_I2C_IV_REG			0x03
>  /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
> -#define OMAP_I2C_WE_REG			0x0c
> -#define OMAP_I2C_SYSS_REG		0x10
> -#define OMAP_I2C_BUF_REG		0x14
> -#define OMAP_I2C_CNT_REG		0x18
> -#define OMAP_I2C_DATA_REG		0x1c
> -#define OMAP_I2C_SYSC_REG		0x20
> -#define OMAP_I2C_CON_REG		0x24
> -#define OMAP_I2C_OA_REG			0x28
> -#define OMAP_I2C_SA_REG			0x2c
> -#define OMAP_I2C_PSC_REG		0x30
> -#define OMAP_I2C_SCLL_REG		0x34
> -#define OMAP_I2C_SCLH_REG		0x38
> -#define OMAP_I2C_SYSTEST_REG		0x3c
> -#define OMAP_I2C_BUFSTAT_REG		0x40
> +#define OMAP_I2C_WE_REG			0x03
> +#define OMAP_I2C_SYSS_REG		0x04
> +#define OMAP_I2C_BUF_REG		0x05
> +#define OMAP_I2C_CNT_REG		0x06
> +#define OMAP_I2C_DATA_REG		0x07
> +#define OMAP_I2C_SYSC_REG		0x08
> +#define OMAP_I2C_CON_REG		0x09
> +#define OMAP_I2C_OA_REG			0x0a
> +#define OMAP_I2C_SA_REG			0x0b
> +#define OMAP_I2C_PSC_REG		0x0c
> +#define OMAP_I2C_SCLL_REG		0x0d
> +#define OMAP_I2C_SCLH_REG		0x0e
> +#define OMAP_I2C_SYSTEST_REG		0x0f
> +#define OMAP_I2C_BUFSTAT_REG		0x10
> 
>  /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
>  #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
> @@ -161,6 +161,7 @@ struct omap_i2c_dev {
>  	struct device		*dev;
>  	void __iomem		*base;		/* virtual */
>  	int			irq;
> +	int			reg_shift;      /* bit shift for I2C register addresses */
>  	struct clk		*iclk;		/* Interface clock */
>  	struct clk		*fclk;		/* Functional clock */
>  	struct completion	cmd_complete;
> @@ -189,12 +190,12 @@ struct omap_i2c_dev {
>  static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
>  				      int reg, u16 val)
>  {
> -	__raw_writew(val, i2c_dev->base + reg);
> +	__raw_writew(val, i2c_dev->base + (reg << i2c_dev->reg_shift));
>  }
> 
>  static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
>  {
> -	return __raw_readw(i2c_dev->base + reg);
> +	return __raw_readw(i2c_dev->base + (reg << i2c_dev->reg_shift));
>  }
> 
>  static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> @@ -893,6 +894,12 @@ omap_i2c_probe(struct platform_device *pdev)
>  	dev->idle = 1;
>  	dev->dev = &pdev->dev;
>  	dev->irq = irq->start;
> +
> +	if (cpu_is_omap7xx())
> +		dev->reg_shift = 1;
> +	else
> +		dev->reg_shift = 2;
> +
>  	dev->base = ioremap(mem->start, resource_size(mem));
>  	if (!dev->base) {
>  		r = -ENOMEM;
> -- 
> 1.6.3.3

> From 7c693afce8ffa3978b4fcecc56cd7d4a9d9d3b75 Mon Sep 17 00:00:00 2001
> From: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Date: Sat, 5 Dec 2009 22:00:25 -0800
> Subject: [PATCH] [I2C-OMAP] Add support for 16-bit registers
> 
> The current i2c-omap driver is set up for 32-bit registers, which
> corresponds to most OMAP devices.  However, OMAP730/850 based
> devices use a 16-bit register size.
> 
> This change modifies the driver to perform a runtime CPU type check
> to determine the register sizes, and uses a bit shift of either 1
> or 2 bits to compute the proper register sizes for all registers.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   45 +++++++++++++++++++++++-----------------
>  1 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0037e31..9c3ce4d 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -49,24 +49,24 @@
>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
>  
>  #define OMAP_I2C_REV_REG		0x00
> -#define OMAP_I2C_IE_REG			0x04
> -#define OMAP_I2C_STAT_REG		0x08
> -#define OMAP_I2C_IV_REG			0x0c
> +#define OMAP_I2C_IE_REG			0x01
> +#define OMAP_I2C_STAT_REG		0x02
> +#define OMAP_I2C_IV_REG			0x03
>  /* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
> -#define OMAP_I2C_WE_REG			0x0c
> -#define OMAP_I2C_SYSS_REG		0x10
> -#define OMAP_I2C_BUF_REG		0x14
> -#define OMAP_I2C_CNT_REG		0x18
> -#define OMAP_I2C_DATA_REG		0x1c
> -#define OMAP_I2C_SYSC_REG		0x20
> -#define OMAP_I2C_CON_REG		0x24
> -#define OMAP_I2C_OA_REG			0x28
> -#define OMAP_I2C_SA_REG			0x2c
> -#define OMAP_I2C_PSC_REG		0x30
> -#define OMAP_I2C_SCLL_REG		0x34
> -#define OMAP_I2C_SCLH_REG		0x38
> -#define OMAP_I2C_SYSTEST_REG		0x3c
> -#define OMAP_I2C_BUFSTAT_REG		0x40
> +#define OMAP_I2C_WE_REG			0x03
> +#define OMAP_I2C_SYSS_REG		0x04
> +#define OMAP_I2C_BUF_REG		0x05
> +#define OMAP_I2C_CNT_REG		0x06
> +#define OMAP_I2C_DATA_REG		0x07
> +#define OMAP_I2C_SYSC_REG		0x08
> +#define OMAP_I2C_CON_REG		0x09
> +#define OMAP_I2C_OA_REG			0x0a
> +#define OMAP_I2C_SA_REG			0x0b
> +#define OMAP_I2C_PSC_REG		0x0c
> +#define OMAP_I2C_SCLL_REG		0x0d
> +#define OMAP_I2C_SCLH_REG		0x0e
> +#define OMAP_I2C_SYSTEST_REG		0x0f
> +#define OMAP_I2C_BUFSTAT_REG		0x10
>  
>  /* I2C Interrupt Enable Register (OMAP_I2C_IE): */
>  #define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
> @@ -161,6 +161,7 @@ struct omap_i2c_dev {
>  	struct device		*dev;
>  	void __iomem		*base;		/* virtual */
>  	int			irq;
> +	int			reg_shift;      /* bit shift for I2C register addresses */
>  	struct clk		*iclk;		/* Interface clock */
>  	struct clk		*fclk;		/* Functional clock */
>  	struct completion	cmd_complete;
> @@ -189,12 +190,12 @@ struct omap_i2c_dev {
>  static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
>  				      int reg, u16 val)
>  {
> -	__raw_writew(val, i2c_dev->base + reg);
> +	__raw_writew(val, i2c_dev->base + (reg << i2c_dev->reg_shift));
>  }
>  
>  static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
>  {
> -	return __raw_readw(i2c_dev->base + reg);
> +	return __raw_readw(i2c_dev->base + (reg << i2c_dev->reg_shift));
>  }
>  
>  static int __init omap_i2c_get_clocks(struct omap_i2c_dev *dev)
> @@ -893,6 +894,12 @@ omap_i2c_probe(struct platform_device *pdev)
>  	dev->idle = 1;
>  	dev->dev = &pdev->dev;
>  	dev->irq = irq->start;
> +
> +	if (cpu_is_omap7xx())
> +		dev->reg_shift = 1;
> +	else
> +		dev->reg_shift = 2;
> +
>  	dev->base = ioremap(mem->start, resource_size(mem));
>  	if (!dev->base) {
>  		r = -ENOMEM;
> -- 
> 1.6.3.3
> 
