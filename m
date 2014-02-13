From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 6/6] arm: dts: am335x beagle bone use processor macids
Date: Thu, 13 Feb 2014 20:47:03 +0100
Message-ID: <20140213194703.GG17650@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <1387385242-1161-7-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43854 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbaBMTrJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 14:47:09 -0500
Content-Disposition: inline
In-Reply-To: <1387385242-1161-7-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hello,

On Wed, Dec 18, 2013 at 05:47:22PM +0100, Markus Pargmann wrote:
> Use macids stored in the am335x chip.
>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/am335x-bone.dts      | 8 ++++++++
>  arch/arm/boot/dts/am335x-boneblack.dts | 8 ++++++++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am=
335x-bone.dts
> index 94ee427..9b65a62 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -10,6 +10,14 @@
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
> =20
> +&cpsw_emac0 {
> +	ti,mac-address-ctrl =3D <&cpsw_ctrl_macid 0>;
> +};
> +
> +&cpsw_emac1 {
> +	ti,mac-address-ctrl =3D <&cpsw_ctrl_macid 1>;
> +};
with the mac-address property overwriting the addresses found in the
mac-address-ctrl block as I suggested in reply to the respective patch,
I'd add this property not per machine but directly in am33xx.dtsi.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
