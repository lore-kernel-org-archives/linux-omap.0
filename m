From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Mon, 11 Apr 2016 14:28:45 -0700
Message-ID: <20160411212845.GJ5995@atomide.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
 <56EFB794.5010505@ti.com>
 <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com>
 <20160402001753.GR9329@atomide.com>
 <57026205.6020105@ti.com>
 <20160404151200.GA4652@atomide.com>
 <5703BA6B.1080208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5703BA6B.1080208-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> [160405 06:16]:
> On 04/04/16 18:12, Tony Lindgren wrote:
> >> The reason for this is that in DT boot we can not provide the
> >> enable_st_clock() callback to the mcbsp driver stack. This is done for legacy
> >> boot in mach-omap2/mcbsp.c
> > 
> > Seems like the short term fix there is to pass enable_st_clock pointer
> > in pdata using pdata-quirks.c.
> 
> I don't think there is a point to spend effort on a workaround via pdata-quirks.
> 
> > Then for the long term solution using
> > PM runtime to block gating of the clock while sidetone is active is
> > the way to go it seems.
> 
> Hrm, I think one of the main issue is that with pm_runtime we can not block
> the clock gating, this is why legacy code uses enable_st_clock(), which will
> call omap2_clk_deny_idle() or omap2_clk_allow_idle().

I see. I think Tero wanted to export omap2_clk_allow_idle() and
omap2_clk_deny_idle() for drivers to use. That should get discussed in
the linux-clk list, probably best to use the pdata callbacks until
the clock idling issue has been discussed.

> >> The ST does not have clocks coming from PRCM level, it only uses the McBSP
> >> iclk when it is enabled (the McBSP block of the McBSP). As far as pm_runtime
> >> goes I think the ST module should not use it. We can not tell hwmod to
> >> enable/disable the McBSP2/3 iclk when we pm_runtime for the ST. It does not
> >> help at all. We can have nop action for the ST when pm_runtime is used, but
> >> then why would we have it?
> > 
> > Using PM runtime in the sidetone driver should just work as long as the
> > sidetone device driver depends on the McBSP driver before it gets probed.
> > The clock framework handles things for the mcbsp ick with the usecount.
> 
> Yes, that is not the problem. The problem is that when McBSP is used w/o
> sidetone the iclk can and should be autogated, but if the sidetone is enabled
> then the iclk must not autogate and this needs to be prevented in PRCM level.
> Note also that while the McBSP is running we must be able to enable/disable
> the sidetone any time w/o affecting the McBSP operation.

OK I see.

> > And doing pm_runtime_get() in the sidetone driver will do what the legacy
> > enable_st_clock() does currently.
> 
> it can't do that as we do not have way to deny/enable just the autoidle for a
> given clock.

Yup. So I suggest the pdata callbacs for the omap2_clk_allow_idle() and
omap2_clk_deny_idle() for now.

> >>> So having two separate drivers might make things a lot simpler.
> >>
> >> Not really. It will make things way more complicated imho. How to handle
> >> legacy boot as we still have that supported?
> > 
> > Hey both the legacy driver and DT driver are really just platform devices
> > and drivers. And passing both dts and platform data can be done just
> > fine, no?
> 
> Sure, but McBSP2-ST needs to bind with McBSP2 driver instance and the
> McBSP3-ST should bind with McBSP3 instance. In legacy mode we can store the
> McBSP pdev pointers in a array and use the devid or get the McBSP id from the
> device name. While with DT boot we must have phandle pointing to/from ST
> from/to McBSP node to be able to figure out who is who.
> 
> >> When the McBSP driver is loaded we must know if it has sidetone or not so
> >> we can create the needed audio controls, sysfs entries. The sysfs and
> >> kcontrol registration could be moved out to the new ST driver, true.
> > 
> > Yeah during the probe, the sidetone driver must register with the McBSP
> > driver to tell it's there.
> 
> When McBSP driver probes, it registers itself to ASoC core and it needs to
> know at that point if we need to prepare for ST or not. So probably the McBSP
> driver needs to register to ST driver?

OK yes if that makes more sense.

> > I guess no need to pass anything in the
> > dts or platform_data for that.
> > 
> >> I actually started with two separate drivers approach first, but decided that
> >> it does not worth the effort (legacy boot support, pm_runtime/hwmod hassle,
> >> platform data, callback API design, etc).
> >> I know, it is not rocket science but it is king of shoot out of cannon into
> >> sparrows.
> >> I'll think about it for a little while ;)
> > 
> > Well what we've seen so far is that any kind of non-standard solution
> > will always be a pain to maintain in the long run :)
> 
> The current implementation (one driver to handle McBSP and the ST) is there
> ever since OMAP3 was introduced afaik. Changing a working (was working) design
> to something which has not been tested will for sure going to open issues we
> have not prepared for.
> I would avoid the rewrite of a proven driver architecture if it is not broken.

Well probably the best thing to do is the use of platform callback
for now until we know how it can be done incrementally :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
