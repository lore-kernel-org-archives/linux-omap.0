From: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Fix omap l4per idling with wlcore   edge
 sensitive interrupt
Date: Mon, 16 Oct 2017 00:15:36 +0200
Message-ID: <20171015221536.ybe7x52tenocel6c@lenoch>
References: <8665E2433BC68541A24DFFCA87B70F5B3646AF81@DFRE01.ent.ti.com>
 <20171015162230.GU4394@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171015162230.GU4394-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gerlach, Dave" <d-gerlach-l0cyMroinI0@public.gmane.org>, "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "Kristo, Tero" <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Oct 15, 2017 at 09:22:31AM -0700, Tony Lindgren wrote:
> * Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> [171014 23:55]:
> > > From: Tony Lindgren [mailto:tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org]
> > > 
> > > On omaps, if the wlcore interrupt is configured as level instead of edge,
> > > L4PER will stop doing hardware based idling after ifconfig wlan0 down is
> > > done and the WL_EN line is pulled down.
> > > 
> > Do we understand why omap is doing this? Is it a bug or a normal behavior?
> > 
> > AFAIK way back edge interrupts have been used. On some omaps based boards.
> > They have used level interrupts instead due to occasional interrupts being missed 
> > By the omap interrupts controller when using edge based interrupts which caused 
> > Issues. This was the reason many boards are set to using level based interrupts which 
> > Seemed much more robust.
> 
> No idea yet why exactly the gpio modules won't idle after that. But for making
> edge interrupts behave, I suspect that Grygorii's patch "[RESEND PATCH] gpio:
> omap: Fix lost edge interrupts" fixes those issues.

Please note, that Grygorii's patch fixes occasional edge interrupts misses
only after your PM patch is applied. That said, edge interrupts are still
being missed in mainline.

	ladis
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
