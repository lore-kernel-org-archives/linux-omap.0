From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Add am57xx-beagle-x15
Date: Thu, 6 Nov 2014 10:32:07 -0600
Message-ID: <20141106163207.GF16896@saruman>
References: <1415290702-11353-1-git-send-email-nm@ti.com>
Reply-To: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ExXT7PjY8AI4Hyfa"
Return-path: <beagleboard+bncBC5M7T4HYEKRB2OE52RAKGQEKBX3NCA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415290702-11353-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
List-Post: <http://groups.google.com/group/beagleboard/post>, <mailto:beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:beagleboard+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/beagleboard
Sender: beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/beagleboard/subscribe>, <mailto:beagleboard+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1035534660134+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/beagleboard/subscribe>
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gerald-xujr6ya/RELK0SuXxyvBAPegYHeGw8Jk@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, beagleboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--ExXT7PjY8AI4Hyfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 10:18:22AM -0600, Nishanth Menon wrote:
> BeagleBoard-X15 is the next generation Open Source Hardware
> BeagleBoard based on TI's AM5728 SoC featuring dual core 1.5GHZ A15
> processor. The platform features 2GB DDR3L (w/dual 32bit busses),
> eSATA, 3 USB3.0 ports, integrated HDMI (1920x108@60), separate LCD
> port, video In port, 4GB eMMC, uSD, Analog audio in/out, dual 1G
> Ethernet.
>=20
> For more information, refer to:
> BeagleBoard-X15 Wiki:
> http://www.elinux.org/Beagleboard:BeagleBoard-X15
>=20
> AM5728 is part of the Sitara product family whose additional details
> will be available: http://www.ti.com/lsds/ti/arm/overview.page
>=20
> Technical Reference Manual for AM5728 is public domain at:
> http://www.ti.com/lit/spruhz6
>=20
> Just add basic support for the moment, the following updates are needed:
>   i)	Ethernet - depends on SoC dts fixes
>   ii)	USB Client (USB2) - depends on GPIO extcon
>   ii)	HDMI - additional driver fixes pending
>   iii)	Audio - additional driver fixes pending
>=20
> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
>=20
> Tested with omap2plus_defconfig modified as: http://slexy.org/view/s2DRTz=
Uwjj
> boot log: http://slexy.org/raw/s25Grf1uoo
> based on 3.18-rc1 tag.
>=20
> Support for u-boot has been posted as well: (series ending
> http://patchwork.ozlabs.org/patch/407552/ )
>=20
> Side note: this patch generates a few unrelated checkpatch warning for
> compatible which probably is part of appropriate driver documentation
> fixes (functionality is already present).
>=20
>  arch/arm/boot/dts/Makefile              |    1 +
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |  405 +++++++++++++++++++++++++=
++++++
>  2 files changed, 406 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 38c89ca..eee1e4f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -347,6 +347,7 @@ dtb-$(CONFIG_SOC_OMAP5) +=3D omap5-cm-t54.dtb \
>  	omap5-sbc-t54.dtb \
>  	omap5-uevm.dtb
>  dtb-$(CONFIG_SOC_DRA7XX) +=3D dra7-evm.dtb \
> +	am57xx-beagle-x15.dtb \
>  	dra72-evm.dtb
>  dtb-$(CONFIG_ARCH_ORION5X) +=3D orion5x-lacie-d2-network.dtb \
>  	orion5x-lacie-ethernet-disk-mini-v2.dtb \
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/=
am57xx-beagle-x15.dts
> new file mode 100644
> index 0000000..1f1875b
> --- /dev/null
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -0,0 +1,405 @@
> +/*
> + * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +#include "dra74x.dtsi"
> +#include <dt-bindings/clk/ti-dra7-atl.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	model =3D "TI AM5728 BeagleBoard-X15";
> +	compatible =3D "ti,am572x-beagle-x15", "ti,am5728", "ti,dra742", "ti,dr=
a74", "ti,dra7";
> +
> +	aliases {
> +		rtc0 =3D &mcp_rtc;
> +		rtc1 =3D &tps659038_rtc;
> +	};
> +
> +	memory {
> +		device_type =3D "memory";
> +		reg =3D <0x80000000 0x40000000>; /* 1GB to start. Target 2GB */

1GiB ? Why would you put this here btw ? u-boot fills this one up.

--=20
balbi

--ExXT7PjY8AI4Hyfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUW6KHAAoJEIaOsuA1yqREZiwP/3HY3YFbWj+FhUop9hVohNeQ
AiLN0sxdxnbP+R5Mkz01LDFJYWmeEciOfTH2nxBJdANVmdfPnLlqLmoSQZmV1fBI
O+rtZhjWf0VrwSkz9cOQIf4qqF0NX32ut209IQQKxHR4XYRDIETxujrRV8Cq+J14
aV+h8u12+V8oUgx3xzbtjwfOiMKyjbimZST7foTb++xfdWFsj+lLI7gGAp9s0K4z
U3HaooK2oGrFi9Wiu5Gs7jKKa3TSWz+vZKsjOKRMKM3IXzyF9x7Wf2WfAK/U45Mw
1BkBTK0a6lY0Jez9n9Jc2diYewRc3RpwMhmdUN6ObtZu99D4DaZS07K24eiqsRMh
ih3eDm1hmUzAghxkUo83dDQOi9PGIcv1twi3BpA8uKxfOnZyqdEk47gFxj2O+1WZ
X0asto+3BJt+lrIStxFb1YZqo1mTt/iHw+o26KT0Y+fVmxqdMm6aS35pehUu/iZO
Oror8hoE+O7e3QPiALN63c9MVvBQl2KFoBn+fj0PXe+V7wtLY9XV2PGepmSqH9PK
+00uwlqo7BbeIR7hLY25s/8tsA4X6Vp2SGiBUjbUodDjPgZWB0AQLLPOVoWWjzzP
5rG8dibrAJE8lv1D/w0Sgvtsf8EtNdwz4PyldaXK3sdmD33/YcZCewxgekPsmABF
HZHHkpsHqx0MChmReNbS
=oF+z
-----END PGP SIGNATURE-----

--ExXT7PjY8AI4Hyfa--
