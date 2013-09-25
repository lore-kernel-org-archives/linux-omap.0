From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH usb 1/2] usb: musb: Add missing ATOMIC_INIT_NOTIFIER_HEAD
Date: Wed, 25 Sep 2013 15:33:33 -0500
Message-ID: <20130925203333.GU10746@radagast>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <20130918164816.GN21559@radagast> <201309181903.33243@pali>
 <201309251017.39014@pali>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8148099519406578953=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201309251017.39014@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, linux-usb@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Anton Vorontsov <anton@enomsg.org>, Linux Kernel <linux-kernel@vger.kernel.org>, balbi@ti.com, freemangordon@abv.bg, Pavel Machek <pavel@ucw.cz>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============8148099519406578953==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4QzzFpAwbwI4hdN6"
Content-Disposition: inline

--4QzzFpAwbwI4hdN6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 25, 2013 at 10:17:38AM +0200, Pali Roh=E1r wrote:
> On Wednesday 18 September 2013 19:03:33 Pali Roh=E1r wrote:
> > &twl->phy.notifier is not initalized
> >=20
> > Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> >=20
> > diff --git a/drivers/usb/phy/phy-twl4030-usb.c
> > b/drivers/usb/phy/phy-twl4030-usb.c index 8f78d2d..efe6155
> > 100644
> > --- a/drivers/usb/phy/phy-twl4030-usb.c
> > +++ b/drivers/usb/phy/phy-twl4030-usb.c
> > @@ -705,6 +705,8 @@ static int twl4030_usb_probe(struct
> > platform_device *pdev) if (device_create_file(&pdev->dev,
> > &dev_attr_vbus)) dev_warn(&pdev->dev, "could not create sysfs
> > file\n");
> >=20
> > +	ATOMIC_INIT_NOTIFIER_HEAD(&twl->phy.notifier);
> > +
> >  	/* Our job is to use irqs and status from the power module
> >  	 * to keep the transceiver disabled when nothing's
> > connected. *
>=20
> I sent above patch week ago. Did you already included it?

look at my testing branch.

--=20
balbi

--4QzzFpAwbwI4hdN6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSQ0idAAoJEIaOsuA1yqRETvkP/00qKMIHusJX8O7XH/vSHkwR
+POrDoU06Cay14nUS7nWEVjNCH7N1shqK46Girevrbo4urlMZoDJhN0I1Q8lgenv
IZsihUkx8Q3AOMNFt0um80vbLL456s9dr4/4PwVXFHK2dkdfUoJqm90JNXGK1Pi4
QHxG8PVO1/6wFBtFgwj8YL1qZwFC6rqlwJCL/Q7orfS4AS6/TDy5p77wnS4md5Hx
ehcD22VrPAo7CcAufw24Y8yYUuIOJK/+F1PUvSVya90D42g5Rueh7V3jxt/GJwDx
ifTD23ENhNzvIU0GwOvLgYQYqDN8Gnx0FkF+UVQh5YrTZLIM1HB3UrHd7waIxNVO
UezaPxv48Ez60/t3tb3SU2dNDrEc89mA/jVD59+fysyg4RJwLbAlROjwOJRXsKQ8
cpuXRI2zH49JKkOuMvf0zhQxjlJvIuwyvof6wDc3iNuyXPypwRyUIgo8TxnIslgt
mIle9yxd+nVbZBrdFUmt2bVW7LuYHZy6krL4HR914b3Mbyd2uOccR92v0n2fRJ6f
cK0QHrocxVyXj4CyGTPyqRl2de0UYBkrlgkvf+n8tm1n4flylcBT7yhyNDkbHGQi
D4KzVabaZHvkBVlaOR/xT51Ttrm1T1MpgPywY4McLnTO0RQ8cxqAzSWRJXCZF61J
2F1KzfOEnDAazyl5qSRB
=80Pi
-----END PGP SIGNATURE-----

--4QzzFpAwbwI4hdN6--


--===============8148099519406578953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8148099519406578953==--
