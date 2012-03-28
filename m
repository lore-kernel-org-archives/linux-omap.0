From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] ARM: OMAP: USB: fix warning on EHCI PHY reset path
Date: Wed, 28 Mar 2012 11:52:32 +0300
Message-ID: <20120328085231.GD18156@arwen.pp.htv.fi>
References: <1332857335-27911-1-git-send-email-grinberg@compulab.co.il>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:33381 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756979Ab2C1IxF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 04:53:05 -0400
Received: by bkuw11 with SMTP id w11so729163bku.9
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 01:53:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1332857335-27911-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keshava Munegowda <Keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2012 at 04:08:55PM +0200, Igor Grinberg wrote:
> When PHY reset pin is connected to a GPIO on external GPIO chip
> (e.g. I2C), we should not call the gpio_set_value() function, but
> gpio_set_value_cansleep().
>=20
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>

Acked-by: Felipe Balbi <balbi@ti.com>

Keshava, please give us your tested-by. Patch looks fine to me.

> ---
> This patch depends on the patch from Keshava [1]:
> ARM: OMAP3: USB: Fix the EHCI ULPI PHY reset issue
>=20
> [1] http://www.spinics.net/lists/linux-omap/msg66774.html
>=20
>  drivers/usb/host/ehci-omap.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
> index 5c78f9e..26e9241 100644
> --- a/drivers/usb/host/ehci-omap.c
> +++ b/drivers/usb/host/ehci-omap.c
> @@ -258,10 +258,10 @@ static int ehci_hcd_omap_probe(struct platform_devi=
ce *pdev)
>  		udelay(10);
> =20
>  		if (gpio_is_valid(pdata->reset_gpio_port[0]))
> -			gpio_set_value(pdata->reset_gpio_port[0], 1);
> +			gpio_set_value_cansleep(pdata->reset_gpio_port[0], 1);
> =20
>  		if (gpio_is_valid(pdata->reset_gpio_port[1]))
> -			gpio_set_value(pdata->reset_gpio_port[1], 1);
> +			gpio_set_value_cansleep(pdata->reset_gpio_port[1], 1);
>  	}
> =20
>  	return 0;
> --=20
> 1.7.3.4
>=20

--=20
balbi

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPctFPAAoJEIaOsuA1yqREvQcP/j5SSfo74vXraHR+6/n+uKZ3
yIDknvXbHqo0R0frLfCb09mv5Cfo0JkfehIrRm+92SP0vARJ80p4N6zDTtMMXmvw
uQZ0kclmdRnocE1tWIvIzFx/7onODzV3VlL+eYYkUSWg5Jrc8l84ABvuTO4e1L6Y
B7qmf4nd6zrZCrIVy0AV2kg42Z+UGm9htvYyYN9dqRQwUFBHby/vyQq2T0bgQhe1
ED6utkZ/cb0hlBHBxkP/eQqY4nLadc1kLwCUGH9hoF3zRmi5vOV08zXC6aINwile
XOv1tjundirlyFkl0LcsenTU7pIhUpCKeP38crpopuiuvh4Cme4JaqJVXmlZ9sKU
rlFPRbV5iOFoD9nBL5M+iZewy9gLvrGS/ti7o+cVp3tksUXaBpgVELCYpGn+c5LY
gI1vd1NW1stYYvXiocnTMnf5Hs6qAGgnNGfm1C6GSmBni1NDAKRAfBD8tahnOHcN
PX+svEG2fp8Cuj21bRncvUw/zRiKoPQbbDCI32xEm0OJn8CglrveucFas29pW6gd
7PMP79b4tsNYsjbouXno3CtYYDjqgpekpBaDep5zDfSvDG1TfLIStORi3k4QPeet
/76tu8lSPwuj8c/x2bGneb2hF68whDUFW1t+KSaTl8vyODjPpeREPkUsekR5qKxQ
6hhX1IhYjTVE/8wZsuZp
=5pme
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
