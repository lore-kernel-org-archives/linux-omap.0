From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH, RFC 7/8] ARM: dts: am4372: initial support
Date: Tue, 19 Feb 2013 11:17:28 +0200
Message-ID: <20130219091728.GF23197@arwen.pp.htv.fi>
References: <cover.1361186097.git.afzal@ti.com>
 <c9c131c0508b875c0893e8557504372a1564568a.1361186097.git.afzal@ti.com>
 <20130218182240.GA10755@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EAA85B2@DBDE01.ent.ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1593171007927263183=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EAA85B2-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Nori,
 Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi,
 Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Syed Mohammed, Khasim" <khasim-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--===============1593171007927263183==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IvGM3kKqwtniy32b"
Content-Disposition: inline

--IvGM3kKqwtniy32b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2013 at 10:10:17AM +0100, Mohammed, Afzal wrote:
> Hi Felipe,
>=20
> On Mon, Feb 18, 2013 at 23:52:40, Balbi, Felipe wrote:
> > On Mon, Feb 18, 2013 at 05:08:16PM +0530, Afzal Mohammed wrote:
>=20
> > > +		uart1: serial@44e09000 {
> > > +			compatible =3D "ti,am4372-uart","ti,omap2-uart";
> > > +			clock-frequency =3D <48000000>;
> > > +			reg =3D <0x44e09000 0x2000>;
> > > +			interrupts =3D <0 72 0x4>;
> >=20
> > missing ti,hwmods ??
>=20
> It is a deliberate omission. For minimal bootconsole booting, hwmod
> help is not required. Hwmod details would be added gradually later,
> current series doesn't register hwmod.

understood, thanks

--=20
balbi

--IvGM3kKqwtniy32b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRI0MoAAoJEIaOsuA1yqREcWwP/0SaFx29vPQKn8AsgF5j9IPF
1m5/CxsFSpR3C+voOuJWLW/5JxYHWKiHNucYPyvoyafhFIj3nNrJERW6Bq5PGSSP
v+AhwNdsQczPSSgaCK+LM/dkssgAoGU8hjbrzSxAAXFYQmfATJqJBAmEDyWfrz4+
OJrAEAs76InLiC1eYaOgQQIPiHTEsPoWRYxHYQV2O+QKMwn9uMxinVauIVHZ1+2H
6mKUm1D7HMU7VudxytoMFDfPhDoNR4wlKg3Ri3mXhNG7zy0avyUxPkOyMo+1ycXM
cQ9HuZNLSNSdoVLuQtcidvNp439eZ0sn/8hZvZLx24PMD2G3laG0ZgIztpgMAhGy
kC6vE6+r4J3XH/Me1KftAkA3o1d58+lzzaF7NcplgC50HpwNvhSg1vhz4S5dA6BW
Q2KUpEkco7bv2p3vrpPcBjukfb4ISBUSIq4wYMvhrTiSLh/HDBw9WO3A4Kkwwk1w
CusS1IfhmmuTPJQ5aNchBCk1CQRZCQZnWH/hVg6uR04TH28hJSBCT2nzLuHmG53U
eRdmJqdzfjt5XA8yPbMspkrJKJLOcbLCzTZPb+gzAjr0JVfeTwtF+l+7N9cYH5oY
qGwNpZmxGCd8IfjPPRbKcnCngQCJT2VtVjQ0ACaunKsjsUZaVtS8lOEMkVK6F2WX
Dj7fH/YDqoaKjrdQbdx/
=SA+Y
-----END PGP SIGNATURE-----

--IvGM3kKqwtniy32b--

--===============1593171007927263183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============1593171007927263183==--
