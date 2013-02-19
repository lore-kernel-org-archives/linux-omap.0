From: Kevin Hilman <khilman@linaro.org>
Subject: Re: OMAP reset requirements
Date: Tue, 19 Feb 2013 12:25:24 -0800
Message-ID: <87d2vwuk3v.fsf@linaro.org>
References: <20130214181217.GA11806@atomide.com>
	<20130214192719.GB26679@arwen.pp.htv.fi>
	<20130214193911.GD11806@atomide.com>
	<alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
	<20130214222247.GE11362@atomide.com>
	<alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
	<20130219163820.GF5724@atomide.com> <87ppzww1ux.fsf@linaro.org>
	<20130219193237.GA8978@arwen.pp.htv.fi> <8738wsw0aa.fsf@linaro.org>
	<20130219201012.GA10166@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:38537 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758807Ab3BSUZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Feb 2013 15:25:28 -0500
Received: by mail-pb0-f44.google.com with SMTP id wz12so2456090pbc.17
        for <linux-omap@vger.kernel.org>; Tue, 19 Feb 2013 12:25:27 -0800 (PST)
In-Reply-To: <20130219201012.GA10166@arwen.pp.htv.fi> (Felipe Balbi's message
	of "Tue, 19 Feb 2013 22:10:12 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Felipe Balbi <balbi@ti.com> writes:

> Hi,
>
> On Tue, Feb 19, 2013 at 11:50:37AM -0800, Kevin Hilman wrote:
>> >> The other problem is the where reset is need during runtime.  Again,
>> >> what are the specific examples here?  The one I can think of off the top
>> >> of my head is I2C, where it's needed in certain error recovery
>> >> scenarios.
>> >
>> > right, I still have a theory that it's not needed in that case either,
>> > though I haven't had time to try that out.
>> 
>> Great, I hope it's not needed.  I've asked several times in past as this
>> driver was converted to runtime PM, but was told it was required for
>> various reasons (which I can't remember anymore.)
>
> :-) just like I2C's revision register was broken and had no useful data
> or MUSB mode1 couldn't be made to work... right. Looking at the
> functional spec, there's no mention that we need to driver reset signal
> anywhere, we _do_ need to reinitialize the transfer-related registers
> (I2C_CON, I2C_CNT, I2C_SA), other than that, I can't think of a need for
> driving the reset signal.
>
> The bus specification isn't that stupid right ? Arbitration Lost and
> NACK are both expected bus conditions. My only concern is write
> underflow and read overflow, but I haven't been able to force that to
> happen yet. Even in those cases, I'd be very surprised if we really
> needed to driver the reset signal.

IIRC, it's definitely related to recovering from underflow/overflow.

>> >> Here, we need a way for the driver itself to initiate a full reset.
>> >> Maybe a new runtime PM hook like ->runtime_reset() as Felipe has
>> >> suggested (though I'm not yet sure runtime PM is the right place for
>> >> this, since it's not strictly related to runtime PM).  Or, if these are
>> >
>> > right, I agree with you but I couldn't think of a better place. Maybe we
>> > need a reset hook in struct device itself (as I suggested on another
>> > mail) but I'm not sure Greg would take it, unless we have a damn good
>> > reason.
>> 
>> I'm starting to think a ->hardreset() method in struct dev_pm_ops is the
>> place to put this.  
>> 
>> IMO, it needs to be in dev_pm_ops, so it can be selectively overridden
>> by PM domains.  On OMAP, we'd just hook it up to omap_device_shutdown()
>> for all omap_devices, and we'd be done.
>
> do you mean omap_device_shutdown(); omap_device_enable(); ?

Possibly, depending on the current state of the device.  That method
would have to be smart enough to know the current state of the device,
and return with it in the same state so as not to confuse runtime PM
usecounting.

>> >> one have the other use cases handy?
>> >
>> > dwc3 gets reset during probe() too, but that has an IP specific reset
>> > which doesn't need SYSCONFIG register for that.
>> 
>> OK, but that's still an init-time reset issue
>
> yeah, and this is pretty mandatory otherwise dwc3 and its PHYs (USB3
> pair plus USB2) won't synchronize and we'll have all sorts of issues :-)
>
>> Do you know of any other runtime reset cases?  If I2C is the only one,
>> then maybe seeing if it can be removed is the right first step.  If that
>> works, we don't need any of this.
>
> I don't know of any other, but there might be a few... On the other
> hand, I doubt there's any of them which is truly necessary, unless
> there's a bug in the IP which we can solve by issuing a reset, other
> than that, driving the reset signal shouldn't be necessary outside of
> probe() (or something before probe()).

If that's the case, then the approach should be to focus on sorting out
the drivers that actually need to reset outside of init/probe before
going and trying to extend the driver model.

Combined with solving the init/probe time reset using bus notifiers (for
devices with drivers) and late initcall for the rest should solve all
the problems, I think.  

Am I missing anything?

Kevin

