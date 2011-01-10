From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 10/17] OMAP2,3: DSS2: Move clocks from core driver to
 dss driver
Date: Mon, 10 Jan 2011 16:59:14 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101101657050.5731@utopia.booyaka.com>
References: <1294399551-10457-1-git-send-email-sumit.semwal@ti.com> <1294399551-10457-11-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56582 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467Ab1AJX7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 18:59:16 -0500
In-Reply-To: <1294399551-10457-11-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, Senthilvadivu Guruswamy <svadivu@ti.com>

On Fri, 7 Jan 2011, Sumit Semwal wrote:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> All clock management is moved to dss platform driver. clk_get/put APIs use
> dss device instead of core platform device.
> 
> Hwmod adaptation design requires each of the DSS HW IP to be a platform driver.
> So the device name is changed from omap_display to omap_dss in 2420, 2430,
> 3xxx clock database files. Now the core driver "omap_display" only takes care
> of panel registration with the custom bus.
> core driver also uses the clk_enable() / clk_disable() APIs exposed by DSS for
> clock management.
> DSS driver would do clock management of clocks needed by DISPC, RFBI, DSI, VENC
> 
> TODO:  The clock content would be adapted to omap_hwmod in a seperate series.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
>  arch/arm/mach-omap2/clock2420_data.c |    8 +-
>  arch/arm/mach-omap2/clock2430_data.c |    8 +-
>  arch/arm/mach-omap2/clock3xxx_data.c |   14 +-

...

> 
> diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
> index a220820..7a56c67 100644
> --- a/arch/arm/mach-omap2/clock2420_data.c
> +++ b/arch/arm/mach-omap2/clock2420_data.c
> @@ -1786,10 +1786,10 @@ static struct omap_clk omap2420_clks[] = {
>  	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_242X),
>  	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_242X),
>  	/* DSS domain clocks */
> -	CLK("omap_display",	"ick",		&dss_ick,	CK_242X),
> -	CLK("omap_display",	"dss1_fck",	&dss1_fck,	CK_242X),
> -	CLK("omap_display",	"dss2_fck",	&dss2_fck,	CK_242X),
> -	CLK("omap_display",	"tv_fck",	&dss_54m_fck,	CK_242X),
> +	CLK("omap_dss",	"ick",		&dss_ick,	CK_242X),
> +	CLK("omap_dss",	"dss1_fck",	&dss1_fck,	CK_242X),
> +	CLK("omap_dss",	"dss2_fck",	&dss2_fck,	CK_242X),
> +	CLK("omap_dss",	"tv_fck",	&dss_54m_fck,	CK_242X),
>  	/* L3 domain clocks */
>  	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_242X),
>  	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_242X),

It would be nice if you could figure out some way to combine or 
restructure these changes with the patch 4 changes, to avoid changing 
these from "omapdss" to "omap_display" then to "omap_dss".

In any case,

Acked-by: Paul Walmsley <paul@pwsan.com>



- Paul
