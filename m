From: Pavel Machek <pavel@ucw.cz>
Subject: Re: PM regression with LED changes in next-20161109
Date: Thu, 10 Nov 2016 17:29:25 +0100
Message-ID: <20161110162925.GA28832@amd>
References: <20161109192301.GS26979@atomide.com>
 <28234714-3994-6747-9cf8-1ff0b3257f7a@gmail.com>
 <CGME20161110084919epcas3p2e8fbdd2905cabe15c5301b7a8e22416c@epcas3p2.samsung.com>
 <f627c778-4378-e5da-09dd-3e0fb2ea4aba@redhat.com>
 <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5bd5333e-0dbb-6333-0a48-ca4d3a990f9c@samsung.com>
Sender: linux-leds-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>
List-Id: linux-omap@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>Looks like commit 883d32ce3385 ("leds: core: Add support for poll()ing
> >>>the sysfs brightness attr for changes.") breaks runtime PM for me.
> >>>
> >>>On my omap dm3730 based test system, idle power consumption is over 70
> >>>times higher now with this patch! It goes from about 6mW for the core
> >>>system to over 440mW during idle meaning there's some busy timer now
> >>>active.
> >>>
> >>>Reverting this patch fixes the issue. Any ideas?

Are you using any LED that toggles with high frequency? Like perhaps
LED that is lit when CPU is active?

> >So a user can do "echo 128 > brightness && cat brightness" and
> >get out 0, or 128, depending purely on timing.
=2E..
> >                Reading from this file while a trigger is active returns
> >the
> >                top brightness trigger is going to use.

Yes, that sounds sane.

> It seems that we should get back to your initial approach. i.e. only
> brightness changes caused by hardware should be reported.

I don't think enabling poll() here is good idea. Some hardware won't
be able to tell you that it changed the state. Returning maximum
brightness trigger is going to use seems easier/better.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgkoGUACgkQMOfwapXb+vIeUACfR+m0VBKjiMJ/lvoDj5sKGhVo
PjYAmwcXhoSwYjC3N3GJ6sCs022yU9eq
=wFaW
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
