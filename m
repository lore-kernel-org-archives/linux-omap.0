From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: Issues with calling pm_runtime functions in
 platform_pm_suspend_noirq/IRQ disabled context.
Date: Fri, 6 Aug 2010 19:52:38 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E800BC1D@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED1089@dbde02.ent.ti.com>
	<874ofbppj4.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301E7F6ECA2@dbde02.ent.ti.com>
	<87tynaaw4r.fsf@deeprootsystems.com>	<87sk2u9fgp.fsf@deeprootsystems.com>
 <87sk2u7ynq.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40497 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703Ab0HFOWs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 10:22:48 -0400
In-Reply-To: <87sk2u7ynq.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kalliguddi, Hema" <hemahk@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, August 05, 2010 4:51 AM
> To: Basak, Partha
> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Kalliguddi, Hema; Raja,
> Govindraj; Varadarajan, Charulatha; Nayak, Rajendra; Cousson, Benoit
> Subject: Re: Issues with calling pm_runtime functions in
> platform_pm_suspend_noirq/IRQ disabled context.
> 
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> > Kevin Hilman <khilman@deeprootsystems.com> writes:
> >
> >> "Basak, Partha" <p-basak2@ti.com> writes:
> >>
> >>>> -----Original Message-----
> >>>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >>>> Sent: Tuesday, August 03, 2010 11:06 PM
> >>>> To: Basak, Partha
> >>>> Cc: Paul Walmsley; linux-omap@vger.kernel.org; Kalliguddi, Hema;
> Raja,
> >>>> Govindraj; Varadarajan, Charulatha; Nayak, Rajendra; Cousson, Benoit
> >>>> Subject: Re: Issues with calling pm_runtime functions in
> >>>> platform_pm_suspend_noirq/IRQ disabled context.
> >>>>
> >>>> "Basak, Partha" <p-basak2@ti.com> writes:
> >>>>
> >>>> > Resending with the corrected mailing list
> >>>> >
> >>>> > Hello Kevin,
> >>>> >
> >>>> > I want to draw your attention to an issue the following patch
> >>>> > introduces. http://dev.omapzoom.org/?p=swarch/linux-omap-
> >>>> adv.git;a=commitdiff;h=8041359e18e49bf8a3d41f15894db9e476f3a8fc
> >>>>
> >>>> [...]
> >>>>
> >>>> > I believe, it is not correct to call the pm_runtime APIs from
> >>>> > interrupt locked context since the underlying functions
> >>>> > __pm_runtime_suspend & __pm_runtime_resume enable interrupts and
> call
> >>>> > schedule().
> >>>> >
> >>>> > Further, from a s/w layering standpoint, platform-bus is a deeper
> >>>> > layer than the Runtime layer, which the runtime layer calls into.
> So
> >>>> > it may not be correct to have this layer calling into pm_runtime().
> It
> >>>> > should directly call omap_device APIs.
> >>>>
> >>>> The original version of this patch did directly call the omap_device
> >>>> APIs.  However, Paul didn't like that approach and there were
> >>>> use-counting problems to handle as well (e.g. if a driver was not
> (yet)
> >>>> in use, it would already be disabled, and a suspend would trigger an
> >>>> omap_device_disable() which would fail since device was already
> >>>> disabled.)
> >>>>
> >>>> Paul and I agreed that this current approach would solve the
> >>>> use-counting problems, but you're correct in that it introduces
> >>>> new problems as these functions can _possibly_ sleep/schedule.
> >>>>
> >>>> That being said, have you actually seen problems here?   I would like
> >>>> to see how they are triggered?
> >>>
> >>> Scenario 1:
> >>>
> >>> Consider the case where a driver has already called
> >>> pm_runtime_put_sync as part of aggressive clock cutting
> >>> scheme. Subsequently, when system suspend is called,
> >>> pm_runtime_put_sync is called again.
> >>
> >>> Due to atomic_dec_and_test check
> >>> on usage_count, the second call goes through w/o error.
> >>
> >> I don't think you're fully understanding the point of the put/get in
> the
> >> suspend/resume path.
> >>
> >> The reason for the 'put' in the suspend path is because the PM core has
> >> done a 'get' in dpm_prepare() [c.f. drivers/base/power/main.c] so that
> >> runtime PM transitions are prevented during suspend/resume.
> >>
> >> On OMAP, we want to allow those transitions to happen so we can use the
> >> same runtime PM calls in the idle and suspend paths.
> >>
> >>> At System resume, pm_runtime_get_sync is called twice, once by resume,
> >>> once by the driver itself.
> >>
> >> Yes, but there is a 'put_sync' in between those done by the PM core
> >> during resume (c.f. dpm_complete() in drivers/base/power/main.c]
> >>
> >>> Because of the extra reference count, the
> >>> aggressive clock control by the driver is broken, as call to put_sync
> >>> by a driver reduces to usage_count to 1. As a result clock transition
> >>> in Idle-path is broken.
> >
> > A closer look here, and there is indeed a bug in the _resume_noirq()
> > method.  The get here needs to be a _noresume version to match what is
> > done in the PM core.
> >
> > This doesn't change the use count, but it does change whether the device
> > is actually awoken by this 'get' or not.  This get should never actually
> > awake the device.  It is only there to compensate for what the PM core
> > does.
> >
> > Can you try this patch?  Will post a version to the list with
> > changelog shortly.
> 
> After a little more thinking, I'm not sure yet if this is a real problem
> or not.
> 
> One other question.  At least for GPIO testing, does it work if you
> simply remove the _noirq hooks from pm_bus.c?  If so, please feel to
> post a version with the dependency that the patch adding suspend/resume
> hooks in pm_bus.c needs to be reverted first.
> 
We have reverted this patch and tested before submitting the modified GPIO series.

> Kevin
> 
> > Kevin
> >
> > diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
> > index bab0186..01bbe65 100644
> > --- a/arch/arm/mach-omap2/pm_bus.c
> > +++ b/arch/arm/mach-omap2/pm_bus.c
> > @@ -90,7 +90,7 @@ int platform_pm_resume_noirq(struct device *dev)
> >  	 * method so that the runtime PM usage counting is in the same
> >  	 * state it was when suspend was called.
> >  	 */
> > -	pm_runtime_get_sync(dev);
> > +	pm_runtime_get_noresume(dev);
> >
> >  	if (!drv)
> >  		return 0;
