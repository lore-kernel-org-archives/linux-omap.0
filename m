From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 0/3] misc: new serdev based drivers for w2sg00x4 GPS module
 and w2cbw003 wifi/bluetooth
Date: Thu, 25 May 2017 19:05:40 +0200
Message-ID: <20170525170540.GF3085@amd>
References: <cover.1495363443.git.hns@goldelico.com>
 <CAL_Jsq+fmi2QwE7J8xv47ece1b+jqnOo99NghfjtocnrRvBkPg@mail.gmail.com>
 <78B1501A-B9AD-4C6E-A481-26F647AA2BCE@goldelico.com>
 <CAL_JsqJamBBggr9AOQtQWtZOG+FevK1XEU_D=nYL6=hyvjviVw@mail.gmail.com>
 <0D94BEA0-F98D-48F6-9DDC-99F932AE7834@goldelico.com>
 <CAL_JsqK5NxL+rHU2enW0Lo+e+HThp-iK3hpW-UxeFREbivRZOw@mail.gmail.com>
 <889E8F7F-FC0F-490E-B924-D04D9F4D3402@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <889E8F7F-FC0F-490E-B924-D04D9F4D3402@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com, Marcel Holtmann <marcel@holtmann.org>
List-Id: linux-omap@vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > You don't need hciattach. All userspace has to do for kernel BT
> > drivers is "hciconfig hci0 up|down".
>=20
> Hm. Well:
>=20
> root@letux:~# hciconfig hci0 up
> Can't get device info: No such device
> root@letux:~#
>=20
> I wonder how I can tell hciconfig about the UART port if not by running h=
ciattach /dev/ttyBT0?

You should not have to tell hciconfig about ttyBT0. Kernel should
automatically setup hci0<->ttyBT0 connection during boot, based on the
device tree.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlknDuQACgkQMOfwapXb+vLfygCglwuirnlxs5N9xPDBEzgZCPoM
ao0AnRVwl260eN43zizM2TXLywWfwLM/
=ULag
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
