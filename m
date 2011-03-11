From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Fri, 11 Mar 2011 09:50:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A4DD948@dbde02.ent.ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
	<1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
 <87oc5ifu12.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58437 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab1CKEUV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 23:20:21 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2B4KHgW006244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 22:20:20 -0600
In-Reply-To: <87oc5ifu12.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, March 11, 2011 4:44 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > Add routines to converts dmtimers to platform devices. The device data
> > is obtained from hwmod database of respective platform and is registered
> > to device model after successful binding to driver. It also provides
> > provision to access timers during early boot when pm_runtime framework
> > is not completely up and running.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Acked-by: Cousson, Benoit <b-cousson@ti.com>
> 
> [...]
> 
> > +/**
> > + * omap_timer_init - build and register timer device with an
> > + * associated timer hwmod
> > + * @oh:	timer hwmod pointer to be used to build timer device
> > + * @user:	parameter that can be passed from calling hwmod API
> > + *
> > + * Called by omap_hwmod_for_each_by_class to register each of the timer
> > + * devices present in the system. The number of timer devices is known
> > + * by parsing through the hwmod database for a given class name. At the
> > + * end of function call memory is allocated for timer device and it is
> > + * registered to the framework ready to be proved by the driver.
> > + */
> > +static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
> > +{
> > +	int id;
> > +	int ret = 0;
> > +	char *name = "omap_timer";
> > +	struct dmtimer_platform_data *pdata;
> > +	struct omap_device *od;
> > +	struct omap_secure_timer_dev_attr *secure_timer_dev_attr;
> > +
> > +	/*
> > +	 * Extract the IDs from name field in hwmod database
> > +	 * and use the same for constructing ids' for the
> > +	 * timer devices. In a way, we are avoiding usage of
> > +	 * static variable witin the function to do the same.
> > +	 * CAUTION: We have to be careful and make sure the
> > +	 * name in hwmod database does not change in which case
> > +	 * we might either make corresponding change here or
> > +	 * switch back static variable mechanism.
> > +	 */
> > +	sscanf(oh->name, "timer%2d", &id);
> > +	if (unlikely(id == system_timer_id))
> > +		return ret;
> 
> As mentioned already, this check belongs in the patch where the
> system_timer is setup.
Right, I will change.

> 
> In addition, I'm not sure this is completely right.
> 
> With this check, the system timer will never be converted from an early
> device to a real platform_device.   As a result, runtime PM will never
> be enabled for this device.
That's right.

> 
> I guess Tony has the final say here, but personally, I don't really like
> the special treatment of a system timer, unless it is an init-time only
> special treatment.  Since we now have dynamically configurable
> clocksources, the concept of a system timer doesn't really exist (except
> for in early boot.)  At any time during runtime, we could dynamically
> switch the clocksource to a different timer device.  At this point, one
> would expect runtime PM for the previous timer to kick in and idle the
> timer.  That cannot happen with this approach.
I am open to suggestions.

> 
> Kevin
> 
> 

