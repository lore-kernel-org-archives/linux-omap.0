From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Tue, 19 Feb 2013 11:50:37 -0800
Message-ID: <8738wsw0aa.fsf@linaro.org>
References: <20130214171253.GC7144@atomide.com>
	<20130214175650.GA25891@arwen.pp.htv.fi>
	<20130214181217.GA11806@atomide.com>
	<20130214192719.GB26679@arwen.pp.htv.fi>
	<20130214193911.GD11806@atomide.com>
	<alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
	<20130214222247.GE11362@atomide.com>
	<alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
	<20130219163820.GF5724@atomide.com> <87ppzww1ux.fsf@linaro.org>
	<20130219193237.GA8978@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:44047 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933352Ab3BSTun (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 14:50:43 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so3111153dan.37
        for <linux-omap@vger.kernel.org>; Tue, 19 Feb 2013 11:50:42 -0800 (PST)
In-Reply-To: <20130219193237.GA8978@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Tue, 19 Feb 2013 21:32:37 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Tue, Feb 19, 2013 at 11:16:38AM -0800, Kevin Hilman wrote:
>
> [ ... ]
>
>> The other problem is the where reset is need during runtime.  Again,
>> what are the specific examples here?  The one I can think of off the top
>> of my head is I2C, where it's needed in certain error recovery
>> scenarios.
>
> right, I still have a theory that it's not needed in that case either,
> though I haven't had time to try that out.

Great, I hope it's not needed.  I've asked several times in past as this
driver was converted to runtime PM, but was told it was required for
various reasons (which I can't remember anymore.)

>> Here, we need a way for the driver itself to initiate a full reset.
>> Maybe a new runtime PM hook like ->runtime_reset() as Felipe has
>> suggested (though I'm not yet sure runtime PM is the right place for
>> this, since it's not strictly related to runtime PM).  Or, if these are
>
> right, I agree with you but I couldn't think of a better place. Maybe we
> need a reset hook in struct device itself (as I suggested on another
> mail) but I'm not sure Greg would take it, unless we have a damn good
> reason.

I'm starting to think a ->hardreset() method in struct dev_pm_ops is the
place to put this.  

IMO, it needs to be in dev_pm_ops, so it can be selectively overridden
by PM domains.  On OMAP, we'd just hook it up to omap_device_shutdown()
for all omap_devices, and we'd be done.

>> mostly corner-case, error recovery scenarios, maybe a a way force the
>> driver to remove itself and re-probe (which would trigger the
>> bus-notifier based reset) as Tony has suggested is the better approach.
>
> I don't think so. We certainly don't need to go through all memory
> allocations again. That will just cause unnecessary memory
> fragmentation.
>
>> The OMAP I2C driver is doing a reset and fully re-initializing itself,
>> so it seems the forced remove/probe is the right approach there.  Any
>
> I must disagree here. Doing a reprobe of I2C every time there's an error
> condition is overkill. It means freeing struct omap_i2c_dev, freeing its
> IRQ, freeing the ioremapped area, changing mux configuration (due to
> pinctrl calls) just to do it all over again. Besides omap_i2c_probe()
> calls omap_i2c_init() which will do the full IP reset anyway.
>
> The difference is that calling omap_i2c_init() directly doesn't force us
> to free and reallocate all resources all over again.

I agree, that would be a lot of churn.

>> one have the other use cases handy?
>
> dwc3 gets reset during probe() too, but that has an IP specific reset
> which doesn't need SYSCONFIG register for that.

OK, but that's still an init-time reset issue

Do you know of any other runtime reset cases?  If I2C is the only one,
then maybe seeing if it can be removed is the right first step.  If that
works, we don't need any of this.

Kevin

