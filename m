From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
Date: Fri, 11 Oct 2013 08:18:39 -0700
Message-ID: <20131011151838.GM29913@atomide.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost>
 <5256AA7F.8030005@ti.com>
 <20131010160018.GA29913@atomide.com>
 <5257BB8C.5080001@ti.com>
 <52580438.4040002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52580438.4040002-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Prakash Manjunathappa <prakash.pm-l0cyMroinI0@public.gmane.org>, Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [131011 07:07]:
> On 10/11/2013 11:49 AM, Roger Quadros wrote:
> > On 10/10/2013 07:00 PM, Tony Lindgren wrote:
> >>
> >> Well the irq_set_wake() should only be needed for suspend and resume. For runtime PM
> >> the wake-events should be always enabled by default as pointed out by Alan Stern
> >> a while back.
> > 
> > Right, but we need to update the WAKEUP_EN bit in the pad control register for that
> > to work, no?. This is something we are not doing in the driver.
> 
> OK sorry, just figured out that we are doing it indeed in pcs_irq_set().
> Wasn't able to test it yet with USB. But I don't see any issues except that
> pcs_soc->rearm() needs to be called from pcs_irq_set() instead of from pcs_irq_unmask().

Hmm that sounds like a different behaviour compared to what I'm seeing
on omap3. Care to send a little fix on top of these patches so I can
test it with my set up too? 

It seems that the only difference would be that we're calling rearm()
after both masking and unmasking, which seemed unnecessary to me earlier.
 
> After that you can add my
> 
> Reviewed-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

Thanks, for testing, sorry I already pushed them out after Kevin
ran his PM tests on them.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
