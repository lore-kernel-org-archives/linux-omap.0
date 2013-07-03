From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/8] wlcore: set irq_flags in the board files instead
 of hiding behind a quirk
Date: Wed, 3 Jul 2013 17:23:11 +0300
Message-ID: <20130703142310.GT15056@arwen.pp.htv.fi>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-3-git-send-email-coelho@ti.com>
 <20130703141332.GO15056@arwen.pp.htv.fi>
 <1372861094.21065.118.camel@cumari.coelho.fi>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2768829520310248056=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1372861094.21065.118.camel-eHkr6bJ9aPyyenC2BZ5AVw@public.gmane.org>
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
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: nm-l0cyMroinI0@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============2768829520310248056==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eNjIDde0W37E3OQP"
Content-Disposition: inline

--eNjIDde0W37E3OQP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2013 at 05:18:14PM +0300, Luciano Coelho wrote:
> On Wed, 2013-07-03 at 17:13 +0300, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Wed, Jul 03, 2013 at 05:03:23PM +0300, Luciano Coelho wrote:
> > > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap=
2/board-4430sdp.c
> > > index 56a9a4f..953f620 100644
> > > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > > @@ -703,12 +703,30 @@ static void __init omap4_sdp4430_wifi_init(void)
> > > =20
> > >  	omap4_sdp4430_wifi_mux_init();
> > >  	omap4_sdp4430_wlan_data.irq =3D gpio_to_irq(GPIO_WIFI_IRQ);
> > > +
> > > +	ret =3D gpio_request_one(GPIO_WIFI_IRQ, GPIOF_IN, "GPIO_WIFI_IRQ");
> > > +	if (ret) {
> > > +		pr_err("error requesting wl12xx gpio: %d\n", ret);
> > > +		goto out;
> > > +	}
> > > +
> > > +	ret =3D irq_set_irq_type(gpio_to_irq(GPIO_WIFI_IRQ), IRQ_TYPE_LEVEL=
_HIGH);
> > > +	if (ret) {
> > > +		pr_err("error setting wl12xx irq type: %d\n", ret);
> > > +		goto free;
> > > +	}
> > > +
> > >  	ret =3D wl12xx_set_platform_data(&omap4_sdp4430_wlan_data);
> > >  	if (ret)
> > >  		pr_err("Error setting wl12xx data: %d\n", ret);
> > > +
> > >  	ret =3D platform_device_register(&omap_vwlan_device);
> > >  	if (ret)
> > >  		pr_err("Error registering wl12xx device: %d\n", ret);
> > > +out:
> > > +	return;
> > > +free:
> > > +	gpio_free(GPIO_WIFI_IRQ);
> >=20
> > actually, you should leave this GPIO requested in order to use it as
> > IRQ.
> >=20
> > ditto for all others
>=20
> Actually, I don't need to use the GPIO if something goes wrong (ie.
> setting the IRQ type or setting the platform data).  Notice that in the
> normal cases (ie. without errors), I return before the gpio_free() is
> called.

hah, missed the 'return' call, my bad :-p

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Corrected-my-broken-eye-sight-by: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>

--=20
balbi

--eNjIDde0W37E3OQP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR1DPOAAoJEIaOsuA1yqRE+w8P/0vQAxjiyRYAtmuG7gTmnMGz
u2DloE0dnB4ex82cDGkDd5bWRNrmZ21MD4CTY5Dpb/i8k5mVnPr/IxNpp7ewJTWZ
WRNlHD7Trwx0B6Bxl93GSpf+rLUWjWsWkch1bWobCl1QjbBHiG+zSSFEtrgq9VCi
rMJTkbgIH0P52O06d0LUU7TuexoRQ6kkXE1yL+EV+y4eZs8UCRd4vkVbRfVloBkr
YGh2k7GIInGfNCjw2g1V83zVrBYKom+qVu4QgomDjEmNFBaLt6lVKDGra5dcXtbA
7WjX+tTgyL9uzDhixQrmzAbe+xyFTdb4iRm2ewyBSzqiTe4Tp5B8FLjyHN4lYVfv
QjIV+cbidsTbFRc/2cBQ3X8OAUEGbR9lPIibF0msQtsM0teNJcd/FJYY09nHn9BV
AIBfxUHmNPOFCHjvhOJQZy4w6MBfIWPY6/OSqNSYqpb+C6WgQbq/asJDw2XMJWdN
4TWxMOC4XXTWrkN8+2pwunSKE0jb9loadmpPcthZOUD6CPcT/LCpJ9THWhX1d+wn
WsXy3q6NZFLMMAEjr+PhydloWmPPiaQbJGoQbuy4OKin1iKjevcmZ1K1AFj1fory
XiUYhF0vmn/aGqMu+yVfma4CJg8ZIYQb+ewAY0985gYLwKOh4bn4tE6U70WTZJJy
y1OlYToV2A0Zkq0R0XJI
=6rpb
-----END PGP SIGNATURE-----

--eNjIDde0W37E3OQP--

--===============2768829520310248056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2768829520310248056==--
