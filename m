From: Anand Gadiyar <gadiyar@ti.com>
Subject: Re: [PATCH] omap3: clocks: Fix build error 'CK_3430ES2' undeclared
 here
Date: Mon, 10 Jan 2011 19:07:10 +0530
Message-ID: <4D2B0B86.3010201@ti.com>
References: <1294611373-1992-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:51460 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753722Ab1AJNh0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jan 2011 08:37:26 -0500
Received: by mail-yx0-f175.google.com with SMTP id 5so7960524yxd.20
        for <linux-omap@vger.kernel.org>; Mon, 10 Jan 2011 05:37:25 -0800 (PST)
In-Reply-To: <1294611373-1992-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

On 1/10/2011 3:46 AM, Santosh Shilimkar wrote:
> At latest mainline commit 0c21e3aaf6a,  omap2plus build is broken. This
> patch is trivial fix for the missed usb clock node for CK_3430ES2PLUS
> flag update.
> 
>  CHK     include/generated/compile.h
>   CC      arch/arm/mach-omap2/clock3xxx_data.o
> arch/arm/mach-omap2/clock3xxx_data.c:3289: error: 'CK_3430ES2' undeclared
> here (not in a function)
> make[1]: *** [arch/arm/mach-omap2/clock3xxx_data.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> index d3ab1c9..c54cc33 100644
> --- a/arch/arm/mach-omap2/clock3xxx_data.c
> +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> @@ -3286,7 +3286,7 @@ static struct omap_clk omap3xxx_clks[] = {
>  	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>  	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
>  	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
> -	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2 | CK_AM35XX),
> +	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX),

Was about to post something similar.

Can you update this line to add CK_36XX as well. Without this, we won't be able to use
the USBHOST on 36xx/37xx platforms.

With this, feel free to add my
Acked-by: Anand Gadiyar <gadiyar@ti.com>

- Anand

>  	CLK("omap-mcbsp.1",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
>  	CLK("omap-mcbsp.5",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
>  	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),

