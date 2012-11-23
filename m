From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v4 05/11] pwm: pwm-tiecap: pinctrl support
Date: Fri, 23 Nov 2012 11:51:10 +0100
Message-ID: <20121123105110.GA6884@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-6-git-send-email-avinashphilip@ti.com>
 <20121122205944.GC16716@avionic-0098.adnet.avionic-design.de>
 <518397C60809E147AF5323E0420B992E3E9EE991@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2036185243435225448=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <518397C60809E147AF5323E0420B992E3E9EE991-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Cc: "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Hebbar,
 Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>, "Bedia, Vaibhav" <vaibhav.bedia-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--===============2036185243435225448==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2012 at 10:34:02AM +0000, Philip, Avinash wrote:
> On Fri, Nov 23, 2012 at 02:29:44, Thierry Reding wrote:
> > On Wed, Nov 21, 2012 at 06:41:02PM +0530, Philip, Avinash wrote:
> > [...]
> > > +	pinctrl =3D devm_pinctrl_get_select_default(&pdev->dev);
> > > +	if (IS_ERR(pinctrl))
> > > +		dev_warn(&pdev->dev, "failed to configure pins from driver\n");
> >=20
> > I think we already discussed this, but shouldn't this be a fatal error?
>=20
> I had checked relevant discussion and found this can be warning message.
> This is because most boards don't have pinctrl implemented at this point,
> or may never have.
>=20
> https://lkml.org/lkml/2012/9/11/369
>=20
> Any way I will change to
> dev_warn(&pdev->dev, "unable to select pin group\n");
> as in other drivers.

But in case pinctrl isn't implemented, shouldn't the implementation of
devm_pinctrl_get_select_default() just be a no-op?

Thierry

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQr1UeAAoJEN0jrNd/PrOhtp0P/3jPxTmRN9ImONWDo9JSKADw
qWlakenC0K01Q+q4bd4kGlwfLEFQqT4OxRTng5/E6UPgNEb1EeMjYltbpLacEN44
lpT859vobtjTAC3hSjJ+M+2uH0LKLflzN2OBXdwKXdr2VHpdrD58KqFSt5pKoTKH
fdyMHdbfGw0gFKDGgh7/4zqj4wOCF1GmjZ+cVGIDRkpCCMW9qXXQ83bE+0CGkx4E
iVPOOLODN/poWkAg4wVOnHU9AVt64IdSuTX+nzKrdZRgsyyw9lHxhJy9WDVli98h
2PXypzzy8yxj01rSPyUoQkt6qfu9hNWIKOLbKmFh7DnSJLrsm8ywqVmWIaJt1Jxv
N8/hfNyGaslUhwk6wQPNFWYFsT5mqeAH7GYMyeHbKgZo8XtoHkDuEUu3C0Zbjx5R
fG/GzbHxACqfBeF6xoWopjczxmrmYwhmGE4Jrc8PDWMEqQtwzhBZQGiBFbGRpVdn
am5s3VN7HfinTPhOjl7wCUv/+cksU3LN4NnU+QOd8V0vA7+Hmcuy0Px5qh6Hr2IV
WyEwA8/+wWndDit1944llxV9FJiAeig4h61X2iYRPmbCok3jyBSfnLtvFC9nmuif
OuijIcQzdhJA9986sPYjVO73lF1l19wShYOVFAdYGjN4TpuXnCxmxh3Vaj4kw9Zx
ZHZPuc1cKGaZlRBHz6ck
=0Z07
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--

--===============2036185243435225448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2036185243435225448==--
