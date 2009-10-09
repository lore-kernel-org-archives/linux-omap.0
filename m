From: Nishanth Menon <nm@ti.com>
Subject: Re: [RFC][PATCH 2/2] OMAP3:PM:SR: SmartReflex Refactor Rev2.0
Date: Fri, 9 Oct 2009 16:50:16 -0500
Message-ID: <4ACFB018.7000100@ti.com>
References: <1254443465-13006-1-git-send-email-nm@ti.com>	<1254443465-13006-2-git-send-email-nm@ti.com>	<1254443465-13006-3-git-send-email-nm@ti.com> <87k4z4uu3l.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36881 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934511AbZJIVvE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Oct 2009 17:51:04 -0400
In-Reply-To: <87k4z4uu3l.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux-omap <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, "Reddy, Teerth" <teerth@ti.com>, Paul Walmsley <paul@pwsan.com>, =?ISO-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>

Kevin Hilman had written, on 10/09/2009 04:37 PM, the following:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Refactor the smart reflex implementation.
> 
> One other request for this refactor.
> 
> Can you remove the usage of OMAP2_IO_ADDRESS (now gone from l-o master)
> in favor of ioremap().
> 
> Here's a totally untested first pass and converting the version
> currently in PM branch.  Could probably use some better error
> detection though, and I didn't look up exactly what size
> should be ioremap'd.
> 
> Kevin
> 
> 
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 1407783..bf57b21 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -48,6 +48,7 @@ struct omap_sr {
>  	u32		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
>  	u32		opp5_nvalue;
>  	u32		senp_mod, senn_mod;
> +	u32		srbase_phys;
>  	void __iomem	*srbase_addr;
>  	void __iomem	*vpbase_addr;
>  };
> @@ -105,7 +106,7 @@ static struct omap_sr sr1 = {
>  	.is_sr_reset		= 1,
>  	.is_autocomp_active	= 0,
>  	.clk_length		= 0,
> -	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
> +	.srbase_phys		= OMAP34XX_SR1_BASE,
>  };
>  
>  static struct omap_sr sr2 = {
> @@ -113,7 +114,7 @@ static struct omap_sr sr2 = {
>  	.is_sr_reset		= 1,
>  	.is_autocomp_active	= 0,
>  	.clk_length		= 0,
> -	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
> +	.srbase_phys		= OMAP34XX_SR2_BASE,
>  };
>  
>  static void cal_reciprocal(u32 sensor, u32 *sengain, u32 *rnsen)
> @@ -987,6 +988,11 @@ static int __init omap3_sr_init(void)
>  		return -ENODEV;
>          }
>  
> +	sr1.srbase_addr = ioremap(sr1.srbase_phys, SZ_4K);
> +	sr2.srbase_addr = ioremap(sr2.srbase_phys, SZ_4K);
4K is more than sufficient.
> +	if (WARN_ON(!sr1.srbase_addr) || WARN_ON(!sr2.srbase_addr))
> +		return;
should'nt we return with -ENOMEM?
> +
>  	/* Enable SR on T2 */
>  	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
>  					R_DCDC_GLOBAL_CFG);
> 

I can do the corresponding changes for SR v2 and post a v3 patch out.

-- 
Regards,
Nishanth Menon
