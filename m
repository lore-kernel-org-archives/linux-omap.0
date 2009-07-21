From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [RESUBMIT][PATCH][RFC] OMAP4: I2C Support for OMAP4430
Date: Tue, 21 Jul 2009 16:46:01 +0100
Message-ID: <20090721154601.GC7547@n2100.arm.linux.org.uk>
References: <53314.192.168.10.89.1248189586.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53314.192.168.10.89.1248189586.squirrel-pJFUjGLopx31T2qfsofKZtBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Syed Rafiuddin <rafiuddin.syed-l0cyMroinI0@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 21, 2009 at 08:49:46PM +0530, Syed Rafiuddin wrote:
> This patch adds OMAP4 support to the I2C driver. All I2C register addresses
> are different between OMAP1/2/3 and OMAP4. In order to not have #ifdef's at
> various places in code, as well as to support multi-OMAP build, Array's are
> created to hold the register addresses.

Hmm, some comments follow.

> @@ -156,6 +162,12 @@
>  #define SYSC_IDLEMODE_SMART		0x2
>  #define SYSC_CLOCKACTIVITY_FCLK		0x2
> 
> +#define maxvalue(x, y)	(x > y ? x : y)

We have a max() and max_t() functions in the kernel which are both
typesafe.  Please don't reintroduce the above buggy construct.

> +
> +struct reg_type {
> +	u32 reg;
> +	u32 offset;
> +};

I'm not sure what use 'reg' is here - since it's always identical to
the index into the array.  Just make this an array.

> 
>  struct omap_i2c_dev {
>  	struct device		*dev;
> @@ -165,6 +177,7 @@ struct omap_i2c_dev {
>  	struct clk		*fclk;		/* Functional clock */
>  	struct completion	cmd_complete;
>  	struct resource		*ioarea;
> +	struct reg_type		*regs;

This could be const...

>  	u32			speed;		/* Speed of bus in Khz */
>  	u16			cmd_err;
>  	u8			*buf;
> @@ -180,15 +193,61 @@ struct omap_i2c_dev {
>  	u16			iestate;	/* Saved interrupt register */
>  };
> 
> +static struct  __initdata reg_type reg_map[] = {
> +	{OMAP_I2C_REV_REG, 0x00},
> +	{OMAP_I2C_IE_REG, 0x04},
> +	{OMAP_I2C_STAT_REG, 0x08},
> +	{OMAP_I2C_IV_REG, 0x0c},
> +	{OMAP_I2C_WE_REG, 0x0c},
> +	{OMAP_I2C_SYSS_REG, 0x10},
> +	{OMAP_I2C_BUF_REG, 0x14},
> +	{OMAP_I2C_CNT_REG, 0x18},
> +	{OMAP_I2C_DATA_REG, 0x1c},
> +	{OMAP_I2C_SYSC_REG, 0x20},
> +	{OMAP_I2C_CON_REG, 0x24},
> +	{OMAP_I2C_OA_REG, 0x28},
> +	{OMAP_I2C_SA_REG, 0x2c},
> +	{OMAP_I2C_PSC_REG, 0x30},
> +	{OMAP_I2C_SCLL_REG, 0x34},
> +	{OMAP_I2C_SCLH_REG, 0x38},
> +	{OMAP_I2C_SYSTEST_REG, 0x3C},
> +	{OMAP_I2C_BUFSTAT_REG, 0x40},
> +};
> +
> +static struct  __initdata reg_type omap4_reg_map[] = {
> +	{OMAP_I2C_REV_REG, 0x04},
> +	{OMAP_I2C_IE_REG, 0x2c},
> +	{OMAP_I2C_STAT_REG, 0x28},
> +	{OMAP_I2C_IV_REG, 0x34},
> +	{OMAP_I2C_WE_REG, 0x34},
> +	{OMAP_I2C_SYSS_REG, 0x90},
> +	{OMAP_I2C_BUF_REG, 0x94},
> +	{OMAP_I2C_CNT_REG, 0x98},
> +	{OMAP_I2C_DATA_REG, 0x9c},
> +	{OMAP_I2C_SYSC_REG, 0x20},
> +	{OMAP_I2C_CON_REG, 0xa4},
> +	{OMAP_I2C_OA_REG, 0xa8},
> +	{OMAP_I2C_SA_REG, 0xac},
> +	{OMAP_I2C_PSC_REG, 0xb0},
> +	{OMAP_I2C_SCLL_REG, 0xb4},
> +	{OMAP_I2C_SCLH_REG, 0xb8},
> +	{OMAP_I2C_SYSTEST_REG, 0xbC},
> +	{OMAP_I2C_BUFSTAT_REG, 0xc0},
> +	{OMAP_I2C_REVNB_LO, 0x00},
> +	{OMAP_I2C_IRQSTATUS_RAW, 0x24},
> +	{OMAP_I2C_IRQENABLE_SET, 0x2c},
> +	{OMAP_I2C_IRQENABLE_CLR, 0x30},
> +};

These arrays could be of a well defined size (enough to hold all enum
values).  They're not going to be huge, and I suspect that the cost of
this code:

> +	if (dev->regs == NULL) {
> +		dev->regs = kmalloc(maxvalue(sizeof(omap4_reg_map),
> +				sizeof(reg_map)), GFP_KERNEL);
> +		if (dev->regs == NULL) {
> +			r = -ENOMEM;
> +			goto err_free_mem;
> +		}
> +	}
> +
> +	if (cpu_is_omap44xx())
> +		memcpy(dev->regs, omap4_reg_map, sizeof(omap4_reg_map));
> +	else
> +		memcpy(dev->regs, reg_map, sizeof(reg_map));
> +

is higher than just having the above be const arrays of 'u8' or maybe
'u16'.

Note that you can explicitly initialize array entries as follows:

static u8 omap4_reg_map[OMAP_I2C_MAX_REG] = {
	[OMAP_I2C_REV_REG] = 0x04,
	[OMAP_I2C_IE_REG]  = 0x2c,
...
};
