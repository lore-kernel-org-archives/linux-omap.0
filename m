From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] OMAP2+: mux: fix trivial typo in name
Date: Wed, 18 Sep 2013 11:50:55 -0700
Message-ID: <20130918185054.GB9994@atomide.com>
References: <1378732680-13159-1-git-send-email-phil.carmody@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:47793 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3IRSu7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Sep 2013 14:50:59 -0400
Content-Disposition: inline
In-Reply-To: <1378732680-13159-1-git-send-email-phil.carmody@partner.samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <phil.carmody@partner.samsung.com>
Cc: linux-omap@vger.kernel.org

* Phil Carmody <phil.carmody@partner.samsung.com> [130909 06:25]:
> Signed-off-by: Phil Carmody <phil.carmody@partner.samsung.com>

Thanks applying into omap-for-v3.12/fixes.

Tony

>  arch/arm/mach-omap2/mux34xx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/mux34xx.c b/arch/arm/mach-omap2/mux34xx.c
> index c53609f4..be271f1 100644
> --- a/arch/arm/mach-omap2/mux34xx.c
> +++ b/arch/arm/mach-omap2/mux34xx.c
> @@ -620,7 +620,7 @@ static struct omap_mux __initdata omap3_muxmodes[] = {
>  		"uart1_rts", "ssi1_flag_tx", NULL, NULL,
>  		"gpio_149", NULL, NULL, "safe_mode"),
>  	_OMAP3_MUXENTRY(UART1_RX, 151,
> -		"uart1_rx", "ss1_wake_tx", "mcbsp1_clkr", "mcspi4_clk",
> +		"uart1_rx", "ssi1_wake_tx", "mcbsp1_clkr", "mcspi4_clk",
>  		"gpio_151", NULL, NULL, "safe_mode"),
>  	_OMAP3_MUXENTRY(UART1_TX, 148,
>  		"uart1_tx", "ssi1_dat_tx", NULL, NULL,
> -- 
> 1.7.9.5
> 
