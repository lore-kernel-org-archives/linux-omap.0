From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Fri, 1 Apr 2011 14:28:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1104011423220.27897@utopia.booyaka.com>
References: <1301672047-31903-1-git-send-email-avinashhm@ti.com> <1301672047-31903-2-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34538 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306Ab1DAU2g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 16:28:36 -0400
In-Reply-To: <1301672047-31903-2-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M" <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi

some comments

On Fri, 1 Apr 2011, Avinash.H.M wrote:

> The i2c module has a special reset sequence. The sequence is
> - Disable the I2C.
> - Write to SOFTRESET bit.
> - Enable the I2C.
> - Poll on the RESETDONE bit.
> This sequence must be followed for i2c reset in omap2, omap3. The sequence is
> implemented as a function and the i2c_class is updated with the correct
> 'reset' pointer.
> 
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |   59 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    1 +
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    1 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    1 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
>  5 files changed, 64 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e034294..f61c9c8 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -156,6 +156,10 @@
>  /* Name of the OMAP hwmod for the MPU */
>  #define MPU_INITIATOR_NAME		"mpu"
>  
> +/* In register I2C_CON, Bit 15 is the I2C enable bit */
> +#define I2C_EN				BIT(15)
> +#define I2C_CON_OFFSET			0x24

This stuff, along with omap_i2c_reset(), doesn't belong in omap_hwmod.c, 
which is common code that is not I2C-specific.  Please put it in 
mach-omap2/i2c.c instead.

> +
>  /* omap_hwmod_list contains all registered struct omap_hwmods */
>  static LIST_HEAD(omap_hwmod_list);
>  
> @@ -2369,3 +2373,58 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
>  
>  	return 0;
>  }
> +
> +/**
> + * omap_i2c_reset- reset the omap i2c module.
> + * @oh: struct omap_hwmod *
> + *
> + * The i2c moudle in omap2, omap3 had a special sequence to reset. The
> + * sequence is:
> + * - Disable the I2C.
> + * - Write to SOFTRESET bit.
> + * - Enable the I2C.
> + * - Poll on the RESETDONE bit.
> + * The sequence is implemented in below function. This is called for 2420,
> + * 2430 and omap3.
> + */
> +int omap_i2c_reset(struct omap_hwmod *oh)
> +{
> +	u32 v = 0;

no need to initialize this to 0

> +	int ret = 0, c = 0;

no need to initialize ret to 0

> +
> +	/* Disable I2C */
> +	v = omap_hwmod_read(oh, I2C_CON_OFFSET);
> +	v = v & ~I2C_EN;
> +	omap_hwmod_write(v, oh, I2C_CON_OFFSET);
> +
> +	/* Write to the SOFTRESET bit */
> +	v = oh->_sysc_cache;
> +	ret = _set_softreset(oh, &v);
> +	if (ret)
> +		goto err1;
> +	_write_sysconfig(v, oh);
> +
> +	/* Enable I2C */
> +	v = omap_hwmod_read(oh, I2C_CON_OFFSET);
> +	v |= I2C_EN;
> +	omap_hwmod_write(v, oh, I2C_CON_OFFSET);
> +
> +	/* Poll on RESETDONE bit */
> +	omap_test_timeout((omap_hwmod_read(oh,
> +				oh->class->sysc->syss_offs)
> +				& SYSS_RESETDONE_MASK),
> +				MAX_MODULE_SOFTRESET_WAIT, c);
> +
> +	if (c == MAX_MODULE_SOFTRESET_WAIT)
> +		pr_warning("%s: %s: softreset failed (waited %d usec)\n",
> +			__func__, oh->name, MAX_MODULE_SOFTRESET_WAIT);
> +	else
> +		pr_debug("%s: %s: softreset in %d usec\n", __func__,
> +			oh->name, c);
> +
> +	return 0;
> +
> +err1:
> +	pr_warning("%s: returned error from _set_softreset\n", __func__);
> +	return ret;
> +}
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index 8eb3ce1..82ff5f7 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -1447,6 +1447,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
>  static struct omap_hwmod_class i2c_class = {
>  	.name		= "i2c",
>  	.sysc		= &i2c_sysc,
> +	.reset		= &omap_i2c_reset,
>  };
>  
>  static struct omap_i2c_dev_attr i2c_dev_attr;
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index a860fb5..ce292f0 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -1524,6 +1524,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
>  static struct omap_hwmod_class i2c_class = {
>  	.name		= "i2c",
>  	.sysc		= &i2c_sysc,
> +	.reset		= &omap_i2c_reset,
>  };
>  
>  static struct omap_i2c_dev_attr i2c_dev_attr = {
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index b98e2df..c74f972 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1460,6 +1460,7 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
>  static struct omap_hwmod_class i2c_class = {
>  	.name = "i2c",
>  	.sysc = &i2c_sysc,
> +	.reset = &omap_i2c_reset,
>  };
>  
>  /*
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1adea9c..26b7ad3 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -545,6 +545,8 @@ struct omap_hwmod {
>  };
>  
>  int omap_hwmod_register(struct omap_hwmod **ohs);
> +int omap_i2c_reset(struct omap_hwmod *oh);

This should go into plat-omap/include/plat/i2c.h

> +
>  struct omap_hwmod *omap_hwmod_lookup(const char *name);
>  int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
>  			void *data);
> -- 
> 1.7.1
> 


- Paul
