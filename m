From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Backlight in motorola Droid 4
Date: Tue, 30 Jul 2019 23:52:33 +0200
Message-ID: <20190730215233.GB9405@amd>
References: <20181219162626.12297-1-dmurphy@ti.com>
 <20190722205921.GA24787@amd>
 <b8fbc94f-c087-2c9d-4532-ea423f1626e6@ti.com>
 <20190724124530.GA30211@amd>
 <ca69f627-96e2-f982-3a29-18b0127ac6e5@ti.com>
 <edde330e-516b-ecaa-4139-0bfa766a9c08@ti.com>
 <20190729220030.GA20100@amd>
 <ff91f577-98ad-d27b-02c2-6ed495cf4a38@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ff91f577-98ad-d27b-02c2-6ed495cf4a38@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, jacek.anaszewski@gmail.com, linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>Looking at the rest of the code.
> >>>
> >>>The DT doc indicated that this was a required child property so this is
> >>>why it
> >>>
> >>>errors out.
> >>>
> >>>Dan
> >>>
> >>><snip>
> >>>
> >>Did you want me to fix up the LM3532 and send the patch?
> >If you could do that, that would be nice :-).
>=20
> Ok I am working on this.

Thanks!

> Is Droid4 supposed to boot off of mainline?=A0 I see blogs stating it
>  should

> but the device locks up when it jumps to the kernel 5.3-rc1.

It should, but I'm not sure if video will work for you. -next may be
better target.

If you have different board with lm3532, it may make sense to use that.

> Unless I need to update my kexec or boot.cfg file but I cannot find any up
> to date info on that.

I don't know what boot.cfg is. I'm using safestrap to dual-boot
between Android and mainline.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1AvCEACgkQMOfwapXb+vIU0ACfVbS3WrpVraASIUWPfLIZLo5r
ZpwAmwfCSRWvlx5KpSt4NYmWE8RoNk2i
=saCx
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
