From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: DTS: omap3-n900.dts: fix i2c bus numbering
Date: Mon, 9 Feb 2015 09:02:46 -0600
Message-ID: <20150209150245.GC21362@kahuna>
References: <1423410536-16579-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39459 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759408AbbBIPCx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Feb 2015 10:02:53 -0500
Content-Disposition: inline
In-Reply-To: <1423410536-16579-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tony@atomide.com, pali.rohar@gmail.com, pavel@ucw.cz, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On 17:48-20150208, Ivaylo Dimitrov wrote:
> With legacy boot i2c buses on Nokia N900 are numbered i2c1, i2c2 and i2c3.
> Commit 20b80942ef4e ("ARM: dts: OMAP3+: Add i2c aliases") fixed the
> numbering with DT boot, but introduced a regression on N900 - aliases
> become i2c0, i2c1 and i2c2. Fix that by providing the correct aliases in
> the board dts.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
I suppose this is due to some legacy userspace breakage?
if yes, we do not intend to break userspace :), So:
Acked-by: Nishanth Menon <nm@ti.com>

>  arch/arm/boot/dts/omap3-n900.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index b550c41..68bf3cd 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -16,6 +16,13 @@
>  	model = "Nokia N900";
>  	compatible = "nokia,omap3-n900", "ti,omap3430", "ti,omap3";
>  
> +	aliases {
> +		i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +	};
> +
>  	cpus {
>  		cpu@0 {
>  			cpu0-supply = <&vcc>;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Regards,
Nishanth Menon
