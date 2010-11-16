From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] Add OMAP Support for Generic PWM Devices using
 Dual-mode Timers
Date: Wed, 17 Nov 2010 00:24:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930247387A4A@dbde02.ent.ti.com>
References: <1289762929-7682-1-git-send-email-marathon96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43752 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757027Ab0KPSyt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 13:54:49 -0500
In-Reply-To: <1289762929-7682-1-git-send-email-marathon96@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Grant Erickson
> Sent: Monday, November 15, 2010 12:59 AM
> To: linux-omap@vger.kernel.org
> Cc: Tony Lindgren
> Subject: [PATCH] Add OMAP Support for Generic PWM Devices 
> using Dual-mode Timers
> 
> This patch adds support to request and use one or more of the OMAP
> dual-mode timers as a generic PWM device compatible with other generic
> PWM drivers such as the PWM backlight or PWM beeper driver.
> 
> Boards can register such devices using platform data such as 
> in the following
> example:
> 
> 	static struct omap2_pwm_platform_config pwm_config = {
> 	    .timer_id           = 10,   // GPT10_PWM_EVT
> 	    .polarity           = 1     // Active-high
> 	};
> 
> 	static struct platform_device pwm_device = {
> 	    .name               = "omap-pwm",
> 	    .id                 = 0,
> 	    .dev                = {
> 	        .platform_data  = &pwm_config
> 	    }
> 	};
> 
> Signed-off-by: Grant Erickson <marathon96@gmail.com>

[snip]...[snip]

[sp] Few additional comments that should be considered while submitting
     next patch revision.

> +/* Preprocessor Definitions */
> +
> +#undef OMAP_PWM_DEBUG
> +
> +#if defined(OMAP_PWM_DEBUG)
> +#define DBG(args...)			\
> +	do {						\
> +		pr_info(args);			\
> +	} while (0)
> +#define DEV_DBG(dev, args...)	\
> +	do {						\
> +		dev_info(dev, args);	\
> +	} while (0)
> +#else
> +#define DBG(args...)			\
> +	do { } while (0)
> +#define DEV_DBG(dev, args...)	\
> +	do { } while (0)
> +#endif /* defined(OMAP_PWM_DEBUG) */

[sp] pr_info(), dev_info() are already macros - conditional to DEBUG.
     We should use them instead of defining another layer.

> +
> +#define DM_TIMER_LOAD_MIN		0xFFFFFFFE
> +
> +/* Type Definitions */
> +
> +/**
> + * struct pwm_device - opaque internal PWM device instance state
> + * @head: list head for all PWMs managed by this driver.
> + * @pdev: corresponding platform device associated with this 
> device instance.
> + * @dm_timer: corresponding dual-mode timer associated with 
> this device
> + *  instance.
> + * @config: platform-specific configuration data.
> + * @label: description label.
> + * @use_count: use count.
> + * @pwm_id: generic PWM ID requested for this device instance.
> + *
> + * As far as clients of the PWM driver are concerned, PWM devices are
> + * opaque abstract objects. Consequently, this structure is used for
> + * tracking internal device instance state but is otherwise just a
> + * instance reference externally.
> + */
> +
> +struct pwm_device {
> +	struct list_head				   head;
> +	struct platform_device			  *pdev;
> +	struct omap_dm_timer			  *dm_timer;
> +	struct omap2_pwm_platform_config   config;
> +	const char						
>   *label;
> +	unsigned int					   use_count;
> +	unsigned int					   pwm_id;
> +};

[sp] This block has mix of tabs and white spaces. We should be consistent.
     There are similar instances below as well...

     You may also want to line up the field names - they start at different columns.

