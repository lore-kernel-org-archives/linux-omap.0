From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 5/8] OMAP2+: hwmod: allow multiple calls to omap_hwmod_init()
Date: Wed, 23 Feb 2011 15:46:12 +0100
Message-ID: <4D651DB4.2060707@ti.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain> <20110223071150.5874.58996.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56396 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752224Ab1BWOqS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Feb 2011 09:46:18 -0500
In-Reply-To: <20110223071150.5874.58996.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

On 2/23/2011 8:11 AM, Paul Walmsley wrote:
> There's no longer any reason why we should prevent multiple
> calls to omap_hwmod_init().  It is now simply used to register an
> array of hwmods.
>
> This should allow a subset of hwmods (e.g., hwmods
> handling the system clocksource and clockevents) to be registered
> earlier than the remaining mass of hwmods.

Cool... that one was needed anyway.
It will allow potentially to split the original omapxxx_hwmod list in=20
severals parts and thus handle the features or the infrastructure hwmod=
s=20
we need to init early od based on the chip capabilities.

I was considering that during the discussion with Sanjeev=20
(http://www.spinics.net/lists/linux-omap/msg46716.html).

Benoit

>
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Beno=C3=AEt Cousson<b-cousson@ti.com>
> Cc: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |   29 ++++++++++-----------------=
--
>   1 files changed, 10 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index 41f548e..86eacaf 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -162,9 +162,6 @@ static LIST_HEAD(omap_hwmod_list);
>   /* mpu_oh: used to add/remove MPU initiator from sleepdep list */
>   static struct omap_hwmod *mpu_oh;
>
> -/* inited: 0 if omap_hwmod_init() has not yet been called; 1 otherwi=
se */
> -static u8 inited;
> -
>
>   /* Private functions */
>
> @@ -1600,26 +1597,20 @@ int omap_hwmod_for_each(int (*fn)(struct omap=
_hwmod *oh, void *data),
>    */
>   int __init omap_hwmod_init(struct omap_hwmod **ohs)
>   {
> -	struct omap_hwmod *oh;
> -	int r;
> -
> -	if (inited)
> -		return -EINVAL;
> -
> -	inited =3D 1;
> +	int r, i;
>
>   	if (!ohs)
>   		return 0;
>
> -	oh =3D *ohs;
> -	while (oh) {
> -		if (omap_chip_is(oh->omap_chip)) {
> -			r =3D _register(oh);
> -			WARN(r, "omap_hwmod: %s: _register returned "
> -			     "%d\n", oh->name, r);
> -		}
> -		oh =3D *++ohs;
> -	}
> +	i =3D 0;
> +	do {
> +		if (!omap_chip_is(ohs[i]->omap_chip))
> +			continue;
> +
> +		r =3D _register(ohs[i]);
> +		WARN(r, "omap_hwmod: %s: _register returned %d\n", ohs[i]->name,
> +		     r);
> +	} while (ohs[++i]);
>
>   	return 0;
>   }
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
