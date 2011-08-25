From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH v2 2/2] omap_twl: Prevent SR to enable for am3517/am3505
 devices
Date: Thu, 25 Aug 2011 17:01:58 +0200
Message-ID: <4E5663E6.3040509@parrot.com>
References: <1314105680-17426-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:51685 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796Ab1HYPCE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Aug 2011 11:02:04 -0400
In-Reply-To: <1314105680-17426-1-git-send-email-abhilash.kv@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "b-cousson@ti.com" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vaibhav Hiremath <hvaibhav@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Abhilash K V a =E9crit :
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>=20
> In case of AM3517 & AM3505, Smart Reflex is not applicable so
> we must not enable it. So add check for absence of SR feature
> in omap3_twl_init() and return -ENODEV if absence, else continue.

I believe another check should be done :
you have the same problem if you run a omap3630 with TPS65023.

The check should take in account the pmu that is used and if it support=
 SR.


Matthieu


>=20
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> ---
>  arch/arm/mach-omap2/id.c              |    2 +-
>  arch/arm/mach-omap2/omap_twl.c        |    8 ++++++++
>  arch/arm/plat-omap/include/plat/cpu.h |    2 ++
>  3 files changed, 11 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 37efb86..da71098 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -202,7 +202,7 @@ static void __init omap3_check_features(void)
>  	if (cpu_is_omap3630())
>  		omap_features |=3D OMAP3_HAS_192MHZ_CLK;
>  	if (!cpu_is_omap3505() && !cpu_is_omap3517())
> -		omap_features |=3D OMAP3_HAS_IO_WAKEUP;
> +		omap_features |=3D (OMAP3_HAS_IO_WAKEUP | OMAP3_HAS_SR);
> =20
>  	omap_features |=3D OMAP3_HAS_SDRC;
> =20
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index 07d6140..47e27b5 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -269,6 +269,14 @@ int __init omap3_twl_init(void)
>  	if (!cpu_is_omap34xx())
>  		return -ENODEV;
> =20
> +	/*
> +	 * In case of AM3517/AM3505 we should not be going down
> +	 * further, since SR is not applicable there.
> +	 */
> +	if (!omap3_has_sr()) {
> +		return -ENODEV;
> +	}
> +
>  	if (cpu_is_omap3630()) {
>  		omap3_mpu_volt_info.vp_vddmin =3D OMAP3630_VP1_VLIMITTO_VDDMIN;
>  		omap3_mpu_volt_info.vp_vddmax =3D OMAP3630_VP1_VLIMITTO_VDDMAX;
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-om=
ap/include/plat/cpu.h
> index 67b3d75..294e015 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -491,6 +491,7 @@ extern u32 omap_features;
>  #define OMAP4_HAS_MPU_1GHZ		BIT(8)
>  #define OMAP4_HAS_MPU_1_2GHZ		BIT(9)
>  #define OMAP4_HAS_MPU_1_5GHZ		BIT(10)
> +#define OMAP3_HAS_SR			BIT(11)
> =20
> =20
>  #define OMAP3_HAS_FEATURE(feat,flag)			\
> @@ -507,6 +508,7 @@ OMAP3_HAS_FEATURE(isp, ISP)
>  OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
>  OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
>  OMAP3_HAS_FEATURE(sdrc, SDRC)
> +OMAP3_HAS_FEATURE(sr, SR)
> =20
>  /*
>   * Runtime detection of OMAP4 features
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