> +
> +/* Function Prototypes */
> +
> +static int __devinit omap_pwm_probe(struct platform_device *pdev);
> +static int __devexit omap_pwm_remove(struct platform_device *pdev);
> +
> +/* Global Variables */
> +
> +static struct platform_driver omap_pwm_driver = {
> +	.driver		= {
> +		.name	= "omap-pwm",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= omap_pwm_probe,
> +	.remove		= __devexit_p(omap_pwm_remove)
> +};
> +
> +/* List and associated lock for managing generic PWM devices bound to
> + * this driver.
> + */
> +
[sp] White space not needed. Similar instances below as well.

> +static DEFINE_MUTEX(pwm_lock);
> +static LIST_HEAD(pwm_list);
> +

[snip]...[snip]

> +/**
> + * pwm_config - configures the generic PWM device to the 
> specified parameters.
> + * @pwm: A pointer to the PWM device to configure.
> + * @duty_ns: The duty period of the PWM, in nanoseconds.
> + * @period_ns: The overall period of the PWM, in nanoseconds.
> + *
> + * Returns 0 if the generic PWM device was successfully configured;
> + * otherwise, < 0 on error.
> + */
> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> +{
> +	int status = 0;
> +	const bool enable = true;
> +	const bool autoreload = true;
> +	const bool toggle = true;
> +	const int trigger = OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE;

[sp] Based on code abobe, I believe that OMAP...COMPARE is macro;
     shouldn't we use it as is - where trigger is used in code below?

> +	int load_value, match_value;
> +	unsigned long clk_rate;
> +
> +	DEV_DBG(&pwm->pdev->dev,
> +			"duty cycle: %d, period %d\n",
> +			duty_ns, period_ns);
> +
> +	clk_rate = clk_get_rate(omap_dm_timer_get_fclk(pwm->dm_timer));
> +
> +	/* Calculate the appropriate load and match values based on the
> +	 * specified period and duty cycle. The load value determines the
> +	 * cycle time and the match value determines the duty cycle.
> +	 */
> +
> +	load_value = pwm_calc_value(clk_rate, period_ns);
> +	match_value = pwm_calc_value(clk_rate, period_ns - duty_ns);
> +
> +	/* We MUST enable yet stop the associated dual-mode timer before
> +	 * attempting to write its registers.
> +	 */
> +
> +	omap_dm_timer_enable(pwm->dm_timer);
> +	omap_dm_timer_stop(pwm->dm_timer);
> +
> +	omap_dm_timer_set_load(pwm->dm_timer, autoreload, load_value);
> +	omap_dm_timer_set_match(pwm->dm_timer, enable, match_value);
> +
> +	DEV_DBG(&pwm->pdev->dev,
> +			"load value: %#08x (%d), "
> +			"match value: %#08x (%d)\n",
> +			load_value, load_value,
> +			match_value, match_value);
> +
> +	omap_dm_timer_set_pwm(pwm->dm_timer,
> +						  !pwm->config.polarity,
> +						  toggle,
> +						  trigger);
> +
> +	/* Set the counter to generate an overflow event immediately. */
> +
> +	omap_dm_timer_write_counter(pwm->dm_timer, DM_TIMER_LOAD_MIN);

[sp] I am assuming that call to this function would be followed by
     another call to pwm_enable().

     omap_dm_timer_write_counter() is being called in pwm_enable()
     with exactly same arguments. Is is necessary duplication?
     If no, call here should be removed.

> +
> +	/* Now that we're done configuring the dual-mode timer, disable it
> +	 * again. We'll enable and start it later, when requested.
> +	 */
> +
> +	omap_dm_timer_disable(pwm->dm_timer);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(pwm_config);
> +
> +/**
> + * pwm_enable - enable the generic PWM device.
> + * @pwm: A pointer to the generic PWM device to enable.
> + *
> + * Returns 0 if the generic PWM device was successfully enabled;
> + * otherwise, < 0 on error.
> + */
> +int pwm_enable(struct pwm_device *pwm)
> +{
> +	int status = 0;

[sp] This variable isn't assigned/modified below. Not required.
     function can simply return 0.

> +
> +	/* Enable the counter--always--before attempting to write its
> +	 * registers and then set the timer to its minimum load value to
> +	 * ensure we get an overflow event right away once we start it.
> +	 */
> +
> +	omap_dm_timer_enable(pwm->dm_timer);
> +	omap_dm_timer_write_counter(pwm->dm_timer, DM_TIMER_LOAD_MIN);
> +	omap_dm_timer_start(pwm->dm_timer);
> +
> +	return status;
> +}
> +EXPORT_SYMBOL(pwm_enable);
> +
> +/**
> + * pwm_disable - disable the generic PWM device.
> + * @pwm: A pointer to the generic PWM device to disable.
> + */
> +void pwm_disable(struct pwm_device *pwm)
> +{
> +	omap_dm_timer_enable(pwm->dm_timer);
> +	omap_dm_timer_stop(pwm->dm_timer);
> +	omap_dm_timer_disable(pwm->dm_timer);
> +}
> +EXPORT_SYMBOL(pwm_disable);
> +
> +/**
> + * omap_pwm_probe - check for the PWM and bind it to the driver.
> + * @pdev: A pointer to the platform device node associated with the
> + *        PWM instance to be probed for driver binding.
> + *
> + * Returns 0 if the PWM instance was successfully bound to 
> the driver;
> + * otherwise, < 0 on error.
> + */
> +static int __devinit omap_pwm_probe(struct platform_device *pdev)
> +{
> +	struct pwm_device *pwm = NULL;
> +	struct omap2_pwm_platform_config *pdata = NULL;
> +	int status = 0;
> +
> +	pdata = ((struct omap2_pwm_platform_config 
> *)(pdev->dev.platform_data));
> +
> +	BUG_ON(pdata == NULL);
> +
> +	if (pdata == NULL) {
> +		dev_err(&pdev->dev, "Could not find required 
> platform data.\n");
> +		status = -ENOENT;
> +		goto done;

[sp] We can simply return status from here. goto and label can be avoided.

> +	}
> +
> +	/* Allocate memory for the driver-private PWM data and state */
> +
> +	pwm = kzalloc(sizeof(struct pwm_device), GFP_KERNEL);
> +
> +	if (pwm == NULL) {
> +		dev_err(&pdev->dev, "Could not allocate memory.\n");
> +		status = -ENOMEM;
> +		goto done;

[sp] We can simply return status from here. goto and label can be avoided.

> +	}
> +
> +	/* Request the OMAP dual-mode timer that will be bound to and
> +	 * associated with this generic PWM.
> +	 */
> +
> +	pwm->dm_timer = omap_dm_timer_request_specific(pdata->timer_id);
> +
> +	if (pwm->dm_timer == NULL) {
> +		status = -ENOENT;
> +		goto err_free;
> +	}
> +
> +	/* Configure the source for the dual-mode timer backing this
> +	 * generic PWM device. The clock source will ultimately 
> determine
> +	 * how small or large the PWM frequency can be.
> +	 *
> +	 * At some point, it's probably worth revisiting moving this to
> +	 * the configure method and choosing either the slow- or
> +	 * system-clock source as appropriate for the desired 
> PWM period.
> +	 */
> +
> +	omap_dm_timer_set_source(pwm->dm_timer, OMAP_TIMER_SRC_SYS_CLK);
> +
> +	/* Cache away other miscellaneous driver-private data and state
> +	 * information and add the driver-private data to the platform
> +	 * device.
> +	 */
> +
> +	pwm->pdev = pdev;
> +	pwm->pwm_id = pdev->id;
> +	pwm->config = *pdata;
> +
> +	platform_set_drvdata(pdev, pwm);
> +
> +	/* Finally, push the added generic PWM device to the end of the
> +	 * list of available generic PWM devices.
> +	 */
> +
> +	mutex_lock(&pwm_lock);
> +	list_add_tail(&pwm->head, &pwm_list);
> +	mutex_unlock(&pwm_lock);
> +
> +	status = 0;
> +	goto done;
> +
> + err_free:
> +	kfree(pwm);
> +
> + done:
> +	return status;
> +}
> +
> +/**
> + * omap_pwm_remove - unbind the specified PWM platform 
> device from the driver.
> + * @pdev: A pointer to the platform device node associated with the
> + *        PWM instance to be unbound/removed.
> + *
> + * Returns 0 if the PWM was successfully removed as a 
> platform device;
> + * otherwise, < 0 on error.
> + */
> +static int __devexit omap_pwm_remove(struct platform_device *pdev)
> +{
> +	struct pwm_device *pwm = NULL;
> +	int status = 0;
> +
> +	/* Attempt to get the driver-private data from the 
> platform device
> +	 * node.
> +	 */
> +
> +	pwm = platform_get_drvdata(pdev);
> +
> +	if (pwm == NULL) {
> +		status = -ENODEV;
> +		goto done;

[sp] We can simply return status from here. goto and label can be avoided.

> +	}
> +
> +	/* Remove the generic PWM device from the list of available
> +	 * generic PWM devices.
> +	 */
> +
> +	mutex_lock(&pwm_lock);
> +	list_del(&pwm->head);
> +	mutex_unlock(&pwm_lock);
> +
> +	/* Unbind the OMAP dual-mode timer associated with the 
> generic PWM
> +	 * device.
> +	 */
> +
> +	omap_dm_timer_free(pwm->dm_timer);
> +
> +	/* Finally, release the memory associated with the 
> driver-private
> +	 * data and state.
> +	 */
> +
> +	kfree(pwm);
> +
> + done:
> +	return status;
> +}

[snip]...[snip]
