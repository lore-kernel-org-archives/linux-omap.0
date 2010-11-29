From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 6/6] OMAP4: powerdomain: Add pwrdm_clear_all_prev_pwrst
Date: Sun, 28 Nov 2010 17:31:01 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011281729220.2515@utopia.booyaka.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com> <1289921886-5139-2-git-send-email-rnayak@ti.com> <1289921886-5139-3-git-send-email-rnayak@ti.com> <1289921886-5139-4-git-send-email-rnayak@ti.com> <1289921886-5139-5-git-send-email-rnayak@ti.com>
 <1289921886-5139-6-git-send-email-rnayak@ti.com> <1289921886-5139-7-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51986 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab0K2AbD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Nov 2010 19:31:03 -0500
In-Reply-To: <1289921886-5139-7-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@deeprootsystems.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Hi

On Tue, 16 Nov 2010, Rajendra Nayak wrote:

> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> OMAP4430 ES2 has additional bitfields in PWRSTST register which help
> identify the previous power state entered by the powerdomain.
> Add pwrdm_clear_all_prev_pwrst api to support this.

OMAP3 has these also.  Please add a similar function for OMAP3.

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/powerdomains44xx.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomains44xx.c b/arch/arm/mach-omap2/powerdomains44xx.c
> index 79be2cd..0414e6a 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx.c
> @@ -45,6 +45,14 @@ static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
>  				OMAP4430_LASTPOWERSTATEENTERED_MASK);
>  }
>  
> +static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
> +{
> +	prm_rmw_mod_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
> +			0x3 << OMAP4430_LASTPOWERSTATEENTERED_SHIFT,

Please just use OMAP4430_LASTPOWERSTATEENTERED_MASK here again rather 
than 0x3 << OMAP4430_LASTPOWERSTATEENTERED_SHIFT.  This avoids introducing 
a magic constant here.

> +			pwrdm->prcm_offs, OMAP4_PM_PWSTST);
> +	return 0;
> +}
> +
>  static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
>  {
>  	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
> @@ -154,6 +162,7 @@ struct pwrdm_functions omap4_pwrdm_functions = {
>  	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
>  	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
>  	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
> +	.pwrdm_clear_all_prev_pwrst	= omap4_pwrdm_clear_all_prev_pwrst,
>  	.pwrdm_set_lowpwrstchange	= omap4_pwrdm_set_lowpwrstchange,
>  	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
>  	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
> -- 
> 1.7.0.4
> 


- Paul
