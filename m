From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Thu, 31 Dec 2015 21:40:07 +0000
Message-ID: <20151231214007.GC16023@sirena.org.uk>
References: <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk>
 <568088B4.6090207@ti.com>
 <1451342963.14631.13.camel@collins>
 <5681D7A8.2030101@ti.com>
 <1451387613.18148.9.camel@collins>
 <568323B7.7080101@ti.com>
 <1451464521.2531.4.camel@collins>
 <20151230163307.GW16023@sirena.org.uk>
 <1451500639.14341.6.camel@collins>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ro1PRY3Rtw8g7IwX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1451500639.14341.6.camel@collins>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Cc: Milo Kim <milo.kim-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--Ro1PRY3Rtw8g7IwX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2015 at 07:37:19PM +0100, Paul Kocialkowski wrote:
> Le mercredi 30 d=E9cembre 2015 =E0 16:33 +0000, Mark Brown a =E9crit :
> > On Wed, Dec 30, 2015 at 09:35:21AM +0100, Paul Kocialkowski wrote:

> > > In my opinion, it would be more elegant to adapt the core regulator
> > > framework to first enable the GPIO and then call the regulator enable
> > > ops callback instead of handling the GPIO in the driver.

> > Why would we want to actively manage both things at runtime?  It's more
> > work, what do we gain from it?

> Well, I figured that it would be best to disable the EN pin when we're
> not using any of the regulators, since that allows the chip to enter
> standby mode (and thus consume less power).

This doesn't sound like it's anything to do with the regulators, that's
a chip wide power management function which should be implemented via
runtime PM if there's any value in implementing it at all (if the device
is a primary PMIC normally this would be handled by the CPU core when it
enters low power state without any software).  It's not something we
should be considering on a per regulator basis since it's at the chip
level and on a per regulator basis it's not doing anything useful for
the reasons above.

> It also doesn't hurt regulators that only use a GPIO for enable.

It causes problems for any device with an optional GPIO,  it means that
we end up mantaining both GPIO and register which as I've said a couple
of times now defeats the point of having the GPIO.

--Ro1PRY3Rtw8g7IwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWhaC3AAoJECTWi3JdVIfQDb4H/AlSsd6XLfq9Otsz4axkNChr
/7EKdNYcYk2bYTCorbUgPFH8g33n2kv/z3Q5HgFdIVR+vztG2h15qaIdEXEak/KM
Ve4hBbQYgULkbcIPJYuL1MRhRCCRrpfBm+fRlWnrcWbrD639wSfNQ+qdt1AwTQl8
EZfYYeWpQBq4dApObt/bbZLyOm+RlhLmjHy/UKZNcka/v3CKKKsmVvE0UL9STGXC
uOx97/owgDyxoSAFWA1eYcN1cSDwruwLU4woG/TQ9vgOj2KDiBCt9fFnxapDjVj+
Ny5v9C12moxprpjfmt/Lgq3kaZ6PApaTs4QemCOvzcnaax99JWloL4zNEVME2Uk=
=5n9K
-----END PGP SIGNATURE-----

--Ro1PRY3Rtw8g7IwX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
