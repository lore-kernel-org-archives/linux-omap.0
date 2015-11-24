From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Gta04-owner] [PATCH 10/13] twl4030_charger: add software
 controlled linear charging mode.
Date: Tue, 24 Nov 2015 23:31:38 +0100
Message-ID: <20151124233138.077e1dba@kemnade.info>
References: <20150730001113.4012.18086.stgit@noble>
	<20150730001124.4012.27784.stgit@noble>
	<20150915112825.GA10704@amd>
	<87bncjjesu.fsf@notabene.neil.brown.name>
	<20151006143407.GA24518@xo-6d-61-c0.localdomain>
	<20151029172041.2a9cd266@kemnade.info>
	<20151114181216.GB20429@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/LmjN=weoj7YwIaLDFBW9PMh"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20151114181216.GB20429@amd>
Sender: linux-pm-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: List for communicating with real GTA04 owners <gta04-owner@goldelico.com>, Neil Brown <neil@brown.name>, Samuel Ortiz <sameo@linux.intel.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/LmjN=weoj7YwIaLDFBW9PMh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Nov 2015 19:12:16 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
> > > > Pavel Machek <pavel@ucw.cz> writes:
> > > > > On Thu 2015-07-30 10:11:24, NeilBrown wrote:
> > > > >>=20
> > > > >> Add a 'continuous' option for usb charging which enables
> > > > >> the "linear" charging mode of the twl4030.
> > > > >>=20
> > > > >> Linear charging does a good job with not-so-reliable power sourc=
es.
> > > > >> Auto mode does not work well as it switches off when voltage dro=
ps
> > > > >> momentarily.  Care must be taken not to over-charge.
> > > > >
> > > > > Can you explain how the user can "care not to over-charge"?
> > > >=20
> > > > The following text reads:
> > > >=20
> > > >     It was used with a bike hub dynamo since a year or so. In that =
case
> > > >     there are automatically charging stops when the cyclist needs a=
 break.
> > > >=20
> > > > so: take a break from cycling occasionally.
> > >=20
> > > If the charger does not exceed 4.2V, I'd not call it overcharge. (Yes=
, some clever
> > > chargers actually let the battery drop below 4.2V when charge is done=
, but...)
> > >=20
> > Yes, that is the case. Perhaps it is not to be called overcharge but
> > it is said that lithium battery charging has to stop if in CV mode the
> > current drops too low.  In automatic mode the charger does exactly
> > that.
> > I would not let a battery for days at 4.2V CV.mode although a lot
> > of cheap chargers
>=20
> Well, I agree that keeping battery at 4.2V constant voltage mode is
> bad, but I'd not call it overcharge. If someone can fix the comment,
> that would be nice.
>
here is my original comment ("on" was replaced by continuous "now"):

    twl4030_charger: add software controlled linear charging mode.
   =20
       adds a sysfs control node to achieve that.
       It can be set to
       auto: normal automatic charging is enabled (default)
       off: charging is off
       on: charing is on (software controlled)
           CC/CV mode is still automatically done,
           but end of charge due to low current not.
   =20
    Note: If linear charging mode is used there should be some method of
    stopping charging automatically. It is not a so time-critical, but
    it is the wrong setting for leaving a charger connected for several
days since Lithium batteries should not be kept at 100% for longer
periods. Linear charging does a good job with not so reliable power
sources, since several voltage controlling is then often too
intelligent. It was used with a bike hub dynamo since a year or so. In
that case there are automatically charging stops when the cyclist needs
a break. Signed-off-by: Andreas Kemnade <andreas@kemnade.info>


> > > If the charger _does_ exceed 4.2V, then the battery will explode. Don=
't do that. Don't
> > > offer that to the user.
> > >=20
> > > On a related note... I've just killed USB charger by overloading it. =
They are not protected.
> > >=20
> > > I believe your automatically-pull-max-power really should stick to th=
e well-known charging
> > > currents (.5A, 1A, 1.7A), at the very minimum.
> > >=20
> > The main reason for the patch was to prevent switching off charging
> > when Vbus drops low. The reason was not to get out extremely much
> > current out of the charger.
> > The electrical characteristics of a  bicycle as a power source are.
> > - the amount of current available changes
> >    - 500mA at around 17km/h
> > - you cannot destroy it by electrically overloading
> >=20
> > If the current is set to e.g. 500mA and that linear charging mode is
> > enabled, the battery gets the maximum current available (upto
> > 500mA) regardless of the speed which is often changing.
>=20
> Yes... I guess that makes sense for you, but I wonder if we should be
> doing this by default. It seems a lot of cheap chargers can be easily
> destroyed if you overload them.
>=20
Hmm, I guess the twl4030_charger would not be the only one destroying
such chargers. I have seen such hub dynamo-friendly behaviour on every
device I had connected to it before (an ipaq h2200, openmoko gta02).
I have checked all usb wall plug chargers I have seen and I found none
which has a lower current then 500mA. Only one has 500mA. The rest has
1A or even 2A.

But I think the non-ending cv stuff is a reason enough so that it is not
the default charge method. I use it only at bootup when battery is low
to have some time to fix charging issues manually and when cycling.
Cycling is detected by acceleration values and I get some feedback if
that charge mode is enabled or disabled.

Regards.
Andreas Kemnade

--Sig_/LmjN=weoj7YwIaLDFBW9PMh
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJWVOVLAAoJEGGrpYhZ30HuC/4H/3Q7ry7ccUBKEgHNpwMoaRSN
+ZDojNgztiV+o7vM28ktBQaAJV7bIIEHGMWlYWD1+gF4Fs5QCAPLgvcWGwIoAofD
Hs6DvW87hXTuahVNEZwsvA8iGDtARIYkBOFD+drEvGs68NJxGWbzGzgboOpOsQYr
GMja31Wid88azVSpl+rfhC7AsFVwfnaDDoQQ5KUj1oHXLKy68MSPnKtUlXgE2Jj7
HPwib3WnTNe5ojfoVYS3peNUy3enlJ9nqmbzzj/n3y5x18L42hsy9Fr2+I10lTzv
eQatHRFrotHT5giLrixNbzznv5OdSRB4LBSJvER1SJIxTFSiChJGoX87g7PKV9o=
=E1Pc
-----END PGP SIGNATURE-----

--Sig_/LmjN=weoj7YwIaLDFBW9PMh--
