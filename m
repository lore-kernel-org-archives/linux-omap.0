From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: linux-next regressions (next-20140423 A15: uevm/dra7)
Date: Wed, 23 Apr 2014 16:55:19 +0300
Message-ID: <5357C647.9000307@ti.com>
References: <5357C481.4090906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56514 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbaDWNzY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Apr 2014 09:55:24 -0400
In-Reply-To: <5357C481.4090906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@linaro.org>

On 04/23/2014 04:47 PM, Nishanth Menon wrote:
> Hi,
>=20
> Will be great if someone else could confirm as well.
>=20
> next-20140423-multi_lpae_defconfig
>  1: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2HJJ9SKzM
>  2: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2HoDCbtO0
> TOTAL =3D 2 boards, Booted Boards =3D 0, No Boot boards =3D 2
>=20
> next-20140423-multi_v7_defconfig
>  1: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2070nXdAg
>  2: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s20wKQEqGp
> TOTAL =3D 2 boards, Booted Boards =3D 0, No Boot boards =3D 2
>=20
> next-20140423-omap2plus_defconfig
>  1: DRA7xx-EVM:  Boot FAIL: http://slexy.org/raw/s2XrqUmRqz
>  2: OMAP5432uEVM:  Boot FAIL: http://slexy.org/raw/s2gQkdoTH4

I suspect you are using ext4 as rootfs?
I just sent a fix for this or similar crash (as in the OMAP5432uEVM log=
):
http://marc.info/?l=3Dlinux-kernel&m=3D139826085609497&w=3D2

>=20
>=20
> Exactly the same setup (rootfs and bootloader) as of yesterday's buil=
t
> image:
> next-20140422-omap2plus_defconfig
>  1: DRA7xx-EVM:  Boot PASS: http://slexy.org/raw/s20sRLHVgN
>  2: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s20ZxlYWaB
> TOTAL =3D 2 boards, Booted Boards =3D 2, No Boot boards =3D 0
>=20
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
