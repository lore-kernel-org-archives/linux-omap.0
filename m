From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] mfd: Add PWM1 and PWM2 support to twl6030-pwm
Date: Thu, 15 Sep 2011 18:47:24 +0200
Message-ID: <20110915164724.GG32263@sortiz-mobl>
References: <51632.192.168.10.10.1314687437.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9654 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934190Ab1IOQoq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 12:44:46 -0400
Content-Disposition: inline
In-Reply-To: <51632.192.168.10.10.1314687437.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemanth V <hemanthv@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Hemanth,

On Tue, Aug 30, 2011 at 12:27:17PM +0530, Hemanth V wrote:
> From: Hemanth V <hemanthv@ti.com>
> Date: Fri, 26 Aug 2011 10:49:29 +0530
> Subject: [PATCH] Add PWM1 and PWM2 support to twl6030-pwm driver
> 
> This patch adds support for PWM1/PWM2. TWL6030 PWM driver also
> supports Indicator LED PWM. Function pointers are defined for
> for init, enable, disable and configuration for both Indicator LED
> PWM (led_pwm) and PWM1/PWM2 (std_pwm)
Some comments on this code:


> +/* PWMs supported by driver */
> +#define PWM_ID_LED		1
> +#define PWM_ID_PWM1		2
> +#define PWM_ID_PWM2		3
I wish we could use enums here, but that's not what the PWM API is expecting.



> +int led_pwm_enable(struct pwm_device *pwm)
All your pwm_ops should be static now.


>  {
>  	u8 val;
>  	int ret;
> @@ -95,9 +140,8 @@ int pwm_enable(struct pwm_device *pwm)
>  	twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, LED_PWM_CTRL2);
>  	return 0;
>  }
> -EXPORT_SYMBOL(pwm_enable);
> 
> -void pwm_disable(struct pwm_device *pwm)
> +void led_pwm_disable(struct pwm_device *pwm)
>  {
>  	u8 val;
>  	int ret;
> @@ -120,37 +164,284 @@ void pwm_disable(struct pwm_device *pwm)
>  	}
>  	return;
>  }
> -EXPORT_SYMBOL(pwm_disable);
> 
> -struct pwm_device *pwm_request(int pwm_id, const char *label)
> +int led_pwm_init(struct pwm_device *pwm)
>  {
>  	u8 val;
>  	int ret;
> +
> +	val = PWM_CTRL2_DIS_PD | PWM_CTRL2_CURR_02 | PWM_CTRL2_SRC_VBUS |
> +		PWM_CTRL2_MODE_HW;
> +
> +	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, LED_PWM_CTRL2);
> +
> +	return ret;
> +}
> +
> +static struct pwm_ops pwm_led = {
> +	.config = led_pwm_config,
> +	.enable = led_pwm_enable,
> +	.disable = led_pwm_disable,
> +	.init = led_pwm_init,
> +};
> +
> +int std_pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> +{
> +	int ret = 0, level, pwm_id, reg;
> +
> +	level = (duty_ns * PWM_CTRL1_MAX) / period_ns;
> +	pwm_id = pwm->pwm_id;
> +
> +	if (pwm_id == PWM_ID_PWM1)
> +		reg = LED_PWM1ON;
> +	else
> +		reg = LED_PWM2ON;
This is not consistent with your:

if (PWM1)
else if (PWM2)
else
	error

logic below.

Moreover, I'd rather use switch() here but that's more of a personal taste
than anything else.


> +struct pwm_device *pwm_request(int pwm_id, const char *label)
> +{
> +	int ret, found = 0;
>  	struct pwm_device *pwm;
> 
> +	mutex_lock(&pwm_lock);
> +
> +	list_for_each_entry(pwm, &pwm_list, node) {
> +		if (pwm->pwm_id == pwm_id) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (found) {
> +		if (pwm->use_count == 0) {
> +			pwm->use_count++;
> +			pwm->label = label;
> +		} else {
> +			pwm = ERR_PTR(-EBUSY);
> +		}
I failed to understand the logic here. How can you have found == TRUE, and
use_count being 0 ? Also, don't you want to track the pwm users and disable it
when user_count is reaching 0 ? You're not doing that from pwm_free().



> +		goto out;
You're leaving with the pwm_lock locked.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
