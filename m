From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/5] usb: dwc3: ep0: use _roundup_ to calculate the
 transfer size
Date: Mon, 6 Jul 2015 14:00:03 -0500
Message-ID: <20150706190003.GM20779@saruman.tx.rr.com>
References: <1433927932-32395-1-git-send-email-kishon@ti.com>
 <1433927932-32395-2-git-send-email-kishon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p1Od3smaOkJqivj4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433927932-32395-2-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, gregkh@linuxfoundation.org
List-Id: linux-omap@vger.kernel.org

--p1Od3smaOkJqivj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2015 at 02:48:48PM +0530, Kishon Vijay Abraham I wrote:
> No functional change. Used _roundup_ macro to calculate the transfer
> size aligned to maxpacket in  dwc3_ep0_complete_data. It also makes it
> similar to how transfer size is calculated in __dwc3_ep0_do_control_data.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

doesn't apply, can you rebase on testing/next ?

--=20
balbi

--p1Od3smaOkJqivj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVmtAzAAoJEIaOsuA1yqRE5kQP/1goquDvjaMEcUH6aH9x3P7l
/jjRoCA9by/7VwsaN2YwomqdPrTAU+Y2wJA6BqJeFtT5XmxEy9XvI62mOdzE190C
TpxdzoVuuStJTjx4L5KcnOAPDrJwr3rKJYqXEiB8W/XV59iGKrLq+P0b00WbCuk4
9H3ZDPaekTXoaXzm/N8qo3gmKgikh6lMAtbTpvN26Z1OE9aNX5hHvy7ma3hpZ4Dm
VQAUVGqTkuBEtmBA9zyZy2ENSFLWuPZ3hxngBYykJrTSfCsYDtrmo7bjFVik00N7
3UkIBHxdcFEszYoqJ8QdLvpnTBJx9dKCK/tB4yxnod9eb1/lPYm7zbWotovY1ypK
AiFN5jO37MgArRrafOdNYq8FSkR/tSB+FktVB3foWVRM8QgBRpxCfxaLXAB2ptd/
CFQbkxF6135MecfxgSi9++Ku+LXxvRK1Xr0BfHOicmJ+2UIG1xoziuifHae12UPt
EWo6SU57PSJ2tNR5jnGZ26xzxHMPHWNAW2AcL8sViyeLB+lyHAQPvbn2b6IZ4kAN
CNZN6Pel2nuIv5Nzyr6i5VU4yEQuDjCVoxFd0DtI64KY3QxhpJoar1f+aoLq2JP9
rViV6BWymAbslEKURa3WHqXUxLYWLI30r27umSPT0fD796vugQkw9CTdpNMl9ec/
cdCx29/SmmArR5qYfUuY
=Tf1y
-----END PGP SIGNATURE-----

--p1Od3smaOkJqivj4--
