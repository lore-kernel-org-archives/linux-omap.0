From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v1 1/1] ARM: OMAP3: Use OMAP3_HAS_IVA_REGS with OMAP3503
Date: Thu, 02 Aug 2012 10:43:37 +0300
Message-ID: <501A2FA9.1060807@compulab.co.il>
References: <1343692239-10393-1-git-send-email-juha.kuikka@gmail.com> <1343692239-10393-2-git-send-email-juha.kuikka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:35224 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753477Ab2HBHns (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Aug 2012 03:43:48 -0400
In-Reply-To: <1343692239-10393-2-git-send-email-juha.kuikka@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: linux-omap@vger.kernel.org

On 07/31/12 02:50, Juha Kuikka wrote:
> Similarly to am3703, it seems that omap3503 has an IVA control
> registers even though the subsystem is non-functional.
> 
> This patch sets the OMAP3_HAS_IVA_REGS feature to force
> initialization of there registers.
> 
> Based in Mark A. Greer's patch
> "ARM: OMAP3: Add OMAP3_HAS_IVA_REGS feature".
> 
> Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
> ---
>  arch/arm/mach-omap2/id.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 4072fbd..45d3eb4 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -244,7 +244,7 @@ void __init omap3xxx_check_features(void)
>  	if (cpu_is_omap3630())
>  		omap_features |= OMAP3_HAS_192MHZ_CLK | OMAP3_HAS_IVA_REGS;

If you add the flag below, then you probably want to remove it from here, right?

>  	if (cpu_is_omap3430() || cpu_is_omap3630())
> -		omap_features |= OMAP3_HAS_IO_WAKEUP;
> +		omap_features |= OMAP3_HAS_IO_WAKEUP | OMAP3_HAS_IVA_REGS;
>  	if (cpu_is_omap3630() || omap_rev() == OMAP3430_REV_ES3_1 ||
>  	    omap_rev() == OMAP3430_REV_ES3_1_2)
>  		omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;

-- 
Regards,
Igor.
