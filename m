From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
Date: Tue, 11 Sep 2012 23:10:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209112307170.9444@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1209110403130.23042@utopia.booyaka.com> <504F0877.4030907@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38453 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135Ab2IKXKw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 19:10:52 -0400
In-Reply-To: <504F0877.4030907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@ti.com

On Tue, 11 Sep 2012, Vaibhav Hiremath wrote:

> I tried this branch on BeagleBone platform and needs one small typo
> correction in hwmod data patch (submitted earlier, which you are going
> to queue it)
> 
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> index de7a3ab..767a77d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> @@ -1441,7 +1441,7 @@ static struct omap_hwmod am33xx_mmc2_hwmod = {
>         .clkdm_name     = "l3s_clkdm",
>         .mpu_irqs       = am33xx_mmc2_irqs,
>         .sdma_reqs      = am33xx_mmc2_edma_reqs,
> -       .main_clk       = "mmc2_fck",
> +       .main_clk       = "mmc_clk",
>         .prcm           = {
>                 .omap4  = {
>                       .clkctrl_offs = AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET,
> 
> 
> With above change I boot tested it on BeagleBone platform and also
> verified the clock rates getting printed in debugfs.

So does this mean we need to put together a patch to remove the existing 
mmc2_fck first from the OMAP clock data file?  Looks like that would be 
the right thing to do, based on the AM33x PRCM data.


- Paul
