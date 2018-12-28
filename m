From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [EXTERNAL] Re: [PATCH] wlcore: Fix bringing up wlan0 again if
 powered down briefly
Date: Fri, 28 Dec 2018 10:48:23 +0100
Message-ID: <CAPDyKFrk8Fx_XywPjhW3CTV9ri0LDovUuhE8=15Zew0_gMgebg@mail.gmail.com>
References: <20181217164207.20081-1-tony@atomide.com> <CAPDyKFoLnNWsBfaUwqwL31J=zb0UOQjXUKi7Sj0AUsnNoC6bYg@mail.gmail.com>
 <20181218155439.GB6707@atomide.com> <CAPDyKFr2xx6fmdgjd10C1jekWg-yZPk32fGWEPO2PyexjofJ1A@mail.gmail.com>
 <20181220231401.GG6707@atomide.com> <c22e2ab61b494ea0852c0f4654fef92d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c22e2ab61b494ea0852c0f4654fef92d-l0cyMroinI0@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 23 Dec 2018 at 08:38, Reizer, Eyal <eyalr-l0cyMroinI0@public.gmane.org> wrote:
>
> > > > > Instead, it looks like what you need, is a way to keep track of
> > > > > whether the SDIO card, became power cycled or if it stayed powered
> > on,
> > > > > when "ifconfig wlan0 up" is done. In case of a power cycle, you need
> > > > > to re-program the firmware, right?
> > > >
> > > > Yeah mostly. But we also need to ensure things do get powered down
> > > > properly after ifconfig wlan0 down :) IMO after ifconfig wlan0 down
> > > > returns, there should be no waiting needed.
> > > >
> > > > > Would it be possible to re-program the firmware, even if the SDIO card
> > > > > stayed powered-on?
> > > >
> > > > That might help for some cases, but the problem of how to ensure the
> > > > card is powered down after ifconfig wlan0 down returns still exists.
> > >
> > > Well, does the SDIO card really have to be powered down before
> > > "ifconfig wlan0 down" returns? If so, why?
> >
> > Good question. Eyal, any comments what should happen here from
> > the wlcore hardware point of view?
> >
>
> You are ok as long as the wlan_enable pin Does go down for a sufficient amount of time
> turning the wl18xx device off.
> The firmware can only be downloaded once after power on.
> In between down/up you have to make sure the wlan_enable is fully going through on->off->on
> and the wl18xx device is fully reset.
> On power on the firmware is loaded by the driver and this will fail in case the reset didn't happen

This clearly answers one of my question, in regards to re-programming
the FW, thanks!

However, I am still lacking an answer to if there is hard requirement
to actually power off the SDIO card at "down". So far, the indications
I have got, gives that answer "yes". Can you or anybody else confirm
that?

> .
> > > An option would be to call pm_runtime_get_sync() at "ifconfig wlan0
> > > up" (I assume you already do that) and then re-program the firmware,
> > > even if the card hasn't been power cycled. Wouldn't that work?
> >
> No, this wouldn't work in case the wlan_enable pin didn't reset the chip as part of the
> "ifconfig wlan0 down" Command.
>
> > Ricardo, care to test and see if the problem comes back if you
> > keep PM runtime enabled?
> >
> > > Or perhaps this is the problem you are encountering, that the FW can't
> > > be reprogrammed, unless the card has been power cycled? You can easily
> > > test that, by simply bumping the runtime usage count for the card
> > > device via sysfs, before doing the "ifconfig wlan0 up/down" thingy.
> >
>
> Correct. The firmware can't be reprogrammed , unless the card has been power cycled.

Again, thanks for clarifying this.

[...]

Kind regards
Uffe
