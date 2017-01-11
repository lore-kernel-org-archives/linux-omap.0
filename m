From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] dmaengine: cppi41: Ignore EINPROGRESS for PM
 runtime in interrupt handler
Date: Wed, 11 Jan 2017 03:05:49 +0200
Message-ID: <CAHp75Vc5zh-36LXcz9ZbvQK-O9wWWji6HRERTyEJguEU6nZpvg@mail.gmail.com>
References: <20170109170337.6957-1-abailon@baylibre.com> <20170109170337.6957-3-abailon@baylibre.com>
 <20170109183946.GK2630@atomide.com> <7f446fd6-23ac-392c-6a2e-6b63843e0299@ti.com>
 <7be08973-1233-a19a-a263-3ca194c4854c@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7be08973-1233-a19a-a263-3ca194c4854c-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 10, 2017 at 1:34 PM, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
> On 01/09/2017 08:11 PM, Grygorii Strashko wrote:
>>> Hmm if the cppi41 interrupt fires, the device has resumed :)
>>>
>>> I think we should have a cppi41.c specific flag that we can set
>>> at the end of cppi41_resume() instead of list_empty() or
>>> pm_runtime_active().

> I think the interrupt can only be fired if the device is active.

I have no idea about this particular case, but believe me there are
cases where above is not true.
I think Tony keeps it in mind after good discussion about thread IRQ
enforcement on shared interrupt handlers.

> And the interrupt happen because the one descriptor queued during the
> resume has been moved to completion queue
> (so device is clocked and operational).

Doesn't really matter in some cases.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
