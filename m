From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [Patch v2 1/2] ARM: OMAP2+: AM33xx: hwmod: add missing
 HWMOD_NO_IDLEST flags
Date: Fri, 1 Feb 2013 05:05:45 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EB5B137@DBDE01.ent.ti.com>
References: <1359642327-5542-1-git-send-email-gururaja.hebbar@ti.com>
 <1359642327-5542-2-git-send-email-gururaja.hebbar@ti.com>
 <alpine.DEB.2.00.1301311527190.23099@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56808 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787Ab3BAFF7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 00:05:59 -0500
In-Reply-To: <alpine.DEB.2.00.1301311527190.23099@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>

On Thu, Jan 31, 2013 at 20:58:24, Paul Walmsley wrote:
> Hi
> 
> On Thu, 31 Jan 2013, Hebbar Gururaja wrote:
> 
> > struct omap_hwmod records belonging to wkup m3 domain is missing
> > HWMOD_NO_IDLEST flags; add them.
> > 
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> 
> I've modified this patch to add some more description of why it's needed 
> as a fix, and queued it for v3.8-rc fixes.
> 
> Updated patch follows.

Thanks for the review & update.


Regards, 
Gururaja

> 
> 
> - Paul
> 
> From: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Date: Thu, 31 Jan 2013 19:55:26 +0530
> Subject: [PATCH] ARM: OMAP2+: AM33xx: hwmod: add missing HWMOD_NO_IDLEST
>  flags
> 
> struct omap_hwmod records belonging to wkup m3 domain is missing
> HWMOD_NO_IDLEST flags; add them.
> 
> This patch is a prerequisite for a subsequent patch, 'ARM: OMAP2:
> am33xx-hwmod: Fix "register offset NULL check" bug'.  That patch would
> otherwise attempt to read from reserved bits.
> 
> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> [paul@pwsan.com: add some more explanation in the patch description]
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index 646c14d..1ab693e 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -262,7 +262,8 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
>  	.name		= "wkup_m3",
>  	.class		= &am33xx_wkup_m3_hwmod_class,
>  	.clkdm_name	= "l4_wkup_aon_clkdm",
> -	.flags		= HWMOD_INIT_NO_RESET,	/* Keep hardreset asserted */
> +	/* Keep hardreset asserted */
> +	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
>  	.mpu_irqs	= am33xx_wkup_m3_irqs,
>  	.main_clk	= "dpll_core_m4_div2_ck",
>  	.prcm		= {
> -- 
> 1.7.10.4
> 
> 

