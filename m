From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 1/5] USB: MUSB: Switch to a_idle when micro/mini-a
	cable is attached
Date: Fri, 16 May 2008 11:40:31 -0700
Message-ID: <20080516184031.GA23002@atomide.com>
References: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com> <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com> <20080516173843.GK23002@atomide.com> <6a33dfd999477caafba5330f53cb8716@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53401 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbYEPSke (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 14:40:34 -0400
Content-Disposition: inline
In-Reply-To: <6a33dfd999477caafba5330f53cb8716@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080516 11:33]:
> 
> 
> On Fri, 16 May 2008 10:38:43 -0700, Tony Lindgren <tony@atomide.com> wrote:
> > * Felipe Balbi <felipe.balbi@nokia.com> [080513 05:33]:
> >> From: ext Felipe Balbi <felipe.balbi@nokia.com>
> >>
> >> This is mostly cosmetic but can help us in the future
> >> making musb driver not insertion-based.
> >>
> >> I mean, whenever we attach micro-/mini-A connector to
> >> musb-based devices, we instantaneously turn vbus on where
> >> we should wait until we need to use the bus.
> > 
> > This would break standard host behavious of basic USB devices that
> > don't support SRP?
> 
> Hmm... the way it is today yeah, but I can keep the behaviour
> that we try to turn vbus on whenever we attach micro/mini-a. But
> I was thinking on letting a file manager (or any other application
> that would use usb) to turn vbus on.
>
> If it's a mass storage device, you could let file manager write
> to session sysfs entry (which I'm changing to make it work on
> both roles).

I guess that could be optional behaviour assuming it does not break
"normal" behaviour :)

Tony

> 
> > 
> > Tony
> > 
> >> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> >> ---
> >>  drivers/usb/musb/tusb6010.c |    2 ++
> >>  1 files changed, 2 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
> >> index 1f3643b..9f92cef 100644
> >> --- a/drivers/usb/musb/tusb6010.c
> >> +++ b/drivers/usb/musb/tusb6010.c
> >> @@ -673,6 +673,8 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void
> > __iomem *tbase)
> >>  			default_a = is_host_enabled(musb);
> >>  		DBG(2, "Default-%c\n", default_a ? 'A' : 'B');
> >>  		musb->xceiv.default_a = default_a;
> >> +		musb->xceiv.state = default_a ? OTG_STATE_A_IDLE
> >> +			: OTG_STATE_B_IDLE;
> >>  		tusb_source_power(musb, default_a);
> >>
> >>  		/* Don't allow idling immediately */
> >> --
> >> 1.5.5.1.125.gc697a
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://felipebalbi.com
> me@felipebalbi.com
> 
