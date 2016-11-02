From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval
 property query
Date: Wed, 2 Nov 2016 09:22:06 +0100
Message-ID: <20161102082206.GE21488@amd>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
 <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
 <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
 <20161024201443.GB5989@amd>
 <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
 <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
 <20161031213846.GA21014@amd>
 <CAKzfze8Bom1XYRfiix_qYFckMggUD0eJm3Fz=GhNi6H_PBFyXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKzfze8Bom1XYRfiix_qYFckMggUD0eJm3Fz=GhNi6H_PBFyXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: Matt Ranostay <matt@ranostay.consulting>, pali.rohar@gmail.com, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, serge@hallyn.com, =?utf-8?B?TWlja3Vsw6HFoQ==?= Qwertz <abcloriens@gmail.com>
List-Id: linux-omap@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> >> Better then previous one.
> >> >>
> >> >> But my version of bq27xxx_battery.c already contains this:
> >> >
> >> > This is for allowing udev rule to set the properties as well.
> >> > otherwise a kinda crude RUN =3D " echo value >
> >> > /sys/module/bq27xxx_battery/parameters/poll_interval" is required.
> >>
> >> Any thoughts on this?
> >
> > I'd say  echo value >
> > /sys/module/bq27xxx_battery/parameters/poll_interval .. is quite
> > adequate solution...?
> >
> > Alternatively, convince us that something else is useful for everyone,
> > and we can do the right thing (poll more often when battery is nearly
> > empty), automatically...
>=20
> Ok should have had the patchset set it per device, and not use the
> global poll_interval. Of need to add some logic to see if uses the
> global poll_interval or it's own setting.
>=20
> There are times where you could have multiple batteries connected to
> multiple fuel gauges, and want to up the polling interval on certain
> ones that are discharging at different rates.
>=20
> But of course I'll let you guys let me know if this seems useful at all.

I agree per-device polling would be cleaner.

But unless you have hardware with more than one bq27xxx, I'd avoid the
work...

Now... its also possible that poll_interval should change itself
(within kernel) to do the right thing.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgZoi0ACgkQMOfwapXb+vLSKQCgsxrli5H77QV7lr9M3wlYm5Va
aQkAoLgZXf5Oe0K8ozBRq9uj5ab8vJDI
=kryH
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
