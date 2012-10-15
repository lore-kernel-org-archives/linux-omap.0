From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] USB: DWC3: Shutdown usb_phy when removing the device
Date: Mon, 15 Oct 2012 15:14:03 +0300
Message-ID: <20121015121403.GK24333@arwen.pp.htv.fi>
References: <1350136218-25678-1-git-send-email-gautam.vivek@samsung.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCF9ydJxlAJsfRTu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57337 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893Ab2JOMTd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 08:19:33 -0400
Content-Disposition: inline
In-Reply-To: <1350136218-25678-1-git-send-email-gautam.vivek@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com

--FCF9ydJxlAJsfRTu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2012 at 07:20:18PM +0530, Vivek Gautam wrote:
> We do usb_phy_init() while doing core_init() in probe,
> so adding usb_phy_shutdown() when we do core_exit()
> while removing the device.
>=20
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>

I believe this needs to be sent to stable too for v3.6, right ?

please resend with a proper Cc: stable@vger.kernel.org # v3.6 tag

> ---
>  drivers/usb/dwc3/core.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index b415c0c..c14ebc9 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -409,6 +409,10 @@ static void dwc3_core_exit(struct dwc3 *dwc)
>  {
>  	dwc3_event_buffers_cleanup(dwc);
>  	dwc3_free_event_buffers(dwc);
> +
> +	usb_phy_shutdown(dwc->usb2_phy);
> +	usb_phy_shutdown(dwc->usb3_phy);
> +
>  }
> =20
>  #define DWC3_ALIGN_MASK		(16 - 1)
> --=20
> 1.7.6.5
>=20

--=20
balbi

--FCF9ydJxlAJsfRTu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQe/4LAAoJEIaOsuA1yqREeWgP/2hSFaYwNv6RXMHclDJegGDN
N65EoCs/SzO6fDrKq5v+NKOrCcIvkvuc0h+yvsROaN/ST0/BoI8umUlC718bhinw
u888S2cYvtM04CMHEQCY8SuaW+SmTVk53u1TIwT4KhkznPja/pRT1198BdjrI1x4
K1d252y5K9PzSQhYD9II1LrVbTFwjcCyJTG94ffZCZujE69mUJKtwJDD+grWPSCD
fQPCNB8nZFqgqkNrWKoUSssMtIakIISggDfjxL3aGka3nJoIOHKckhanlad01RtE
JBdWgow247TsorHS+VzEx6T1XJinvFC92qJ6cl8z4SIQAoFrAFxuqYKNN8/JRu3Q
z6iUxmvQBSpKXnLQKoDUT7V+EmPK3bg27fRbzGUOFWc8I5KkX4JGyegbaHFZNvjT
EiMptMztSQ/maXuY73CDuSyQI+EjSD4zgAby4VXndgvb2rjXXXVbvSy+mgufuZ6X
avtmC/zSsIS/Bpds3XzzCIWQcA/hka11+OvlGAHY7UKj7ACKomPutxkEt4jOVKuD
155R8gG0PA5iOtguz9Wzc5nYe/HBWy54HcX1BAEBFmG6+WW2I6Z2JKrCsOgcbg0R
0GmigwWho5IrAeQuKsgfrsbgGlFI0VJteCzqDOohLZ0/ddK2BzvAn8s27jnQUtv8
eCLvKh4tq9V0OuwAhfRJ
=pHyv
-----END PGP SIGNATURE-----

--FCF9ydJxlAJsfRTu--
