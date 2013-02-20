From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [RFC v2 16/18] ARM: OMAP2+: AM33XX: Basic suspend resume support
Date: Wed, 20 Feb 2013 09:21:41 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED2C85F@DBDE01.ent.ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
	<1356959231-17335-17-git-send-email-vaibhav.bedia@ti.com>
	<87k3qewcbt.fsf@linaro.org>
	<B5906170F1614E41A8A28DE3B8D121433ED1D197@DBDE01.ent.ti.com>
 <87lialzjne.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33555 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527Ab3BTJVv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 04:21:51 -0500
In-Reply-To: <87lialzjne.fsf@linaro.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

On Mon, Feb 18, 2013 at 21:41:49, Kevin Hilman wrote:
[...]
> > By default these IPs don't have MSTANDBY asserted.
> 
> When you say "by default", I guess you mean after reset (and/or context
> loss), right?
> 

Yes
> > When a low power transition happens, the peripheral power domain loses
> > context and hence the forced MSTANDBY configuration in the IP is
> > lost. To work around this problem we need to assert MSTANDBY in every
> > suspend-resume iteration.
> 
> Yuck.  More clever hardware.  ;)

We are getting this gradually :)

> 
> > I agree that this might hide PM bugs in the driver but to solve this problem we
> > need some mechanism for the PM code to know whether or not a driver is bound
> > to the corresponding platform devices. Any suggestions on this?
> 
> Driver bound status can be tracked easily using bus notifiers.  You can
> see an example in the omap_device core.

Ok. I'll try to use the driver bound status in the next version.

[...]

> >> > +	/*
> >> > +	 * GFX_L4LS clock domain needs to be woken up to
> >> > +	 * ensure thet L4LS clock domain does not get stuck in transition
> >> > +	 * If that happens L3 module does not get disabled, thereby leading
> >> > +	 * to PER power domain transition failing
> >> > +	 *
> >> > +	 * The clock framework should take care of ensuring
> >> > +	 * that the clock domain is in the right state when
> >> > +	 * GFX driver is active.
> >> 
> >> Are you suggesting that the clock framework is not doing this already?
> >> 
> >
> > No. This clkdm_*() calls are here to work-around an issue that I observed
> > when implementing suspend-resume. The force wakeup and sleep of the gfx_l4ls
> > clock domain across every suspend-resume is something I don't think can
> > be pushed to the clock framework.
> 
> I still don't follow what you're suggesting the clock framework "should"
> do.  Are you describing the case when there is a GFX driver vs. when
> there isn't a driver?  If so, it needs to be more clear.
>

No. The issue with GFX_L4LS happens irrespective of the state of the GFX driver and
needs to be handled in the suspend-resume sequence. I guess the second part of
comment is what created the confusion. I'll get rid of that.
 
> Also, some more description about why the device gets 'stuck in
> transition' would be helpful.  Is this an erratum workaround?
> 

I'll follow up with the design folks to find out more. From some past discussions
this is not expected so looks like we need to an erratum published for this issue.

> 
> I see, then probably a TODO here with more description would be more
> helpful. 
> 
> So, IIUC, without implemeting this, the drivers will never be able to
> detect loss of context, correct?  Sounds like something that should be
> decribed in the changelog as that's a rather important limitation to
> this implementaion.
> 

Ok. I'll address this limitation in the next version and improve the changelog.

> >> > +
> >> > +	/* Give some time to M3 to respond. 500msec is a random value here */
> >> 
> >> random?  really?
> >
> > Sort of. I don't have any numbers from the h/w guys on the worst
> > case delay in getting an interrupt from M3 to MPU. At the same time
> > I want to handle the scenario where something goes wrong on the M3
> > side and it doesn't respond.
> 
> OK, then it's not random.  You have some reasoning behind the number
> that should be documented.

Will do.

> 
> That being said, in the absence of numbers from HW folks, can't you
> measure the typical times so you know roughly what's "normal".  

I'll do some timer based profiling and get rough numbers for this.

[...]

> >> 
> >> Why not omap_device_enable(pdev) ?
> >> 
> >
> > The objective is to leverage the hwmod code to get the WKUP-M3
> > functional and not have OMAP runtime PM code coming in the way. 
> 
> FWIW, it is not runtime PM getting in the way.
> 
> > Using omap_device_enable() triggers the following dev_warn()
> > from omap_device_enable().
> 
> Looking closer at the trace, you'll see it's not omap_device_enable()
> that is triggering this warning.  What is happening is that omap_device
> has a late_initcall which forcibly idles omap_devices that have been
> enabled, but that don't have a driver.  You're hacking around that.
> 

Thanks for the explanation. I should have looked closer :(

> IMO, this would be a much cleaner implementation if you just created a
> small driver for the wkup_m3.  You're already doing a bunch of
> driver-like stuff for it (requesting base/IRQs, mapping regions,
> firmware, etc.)  I think this should separated out into a real driver.
> Then it will be bound to the right omap_device, and normal PM operations
> will work as expected.
> 
> Also, doing it this way will be more flexible for those wanting to use
> their own firmware on the M3, or customize the current firmware.

Hmm... that definitely sounds more flexible. It should also help in the next SoC
AM437x which has a similar PM architecture. Where would you suggest placing
this minimal driver?

Regards,
Vaibhav
