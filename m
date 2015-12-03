From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [4.4-rc][PATCH] ARM: dts: am4372: disable arm twd and global
 timer's nodes
Date: Thu, 3 Dec 2015 08:33:11 -0800
Message-ID: <20151203163311.GP23396@atomide.com>
References: <1447855315-419-1-git-send-email-grygorii.strashko@ti.com>
 <20151118141537.GC10644@leverpostej>
 <564C9ACF.6040107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <564C9ACF.6040107-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, slash.tmp-GANU6spQydw@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [151118 07:36]:
> Hi Mark,
> 
> On 11/18/2015 04:15 PM, Mark Rutland wrote:
> > On Wed, Nov 18, 2015 at 04:01:55PM +0200, Grygorii Strashko wrote:
> >> Keep ARM TWD and Global timer's nodes disabled by default - if someone
> >> would like to use them then those nodes have to be enabled explicitly
> >> in board file.
> >>
> >> The reason for this change is:
> >> - ARM TWD is not always-on timer on am437x and it will stop in low
> >>    CPUIdle states and, therefore, broadcast timer has to configured
> >>    properly if CPU_IDLE=y.
> >> - ARM Global timer is not always-on timer on am437x and it can't be
> >>    used as clocksource device if CPU_IDLE=y.
> > 
> > I don't understand. What timer do you use in the absence of a TWD, and
> > if it is better why is it not used even if TWD is present?
> 
> OMAP GP timer as clockevent device
> "ti,omap-counter32k" as clocksource
> both are in wakeup (always-on) PM domain.
> 
> I see some problems with selecting clocksource/event device (but may be I'm mistaken):
> - Current clock event will be selected using "rating" field in clock_event_device
>   structure and now ARM TWD has higer value (350) vs OMAP GP timer (300),
>   so ARM TWD will be always selected if it's present. 
> - we have to force all am437x user to use kernel cmdline parameter "clocksource="
>   if ARM Global timer is present, but shouldn't be used. But even in this case,
>   it will be selected as sched_clock.

Yeah makes sense to me. Eventually when I get my clocksource switch patches
updated this problem will go away and we can use a local timer clocksource
during runtime and slower always on timer during idle like we already do
for clockevents.

> We can see benefits from using these timers when Power mangement is not the case,
> for example on -RT kernel where CPUIdle is not the target.

Yes we really want to use local timers for RT during runtime.

> By this change, and taking into account discovered issues, I want to make people,
> who would like to use these timers on AM437x based boards, responsible for such
> decision with assumption that they know what they are doing.
> And this is simplest way I found to disable those timers without modifying kernel.
> 
> > 
> >> - ARM Global timer driver doesn't support CPUfreq now.
> > 
> > Surely that should be fixed in the driver (e.g. make it fail to probe if
> > CPUfreq is present)? It's broken for any other users too...
> 
> May be.

I think it's only broken for users who have PM entering deeper idle states
where the ARM core is powered off.

The selection of the timer needs to be done in the board specific dts file as we
already have cases where RT works but PM does not and should use the local timer,
and we have boards where PM works and we must use the always on timer.

> Also, there is additional issue with ARM global timer which I've not
> mentioned here, because I sent the fix for it already (in progress):
> https://lkml.org/lkml/2015/11/13/456
> 
> and there is ongoing discussion:
> http://www.spinics.net/lists/arm-kernel/msg459649.html

It seems we should apply this as a fix unless somebody has better ideas.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
