From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFT 6/6] wlcore: Use generic runtime pm calls for wowlan elp
 configuration
Date: Tue, 29 May 2018 14:40:11 -0700
Message-ID: <20180529213928.GA5705@atomide.com>
References: <20180529180605.73622-1-tony@atomide.com>
 <20180529180605.73622-7-tony@atomide.com>
 <75fb865b-dc84-2e7d-d879-581e65dc343d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <75fb865b-dc84-2e7d-d879-581e65dc343d-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [180529 19:25]:
> On 05/29/2018 01:06 PM, Tony Lindgren wrote:
> > From: Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > 
> > With runtime PM enabled, we can now use generic calls to
> > pm_generic_runtime_suspend and pm_generic_runtime_resume for enabling elp
> > during suspend when wowlan is enabled and waking the chip from elp
> > on resume.
> 
> Sry, but not sure you can :(
> 
> These functions are not used by drivers directly because system suspend
> are not synchronized with PM runtime, so if you call pm_generic_runtime_suspend()
> and, at the same time, there is pm_runtime_get_() in progress --> race ...
> 
> The pm_runtime_force_() APIs have to be used, or 
> PM runtime drivers functions can be called directly, but only if it possible to be
> sure no other PM runtime calls active which is usually true at suspend_noirq stage. 

Oh right, those are subsystem calls. Seems like
pm_runtime_force_suspend/resume() should work here,
Eyal?

Regards,

Tony
