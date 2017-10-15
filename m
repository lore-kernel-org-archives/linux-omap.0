From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Fix omap l4per idling with wlcore   edge
 sensitive interrupt
Date: Sun, 15 Oct 2017 09:22:31 -0700
Message-ID: <20171015162230.GU4394@atomide.com>
References: <8665E2433BC68541A24DFFCA87B70F5B3646AF81@DFRE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8665E2433BC68541A24DFFCA87B70F5B3646AF81-1tpBd5JUCm6IQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gerlach, Dave" <d-gerlach-l0cyMroinI0@public.gmane.org>, "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "Kristo, Tero" <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [171014 23:55]:
> > From: Tony Lindgren [mailto:tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org]
> > 
> > On omaps, if the wlcore interrupt is configured as level instead of edge,
> > L4PER will stop doing hardware based idling after ifconfig wlan0 down is
> > done and the WL_EN line is pulled down.
> > 
> Do we understand why omap is doing this? Is it a bug or a normal behavior?
> 
> AFAIK way back edge interrupts have been used. On some omaps based boards.
> They have used level interrupts instead due to occasional interrupts being missed 
> By the omap interrupts controller when using edge based interrupts which caused 
> Issues. This was the reason many boards are set to using level based interrupts which 
> Seemed much more robust.

No idea yet why exactly the gpio modules won't idle after that. But for making
edge interrupts behave, I suspect that Grygorii's patch "[RESEND PATCH] gpio:
omap: Fix lost edge interrupts" fixes those issues.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
