From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] MAINTAINERS: Update entry for omap related .dts files
 to cover new SoCs
Date: Tue, 21 Oct 2014 22:26:59 +0800
Message-ID: <54466D33.1010501@baylibre.com>
References: <1413901462-32181-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413901462-32181-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

On 21/10/2014 22:24, Nishanth Menon wrote:
> DRA7(including AM5x) and AM47x series are handled under OMAP umbrella=
=2E
> These SoC support and dts have been added since 3.14 kernel and Pull
> requests for these have come in from OMAP till date.
>
> So just ensure that get_maintainers can pick up this list as well.
>
> Cc: Beno=C3=AEt Cousson <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Beno=C3=AEt Cousson <bcousson@baylibre.com>


Thanks,
Benoit

> ---
>   MAINTAINERS |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a20df9b..e205bd2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6585,6 +6585,9 @@ L:	devicetree@vger.kernel.org
>   S:	Maintained
>   F:	arch/arm/boot/dts/*omap*
>   F:	arch/arm/boot/dts/*am3*
> +F:	arch/arm/boot/dts/*am4*
> +F:	arch/arm/boot/dts/*am5*
> +F:	arch/arm/boot/dts/*dra7*
>
>   OMAP CLOCK FRAMEWORK SUPPORT
>   M:	Paul Walmsley <paul@pwsan.com>
>


--=20
Beno=C3=AEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
