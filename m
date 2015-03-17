From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH v3 3/6] Documentation: DT: Document twl4030-madc-battery
 bindings
Date: Tue, 17 Mar 2015 11:37:46 +0100
Message-ID: <20150317103746.GB3759@amd>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
 <1423088075-10025-4-git-send-email-marek@goldelico.com>
 <20150316210532.GA11441@amd>
 <CAAfyv34vnRY=TAyx4+7s1SW7rVE7CFh9z+OOcCsbCx63y9aVog@mail.gmail.com>
 <20150317084730.GA9761@amd>
 <940EE988-03A4-4B1B-A168-959E367953A6@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <940EE988-03A4-4B1B-A168-959E367953A6-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux PM mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> >>> to introduce coefficients for temperature and discharge rate?
> >> What do you mean? Nothing like that is used in current driver why =
do
> >> we need to add it?
> >=20
> > Well, conversion between Li-ion's voltage and state of charge at 0
> > current is well known:
>=20
> We can=E2=80=99t measure at 0 current since the OMAP is driven from b=
attery
> and charger and may also draw some mA=E2=80=A6

Yes, but you know how many mA you are taking just now. So if you knew
the internal resistance, you could compute the voltage at 0
current. (And it should also work during charging, as long as you know
how much current is going in.)

> >    def percent(m, v):
> >    	u =3D 0.0387-(1.4523*(3.7835-v))
> >        if u < 0:
> >            return 0
> >          return (0.1966+math.sqrt(u))*100
> >=20
> > And there's not much to calibrate there, and it should become libra=
ry
> > helper function; there's no need to write it to every single dts.
> >=20
> > The charge/discharge difference is due to internal battery resistan=
ce,
> > and Ohm's law. (Then, you should not need different values for
> > charging/discharging case.)
>=20
> Yes, and that also depends on the board and battery type. So you alwa=
ys
> need to specify some battery specific coefficient for that in the DT.

Yes, and that coefficient should be internal battery resistance ;-).

> We simply did choose a table, because calculating the right coefficie=
nts
> is more complex and getting the table values can easily be done from
> running one full charge-discharge-charge cycle.

Well.. One set of coefficients would be kind of ok. But you are doing
two, because it really depends on current, not charge/discharge. So
why not do it right, for all currents...?

> > With your aproach, you'll get lower percentage when phone is under
> > load vs. idle. Taking internal resistance into account would give y=
ou
> > more precise readings. (Attached, old patch for zaurus shows the
> > needed computation).
>=20
> This is why we have a charging and a discharging table to compensate
> for this effect.

Yes, but there's very different current during "idle" phone and during
call (for example). So yes, you are compensating for different current
during charge and discharge, but it is possible to do better.

> > I guess this should go into library somewhere, because many machine=
s
> > need similar code.
>=20
> Is a library easier to maintain and handle than just a set of table
> values?

I think so, yes, because otherwise you need a set of tables for each
machine.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
