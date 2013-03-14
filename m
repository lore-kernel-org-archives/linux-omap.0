From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: dwc3: exynos: Use of_platform API to create
 dwc3 core pdev
Date: Thu, 14 Mar 2013 12:51:55 +0200
Message-ID: <20130314105155.GG32369@arwen.pp.htv.fi>
References: <1363257898-17504-1-git-send-email-gautam.vivek@samsung.com>
 <1363257898-17504-2-git-send-email-gautam.vivek@samsung.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8732602415078739218=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1363257898-17504-2-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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
To: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============8732602415078739218==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline

--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 14, 2013 at 04:14:57PM +0530, Vivek Gautam wrote:
> @@ -170,7 +155,6 @@ static int dwc3_exynos_remove(struct platform_device =
*pdev)
>  {
>  	struct dwc3_exynos	*exynos =3D platform_get_drvdata(pdev);
> =20
> -	platform_device_unregister(exynos->dwc3);

don't you want to do what Kishon did here and have:

static int dwc3_exynos_remove_child(struct device *dev, void *unused)
{
	struct platform_device	*pdev =3D to_platform_device(dev);

	platform_device_unregister(pdev);

	return 0;
}

device_for_each_child(&pdev->dev, NULL, dwc3_exynos_remove_child);

???

--=20
balbi

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRQavLAAoJEIaOsuA1yqREcP0P/RW25dtnA4FyuLaD6Q7QMHPa
771znPkwXxH4bdlt6u8FLLHMYTmG9ZQNXEGvKjHn3yCqBl4XEwpSVcOmAVcJgJfA
KZvDnPbSjXLWVGdqn94YieiZQ/xaTm+Lam1LjokOnLJlgmZwbuNpX8baVSFfxWrP
/GCjJl0Wh1Ps0Yldr+TpGH9XhMCHkuhe/4mtnUaTcM4Hdr3cpw4Y47oESxJHPgWh
6+BiZ8G69vtEMpoMYpX/rybkI28LFseLEacbRe1aGPbP13MSqpY6Dy6z39s0y9Kc
rU96hM9BJNxFI8i+6jNTd1WCf6YdzkQprc8v/k36Jatq7+CHn4I/Q7hnAt2bY+8X
rAHpiSMN5peL1jMn/xW7zy2LIOO/bFpbPwCCOzD8XiffK4XxR690ZUcVPFL82eb4
Oac7iXFxuoXqT2+ydi1vi60OSrqtK0bmk50NFpkPXMCjfpvfm0Z4AhtsCiVEUA+w
+1SjOPhGsCwtFwwfPvV2jKDnPs/peBpCP0sjrf3TSMsFmwwa6180KyumuLNih6xj
Syj/AoMPrqzhoQFGHhU/qnshOMYW1xGslPgy0kRn0w9UEE1YbapZAZImyWOzzwdS
0zaTd/JFg82WEYyD08vXsr8XM5yAR+bhsJaPHq265TCSEFnDbtnmNb96uVEXWC7I
I+3/2UAdHQ5gOg/79IqA
=6nix
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--

--===============8732602415078739218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8732602415078739218==--
