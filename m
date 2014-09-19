From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 3/3] mfd: palmas: Add support for optional wakeup
Date: Thu, 18 Sep 2014 17:57:33 -0700 (PDT)
Message-ID: <alpine.DEB.2.10.1409181749170.4206@nanos>
References: <1411067086-16613-1-git-send-email-nm@ti.com> <1411067086-16613-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57160 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbaISA5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2014 20:57:45 -0400
In-Reply-To: <1411067086-16613-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: lee.jones@linaro.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Keerthy <j-keerthy@ti.com>, Mark Brown <broonie@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org

On Thu, 18 Sep 2014, Nishanth Menon wrote:
> +static irqreturn_t palmas_wake_irq(int irq, void *_palmas)
> +{
> +	/*
> +	 * Return Not handled so that interrupt is disabled.

And how is that interrupt disabled by returning IRQ_NONE? You mean it
gets disabled after it got reraised 100000 times and the spurious
detector kills it?

> +	 * Level event ensures that the event is eventually handled
> +	 * by the appropriate chip handler already registered

Eventually handled? So eventually it's not handled?

> +	 */
> +	return IRQ_NONE;
> +}
> +
>  int palmas_ext_control_req_config(struct palmas *palmas,
>  	enum palmas_external_requestor_id id,  int ext_ctrl, bool enable)
>  {
> @@ -409,6 +420,7 @@ static void palmas_dt_to_pdata(struct i2c_client *i2c,
>  		pdata->mux_from_pdata = 1;
>  		pdata->pad2 = prop;
>  	}
> +	pdata->wakeirq = irq_of_parse_and_map(node, 1);
>  
>  	/* The default for this register is all masked */
>  	ret = of_property_read_u32(node, "ti,power-ctrl", &prop);
> @@ -521,6 +533,7 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  	i2c_set_clientdata(i2c, palmas);
>  	palmas->dev = &i2c->dev;
>  	palmas->irq = i2c->irq;
> +	palmas->wakeirq = pdata->wakeirq;
>  
>  	match = of_match_device(of_palmas_match_tbl, &i2c->dev);
>  
> @@ -587,6 +600,25 @@ static int palmas_i2c_probe(struct i2c_client *i2c,
>  	if (ret < 0)
>  		goto err_i2c;
>  
> +	if (!palmas->wakeirq)
> +		goto no_wake_irq;
> +
> +	ret = devm_request_irq(palmas->dev, palmas->wakeirq,
> +			       palmas_wake_irq,
> +			       pdata->irq_flags,
> +			       dev_name(palmas->dev),
> +			       &palmas);
> +	if (ret < 0) {
> +		dev_err(palmas->dev, "Invalid wakeirq(%d) (res: %d), skiping\n",
> +			palmas->wakeirq, ret);
> +		palmas->wakeirq = 0;
> +	} else {
> +		/* We use wakeirq only during suspend-resume path */
> +		device_set_wakeup_capable(palmas->dev, true);
> +		disable_irq_nosync(palmas->wakeirq);

Urgh. Why nosysnc? And why do you want to do that at all?

	irq_set_status_flags(irq, IRQ_NOAUTOEN);

Is what you want to set before requesting the irq.


> +	}
> +
> +no_wake_irq:
>  no_irq:
>  	slave = PALMAS_BASE_TO_SLAVE(PALMAS_PU_PD_OD_BASE);
>  	addr = PALMAS_BASE_TO_REG(PALMAS_PU_PD_OD_BASE,
> @@ -706,6 +738,34 @@ static int palmas_i2c_remove(struct i2c_client *i2c)
>  	return 0;
>  }
>  
> +static int palmas_i2c_suspend(struct i2c_client *i2c,  pm_message_t mesg)
> +{
> +	struct palmas *palmas = i2c_get_clientdata(i2c);
> +	struct device *dev = &i2c->dev;
> +
> +	if (!palmas->wakeirq)
> +		return 0;
> +
> +	if (device_may_wakeup(dev))
> +		enable_irq(palmas->wakeirq);
> +
> +	return 0;
> +}
> +
> +static int palmas_i2c_resume(struct i2c_client *i2c)
> +{
> +	struct palmas *palmas = i2c_get_clientdata(i2c);
> +	struct device *dev = &i2c->dev;
> +
> +	if (!palmas->wakeirq)
> +		return 0;
> +
> +	if (device_may_wakeup(dev))
> +		disable_irq_nosync(palmas->wakeirq);

Again, why nosync?
