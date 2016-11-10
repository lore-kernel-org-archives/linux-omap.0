From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM regression with LED changes in next-20161109
Date: Thu, 10 Nov 2016 21:29:10 +0100
Message-ID: <20161110202910.GE28832@amd>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
 <20161110162925.GA28832@amd>
 <20161110175537.GF27724@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vv4Sf/kQfcwinyKX"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161110175537.GF27724@atomide.com>
Sender: linux-leds-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Hans de Goede <hdegoede@redhat.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2016-11-10 10:55:37, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [161110 09:29]:
> > Hi!
> >=20
> > > >>>Looks like commit 883d32ce3385 ("leds: core: Add support for poll(=
)ing
> > > >>>the sysfs brightness attr for changes.") breaks runtime PM for me.
> > > >>>
> > > >>>On my omap dm3730 based test system, idle power consumption is ove=
r 70
> > > >>>times higher now with this patch! It goes from about 6mW for the c=
ore
> > > >>>system to over 440mW during idle meaning there's some busy timer n=
ow
> > > >>>active.
> > > >>>
> > > >>>Reverting this patch fixes the issue. Any ideas?
> >=20
> > Are you using any LED that toggles with high frequency? Like perhaps
> > LED that is lit when CPU is active?
>=20
> Yeah one of them seems to have cpu0 as the default trigger.

Aha. Its quite obvious we don't want to notify sysfs each time that
one is toggled, right?

IMO brightness should display max brightness for the trigger, as Hans
suggested, anything else is madness for trigger such as cpu activity.

Thanks and best regards,

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vv4Sf/kQfcwinyKX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgk2JYACgkQMOfwapXb+vIqvACgio501ouK+/EMLvFEPdOiKMuK
w2YAoINJ1X7Ehl/PKJDbBGVjpfYtg0Fr
=Vr2J
-----END PGP SIGNATURE-----

--vv4Sf/kQfcwinyKX--
