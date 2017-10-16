From: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Subject: RE: Re: [PATCH] ARM: dts: Fix omap l4per idling with   wlcore
   edge sensitive interrupt
Date: Mon, 16 Oct 2017 06:22:30 +0000
Message-ID: <8665E2433BC68541A24DFFCA87B70F5B3646C06C@DFRE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gerlach, Dave" <d-gerlach-l0cyMroinI0@public.gmane.org>, "Strashko, Grygorii" <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "Kristo, Tero" <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> > >
> > > On omaps, if the wlcore interrupt is configured as level instead of e=
dge,
> > > L4PER will stop doing hardware based idling after ifconfig wlan0 down=
 is
> > > done and the WL_EN line is pulled down.
> > >
> > Do we understand why omap is doing this? Is it a bug or a normal behavi=
or?
> >
> > AFAIK way back edge interrupts have been used. On some omaps based
> boards.
> > They have used level interrupts instead due to occasional interrupts be=
ing
> missed
> > By the omap interrupts controller when using edge based interrupts whic=
h
> caused
> > Issues. This was the reason many boards are set to using level based in=
terrupts
> which
> > Seemed much more robust.
>=20
> No idea yet why exactly the gpio modules won't idle after that. But for m=
aking
> edge interrupts behave, I suspect that Grygorii's patch "[RESEND PATCH] g=
pio:
> omap: Fix lost edge interrupts" fixes those issues.
>=20
Glad to see this patch fixing edge interrupts. Makes a lot of sense.
Then, all looks good to me.

Best Regards,
Eyal
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
