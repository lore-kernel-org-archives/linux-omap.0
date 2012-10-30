From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] gpio: omap-gpio: add support for pm_runtime autosuspend
Date: Tue, 30 Oct 2012 09:16:34 -0500
Message-ID: <508FE142.2020408@ti.com>
References: <20121026114250.GA26342@arwen.pp.htv.fi> <1351257553-7896-1-git-send-email-tim.niemeyer@corscience.de> <508E266C.6090901@ti.com> <20121029080523.GC13657@arwen.pp.htv.fi> <508E3D09.9090802@ti.com> <20121029200328.GE30152@arwen.pp.htv.fi> <508F7471.8060402@ti.com> <20121030070904.GB1978@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49195 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756127Ab2J3OQj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 10:16:39 -0400
In-Reply-To: <20121030070904.GB1978@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tim Niemeyer <tim.niemeyer@corscience.de>, Linux OMAP List <linux-omap@vger.kernel.org>

Hi Felipe,

On 10/30/2012 02:09 AM, Felipe Balbi wrote:

...

>> its bit of an issue to take care. How do you ensure that GPIO
>> does idle on SOC idle C-state attempts in such cases. Today that
>> job is done by omap_gpio_[prepare/resume]_for_idle.
> 
> that's only there because we pm_runtime_get_sync() on gpio_request() and
> pm_runtime_put_sync() only on gpio_free().
> 
> That's the problem IMHO. And that's easy enough to 'fix':
> 
> call pm_runtime_mark_last_busy(); pm_runtime_put_sync_autosuspend();
> also on gpio_request() and pm_runtime_get_sync() on gpio_free().

Sounds like a good approach. I have been discussing with Kevin and I
need to look more at the resume handler as we are working around some
old issues in there and with this approach the resume following idle
will be delayed and we were not sure if there could be any implications
for omap2. I am hoping not, but we need to look into this.

So I am wondering if we should just take Tim's original proposal for now
and then I will look into improving this long term. I really need to
clean-up the suspend/resume stuff for gpio and so may be we can make
that a separate change. What do you think?

...

> The difficult part, IMHO, is to figure out what's a good autosuspend
> timeout to use. Some GPIO lines are used as IRQ lines on some devices,
> that means that the GPIO will be periodically triggered and, depending
> on our timeout, we will either loose IRQs or prevent power domain from
> idling. We could figure out a way to let board code to choose what it
> wants on a per-bank basis (maybe some extra DT attribute).

I have also been bending Kevin's ear on this, this week and we were
wondering if we should make the default 0 for now as this will have the
same behaviour that we have today but would allow Tim to customise via
the sysfs for his specific app.

Cheers
Jon
