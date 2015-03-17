From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Tue, 17 Mar 2015 14:59:13 +0100
Message-ID: <20150317135913.GA4034@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <20150317084730.GA9761@amd>
 <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com>
 <20150317103746.GB3759@amd>
 <CDA0FF88-2D00-46E0-828E-DD6F4FF4ADAF@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CDA0FF88-2D00-46E0-828E-DD6F4FF4ADAF@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Belisko Marek <marek.belisko@gmail.com>, mark.rutland@arm.com, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Tony Lindgren <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi!

> >>>>> to introduce coefficients for temperature and discharge rate?
> >>>> What do you mean? Nothing like that is used in current driver wh=
y do
> >>>> we need to add it?
> >>>=20
> >>> Well, conversion between Li-ion's voltage and state of charge at =
0
> >>> current is well known:
> >>=20
> >> We can=E2=80=99t measure at 0 current since the OMAP is driven fro=
m battery
> >> and charger and may also draw some mA=E2=80=A6
> >=20
> > Yes, but you know how many mA you are taking just now. So if you kn=
ew
> > the internal resistance, you could compute the voltage at 0
> > current. (And it should also work during charging, as long as you k=
now
> > how much current is going in.)
>=20
> As far as I understand the twl4030 charger and MADC it is not possibl=
e to
> separate these values. It is only reporting the inflow from charger t=
o
> battery + system. So you don=E2=80=99t know how many mA are supplying=
 the system
> and how many mA are left over for charging.
>=20
> You can only assume how much the system is drawing while running (som=
ething
> between 50 and 600 mA but this depends on system activities, power st=
ate
> of peripherald and e.g. backlight being switched on).
>=20
> I think your basic assumption that we know any time how many mA the s=
ystem
> is taking is not given.

So.. you won't be able to get exact value while charging, but you
get one while discharging, which is what really matters...?

> > Yes, and that coefficient should be internal battery resistance ;-)=
=2E
>=20
> But where do you know this value from to write it into a DT file?
> Usually you can=E2=80=99t measure it easily and for some batteries yo=
u don=E2=80=99t have
> a data sheet.
>=20
> Contrary, the calibration curves can easily be measured on the device
> (assuming that the charge level decreases/increases linearly over tim=
e
> between Full and Empty).

If you can copy it from the data sheet, that's the easiest option. If
not, you should be able to easily compute it from the charge/discharge
curves or from measured voltage at different loads.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
