From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v2] twl4030: Enable low-power mode to 32kHz oscillator
Date: Fri, 23 Oct 2009 16:13:11 +0200
Message-ID: <20091023141310.GB3718@sortiz.org>
References: <1256210049-4567-1-git-send-email-ilkka.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752064AbZJWOLQ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1256210049-4567-1-git-send-email-ilkka.koskinen@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Ilkka,

On Thu, Oct 22, 2009 at 02:14:09PM +0300, Ilkka Koskinen wrote:
> Allows TWL's 32kHz oscillator to go in low-power mode when
> main battery voltage is running low.
Patch applied, thanks a lot.

Cheers,
Samuel.


> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> ---
>  drivers/mfd/twl4030-core.c  |    9 +++++++--
>  include/linux/i2c/twl4030.h |    5 +++++
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
> index eee5af8..004a8be 100644
> --- a/drivers/mfd/twl4030-core.c
> +++ b/drivers/mfd/twl4030-core.c
> @@ -177,6 +177,7 @@
>  #define HFCLK_FREQ_26_MHZ		(2 << 0)
>  #define HFCLK_FREQ_38p4_MHZ		(3 << 0)
>  #define HIGH_PERF_SQ			(1 << 3)
> +#define CK32K_LOWPWR_EN			(1 << 7)
>  
>  
>  /* chip-specific feature flags, for i2c_device_id.driver_data */
> @@ -681,7 +682,8 @@ static inline int __init unprotect_pm_master(void)
>  	return e;
>  }
>  
> -static void clocks_init(struct device *dev)
> +static void clocks_init(struct device *dev,
> +			struct twl4030_clock_init_data *clock)
>  {
>  	int e = 0;
>  	struct clk *osc;
> @@ -728,6 +730,9 @@ static void clocks_init(struct device *dev)
>  	}
>  
>  	ctrl |= HIGH_PERF_SQ;
> +	if (clock && clock->ck32k_lowpwr_enable)
> +		ctrl |= CK32K_LOWPWR_EN;
> +
>  	e |= unprotect_pm_master();
>  	/* effect->MADC+USB ck en */
>  	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
> @@ -806,7 +811,7 @@ twl4030_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	inuse = true;
>  
>  	/* setup clock framework */
> -	clocks_init(&client->dev);
> +	clocks_init(&client->dev, pdata->clock);
>  
>  	/* load power event scripts */
>  	if (twl_has_power() && pdata->power)
> diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
> index 4a2fb27..10e68cb 100644
> --- a/include/linux/i2c/twl4030.h
> +++ b/include/linux/i2c/twl4030.h
> @@ -313,6 +313,10 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
>  
>  /*----------------------------------------------------------------------*/
>  
> +struct twl4030_clock_init_data {
> +	bool ck32k_lowpwr_enable;
> +};
> +
>  struct twl4030_bci_platform_data {
>  	int *battery_tmp_tbl;
>  	unsigned int tblsize;
> @@ -407,6 +411,7 @@ extern void twl4030_power_init(struct twl4030_power_data *triton2_scripts);
>  
>  struct twl4030_platform_data {
>  	unsigned				irq_base, irq_end;
> +	struct twl4030_clock_init_data		*clock;
>  	struct twl4030_bci_platform_data	*bci;
>  	struct twl4030_gpio_platform_data	*gpio;
>  	struct twl4030_madc_platform_data	*madc;
> -- 
> 1.6.0.4
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
