From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 29/35] arm: omap: intc: switch over to linear irq domain
Date: Wed, 30 Jul 2014 10:45:41 -0500
Message-ID: <CAGo_u6ou+MoKOE_tTTmjxyFNW=jTaN9vnTsHrxR6sQHsieJyLA@mail.gmail.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
	<1406582183-696-30-git-send-email-balbi@ti.com>
	<20140729121425.GR29045@atomide.com>
	<20140729141522.GB17808@saruman.home>
	<20140729152052.GV29045@atomide.com>
	<20140729154057.GE17808@saruman.home>
	<20140729163345.GF17808@saruman.home>
	<20140730060420.GY29045@atomide.com>
	<20140730144059.GA7272@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140730144059.GA7272-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, dt list <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 30, 2014 at 9:40 AM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> HI,
>
> On Tue, Jul 29, 2014 at 11:04:21PM -0700, Tony Lindgren wrote:
>> * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140729 09:36]:
>> > Hi,
>> >
>> > On Tue, Jul 29, 2014 at 10:40:57AM -0500, Felipe Balbi wrote:
>> > > On Tue, Jul 29, 2014 at 08:20:52AM -0700, Tony Lindgren wrote:
>> > > > * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140729 07:18]:
>> > > > > Hi,
>> > > > >
>> > > > > On Tue, Jul 29, 2014 at 05:14:25AM -0700, Tony Lindgren wrote:
>> > > > > > * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> [140728 14:19]:
>> > > > > > > now that we don't need to support legacy board-files,
>> > > > > > > we can completely switch over to a linear irq domain
>> > > > > > > and make use of irq_alloc_domain_generic_chips() to
>> > > > > > > allocate all generic irq chips for us.
>> > > > > >
>> > > > > > This patch seems to somehow break off-idle for omap3
>> > > > > > where it no longer wakes up.
>> > > > >
>> > > > > Sure your bisection is correct ? This patch just switches from legacy
>> > > > > irq domain to linear irq domain.
>> > > >
>> > > > Yes, I tried it a few times. Just enabling
>> > > > retention idle hangs too with this patch.
>> > > >
>> > > > Maybe it's omap3_prcm_irq_setup that relies on
>> > > > 11 + OMAP_INTC_START? There may be other such issues
>> > >
>> > > lol.
>> > >
>> > > OMAP4 has the same nonsense.
>> >
>> > made me think why (if) OMAP4 works with that same setup. Does wake from
>> > OFF work with OMAP4 ?
>>
>> Not without similar changes, omap4+ has the same issue.. There's a RFC
>> series from Nishant to fix some of this, and Tero is moving the PRCM
>> into a driver.
>>
>> > Anyway, here's a quick little hack to check if that's the reason for the
>> > regression:
>>
>> OK yeah that's along the same lines with Nishant's RFC series in thread
>> "[RFC PATCH 0/7] ARM: OMAP4+: PRM: minor cleanups and dt support of
>> interrupts"
>>
>> FYI, it did not compile, needs to include linux/of_irq.h. But yes,
>
> I might have sent the wrong version as I had that same build error and
> fixed it localy.
>
>> it fixes the regression for me, Also now the whole series works for
>> me :)
>
> good to know.
>
> What do you want to do now ? Wait for PRCM to become a driver ? Wait for
> Nishanth's series to get accepted ? I guess the same thing could be done
> for OMAP3 and AM33, then we would have a chance of having working wake
> from idle with the new irqchip.

I can repost the current series as it stands now once 17-rc1 comes out
(without the build failure ofcourse).. if that helps to move it out of
RFC status.


-- 
---
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
