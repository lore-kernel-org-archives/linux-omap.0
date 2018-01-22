From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 3/3] clocksource: timer-dm: Make unexported functions
 static
Date: Mon, 22 Jan 2018 11:26:44 +0200
Message-ID: <755fca20-7544-1655-47c7-83b1a2669adc@microchip.com>
References: <20180117214629.GA11952@lenoch> <20180117214826.GD11952@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180117214826.GD11952@lenoch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>, daniel.lezcano@linaro.org, thierry.reding@gmail.com, tony@atomide.com, aaro.koskinen@iki.fi, narmstrong@baylibre.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sebastian.reichel@collabora.co.uk, robh+dt@kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com
List-Id: linux-omap@vger.kernel.org



On 17.01.2018 23:48, Ladislav Michl wrote:
> As dmtimer no longer exports functions, make those previously
> exported static.
> 
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Note: only those functions assigned to timer ops are made static
>        as some others will be needed later for event capture.
> 
>  drivers/clocksource/timer-dm.c |  218 ++++++++++++++++++++---------------------
>  include/clocksource/dmtimer.h  |   24 ----
>  2 files changed, 109 insertions(+), 133 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-dm.c b/drivers/clocksource/timer-dm.c
> index 324ec93d3dd2..8de9e543d129 100644
> --- a/drivers/clocksource/timer-dm.c
> +++ b/drivers/clocksource/timer-dm.c
> @@ -163,6 +163,92 @@ static int omap_dm_timer_of_set_source(struct omap_dm_timer *timer)
>  	return ret;
>  }
>  
> +static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
> +{
> +	int ret;
> +	char *parent_name = NULL;
Could be declared as const: const char *parent_name = NULL;

> +	struct clk *parent;
> +	struct dmtimer_platform_data *pdata;
> +
> +	if (unlikely(!timer))
> +		return -EINVAL;
> +
> +	pdata = timer->pdev->dev.platform_data;
> +
> +	if (source < 0 || source >= 3)
> +		return -EINVAL;
> +
> +	/*
> +	 * FIXME: Used for OMAP1 devices only because they do not currently
> +	 * use the clock framework to set the parent clock. To be removed
> +	 * once OMAP1 migrated to using clock framework for dmtimers
> +	 */
> +	if (pdata && pdata->set_timer_src)
> +		return pdata->set_timer_src(timer->pdev, source);
> +
> +	if (IS_ERR(timer->fclk))
> +		return -EINVAL;
Souldn't this check be done at the beginning of the function?

> +
> +#if defined(CONFIG_COMMON_CLK)
> +	/* Check if the clock has configurable parents */
> +	if (clk_hw_get_num_parents(__clk_get_hw(timer->fclk)) < 2)
> +		return 0;
> +#endif
> +
> +	switch (source) {
> +	case OMAP_TIMER_SRC_SYS_CLK:
> +		parent_name = "timer_sys_ck";
> +		break;
> +
> +	case OMAP_TIMER_SRC_32_KHZ:
> +		parent_name = "timer_32k_ck";
> +		break;
> +
> +	case OMAP_TIMER_SRC_EXT_CLK:
> +		parent_name = "timer_ext_ck";
> +		break;
> +	}
> +
> +	parent = clk_get(&timer->pdev->dev, parent_name);
> +	if (IS_ERR(parent)) {
> +		pr_err("%s: %s not found\n", __func__, parent_name);
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_set_parent(timer->fclk, parent);
> +	if (ret < 0)
> +		pr_err("%s: failed to set %s as parent\n", __func__,
> +			parent_name);
> +
> +	clk_put(parent);
> +
> +	return ret;
> +}
> +
> +static void omap_dm_timer_enable(struct omap_dm_timer *timer)
> +{
> +	int c;
> +
> +	pm_runtime_get_sync(&timer->pdev->dev);
> +
> +	if (!(timer->capability & OMAP_TIMER_ALWON)) {
> +		if (timer->get_context_loss_count) {
> +			c = timer->get_context_loss_count(&timer->pdev->dev);
> +			if (c != timer->ctx_loss_count) {
> +				omap_timer_restore_context(timer);
> +				timer->ctx_loss_count = c;
> +			}
> +		} else {
> +			omap_timer_restore_context(timer);
> +		}
> +	}
> +}
> +
> +static void omap_dm_timer_disable(struct omap_dm_timer *timer)
> +{
> +	pm_runtime_put_sync(&timer->pdev->dev);
> +}
> +
>  static int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>  {
>  	int rc;
> @@ -298,16 +384,16 @@ static struct omap_dm_timer *_omap_dm_timer_request(int req_type, void *data)
>  	return timer;
>  }
>  
> -struct omap_dm_timer *omap_dm_timer_request(void)
> +static struct omap_dm_timer *omap_dm_timer_request(void)
>  {
>  	return _omap_dm_timer_request(REQUEST_ANY, NULL);
>  }
>  
> -struct omap_dm_timer *omap_dm_timer_request_specific(int id)
> +static struct omap_dm_timer *omap_dm_timer_request_specific(int id)
>  {
>  	/* Requesting timer by ID is not supported when device tree is used */
>  	if (of_have_populated_dt()) {
> -		pr_warn("%s: Please use omap_dm_timer_request_by_cap/node()\n",
> +		pr_warn("%s: Please use omap_dm_timer_request_by_node()\n",
>  			__func__);
>  		return NULL;
>  	}
> @@ -336,7 +422,7 @@ struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap)
>   * Request a timer based upon a device node pointer. Returns pointer to
>   * timer handle on success and a NULL pointer on failure.
>   */
> -struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np)
> +static struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np)
>  {
>  	if (!np)
>  		return NULL;
> @@ -344,7 +430,7 @@ struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np)
>  	return _omap_dm_timer_request(REQUEST_BY_NODE, np);
>  }
>  
> -int omap_dm_timer_free(struct omap_dm_timer *timer)
> +static int omap_dm_timer_free(struct omap_dm_timer *timer)
>  {
>  	if (unlikely(!timer))
>  		return -EINVAL;
> @@ -356,30 +442,6 @@ int omap_dm_timer_free(struct omap_dm_timer *timer)
>  	return 0;
>  }
>  
> -void omap_dm_timer_enable(struct omap_dm_timer *timer)
> -{
> -	int c;
> -
> -	pm_runtime_get_sync(&timer->pdev->dev);
> -
> -	if (!(timer->capability & OMAP_TIMER_ALWON)) {
> -		if (timer->get_context_loss_count) {
> -			c = timer->get_context_loss_count(&timer->pdev->dev);
> -			if (c != timer->ctx_loss_count) {
> -				omap_timer_restore_context(timer);
> -				timer->ctx_loss_count = c;
> -			}
> -		} else {
> -			omap_timer_restore_context(timer);
> -		}
> -	}
> -}
> -
> -void omap_dm_timer_disable(struct omap_dm_timer *timer)
> -{
> -	pm_runtime_put_sync(&timer->pdev->dev);
> -}
> -
>  int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
>  {
>  	if (timer)
> @@ -424,7 +486,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
>  
>  #else
>  
> -struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
> +static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
>  {
>  	if (timer && !IS_ERR(timer->fclk))
>  		return timer->fclk;
> @@ -451,7 +513,7 @@ int omap_dm_timer_trigger(struct omap_dm_timer *timer)
>  	return 0;
>  }
>  
> -int omap_dm_timer_start(struct omap_dm_timer *timer)
> +static int omap_dm_timer_start(struct omap_dm_timer *timer)
>  {
>  	u32 l;
>  
> @@ -471,7 +533,7 @@ int omap_dm_timer_start(struct omap_dm_timer *timer)
>  	return 0;
>  }
>  
> -int omap_dm_timer_stop(struct omap_dm_timer *timer)
> +static int omap_dm_timer_stop(struct omap_dm_timer *timer)
>  {
>  	unsigned long rate = 0;
>  
> @@ -494,70 +556,8 @@ int omap_dm_timer_stop(struct omap_dm_timer *timer)
>  	return 0;
>  }
>  
> -int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
> -{
> -	int ret;
> -	char *parent_name = NULL;
> -	struct clk *parent;
> -	struct dmtimer_platform_data *pdata;
> -
> -	if (unlikely(!timer))
> -		return -EINVAL;
> -
> -	pdata = timer->pdev->dev.platform_data;
> -
> -	if (source < 0 || source >= 3)
> -		return -EINVAL;
> -
> -	/*
> -	 * FIXME: Used for OMAP1 devices only because they do not currently
> -	 * use the clock framework to set the parent clock. To be removed
> -	 * once OMAP1 migrated to using clock framework for dmtimers
> -	 */
> -	if (pdata && pdata->set_timer_src)
> -		return pdata->set_timer_src(timer->pdev, source);
> -
> -	if (IS_ERR(timer->fclk))
> -		return -EINVAL;
> -
> -#if defined(CONFIG_COMMON_CLK)
> -	/* Check if the clock has configurable parents */
> -	if (clk_hw_get_num_parents(__clk_get_hw(timer->fclk)) < 2)
> -		return 0;
> -#endif
> -
> -	switch (source) {
> -	case OMAP_TIMER_SRC_SYS_CLK:
> -		parent_name = "timer_sys_ck";
> -		break;
> -
> -	case OMAP_TIMER_SRC_32_KHZ:
> -		parent_name = "timer_32k_ck";
> -		break;
> -
> -	case OMAP_TIMER_SRC_EXT_CLK:
> -		parent_name = "timer_ext_ck";
> -		break;
> -	}
> -
> -	parent = clk_get(&timer->pdev->dev, parent_name);
> -	if (IS_ERR(parent)) {
> -		pr_err("%s: %s not found\n", __func__, parent_name);
> -		return -EINVAL;
> -	}
> -
> -	ret = clk_set_parent(timer->fclk, parent);
> -	if (ret < 0)
> -		pr_err("%s: failed to set %s as parent\n", __func__,
> -			parent_name);
> -
> -	clk_put(parent);
> -
> -	return ret;
> -}
> -
> -int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
> -			    unsigned int load)
> +static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
> +				  unsigned int load)
>  {
>  	u32 l;
>  
> @@ -609,9 +609,8 @@ int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload,
>  	timer->context.tcrr = load;
>  	return 0;
>  }
> -
> -int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
> -			     unsigned int match)
> +static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
> +				   unsigned int match)
>  {
>  	u32 l;
>  
> @@ -634,8 +633,8 @@ int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
>  	return 0;
>  }
>  
> -int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
> -			   int toggle, int trigger)
> +static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
> +				 int toggle, int trigger)
>  {
>  	u32 l;
>  
> @@ -659,7 +658,8 @@ int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
>  	return 0;
>  }
>  
> -int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
> +static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
> +					int prescaler)
>  {
>  	u32 l;
>  
> @@ -681,8 +681,8 @@ int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler)
>  	return 0;
>  }
>  
> -int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
> -				  unsigned int value)
> +static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
> +					unsigned int value)
>  {
>  	if (unlikely(!timer))
>  		return -EINVAL;
> @@ -704,7 +704,7 @@ int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
>   *
>   * Disables the specified timer interrupts for a timer.
>   */
> -int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
> +static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
>  {
>  	u32 l = mask;
>  
> @@ -727,7 +727,7 @@ int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
>  	return 0;
>  }
>  
> -unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
> +static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
>  {
>  	unsigned int l;
>  
> @@ -741,7 +741,7 @@ unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
>  	return l;
>  }
>  
> -int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
> +static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
>  {
>  	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev)))
>  		return -EINVAL;
> @@ -751,7 +751,7 @@ int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
>  	return 0;
>  }
>  
> -unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
> +static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
>  {
>  	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
>  		pr_err("%s: timer not iavailable or enabled.\n", __func__);
> @@ -761,7 +761,7 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
>  	return __omap_dm_timer_read_counter(timer, timer->posted);
>  }
>  
> -int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
> +static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
>  {
>  	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
>  		pr_err("%s: timer not available or enabled.\n", __func__);
> diff --git a/include/clocksource/dmtimer.h b/include/clocksource/dmtimer.h
> index 862ad62dab9d..ce596172a93a 100644
> --- a/include/clocksource/dmtimer.h
> +++ b/include/clocksource/dmtimer.h
> @@ -125,37 +125,13 @@ struct omap_dm_timer {
>  };
>  
>  int omap_dm_timer_reserve_systimer(int id);
> -struct omap_dm_timer *omap_dm_timer_request(void);
> -struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
>  struct omap_dm_timer *omap_dm_timer_request_by_cap(u32 cap);
> -struct omap_dm_timer *omap_dm_timer_request_by_node(struct device_node *np);
> -int omap_dm_timer_free(struct omap_dm_timer *timer);
> -void omap_dm_timer_enable(struct omap_dm_timer *timer);
> -void omap_dm_timer_disable(struct omap_dm_timer *timer);
>  
>  int omap_dm_timer_get_irq(struct omap_dm_timer *timer);
>  
>  u32 omap_dm_timer_modify_idlect_mask(u32 inputmask);
> -struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer);
>  
>  int omap_dm_timer_trigger(struct omap_dm_timer *timer);
> -int omap_dm_timer_start(struct omap_dm_timer *timer);
> -int omap_dm_timer_stop(struct omap_dm_timer *timer);
> -
> -int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source);
> -int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload, unsigned int value);
> -int omap_dm_timer_set_load_start(struct omap_dm_timer *timer, int autoreload, unsigned int value);
> -int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable, unsigned int match);
> -int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on, int toggle, int trigger);
> -int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer, int prescaler);
> -
> -int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer, unsigned int value);
> -int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask);
> -
> -unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer);
> -int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value);
> -unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer);
> -int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value);
>  
>  int omap_dm_timers_active(void);
>  
> 
