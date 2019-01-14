From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [EXTERNAL] Re: [PATCH] wlcore: Fix bringing up wlan0 again if
 powered down briefly
Date: Mon, 14 Jan 2019 14:47:31 +0100
Message-ID: <CAPDyKFrYk87AwpHd5B06quGQAtfPYRHMD-9-2WzR=7Y=5Oog2A@mail.gmail.com>
References: <20181217164207.20081-1-tony@atomide.com> <CAPDyKFoLnNWsBfaUwqwL31J=zb0UOQjXUKi7Sj0AUsnNoC6bYg@mail.gmail.com>
 <20181218155439.GB6707@atomide.com> <CAPDyKFr2xx6fmdgjd10C1jekWg-yZPk32fGWEPO2PyexjofJ1A@mail.gmail.com>
 <20181220231401.GG6707@atomide.com> <c22e2ab61b494ea0852c0f4654fef92d@ti.com>
 <20181223160226.GK6707@atomide.com> <CAPDyKFoEOGACs4Wnm7UgKab2b1-7+v8+31DpC+p=8XxcQhSpcQ@mail.gmail.com>
 <20181228195903.GX6707@atomide.com> <CAPDyKFq9XmRueJEFKVb03hqLuoB84TGjrdvEjre46ezYbk_wgw@mail.gmail.com>
 <20190107151849.GC5544@atomide.com> <87k1jgsaze.fsf@kamboji.qca.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87k1jgsaze.fsf-HodKDYzPHsUD5k0oWYwrnHL1okKdlPRT@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>, KISHON VIJAY ABRAHAM <kishon-l0cyMroinI0@public.gmane.org>, "Mishol, Guy" <guym-l0cyMroinI0@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anders Roxell <anders.roxell-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ricardo Salveti <rsalveti-3fX5ma9fJBTk1uMJSBkQmQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 7 Jan 2019 at 17:12, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
>
> > * Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> [190102 12:02]:
> >>
> >> However, if this is about an out-of-band IRQ line, instead of using
> >> the SDIO IRQs on DAT1, I think management of that, belongs in the wlan
> >> (or gpiochip) layers.
> >
> > Yes this can be handled at the gpiochip layer.
> >
> >> We have to distinguish if "down" has a strict requirement to power off
> >> the wlan-chip.
> >>
> >> For example, in "flight mode", is it okay to leave the wlan chip
> >> powered on and thus potentially also having its radio part active?
> >
> > I don't know. If unsure, we should at least have that possibility
> > available for future versions if needed. It might also help a bit
> > with PM measurements :)
>
> I don't know if there are any written rules but I have preferred that in
> wireless drivers "ifconfig down" means that all power is turned off on
> the device, at least this way user space can achive maximum power
> savings. And there's also a simple way to start the firmware from clean
> state, we all know how buggy firmwares are so I think that's important
> as well.

Alright, I buy this! I am going to have a look to see how we can
accomplish this in the best way, but I need some more time before I
can post something.

In the meantime, let's go with Tony's suggestion to fix the
regression. I am about to post a patch.

Kind regards
Uffe
