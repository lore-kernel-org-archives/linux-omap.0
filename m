From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Gta04-owner] [PATCH 10/13] twl4030_charger: add software
 controlled linear charging mode.
Date: Thu, 29 Oct 2015 17:20:41 +0100
Message-ID: <20151029172041.2a9cd266@kemnade.info>
References: <20150730001113.4012.18086.stgit@noble>
	<20150730001124.4012.27784.stgit@noble>
	<20150915112825.GA10704@amd>
	<87bncjjesu.fsf@notabene.neil.brown.name>
	<20151006143407.GA24518@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/rC2ulWdBFfVx_2OVBosjsK/"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20151006143407.GA24518@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
To: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>
Cc: pavel@ucw.cz, Neil Brown <neil@brown.name>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/rC2ulWdBFfVx_2OVBosjsK/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Oct 2015 16:34:07 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
> > Pavel Machek <pavel@ucw.cz> writes:
> > > On Thu 2015-07-30 10:11:24, NeilBrown wrote:
> > >>=20
> > >> Add a 'continuous' option for usb charging which enables
> > >> the "linear" charging mode of the twl4030.
> > >>=20
> > >> Linear charging does a good job with not-so-reliable power sources.
> > >> Auto mode does not work well as it switches off when voltage drops
> > >> momentarily.  Care must be taken not to over-charge.
> > >
> > > Can you explain how the user can "care not to over-charge"?
> >=20
> > The following text reads:
> >=20
> >     It was used with a bike hub dynamo since a year or so. In that case
> >     there are automatically charging stops when the cyclist needs a bre=
ak.
> >=20
> > so: take a break from cycling occasionally.
>=20
> If the charger does not exceed 4.2V, I'd not call it overcharge. (Yes, so=
me clever
> chargers actually let the battery drop below 4.2V when charge is done, bu=
t...)
>=20
Yes, that is the case. Perhaps it is not to be called overcharge but
it is said that lithium battery charging has to stop if in CV mode the
current drops too low.  In automatic mode the charger does exactly
that.
I would not let a battery for days at 4.2V CV.mode although a lot
of cheap chargers=20

> If the charger _does_ exceed 4.2V, then the battery will explode. Don't d=
o that. Don't
> offer that to the user.
>=20
> On a related note... I've just killed USB charger by overloading it. They=
 are not protected.
>=20
> I believe your automatically-pull-max-power really should stick to the we=
ll-known charging
> currents (.5A, 1A, 1.7A), at the very minimum.
>=20
The main reason for the patch was to prevent switching off charging
when Vbus drops low. The reason was not to get out extremely much
current out of the charger.
The electrical characteristics of a  bicycle as a power source are.
- the amount of current available changes
   - 500mA at around 17km/h
- you cannot destroy it by electrically overloading

If the current is set to e.g. 500mA and that linear charging mode is
enabled, the battery gets the maximum current available (upto
500mA) regardless of the speed which is often changing.

Regards,
Andreas Kemnade

--Sig_/rC2ulWdBFfVx_2OVBosjsK/
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJWMkdZAAoJEGGrpYhZ30HuhBkH/2m+Wd5ndAIys/PSMzIIJIVj
UuDxlzstsPqh/MK6PRi74LipdMAID6nECBsxPlrjNs2Ef2Mx2Kzq0XKDJctJHZIw
SSBTU5mb260Vas36wZvfD/lBdYIaSuwAyrzmXEaggT8FxjC5snvTE1ECKP0pdMPT
bJqtgg3/DZZBI/TqJmjTSSuDXl5XiGIKuyyLCPYWO70zMNvsGOsDOddPxAJIyQo2
yYpc9tF27O7C6ptD2e0Nm3uryqD8nvSmqa3YC48DJpY82J6DnuYAYM8t5pCJfguK
a6rbxgFMfDehpbX0Q0WYUFOYCmTr20qReiCl7hesPqXVT9OCRPyHo3FaLdsXgA8=
=/9dB
-----END PGP SIGNATURE-----

--Sig_/rC2ulWdBFfVx_2OVBosjsK/--
