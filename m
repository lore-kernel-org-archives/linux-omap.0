From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 11/16] mfd: omap-usb-host: Manage HSIC clocks for HSIC
 mode
Date: Wed, 21 Nov 2012 15:54:51 +0200
Message-ID: <20121121135451.GM10216@arwen.pp.htv.fi>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
 <1352990054-14680-12-git-send-email-rogerq@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gWRamliw218YCZO9"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1352990054-14680-12-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, keshava_mgowda-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--gWRamliw218YCZO9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 15, 2012 at 04:34:09PM +0200, Roger Quadros wrote:
> Enable the optional HSIC clocks (60MHz and 480MHz) for the ports
> that are configured in HSIC mode.
>=20
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/mfd/omap-usb-host.c |   56 +++++++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 54 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 0d39bd7..e5ba193 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
> @@ -88,6 +88,8 @@
> =20
>  struct usbhs_port {
>  	struct clk	*utmi_clk;
> +	struct clk	*hsic60m_clk;
> +	struct clk	*hsic480m_clk;
>  };
> =20
>  struct usbhs_hcd_omap {
> @@ -300,6 +302,26 @@ static int usbhs_runtime_resume(struct device *dev)
>  				}
>  			}
>  		}
> +
> +		/* Enable HSIC clocks if required */
> +		if (is_ehci_hsic_mode(pdata->port_mode[i])) {
> +			if (omap->port[i].hsic60m_clk) {
> +				r =3D clk_enable(omap->port[i].hsic60m_clk);
> +				if (r) {
> +					dev_err(dev,
> +					 "%s: Can't enable port %d hsic60m clk : %d\n",
> +					 __func__, i, r);
> +				}
> +			}
> +			if (omap->port[i].hsic480m_clk) {
> +				r =3D clk_enable(omap->port[i].hsic480m_clk);
> +				if (r) {
> +					dev_err(dev,
> +					 "%s: Can't enable port %d hsic480m clk : %d\n",
> +					 __func__, i, r);
> +				}
> +			}
> +		}
>  	}

with this deep indentation, it should've caught your attention that
something can definitely be re-factored.

> @@ -323,6 +345,14 @@ static int usbhs_runtime_suspend(struct device *dev)
>  			if (omap->port[i].utmi_clk)
>  				clk_disable(omap->port[i].utmi_clk);
>  		}
> +
> +		if (is_ehci_hsic_mode(pdata->port_mode[i])) {
> +			if (omap->port[i].hsic60m_clk)
> +				clk_disable(omap->port[i].hsic60m_clk);
> +
> +			if (omap->port[i].hsic480m_clk)
> +				clk_disable(omap->port[i].hsic480m_clk);
> +		}
>  	}
> =20
>  	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
> @@ -575,6 +605,7 @@ static int __devinit usbhs_omap_probe(struct platform=
_device *pdev)
>  	for (i =3D 0; i < omap->nports; i++) {
>  		struct clk *pclk;
>  		char utmi_clk[] =3D "usb_host_hs_utmi_px_clk";
> +		char hsic_clk[] =3D "usb_host_hs_hsic480m_px_clk";

same comment from another patch. Was this lazyness ?

> @@ -590,6 +621,21 @@ static int __devinit usbhs_omap_probe(struct platfor=
m_device *pdev)
>  		else
>  			omap->port[i].utmi_clk =3D pclk;
> =20
> +		sprintf(hsic_clk, "usb_host_hs_hsic480m_p%d_clk", i + 1);

will overflow if 'i' ever goes over 8.

> +		pclk =3D clk_get(dev, hsic_clk);
> +		if (IS_ERR(pclk))
> +			dev_err(dev, "Failed to get clock : %s : %ld\n",
> +				hsic_clk, PTR_ERR(pclk));
> +		else
> +			omap->port[i].hsic480m_clk =3D pclk;
> +
> +		sprintf(hsic_clk, "usb_host_hs_hsic60m_p%d_clk", i + 1);

ditto.

--=20
balbi

--gWRamliw218YCZO9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrN0rAAoJEIaOsuA1yqREBcoQAJZpcFKdGVUc8jwrRjn9KZ1/
TGiZB1ALTsLkJ/y5lRynDI0IAokDwHL2RnWr0ey9pwTVDDgda7WUbmfBDF80it2Q
fLcIB8W9SPy6UlLdB/ypxL2z0qeJ87N3OpQW3pv8VHFtlia9G/bQ/7a/T/wC4vcN
EIzFXztA5YCJm9u1ESY8Da+N1LUbFQZVgUg3zCmosatjEc8dZTQ8lK5hQeqItLiH
XKB5ZBxV2pHlV4Hl0dfZB3hFtjqfKNqJw2ym3LWsPrheCGJxj2tIiuiQnNhJjQZv
kVuuIz94jA9jshzSPvF/OBn6VimC4OYJdmR1STQ74da311NCWbHUjhFov5uEje8P
t0zGaiTWaf2gQUZ/nF03Ls5bdngto9+q2Ow2IV1i0axN1IXztgczZ80aExu6pcx2
AVFj/nDfrQzEi+yT5AWZrsRE1N3aAZr1ZbybgaE4O7e+5t/dwA1n1MHtAwzqkuAf
LO+B9cHzFjsx79kawVt5hI/ui5aBvR/r2cvcjYXjXp5qV5eYKNz/yh3+giNq6c+A
asapBCAJrLgTpET4VcnOKPpvQRy6WwKTwV15q3RcEwdeLkiyNgNghssIHAegG0F6
jeRNRvcyp/5UL0E9Eg9brLIHHlevBdvUVX59usejlgYq37GhJxIK/9csFTBB7+z8
+Tlnm0t2N4XVAJWj9yka
=h2kC
-----END PGP SIGNATURE-----

--gWRamliw218YCZO9--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
