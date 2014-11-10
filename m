From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] MAINTAINERS: Update entry for omap related .dts files to
 cover new SoCs
Date: Mon, 10 Nov 2014 12:30:17 -0800
Message-ID: <20141110203017.GT31454@atomide.com>
References: <1413901462-32181-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413901462-32181-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm@ti.com> [141021 07:25]:
> DRA7(including AM5x) and AM47x series are handled under OMAP umbrella=
=2E
> These SoC support and dts have been added since 3.14 kernel and Pull
> requests for these have come in from OMAP till date.
>=20
> So just ensure that get_maintainers can pick up this list as well.

Applying this into omap-for-v3.18/fixes as we've seen some
patches not copied to linux-omap list.

Regards,

Tony
=20
> Cc: Beno=C3=AEt Cousson <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  MAINTAINERS |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a20df9b..e205bd2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6585,6 +6585,9 @@ L:	devicetree@vger.kernel.org
>  S:	Maintained
>  F:	arch/arm/boot/dts/*omap*
>  F:	arch/arm/boot/dts/*am3*
> +F:	arch/arm/boot/dts/*am4*
> +F:	arch/arm/boot/dts/*am5*
> +F:	arch/arm/boot/dts/*dra7*
> =20
>  OMAP CLOCK FRAMEWORK SUPPORT
>  M:	Paul Walmsley <paul@pwsan.com>
> --=20
> 1.7.9.5
>=20
