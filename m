From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Thu, 10 Mar 2011 15:14:01 -0800
Message-ID: <87oc5ifu12.fsf@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
	<1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:58523 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751272Ab1CJXOF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 18:14:05 -0500
Received: by mail-gw0-f43.google.com with SMTP id 21so895514gwj.2
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 15:14:04 -0800 (PST)
In-Reply-To: <1299627948-20040-5-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 9 Mar 2011 05:15:43 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Add routines to converts dmtimers to platform devices. The device data
> is obtained from hwmod database of respective platform and is registered
> to device model after successful binding to driver. It also provides
> provision to access timers during early boot when pm_runtime framework
> is not completely up and running.
>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Acked-by: Cousson, Benoit <b-cousson@ti.com>

[...]

> +/**
> + * omap_timer_init - build and register timer device with an
> + * associated timer hwmod
> + * @oh:	timer hwmod pointer to be used to build timer device
> + * @user:	parameter that can be passed from calling hwmod API
> + *
> + * Called by omap_hwmod_for_each_by_class to register each of the timer
> + * devices present in the system. The number of timer devices is known
> + * by parsing through the hwmod database for a given class name. At the
> + * end of function call memory is allocated for timer device and it is
> + * registered to the framework ready to be proved by the driver.
> + */
> +static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
> +{
> +	int id;
> +	int ret = 0;
> +	char *name = "omap_timer";
> +	struct dmtimer_platform_data *pdata;
> +	struct omap_device *od;
> +	struct omap_secure_timer_dev_attr *secure_timer_dev_attr;
> +
> +	/*
> +	 * Extract the IDs from name field in hwmod database
> +	 * and use the same for constructing ids' for the
> +	 * timer devices. In a way, we are avoiding usage of
> +	 * static variable witin the function to do the same.
> +	 * CAUTION: We have to be careful and make sure the
> +	 * name in hwmod database does not change in which case
> +	 * we might either make corresponding change here or
> +	 * switch back static variable mechanism.
> +	 */
> +	sscanf(oh->name, "timer%2d", &id);
> +	if (unlikely(id == system_timer_id))
> +		return ret;

As mentioned already, this check belongs in the patch where the
system_timer is setup.

In addition, I'm not sure this is completely right.

With this check, the system timer will never be converted from an early
device to a real platform_device.   As a result, runtime PM will never
be enabled for this device.

I guess Tony has the final say here, but personally, I don't really like
the special treatment of a system timer, unless it is an init-time only
special treatment.  Since we now have dynamically configurable
clocksources, the concept of a system timer doesn't really exist (except
for in early boot.)  At any time during runtime, we could dynamically
switch the clocksource to a different timer device.  At this point, one
would expect runtime PM for the previous timer to kick in and idle the
timer.  That cannot happen with this approach.

Kevin



