From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 4/4] USB: OMAP1: Tahvo USB transceiver driver
Date: Sat, 7 Dec 2013 11:51:27 -0600
Message-ID: <20131207175127.GA12628@saruman.home>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
 <1386339187-28466-5-git-send-email-aaro.koskinen@iki.fi>
 <20131206204629.GL21086@saruman.home>
 <20131207141623.GL30823@blackmetal.musicnaut.iki.fi>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1005806735582659599=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131207141623.GL30823@blackmetal.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

--===============1005806735582659599==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 07, 2013 at 04:16:23PM +0200, Aaro Koskinen wrote:
> > fixed it up with:
> >
> > diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
> > index 7cf1766..8bb833e 100644
> > --- a/drivers/usb/phy/phy-tahvo.c
> > +++ b/drivers/usb/phy/phy-tahvo.c
> > @@ -368,7 +368,9 @@ static int tahvo_usb_probe(struct platform_device *=
pdev)
> > =20
> >  	tu->extcon.name =3D DRIVER_NAME;
> >  	tu->extcon.supported_cable =3D tahvo_cable;
> > -	ret =3D extcon_dev_register(&tu->extcon, &pdev->dev);
> > +	tu->extcon.dev.parent =3D &pdev->dev;
> > +
> > +	ret =3D extcon_dev_register(&tu->extcon);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "could not register extcon device: %d\n",
> >  			ret);
> >=20
> > please make sure it still works with v3.13-rc2 + this patch.
>=20
> Yes, that works fine with 3.13-rc2. Sorry for this, I was accidentally

cool, thanks :-)

> testing & basing these patches on an old branch.

no problem, s**t happens to everybody :-)

--=20
balbi

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSo2AfAAoJEIaOsuA1yqRExKQQAI+jwEA4R3x5DfL4Z9N99BMa
rJzhUrOawT/TucU1dXJ0TfwMQN/AOyhYYvn7R8MAi5X9opDd1doEhrchthL3hKs9
8/XMI+S304uJwGmW/Qv1nFK1A+5ZEpmA265K3wSn0wQzpAHyvYJ/j2D7fMbB0dsU
P+vynHzaQ9+hwoZ+qFn4Hus2Cikc1O3YJaLuzpkfXk31SyQMOjMxAQ6T4LjhA0uS
xoeHDO7EyiewMiKHKaauB79l9h42/ylMjX91fx9ZAGj2iuJnZ86JX4zOgJClCPai
fov6So5t9Sij7MB+dQ5KSnlemna3O4D7p+p0xN6clUpFvpupwgg6kPkce6IeP5qP
tE9j57QQKqZE6Y9+f8bYFjtp1vwc9JKvQQ+gqhIkHBy9VAbm476PZhPsloPtTveM
goqaKo0VJ3XfnLe5b2zYy7QMWDwbmImHHgUrOOZvfs111LK9w9IDHEaS1a7g1J88
Yqonr+6itm/rtOVH30VQyZ6rFo5+P6ciBJrBg38hH0en2EePZWs2L1U9b4fTY3r1
AiAi6WpelKQRJYARoXaD0QKRoEhJdI8klRS/EOkRKf7WYpCB0mnl6mhdSY3XEG/V
kdVdY33QaQHTzSDG/wLm0tv1n28CNPwBJuieUoX9wMir6LdDxYFDs7bOfBtAhpgx
uL30Gof/b9KToEWp6z/g
=osdM
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--


--===============1005806735582659599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1005806735582659599==--
