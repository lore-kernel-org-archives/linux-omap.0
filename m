From: Kevin Hilman <khilman@ti.com>
Subject: Re: context_loss_count error value
Date: Wed, 25 May 2011 11:34:33 -0700
Message-ID: <87ipsyvdc6.fsf@ti.com>
References: <1305704452.1834.12.camel@deskari> <87k4douvsd.fsf@ti.com>
	<1305718422.1834.23.camel@deskari> <877h9ot7c3.fsf@ti.com>
	<1305729690.30372.7.camel@deskari> <1306252069.2194.28.camel@deskari>
	<87lixv1x3s.fsf@ti.com> <1306312262.2062.16.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33831 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752184Ab1EYSek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 14:34:40 -0400
Received: by iye7 with SMTP id 7so9129849iye.34
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 11:34:36 -0700 (PDT)
In-Reply-To: <1306312262.2062.16.camel@deskari> (Tomi Valkeinen's message of
	"Wed, 25 May 2011 11:31:02 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

[...]

>> 
>> You're right, the code is just wrong here and would lead to strange
>> return value checking in the callers to be correct.
>> 
>> I think the best fix for this problem is to use a signed return value
>> which can wrap as expected, and then use return negative error codes
>> (e.g. -ENODEV).
>> 
>> Care to send a patch?  or do you have any other suggestions for a fix?
>
> Here's a patch. 

Thanks!

> I'm not quite sure in what situations the functions should return an
> error, but the code now returns -ENODEV if:
>
> - device pointer given by the driver to
> omap_pm_get_dev_context_loss_count() is NULL
>
> - pwrdomain pointer given to pwrdm_get_context_loss_count() is NULL,
> which should never happen, as the caller of that function already checks
> the pwrdomain pointer

Looks right.

Some comments below about wrapping.  Looks like your doing wrapping
manually?  Why is that necessary?

>  Tomi
>
>
> From 11ce3b3bd1f5aac44aae7ab05725d77bc9ca3b42 Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Wed, 25 May 2011 11:06:41 +0300
> Subject: [PATCH] OMAP: change get_context_loss_count ret value to int
>
> get_context_loss_count functions return context loss count as u32, and
> zero means an error. However, zero is also returned when context has
> never been lost and could also be returned when the context loss count
> has wrapped and goes to zero.
>
> Change the functions to return an int, with negative value meaning an
> error.
>
> OMAP HSMMC code uses omap_pm_get_dev_context_loss_count(), but as the
> hsmmc code handles the returned value as an int, with negative value
> meaning an error, this patch actually fixes hsmmc code also.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

[...]

> @@ -953,7 +953,9 @@ u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm)
>  	for (i = 0; i < pwrdm->banks; i++)
>  		count += pwrdm->ret_mem_off_counter[i];
>  
> -	pr_debug("powerdomain: %s: context loss count = %u\n",
> +	count &= 0x7fffffff;

What's this for?

> +	pr_debug("powerdomain: %s: context loss count = %d\n",
>  		 pwrdm->name, count);
>  
>  	return count;

[...]

> @@ -311,22 +311,26 @@ void omap_pm_disable_off_mode(void)
>  
>  #ifdef CONFIG_ARCH_OMAP2PLUS
>  
> -u32 omap_pm_get_dev_context_loss_count(struct device *dev)
> +int omap_pm_get_dev_context_loss_count(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> -	u32 count;
> +	int count;
>  
>  	if (WARN_ON(!dev))
> -		return 0;
> +		return -ENODEV;
>  
>  	if (dev->parent == &omap_device_parent) {
>  		count = omap_device_get_context_loss_count(pdev);
>  	} else {
>  		WARN_ONCE(off_mode_enabled, "omap_pm: using dummy context loss counter; device %s should be converted to omap_device",
>  			  dev_name(dev));
> -		if (off_mode_enabled)
> -			dummy_context_loss_counter++;
> +
>  		count = dummy_context_loss_counter;
> +
> +		if (off_mode_enabled) {
> +			count = (count + 1) & 0x7fffffff;
> +			dummy_context_loss_counter = count;
> +		}

Again, I don't think this masking is needed.   count is already an
'int', so when it gets bigger than INT_MAX, it will wrap.

Kevin
