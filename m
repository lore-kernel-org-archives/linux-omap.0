From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 00/20] rtc: omap: fixes and power-off feature
Date: Tue, 28 Oct 2014 09:16:16 +0100
Message-ID: <20141028081616.GL2006@localhost>
References: <1413913086-12730-1-git-send-email-johan@kernel.org>
 <20141024160845.GM26941@saruman>
 <20141024190251.GB19377@localhost>
 <20141024192540.GD11455@saruman>
 <20141024192948.GE11455@saruman>
 <20141024193655.GD19377@localhost>
 <20141024194442.GG11455@saruman>
 <20141024195532.GF19377@localhost>
 <20141027162251.d7ff2a5f31917c638d4e47f7@linux-foundation.org>
 <20141028002552.GX12379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141028002552.GX12379-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, nsekhar-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, j-keerthy-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 28, 2014 at 12:25:52AM +0000, Russell King - ARM Linux wrote:
> On Mon, Oct 27, 2014 at 04:22:51PM -0700, Andrew Morton wrote:
> > On Fri, 24 Oct 2014 21:55:32 +0200 Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > > I will. :) Just wanted to see whether Andrew preferred I resend the
> > > whole series or just that one patch first.
> > > 
> > > The diff is minimal:
> > > 
> > > diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> > > index e74750f00b18..e4f97ad9eb21 100644
> > > --- a/drivers/rtc/rtc-omap.c
> > > +++ b/drivers/rtc/rtc-omap.c
> > > @@ -423,6 +423,8 @@ static void omap_rtc_power_off(void)
> > >         val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
> > >         rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
> > >                         val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> > > +
> > > +       mdelay(2000);
> > >  }
> > 
> > Yes, having read this threadlet: we need a very good comment in there
> > explaining what's going on, please.
> >
> > Do we even need this delay on anything other than arm?  Or even on all arm?
> 
> I think I've already commented on the behaviour of the reboot syscalls
> such as power off which can return to userspace, pointing out that
> x86 can return to userspace.
> 
> As long as x86 can return to userspace, I see no harm in ARM returning
> to userspace.  If a driver which is hooking into the power off stuff
> is unable to immediately shut off the power (wtf it can't for 2 sec
> I've no idea) then having that driver work around that hardware's
> specific brokenness with a delay seems entirely reasonable.

Yeah, there are two issues here. If a power-off handler is crazy slow
there really should be a delay in the handler. That was just an
oversight on my part. [ In this case it takes between one and two
seconds due to the resolution of the rtc and they way it's alarm events
are triggered. ]

The other issue is whether arch code should inform the user about failed
power-off, in really exactly the same way as it does for failed reboot,
see:

	ac15e00b1efe ("ARM: restart: move reboot failure handing into
	machine_restart()"

by Russell.

It looks like we're soon to be having power-off call chains, with
configurable priorities, to shut of various parts of the hardware and
this is all at least partly configurable through DT. [1] I think it's
reasonable to expect to see more frequent failures to power off either
due to (DT) misconfiguration or broken or flakey hardware.

Having a short delay (I proposed 1s as for reboot) would also prevent
any oopses when returning to user-space for just quite slow devices
(e.g. millisecond range) without requiring explicit delays in these
handlers.

But as Andrew points out above, this really isn't an arm-specific issue,
and currently various arches deal with this differently, where some
return to user-space, some spin indefinitely (without an error message),
and some spin on failed reboot but not power-off (e.g. arm and arm64).

> That allows those SoCs which can do the right thing to do the right
> thing without being hindered by such silliness.  And it also stops
> the next person coming along and bumping the delay from 2 to 3, to 5,
> and then what... 10 seconds?

That wouldn't be an issue then. Arch code would only handle the
non-crazy case and complete power-off failures.

> Keeping it in the driver means that the workaround for the broken
> hardware is kept with the driver for the broken hardware - exactly
> where it should be.

Agreed.

Johan

[1] https://lkml.org/lkml/2014/10/27/506
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
