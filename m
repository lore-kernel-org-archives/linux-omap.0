From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix tusb6010 GPIO interrupt for n8x0
Date: Mon, 25 Jun 2012 12:38:59 +0300
Message-ID: <20120625093858.GA6468@arwen.pp.htv.fi>
References: <20120613101303.18645.83320.stgit@muffinssi.local>
 <20120613101512.18645.12865.stgit@muffinssi.local>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3363193800237930603=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120613101512.18645.12865.stgit@muffinssi.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============3363193800237930603==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2012 at 03:15:12AM -0700, Tony Lindgren wrote:
> Here's one more gpio_to_irq conversion that we missed
> earlier. Tested with n800 in gadget mode using USB_ETH.
>=20
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/usb-tusb6010.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb=
-tusb6010.c
> index db84a46..805bea6 100644
> --- a/arch/arm/mach-omap2/usb-tusb6010.c
> +++ b/arch/arm/mach-omap2/usb-tusb6010.c
> @@ -300,7 +300,7 @@ tusb6010_setup_interface(struct musb_hdrc_platform_da=
ta *data,
>  		printk(error, 3, status);
>  		return status;
>  	}
> -	tusb_resources[2].start =3D irq + IH_GPIO_BASE;
> +	tusb_resources[2].start =3D gpio_to_irq(irq);
> =20
>  	/* set up memory timings ... can speed them up later */
>  	if (!ps_refclk) {
>=20

--=20
balbi

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6DGxAAoJEIaOsuA1yqREqMIP/012LNrnsyG1QFbEqt2jApjT
BlLma4IS53eZNFXcIJ3Wm6hoiKq03ihgyYnBouTGoLzVBL47k+E2zTrkqouyzDHK
ymMjaZPeCgCmEnUEPrd7ukHFxZwvYvpGPSsHYGxWUOXg1JdbAvpPGtIXGzaU5dtm
hO5/B4H92LVQNOX1ud5GRKJ0mMxEZzcoxReASASxYEpBVLHnGr+xzddXXQ/nuxhY
D3IQDFTtMiLasheo2ifEllHi4+cWtjIktlHNAQnnGeatbdRk8eksCmBdAMyzSO/y
p1ZnGRhgd3UOBQt0STIW23JGBITR3gWCCJvclp98FeKmbai+TscN63xG36ZyNfah
ETtBTDZcpwdVqBoNipJwSfjBZh5IuNUo9NNl9t41AZX8A1v3StlYEiX8kkUfZkNU
lf6pxS0Vx2X1NlTzJ3PgMSTj+BKIIRdk+w6OZ1grYod15G0B3XY/8XDIK3yO7Zm1
gwoUeo85IKGSs4UPyikC44n5UCrB32OpPTXHt8t1wRmJ0gtXBa+iUUDJNzTe+wCX
w9Eg07cC05+to/T8+wNAbSfGM1SAyzurI5EiqANJhoqZtHWveru6+WscwyvV0iUo
6zBZmiOF6AI3dTaMTEThUAFvkfNhxiXzmGiO3pjD4mDLOb0DKG589C1bfo+wBZqU
/qU3LJr88OIZnGyfqDuf
=oTHE
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--


--===============3363193800237930603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3363193800237930603==--
