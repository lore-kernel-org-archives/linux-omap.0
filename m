From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 1/4] ARM: OMAP2+: Add CTRL_MODULE_CORE as a master clock
 provider for DRA7
Date: Thu, 8 May 2014 01:19:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405080117370.23579@utopia.booyaka.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36860 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752845AbaEHBTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 21:19:47 -0400
In-Reply-To: <1397654063-8055-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Wed, 16 Apr 2014, Archit Taneja wrote:

> The control module isn't actually a clock management module, but there are a few
> register bits which perform gating and muxing of clocks.
> 
> Add CTRL_MODULE_CORE sub block as a clock provider for DRA7. The control module
> has 2 sub modules: CTRL_MODULE_CORE, and CTRL_MODULE_WKUP. Out of these, only
> the CORE sub module has clock related register fields. We ignore the WKUP sub
> module.
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  arch/arm/mach-omap2/prm_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index b4c4ab9..f86029a 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -489,6 +489,7 @@ static struct of_device_id omap_prcm_dt_match_table[] = {
>  	{ .compatible = "ti,dra7-prm" },
>  	{ .compatible = "ti,dra7-cm-core-aon" },
>  	{ .compatible = "ti,dra7-cm-core" },
> +	{ .compatible = "ti,dra7-ctrl-core" },
>  	{ }
>  };

So, based on a quick glance, and without the benefit of any 
documentation, it makes general sense to add the DRA7 CTRL module as a 
clock provider, but it does not make any sense to associate it with the 
PRCM.  Please find a control module-specific piece of code to register as 
a clock provider, not prm_common.c.



- Paul
