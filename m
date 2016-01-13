From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging of backup battery
Date: Wed, 13 Jan 2016 19:44:55 +0100
Message-ID: <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com>
References: <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com> <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com> <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com> <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com> <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com> <56966558.1070608@ti.com> <569669C5.2070200@ti.com> <20160113164856.GF12777@atomide.com> <5696896F.4090309@ti.com> <20160113180006.GJ12777@atomide.com> <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com> <56969800.5010206@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56969800.5010206-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


Am 13.01.2016 um 19:31 schrieb Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>:

> On 01/13/2016 12:08 PM, H. Nikolaus Schaller wrote:
> [...]
>=20
>>> OK. So are we sure the TWL driver will never have to toggle this pi=
n?
>>=20
>> After studying the Palmas TRM it appears that this pin just should b=
e "high"
>> to be able to write to RTC and some scratchpad register. If the Palm=
as OTP
>> is programmed to use gpio7 as msecure input.
>=20
> Thanks for digging it up. we dont use the scratchpad, but in some cas=
es
> where SoC cold reset is involved, those registers may store additiona=
l
> information.

I remember a similar thing from omap3-twl4030 where the boot source is =
stored
so that a warm reboot searches there. But I don#t know if the OMPAP5 Bo=
ot ROM
is using that.

>=20
>>=20
>> Since the scratchpad is not used we can permanently enable msecure. =
Which
>> means that we must somehow get the driving output to be "1".
>>=20
>> This can be either done by
>> * a gpio with pull-up - switched to input mode as I proposed, or
>=20
> I think you intended to suggest to do a mux to gpio with just pinmux
> pull?

Yes.

> The internal pull on padconf is very weak
> - for typical needs like
> these, it is rather suggested to stick with real GPIO drive to preven=
t
> conditions like noise interference(for example).


well, on OMAP5 pull up/down are astonishingly strong :)
100-250=B5A. Which translated roughly to 7 .. 18 kOhm @ 1.8V logic.
So a noise source must be coupled by an impedance in the 1 kOhm range.
This is quite rare. So I would not worry about that.

But if there is MUX_MODE1 for this purpose that works equally well, we
should use it instead of a gpin+pullup.

BR,
Nikolaus--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
