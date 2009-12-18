From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [rfc/rft/patch-v2.6.32-omap1+ 1/2] arm: omap: clock: add omap_udc
 to clkdev
Date: Thu, 17 Dec 2009 19:05:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912171904330.12561@utopia.booyaka.com>
References: <1261000355-2174-1-git-send-email-felipe.balbi@nokia.com> <1261000355-2174-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43253 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942AbZLRCFJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 21:05:09 -0500
In-Reply-To: <1261000355-2174-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kevin Hilman <kjh@hilman.org>

Hi Felipe,

On Wed, 16 Dec 2009, Felipe Balbi wrote:

> then we can later remove all of those cpu conditionals
> on drivers/usb/gadget/omap_udc.c
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
> 
> Paul, do you think the following is correct ? Judging
> by omap_udc.c those are the clocks used by that driver
> but I don't have boards to try out.

I guess these can also be used by ohci-omap.c ?

> 
> Anyways, after this patch hits mainline, I can send
> patches to omap_udc.c removing the cpu conditional
> clk_get().
> 
>  arch/arm/mach-omap1/clock_data.c     |   10 +++++-----
>  arch/arm/mach-omap2/clock2xxx_data.c |    4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
> index ab995a9..72169e7 100644
> --- a/arch/arm/mach-omap1/clock_data.c
> +++ b/arch/arm/mach-omap1/clock_data.c
> @@ -622,7 +622,7 @@ static struct omap_clk omap_clks[] = {
>  	/* CK_GEN3 clocks */
>  	CLK(NULL,	"tc_ck",	&tc_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
>  	CLK(NULL,	"tipb_ck",	&tipb_ck,	CK_1510 | CK_310),
> -	CLK(NULL,	"l3_ocpi_ck",	&l3_ocpi_ck,	CK_16XX | CK_7XX),
> +	CLK("omap_udc",	"l3_ocpi_ck",	&l3_ocpi_ck,	CK_16XX | CK_7XX),
>  	CLK(NULL,	"tc1_ck",	&tc1_ck,	CK_16XX),
>  	CLK(NULL,	"tc2_ck",	&tc2_ck,	CK_16XX),
>  	CLK(NULL,	"dma_ck",	&dma_ck,	CK_16XX | CK_1510 | CK_310),
> @@ -640,10 +640,10 @@ static struct omap_clk omap_clks[] = {
>  	CLK(NULL,	"uart3_ck",	&uart3_1510,	CK_1510 | CK_310),
>  	CLK(NULL,	"uart3_ck",	&uart3_16xx.clk, CK_16XX),
>  	CLK(NULL,	"usb_clko",	&usb_clko,	CK_16XX | CK_1510 | CK_310),
> -	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck1510, CK_1510 | CK_310),
> -	CLK(NULL,	"usb_hhc_ck",	&usb_hhc_ck16xx, CK_16XX),
> -	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck,	CK_16XX),
> -	CLK(NULL,	"usb_dc_ck",	&usb_dc_ck7xx,	CK_7XX),
> +	CLK("omap_udc",	"usb_hhc_ck",	&usb_hhc_ck1510, CK_1510 | CK_310),
> +	CLK("omap_hdc",	"usb_hhc_ck",	&usb_hhc_ck16xx, CK_16XX),
> +	CLK("omap_udc",	"usb_dc_ck",	&usb_dc_ck,	CK_16XX),
> +	CLK("omap_udc",	"usb_dc_ck",	&usb_dc_ck7xx,	CK_7XX),
>  	CLK(NULL,	"mclk",		&mclk_1510,	CK_1510 | CK_310),
>  	CLK(NULL,	"mclk",		&mclk_16xx,	CK_16XX),
>  	CLK(NULL,	"bclk",		&bclk_1510,	CK_1510 | CK_310),
> diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
> index 97dc7cf..c21bf7c 100644
> --- a/arch/arm/mach-omap2/clock2xxx_data.c
> +++ b/arch/arm/mach-omap2/clock2xxx_data.c
> @@ -2126,7 +2126,7 @@ static struct omap_clk omap24xx_clks[] = {
>  	/* L3 domain clocks */
>  	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X | CK_242X),
>  	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X | CK_242X),
> -	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_243X | CK_242X),
> +	CLK("omap_udc",	"usb_l4_ick",	&usb_l4_ick,	CK_243X | CK_242X),
>  	/* L4 domain clocks */
>  	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X | CK_242X),
>  	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X | CK_242X),
> @@ -2221,7 +2221,7 @@ static struct omap_clk omap24xx_clks[] = {
>  	CLK("omap_rng",	"ick",		&rng_ick,	CK_243X | CK_242X),
>  	CLK(NULL,	"aes_ick",	&aes_ick,	CK_243X | CK_242X),
>  	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X | CK_242X),
> -	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
> +	CLK("omap_udc",	"usb_fck",	&usb_fck,	CK_243X | CK_242X),
>  	CLK("musb_hdrc",	"ick",	&usbhs_ick,	CK_243X),
>  	CLK("mmci-omap-hs.0", "ick",	&mmchs1_ick,	CK_243X),
>  	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
> -- 
> 1.6.6.rc0
> 


- Paul
