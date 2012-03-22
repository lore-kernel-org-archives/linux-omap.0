From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH 09/13] Add dummy smsc911x regulators to omap3evm.
Date: Thu, 22 Mar 2012 08:07:20 +0100
Message-ID: <8F060D80-6F86-49C2-A30F-A2728D48A025@dominion.thruhere.net>
References: <20120321194133.GP9859@atomide.com> <1332393594-23993-1-git-send-email-Russ.Dill@ti.com> <1332393594-23993-10-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44176 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab2CVHHV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 03:07:21 -0400
Received: by wibhj6 with SMTP id hj6so360220wib.1
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 00:07:18 -0700 (PDT)
In-Reply-To: <1332393594-23993-10-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org


Op 22 mrt. 2012, om 06:19 heeft Russ Dill het volgende geschreven:

> Signed-off-by: Russ Dill <russ.dill@ti.com>
> ---
> arch/arm/mach-omap2/board-omap3evm.c |   15 ++++++---------
> 1 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index a659e19..6a5e57c 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -114,15 +114,6 @@ static struct omap_smsc911x_platform_data smsc911x_cfg = {
> 
> static inline void __init omap3evm_init_smsc911x(void)
> {
> -	struct clk *l3ck;
> -	unsigned int rate;
> -
> -	l3ck = clk_get(NULL, "l3_ck");
> -	if (IS_ERR(l3ck))
> -		rate = 100000000;
> -	else
> -		rate = clk_get_rate(l3ck);

The above hunk gets added/removed multiple times during this patch series, a rebase -i mishap?

regards,

Koen