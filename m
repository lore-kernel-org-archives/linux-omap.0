From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] lm8323 pwm fixes
Date: Fri, 17 Oct 2008 15:08:08 -0700
Message-ID: <20081017220803.GG18573@atomide.com>
References: <1222938442-2805-1-git-send-email-timo.o.karjalainen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64194 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755059AbYJQWIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 18:08:10 -0400
Content-Disposition: inline
In-Reply-To: <1222938442-2805-1-git-send-email-timo.o.karjalainen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Timo Karjalainen <timo.o.karjalainen@nokia.com>
Cc: linux-omap@vger.kernel.org, Daniel Stone <daniel.stone@nokia.com>

* Timo Karjalainen <timo.o.karjalainen@nokia.com> [081002 02:09]:
> This patch fixes two problems in LM8323 PWM control. One is that
> locking is needed when setting and reading pwm->desired_brightness
> asynchronously. The other is that LM8323 may stop a PWM script only
> after the current instruction has finished. If it is a long RAMP,
> the chip would keep executing the old instruction and new
> settings were effectively ignored.

Yet another driver to go to mainline.. Pushing to l-o.

Tony

> Signed-off-by: Timo Karjalainen <timo.o.karjalainen@nokia.com>
> Signed-off-by: Daniel Stone <daniel.stone@nokia.com>
> ---
>  drivers/input/keyboard/lm8323.c |  129 +++++++++++++++++++++------------------
>  1 files changed, 69 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
> index 72bb587..342ef6a 100644
> --- a/drivers/input/keyboard/lm8323.c
> +++ b/drivers/input/keyboard/lm8323.c
> @@ -141,6 +141,8 @@ struct lm8323_pwm {
>  	int			fade_time;
>  	int			brightness;
>  	int			desired_brightness;
> +	int			running;
> +	struct mutex		lock;
>  	struct work_struct	work;
>  	struct led_classdev	cdev;
>  };
> @@ -384,6 +386,15 @@ static int lm8323_configure(struct lm8323_chip *lm)
>  	return 0;
>  }
>  
> +static void pwm_done(struct lm8323_pwm *pwm)
> +{
> +	mutex_lock(&pwm->lock);
> +	pwm->running = 0;
> +	if (pwm->desired_brightness != pwm->brightness)
> +		schedule_work(&pwm->work);
> +	mutex_unlock(&pwm->lock);
> +}
> +
>  /*
>   * Bottom half: handle the interrupt by posting key events, or dealing with
>   * errors appropriately.
> @@ -411,12 +422,18 @@ static void lm8323_work(struct work_struct *work)
>  						  "reinitialising\n");
>  			lm8323_configure(lm);
>  		}
> -		if (ints & INT_PWM1)
> +		if (ints & INT_PWM1) {
>  			debug(&lm->client->dev, "pwm1 engine completed\n");
> -		if (ints & INT_PWM2)
> +			pwm_done(&lm->pwm1);
> +		}
> +		if (ints & INT_PWM2) {
>  			debug(&lm->client->dev, "pwm2 engine completed\n");
> -		if (ints & INT_PWM3)
> +			pwm_done(&lm->pwm2);
> +		}
> +		if (ints & INT_PWM3) {
>  			debug(&lm->client->dev, "pwm3 engine completed\n");
> +			pwm_done(&lm->pwm3);
> +		}
>  	}
>  
>  	mutex_unlock(&lm->lock);
> @@ -458,92 +475,80 @@ static void lm8323_write_pwm_one(struct lm8323_pwm *pwm, int pos, u16 cmd)
>  
>  /*
>   * Write a script into a given PWM engine, concluding with PWM_END.
> - * If 'keepalive' is specified, the engine will be kept running
> - * indefinitely.
> + * If 'kill' is nonzero, the engine will be shut down at the end
> + * of the script, producing a zero output. Otherwise the engine
> + * will be kept running at the final PWM level indefinitely.
>   */
> -static void lm8323_write_pwm(struct lm8323_pwm *pwm, int keepalive,
> -			     int len, ...)
> +static void lm8323_write_pwm(struct lm8323_pwm *pwm, int kill,
> +			     int len, const u16 *cmds)
>  {
>  	struct lm8323_chip *lm = pwm_to_lm8323(pwm);
> -	int i, cmd;
> -	va_list ap;
> -
> -	/*
> -	 * If there are any scripts running at the moment, terminate them
> -	 * and make sure the duty cycle is as if it finished.
> -	 */
> -	lm8323_write(lm, 2, LM8323_CMD_STOP_PWM, pwm->id);
> -
> -	va_start(ap, len);
> -	for (i = 0; i < len; i++) {
> -		cmd = va_arg(ap, int);
> -		lm8323_write_pwm_one(pwm, i, cmd);
> -	}
> -	va_end(ap);
> +	int i;
>  
> -	/* Wait for a trigger from any channel. This keeps the engine alive. */
> -	if (keepalive)
> -		lm8323_write_pwm_one(pwm, i++, PWM_WAIT_TRIG(0xe));
> -	else
> -		lm8323_write_pwm_one(pwm, i++, PWM_END(1));
> +	for (i = 0; i < len; i++)
> +		lm8323_write_pwm_one(pwm, i, cmds[i]);
>  
> +	lm8323_write_pwm_one(pwm, i++, PWM_END(kill));
>  	lm8323_write(lm, 2, LM8323_CMD_START_PWM, pwm->id);
> +	pwm->running = 1;
>  }
>  
>  static void lm8323_pwm_work(struct work_struct *work)
>  {
>  	struct lm8323_pwm *pwm = work_to_pwm(work);
> -	int div, perstep, steps, hz, direction, keepalive;
> +	int div512, perstep, steps, hz, up, kill;
> +	u16 pwm_cmds[3];
> +	int num_cmds = 0;
> +
> +	mutex_lock(&pwm->lock);
>  
> -	/* Do nothing if we're already at the requested level. */
> -	if (pwm->desired_brightness == pwm->brightness)
> +	/*
> +	 * Do nothing if we're already at the requested level,
> +	 * or previous setting is not yet complete. In the latter
> +	 * case we will be called again when the previous PWM script
> +	 * finishes.
> +	 */
> +	if (pwm->running || pwm->desired_brightness == pwm->brightness) {
> +		mutex_unlock(&pwm->lock);
>  		return;
> +	}
>  
> -	keepalive = (pwm->desired_brightness > 0);
> -	direction = (pwm->desired_brightness > pwm->brightness);
> +	kill = (pwm->desired_brightness == 0);
> +	up = (pwm->desired_brightness > pwm->brightness);
>  	steps = abs(pwm->desired_brightness - pwm->brightness);
>  
>  	/*
>  	 * Convert time (in ms) into a divisor (512 or 16 on a refclk of
>  	 * 32768Hz), and number of ticks per step.
>  	 */
> -	if ((pwm->fade_time / steps) > (32768 / 512))
> -		div = 512;
> -	else
> -		div = 16;
> +	if ((pwm->fade_time / steps) > (32768 / 512)) {
> +		div512 = 1;
> +		hz = 32768 / 512;
> +	}
> +	else {
> +		div512 = 0;
> +		hz = 32768 / 16;
> +	}
>  
> -	hz = 32768 / div;
> -	if (pwm->fade_time < ((steps * 1000) / hz))
> -		perstep = 1;
> -	else
> -		perstep = (hz * pwm->fade_time) / (steps * 1000);
> +	perstep = (hz * pwm->fade_time) / (steps * 1000);
>  
>  	if (perstep == 0)
>  		perstep = 1;
>  	else if (perstep > 63)
>  		perstep = 63;
>  
> -	if (steps > 252) {
> -		lm8323_write_pwm(pwm, keepalive, 3,
> -				 PWM_RAMP((div == 512), perstep, 126,
> -					  direction),
> -				 PWM_RAMP((div == 512), perstep, 126,
> -					  direction),
> -				 PWM_RAMP((div == 512), perstep, steps - 252,
> -					  direction));
> -	} else if (steps > 126) {
> -		lm8323_write_pwm(pwm, keepalive, 2,
> -				 PWM_RAMP((div == 512), perstep, 126,
> -					  direction),
> -				 PWM_RAMP((div == 512), perstep, steps - 126,
> -					  direction));
> -	} else {
> -		lm8323_write_pwm(pwm, keepalive, 1,
> -				 PWM_RAMP((div == 512), perstep, steps,
> -					  direction));
> +	while (steps) {
> +		int s;
> +
> +		s = min(126, steps);
> +		pwm_cmds[num_cmds++] = PWM_RAMP(div512, perstep, s, up);
> +		steps -= s;
>  	}
>  
> +	lm8323_write_pwm(pwm, kill, num_cmds, pwm_cmds);
> +
>  	pwm->brightness = pwm->desired_brightness;
> +	mutex_unlock(&pwm->lock);
>  }
>  
>  static void lm8323_pwm_set_brightness(struct led_classdev *led_cdev,
> @@ -552,7 +557,9 @@ static void lm8323_pwm_set_brightness(struct led_classdev *led_cdev,
>  	struct lm8323_pwm *pwm = cdev_to_pwm(led_cdev);
>  	struct lm8323_chip *lm = pwm_to_lm8323(pwm);
>  
> +	mutex_lock(&pwm->lock);
>  	pwm->desired_brightness = brightness;
> +	mutex_unlock(&pwm->lock);
>  
>  	if (in_interrupt()) {
>  		schedule_work(&pwm->work);
> @@ -620,6 +627,8 @@ static int init_pwm(struct lm8323_chip *lm, int id, struct device *dev,
>  	pwm->fade_time = 0;
>  	pwm->brightness = 0;
>  	pwm->desired_brightness = 0;
> +	pwm->running = 0;
> +	mutex_init(&pwm->lock);
>  	if (name) {
>  		pwm->cdev.name = name;
>  		pwm->cdev.brightness_set = lm8323_pwm_set_brightness;
> @@ -917,7 +926,7 @@ static void __exit lm8323_exit(void)
>  	i2c_del_driver(&lm8323_i2c_driver);
>  }
>  
> -MODULE_AUTHOR("Daniel Stone");
> +MODULE_AUTHOR("Timo O. Karjalainen <timo.o.karjalainen@nokia.com>, Daniel Stone");
>  MODULE_DESCRIPTION("LM8323 keypad driver");
>  MODULE_LICENSE("GPL");
>  
> -- 
> 1.6.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
