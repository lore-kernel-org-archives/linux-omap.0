From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/7] Menelaus cleanup for DT, phase 1
Date: Tue, 20 Jan 2015 17:13:04 +0000
Message-ID: <20150120171304.GA32495@x1>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1419702779-16001-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sat, 27 Dec 2014, Aaro Koskinen wrote:
> These patches start removal of board-specific callbacks from Menelaus=
:
> delete platform data and a callback from the driver to the board file=
s.
>=20
> Tested on top of 3.19-rc1 on N800/N810 which are the only in-tree use=
rs
> for the driver.
>=20
> Aaro Koskinen (7):
>   mfd: menelaus: delete omap_has_menelaus
>   mfd: menelaus: drop support for SW controller VCORE
>   mfd: menelaus: add initial DT support
>   ARM: OMAP: N8x0: configure menelaus using DT
>   mfd: menelaus: delete platform data support
>   mfd: menelaus: make vcore and regulator controls internal
>   mfd: menelaus: use macro for magic number
>=20
>  Documentation/devicetree/bindings/mfd/menelaus.txt | 30 ++++++++
>  arch/arm/boot/dts/omap2420-n8x0-common.dtsi        |  3 +
>  arch/arm/mach-omap2/board-n8x0.c                   | 57 ------------=
--
>  arch/arm/mach-omap2/common-board-devices.h         |  2 -
>  arch/arm/mach-omap2/pdata-quirks.c                 |  1 -
>  drivers/mfd/menelaus.c                             | 86 ++++++++++++=
++--------
>  include/linux/mfd/menelaus.h                       | 25 -------
>  7 files changed, 87 insertions(+), 117 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/menelaus.tx=
t

Scrap that.  Looks like I can't apply the other patches without
03/07.  Please sort this out with Felipe and re-submit.  Don't forget
to apply my Ack to the patches I said I "applied".

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
