From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] wlcore: Fix bringing up wlan0 again if powered down
 briefly
Date: Thu, 20 Dec 2018 15:14:01 -0800
Message-ID: <20181220231401.GG6707@atomide.com>
References: <20181217164207.20081-1-tony@atomide.com>
 <CAPDyKFoLnNWsBfaUwqwL31J=zb0UOQjXUKi7Sj0AUsnNoC6bYg@mail.gmail.com>
 <20181218155439.GB6707@atomide.com>
 <CAPDyKFr2xx6fmdgjd10C1jekWg-yZPk32fGWEPO2PyexjofJ1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFr2xx6fmdgjd10C1jekWg-yZPk32fGWEPO2PyexjofJ1A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [181220 10:15]:
> On Tue, 18 Dec 2018 at 16:54, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> >
> > Hi,
> >
> > * Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [181218 12:34]:
> > > Instead, it looks like what you need, is a way to keep track of
> > > whether the SDIO card, became power cycled or if it stayed powered on,
> > > when "ifconfig wlan0 up" is done. In case of a power cycle, you need
> > > to re-program the firmware, right?
> >
> > Yeah mostly. But we also need to ensure things do get powered down
> > properly after ifconfig wlan0 down :) IMO after ifconfig wlan0 down
> > returns, there should be no waiting needed.
> >
> > > Would it be possible to re-program the firmware, even if the SDIO card
> > > stayed powered-on?
> >
> > That might help for some cases, but the problem of how to ensure the
> > card is powered down after ifconfig wlan0 down returns still exists.
> 
> Well, does the SDIO card really have to be powered down before
> "ifconfig wlan0 down" returns? If so, why?

Good question. Eyal, any comments what should happen here from
the wlcore hardware point of view?

> An option would be to call pm_runtime_get_sync() at "ifconfig wlan0
> up" (I assume you already do that) and then re-program the firmware,
> even if the card hasn't been power cycled. Wouldn't that work?

Ricardo, care to test and see if the problem comes back if you
keep PM runtime enabled?

> Or perhaps this is the problem you are encountering, that the FW can't
> be reprogrammed, unless the card has been power cycled? You can easily
> test that, by simply bumping the runtime usage count for the card
> device via sysfs, before doing the "ifconfig wlan0 up/down" thingy.

Ricardo, care to play with this too?

Regards,

Tony
