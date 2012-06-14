From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 09/17] i2c: omap: ack IRQ in parts
Date: Thu, 14 Jun 2012 14:47:14 +0300
Message-ID: <20120614114712.GR13602@arwen.pp.htv.fi>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-10-git-send-email-balbi@ti.com>
 <20120614112017.GC31187@n2100.arm.linux.org.uk>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xe2geHXJg22At20M"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120614112017.GC31187-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--xe2geHXJg22At20M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2012 at 12:20:17PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 14, 2012 at 01:20:42PM +0300, Felipe Balbi wrote:
> > According to flow diagrams on OMAP TRMs,
> > we should ACK the IRQ as they happen.
>=20
> You don't explain that you're adding a new dev_err() statement into the
> driver for a missing acknowledge.
>=20
> What if you're probing for a device - can this cause spam to the kernel
> console?  What if you have protocol mangling enabled with the "ignore
> lack of ack bit set" ?

indeed... maybe dev_vdbg() would fit better, or just don't add anything.

--=20
balbi

--xe2geHXJg22At20M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP2c9AAAoJEIaOsuA1yqREsvMP/iE7gkRyWCUUbOpBdHz7G/sr
4lnz//06Dmx3HcX63y+b6SeXc82fEfJ10BvNBAfiXQTP4BXuLFBO2EPPClipCpoQ
8kZacT5YCbRVAYCApBySse/Zl4qKYQuNjq+Ee5ubZoz57sUpVCJ0umqesxgcwCA/
+nE171OCCFqZJWOEnlKZQjOJV3aVoJ8tMCngmJKmshr412Uyn6Owua/wcLWyUK4X
EjVmmjYs6g1DBXx5aoGv3gWYFMl2ATCzvRyuqr2//RdNvgkmybgG/h5yFOoko+mO
O+WtO19BFyPt/QPJGfGqEGWTfMNLcv2QvCs3kCISmVwrOHHVn2IiAjdkNC0BPFW1
Z3LuJfzlqE0G6WbXPzTWzQJc1kIsE0yzbi6Ul/FvokSiPhF+m+hwPWrVgCmlU8BT
Xm6SC0IXhOJuQWTfEN+BWBfShxPKp1UXBOLBcYM99bYGxYrV96Vd08/czksBcH6v
+44ntW6SwKplibfBG8Z769EtFfE7979UNpEsqf36eT0ChraHAUdwnYJRUr6X9812
B8LA/5zF8rfpRgk1lnm8MQInethtObuQlE2MJsuyi8OqGQpVGyxzvvJHDywI6fYY
DtaAOcLdyJSVke+fB9gfSBwydKMUXmEfiEPf+m+Wxis+HwDXyJGjGfPn1xxuFPku
asPlHZgdO7ODub1TP88Z
=pFLX
-----END PGP SIGNATURE-----

--xe2geHXJg22At20M--
