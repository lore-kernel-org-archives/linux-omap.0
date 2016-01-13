From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and
 charging of backup battery
Date: Wed, 13 Jan 2016 11:40:32 -0800
Message-ID: <20160113194032.GL12777@atomide.com>
References: <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com>
 <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com>
 <5696896F.4090309@ti.com>
 <20160113180006.GJ12777@atomide.com>
 <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com>
 <56969800.5010206@ti.com>
 <D6479E92-4226-4B07-95F3-C0DF092B827C@goldelico.com>
 <5696A002.6050402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5696A002.6050402@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Laxman Dewangan <ldewangan@nvidia.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Marek Belisko <marek@goldelico.com>, =?utf-8?Q?Gra=C5=BEvydas?= Ignotas <notasas@gmail.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [160113 11:06]:
> On 01/13/2016 12:44 PM, H. Nikolaus Schaller wrote:
> >=20
> > Am 13.01.2016 um 19:31 schrieb Nishanth Menon <nm@ti.com>:
> >=20
> >> On 01/13/2016 12:08 PM, H. Nikolaus Schaller wrote:
> >>> Since the scratchpad is not used we can permanently enable msecur=
e. Which
> >>> means that we must somehow get the driving output to be "1".
> >>>
> >>> This can be either done by
> >>> * a gpio with pull-up - switched to input mode as I proposed, or
> >>
> >> I think you intended to suggest to do a mux to gpio with just pinm=
ux
> >> pull?
> >=20
> > Yes.
> >=20
> >> The internal pull on padconf is very weak
> >> - for typical needs like
> >> these, it is rather suggested to stick with real GPIO drive to pre=
vent
> >> conditions like noise interference(for example).
> >=20
> >=20
> > well, on OMAP5 pull up/down are astonishingly strong :)
> > 100-250=C2=B5A. Which translated roughly to 7 .. 18 kOhm @ 1.8V log=
ic.
> > So a noise source must be coupled by an impedance in the 1 kOhm ran=
ge.
> > This is quite rare. So I would not worry about that.
> >=20
>=20
> Interesting. I did not know that, and have'nt dug at people to confir=
m
> that either :).
>=20
> An internal feedback I got some time back on AM57 (not OMAP5) - conte=
xt
> was that we were discussing if an external pull up resistor was neede=
d
> for a GPIO button:
> "Internal pull-ups are relatively weak (ranging to 100kOhm or higher)
> and are good for avoiding higher leakage due to floating input level,
> and may not be sufficient for valid logic 1/0 depending on what else =
is
> connected on the board.  If a signal must absolutely be pulled to a
> valid logic 1 or 0 for system functionality, then an external pull
> should be used."
>=20
> Anyways... will let Tony decide where he wants to go on this..

Eek now we have at least three options! Time for online vote:

1. Use msecure pinmux and let whatever mystery software control
   the pin completely out of our control like we've been doing with
   the mainline kernel for years.

2. Set up the msecure pin as GPIO output high unconditionally.
   This is what the TI android kernel tree seems to be doing.

3. New suggestion to use the SoC internal pull to keep the msecure
   pin high. This might be a little bit more power friendly than
   option #2 or #3.

Maybe option #3 would save a little bit more power compared to
options 1 and 2?

Anyways, considering what's been discussed, after the minimal RTC fix
we could also add code to allow the TWL driver optionally configure the
GPIO. This way the TWL driver could also check the GPIO state in case
some out-of-our-control mystery software goes tweak the msecure pin
state. Or the RTC driver could just check that the bits really change
after=3D writing them. Then we would at least know things are not worki=
ng
right for the TWL related RTC drivers.

Regards,

Tony
