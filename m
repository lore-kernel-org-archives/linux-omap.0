From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3] OMAP2/3: hwmod: fix the i2c-reset timeout during
 bootup
Date: Thu, 5 May 2011 15:58:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1105051548210.30136@utopia.booyaka.com>
References: <1304328111-15999-1-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47909 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1EEV65 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 17:58:57 -0400
In-Reply-To: <1304328111-15999-1-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Avinash.H.M" <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hello Avinash

On Mon, 2 May 2011, Avinash.H.M wrote:

> The sequence of _ocp_softreset doesn't work for i2c. The i2c module has a
> special sequence to reset the module. The sequence is
>  - Disable the I2C.
>  - Write to SOFTRESET bit.
>  - Enable the I2C.
>  - Poll on the RESETDONE bit.
> The sequence is implemented as a function and the i2c_class is updated with
> the correct 'reset' pointer.  omap_hwmod_softreset function is implemented
> which triggers the softreset by writing into sysconfig register. On following
> this sequence, i2c module resets properly and timeouts are not seen.
> 
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Avinash.H.M <avinashhm@ti.com>
> ---
> 
> The patch is based on
>  * git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>  * master branch.
>  * 9be20f0 commit. ( Linux-omap rebuilt: Updated to -rc5 )

Please base all your patches against mainline commits.  I suggest using 
v2.6.39-rc6.

Also some comments:

> Changes from previous versions:
> from v1:
> 	- moved i2c specific things from hwmod files to i2c files.
> 	- fixed comments from Paul.
> 	- http://www.spinics.net/lists/linux-omap/msg49483.html
> 
> from v2: 
> 	- Avoided direct SYSCONFIG access in i2c.c
> 	- http://www.spinics.net/lists/linux-omap/msg49632.html
> 
> Testing:
> * build tested omap2plus_defconfig for warnings and errors. none introduced.
> * boot tested on 2430. 
> * tested for 'core off' in suspend resume on 3430 sdp. core off counters
>   increment after suspend resume. 
> 
>  arch/arm/mach-omap2/i2c.c                    |   54 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod.c             |   12 ++++++
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    1 +
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    1 +
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    1 +
>  arch/arm/plat-omap/include/plat/i2c.h        |    4 ++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
>  7 files changed, 74 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
> index 79c478c..bd50e26 100644
> --- a/arch/arm/mach-omap2/i2c.c
> +++ b/arch/arm/mach-omap2/i2c.c
> @@ -21,9 +21,16 @@
>  
>  #include <plat/cpu.h>
>  #include <plat/i2c.h>
> +#include <plat/common.h>
>  
>  #include "mux.h"
>  
> +/* In register I2C_CON, Bit 15 is the I2C enable bit */
> +#define I2C_EN				BIT(15)
> +#define I2C_CON_OFFSET			0x24
> +/* Maximum microseconds to wait for OMAP module to softreset */
> +#define MAX_MODULE_SOFTRESET_WAIT	10000
> +
>  void __init omap2_i2c_mux_pins(int bus_id)
>  {
>  	char mux_name[sizeof("i2c2_scl.i2c2_scl")];
> @@ -37,3 +44,50 @@ void __init omap2_i2c_mux_pins(int bus_id)
>  	sprintf(mux_name, "i2c%i_sda.i2c%i_sda", bus_id, bus_id);
>  	omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
>  }
> +
> +/**
> + * omap_i2c_reset- reset the omap i2c module.

Please put a space before the dash.

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
> +	u32 v;
> +	int c = 0;
> +
> +	/* Disable I2C */
> +	v = omap_hwmod_read(oh, I2C_CON_OFFSET);
> +	v = v & ~I2C_EN;
> +	omap_hwmod_write(v, oh, I2C_CON_OFFSET);
> +
> +	/* Write to the SOFTRESET bit */
> +	omap_hwmod_softreset(oh);
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
> +}
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index e034294..771fc15 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1561,6 +1561,18 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
>  		__raw_writel(v, oh->_mpu_rt_va + reg_offs);
>  }
>  

You're missing kerneldoc here.  Please add it.

> +void omap_hwmod_softreset(struct omap_hwmod *oh)
> +{
> +	u32 v;
> +
> +	/* Write to the SOFTRESET bit in SYSCONFIG */
> +	v = oh->_sysc_cache;
> +	v |= (0x1 << oh->class->sysc->sysc_fields->srst_shift);
> +
> +	oh->_sysc_cache = v;
> +	omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
> +}

This is a public function, so you need to validate your oh argument and 
return an error if something isn't right.  Similarly, you should use the 
existing function _set_softreset() to set the bit, because it also does 
some errorchecking.

> +
>  /**
>   * omap_hwmod_set_slave_idlemode - set the hwmod's OCP slave idlemode
>   * @oh: struct omap_hwmod *
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index e9a416c..fd386af 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -1447,6 +1447,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
>  static struct omap_hwmod_class i2c_class = {
>  	.name		= "i2c",
>  	.sysc		= &i2c_sysc,
> +	.reset		= &omap_i2c_reset,
>  	.rev		= OMAP_I2C_IP_VERSION_1,
>  };
>  
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index beedda6..4ad4188 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -1524,6 +1524,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
>  static struct omap_hwmod_class i2c_class = {
>  	.name		= "i2c",
>  	.sysc		= &i2c_sysc,
> +	.reset		= &omap_i2c_reset,
>  	.rev		= OMAP_I2C_IP_VERSION_1,
>  };
>  
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index dec1a38..e938810 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1460,6 +1460,7 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
>  static struct omap_hwmod_class i2c_class = {
>  	.name = "i2c",
>  	.sysc = &i2c_sysc,
> +	.reset = &omap_i2c_reset,
>  	.rev  = OMAP_I2C_IP_VERSION_1,
>  };
>  
> diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
> index fd75dad..20237c1 100644
> --- a/arch/arm/plat-omap/include/plat/i2c.h
> +++ b/arch/arm/plat-omap/include/plat/i2c.h
> @@ -24,6 +24,8 @@
>  #include <linux/i2c.h>
>  #include <linux/i2c-omap.h>
>  
> +#include <plat/omap_hwmod.h>
> +
>  #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
>  extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
>  				 struct i2c_board_info const *info,
> @@ -53,4 +55,6 @@ struct omap_i2c_dev_attr {
>  void __init omap1_i2c_mux_pins(int bus_id);
>  void __init omap2_i2c_mux_pins(int bus_id);
>  
> +int omap_i2c_reset(struct omap_hwmod *oh);
> +
>  #endif /* __ASM__ARCH_OMAP_I2C_H */
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1adea9c..9637130 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -572,6 +572,7 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
>  
>  void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs);
>  u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
> +void omap_hwmod_softreset(struct omap_hwmod *oh);
>  
>  int omap_hwmod_count_resources(struct omap_hwmod *oh);
>  int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
