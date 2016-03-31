From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] ARM: dts: dra7: Correct clock tree for sys_32k_ck
Date: Thu, 31 Mar 2016 10:00:18 -0700
Message-ID: <20160331170017.GI9329@atomide.com>
References: <1457957001-720-1-git-send-email-j-keerthy@ti.com>
 <20160330211828.GE9329@atomide.com>
 <20160330213224.GH9329@atomide.com>
 <56FCC3FF.7080901@ti.com>
 <56FCEC61.5020400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56FCEC61.5020400-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Keerthy <a0393675-l0cyMroinI0@public.gmane.org> [160331 02:26]:
> 
> 
> On Thursday 31 March 2016 12:00 PM, Tero Kristo wrote:
> >On 03/31/2016 12:32 AM, Tony Lindgren wrote:
> >>* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160330 14:19]:
> >>>* Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org> [160314 05:04]:
> >>>>This is w.r.t J6/J6eco: 32clk is pseudo (erratum i856) - clock source.
> >>>>Errata i856 for the AM572x (DRA7xx) points out that the 32.768KHz
> >>>>external
> >>>>crystal is not enabled at power up. Instead the CPU falls back to using
> >>>>an emulation for the 32KHz clock which is SYSCLK1/610.  SYSCLK1 is
> >>>>usually
> >>>>20MHz on boards so far (which gives an emulated frequency of 32.786KHz)
> >>>
> >>>Thanks applying into omap-for-v4.6/fixes.
> >>
> >>Actually let's wait a review from Tero on this one, not sure
> >>about the pseudo clock naming here. So dropping for now.
> >
> >The patch is fine for me, I didn't comment anything before as I thought
> >you already applied it.
> >
> >Acked-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> 
> Thanks Tero.

OK applying with Tero's ack.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
