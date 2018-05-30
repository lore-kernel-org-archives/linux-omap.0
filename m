From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFT 6/6] wlcore: Use generic runtime pm calls   for wowlan elp
 configuration
Date: Wed, 30 May 2018 14:44:11 -0700
Message-ID: <20180530214411.GI5705@atomide.com>
References: <63ad2f07fac941b88408352f6ddbce50@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <63ad2f07fac941b88408352f6ddbce50-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Hahn, Maital" <maitalm-l0cyMroinI0@public.gmane.org>, "Altshul, Maxim" <maxim.altshul-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [180530 06:37]:
> > > >
> > > > With runtime PM enabled, we can now use generic calls to
> > > > pm_generic_runtime_suspend and pm_generic_runtime_resume for
> > enabling elp
> > > > during suspend when wowlan is enabled and waking the chip from elp
> > > > on resume.
> > >
> > > Sry, but not sure you can :(
> > >
> > > These functions are not used by drivers directly because system suspend
> > > are not synchronized with PM runtime, so if you call
> > pm_generic_runtime_suspend()
> > > and, at the same time, there is pm_runtime_get_() in progress --> race ...
> > >
> > > The pm_runtime_force_() APIs have to be used, or
> > > PM runtime drivers functions can be called directly, but only if it possible to
> > be
> > > sure no other PM runtime calls active which is usually true at
> > suspend_noirq stage.
> > 
> > Oh right, those are subsystem calls. Seems like
> > pm_runtime_force_suspend/resume() should work here,
> > Eyal?
> > 
> 
> Oh, nice, wasn't aware of the pm_runtime_force_() calls.
> For some reason they are not documented in:
> https://www.kernel.org/doc/Documentation/power/runtime_pm.txt
> Perhaps they should be?

Sure why not submit a patch for that.

> Anyway I have tried them instead of pm_generic_runtime_() and they seem
> To work fine on my platform.
> Will test some more and submit a v2.

OK I'll your pick v2 into my series.

Regards,

Tony
