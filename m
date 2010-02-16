From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 15/24] omap4: clocks: Convert i2c clocks data to fclks
Date: Tue, 16 Feb 2010 16:22:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002161622310.10478@utopia.booyaka.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-12-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-13-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-14-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39646 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741Ab0BPXWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 18:22:48 -0500
In-Reply-To: <1266335895-32741-15-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk

On Tue, 16 Feb 2010, Santosh Shilimkar wrote:

> In OMAP4 I2C module has only fclk control and iclks are controlled
> through hardware.(The OMAP4 clock tree autogeneration script has
> been updated accordingly.)
> 
> CC:Paul Walmsley <paul@pwsan.com>
> CC:Benoit Cousson <b-cousson@ti.com)his patch>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 86af31d..a69e8a0 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -2665,10 +2665,10 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK(NULL,	"gptimer9_ck",			&gptimer9_ck,	CK_443X),
>  	CLK("omap2_hdq.0",	"ick",				&hdq1w_ck,	CK_443X),
>  	CLK(NULL,	"hsi_ck",			&hsi_ck,	CK_443X),
> -	CLK("i2c_omap.1",	"ick",				&i2c1_ck,	CK_443X),
> -	CLK("i2c_omap.2",	"ick",				&i2c2_ck,	CK_443X),
> -	CLK("i2c_omap.3",	"ick",				&i2c3_ck,	CK_443X),
> -	CLK("i2c_omap.4",	"ick",				&i2c4_ck,	CK_443X),

You'll want to keep the above around, but use dummy_ck instead.

> +	CLK("i2c_omap.1",	"fck",				&i2c1_ck,	CK_443X),
> +	CLK("i2c_omap.2",	"fck",				&i2c2_ck,	CK_443X),
> +	CLK("i2c_omap.3",	"fck",				&i2c3_ck,	CK_443X),
> +	CLK("i2c_omap.4",	"fck",				&i2c4_ck,	CK_443X),
>  	CLK(NULL,	"iss_ck",			&iss_ck,	CK_443X),
>  	CLK(NULL,	"ivahd_ck",			&ivahd_ck,	CK_443X),
>  	CLK(NULL,	"keyboard_ck",			&keyboard_ck,	CK_443X),
> -- 
> 1.6.0.4
> 


- Paul
