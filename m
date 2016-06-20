From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v10 06/14] usb: gadget.h: Add OTG to gadget interface
Date: Mon, 20 Jun 2016 10:21:22 +0300
Message-ID: <87k2hkxr4d.fsf@linux.intel.com>
References: <1465564043-27163-1-git-send-email-rogerq@ti.com> <1465564043-27163-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465564043-27163-7-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peter.chen@freescale.com
Cc: tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> The OTG core will use struct otg_gadget_ops to
> start/stop the gadget controller.
>
> The main purpose of this interface is to avoid directly
> calling usb_gadget_start/stop() from the OTG core as they
> wouldn't be defined in the built-in symbol table if
> CONFIG_USB_GADGET is m.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  include/linux/usb/gadget.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index 2dd9e6b..f4fc0aa 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -639,6 +639,22 @@ struct usb_gadget_driver {
>  };
>=20=20
>=20=20
> +/*----------------------------------------------------------------------=
---*/
> +
> +/**
> + * struct otg_gadget_ops - Interface between OTG core and gadget
> + *
> + * Provided by the gadget core to allow the OTG core to start/stop the g=
adget
> + *
> + * @start: function to start the gadget
> + * @stop: function to stop the gadget
> + * @connect_control: function to connect/disconnect from the bus
> + */
> +struct otg_gadget_ops {
> +	int (*start)(struct usb_gadget *gadget);
> +	int (*stop)(struct usb_gadget *gadget);
> +	int (*connect_control)(struct usb_gadget *gadget, bool connect);
> +};

you shouldn't need these at all. They are already part of the gadget
framework as ->udc_start(), ->udc_stop() and ->pullup()

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXZ5lyAAoJEIaOsuA1yqRETboQAKD/5pMHlxy9SVH5j0c+5/YM
W91O3OsnVtXin3ELm35oFuGHOok3NjWNwwPdrAmDzWboI1YFjcBfPRssYeolv9mY
nkP5Onz1WuKEHqesdKNnmL7KorpL4wuvS0d/azFn3couqlOr0y+1D9e5x1brJ7w+
OCo0HH9LZ3oY6C2wx9wkmQ7kg7wzPZHVafmmP717fVqyo51hgwtuVT0VU2VEZG5R
Sag9kamMD75hmSWyCY/OI3UuAbIGr0KcOdmxnlPh1os/V7CM1QMtR9BDMHIV2tuG
mNMQb0kGOvRQLoKSDPq2hXPJa1Cg4IvkzSL85zcHv6dUGVHzC1haZSXXXCKr7m+M
+dw5f3Vuf9qzucJiKd/dMCbRX501rZ2U+PoVAP5GljyBvsv3WUzQxMIrnTRzwH5x
aJyvR+WP2E/J0npJqrN2ishNikzVycwC87oP3KKCT45mm6iMCb6F3K4RlrAwnyby
CfdIWsm2STxgz2vft9DiObAcG4HHXOJidB8V2vzm67fsgeV8kU4yasBkFTgeH/Lf
pydf6tnj7a7/PjSoig0yNN8ZocSY5RTaPlh8rIrpDkKABuBsQAaowuaKWNgplKEE
/QRHlaVy6TRuIp9oCFLPpHnyaxnthlvIqW0xhMSkyBoecSlJVJdoY5GbLFS0d1Gz
rbN8fRK+BXrYxW8ey3pi
=YxXK
-----END PGP SIGNATURE-----
--=-=-=--
