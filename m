From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Thu, 21 Jan 2016 16:26:46 +0000
Message-ID: <20160121162646.GK6588@sirena.org.uk>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
 <20160120164258.GF6588@sirena.org.uk>
 <20160121080524.27af489f@ipc1.ka-ro>
 <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
 <20160121111115.GJ6588@sirena.org.uk>
 <20160121123311.5346e40d@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eJpN0D5W9Nffl1c7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160121123311.5346e40d-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--eJpN0D5W9Nffl1c7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 12:33:11PM +0100, Lothar Wa=DFmann wrote:
> > On Thu, Jan 21, 2016 at 11:26:11AM +0100, Lothar Wa=DFmann wrote:
> > > > On Thu, Jan 21, 2016 at 08:05:24AM +0100, Lothar Wa=DFmann wrote:
> > > > > > On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa=DFmann wrot=
e:

> > > > > > > This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> > > > > > > electronics TX48 module. Make the IRQ optional in the driver =
and use a
> > > > > > > polling routine instead if no IRQ is specified in DT.
> > > > > > > Otherwise the driver will continuously generate interrupts an=
d make
> > > > > > > the system unusable.

> It won't. That's the whole purpose of this patch.
> I'm afraid, I don't quite understand what you want to say...

Your commit message (quoted above) claims that without this patch if no
interrupt is supplied then the unsupplied interrupt will somehow be left
screaming and make the system unusable.  This doesn't make sense, if
there is no interrupt there is nothing to scream.

> Without this patch there will be a constantly active interrupt, which
> will stall the system because the nNMI interrupt (on the EXTINTn pin) is
> level triggered.
> Since the polarity of the interrupt input is fixed, there is no way to
> use it in our HW.

So, contrary to what you've been saying, the interrupt is actually
connected (and worse, connected to a NMI) but apparently not described
in DT.  Why is it sensible to make the driver poll (which will affect
all systems using this device, even those that don't care) and not just
describe the interrupt in DT so it can be handled promptly in the normal
fashion?  Presumably this will run into serious problems if the
interrupt actually fires at runtime since the NMI will scream, it's not
clear to me how the poll will manage to run successfully in that case.

This really feels like a very system specific workaround which is
attempting to address things in the wrong place and coming up with
something very non-obvious as a result.

--eJpN0D5W9Nffl1c7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWoQbFAAoJECTWi3JdVIfQQQUH/Amafmd4EIoMHLytpYVzneH9
pk6d9qXm/PVEzN3tUpWNvO88Inu2itimAl/VADnwlQJlH5yQKWGpXIe33DrsAxCN
7A1gKmH6bNWttCEUzDH1mYVDEmkiE5bb5iOUHXwaj/RVgBwt4ZMfcBg/pfaI63CZ
F/VP/TKS5yZpyf8HvM1dN30zMl8S6eSAlzxehhi/oCMb5z7l9t6J4H1XA0ftIpO7
JOsmPhqcgypCSQQz7IQKFyy9IfcUkNuc+DZOLFX9Q7yuJreOdo8STkcZERtc5wSK
N6fGD5rEtcatU+YNilOJ720GiOFsW4rL5dtIgJyQfZAr5hYgyWNji1SGhp1YSnY=
=3Q/K
-----END PGP SIGNATURE-----

--eJpN0D5W9Nffl1c7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
