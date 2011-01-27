From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 4/4] OMAP4: DSS2: clocks: Add ick as dummy clock
Date: Thu, 27 Jan 2011 09:46:34 -0800
Message-ID: <87k4hqp7d1.fsf@ti.com>
References: <1295960398-25329-1-git-send-email-sumit.semwal@ti.com>
	<1295960398-25329-5-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48734 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751811Ab1A0Rqj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 12:46:39 -0500
Received: by mail-iy0-f172.google.com with SMTP id 42so1822290iyi.17
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 09:46:37 -0800 (PST)
In-Reply-To: <1295960398-25329-5-git-send-email-sumit.semwal@ti.com> (Sumit
	Semwal's message of "Tue, 25 Jan 2011 18:29:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sumit Semwal <sumit.semwal@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com

Sumit Semwal <sumit.semwal@ti.com> writes:

> DSS code uses ick as one of the clocks in clk_get/clk_put. OMAP4 clock database
> doesn't have ick for DSS, so adding ick as dummy clock.
>
> Once pm_runtime* APIs get introduced in DSS, this will be revisited.
>
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 74db324..8603b1f 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -3109,6 +3109,8 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK(NULL,	"dsp_fck",			&dsp_fck,	CK_443X),
>  	/* dss clocks */
>  	CLK(NULL,	"fck",				&dss_fck,	CK_443X),
> +	CLK("omap_dss",	"ick",				&dummy_ck,	CK_443X),
> +	/* on OMAP4, ick is a dummy clock */

minor nit: the comment should go above the code, and should also state
it's needed for OMAP2/3 compatibility.

Kevin

>  	/*
>  	 * clocks handled via hwmod opt_clk mechanism need dev=NULL,
>  	 * con=clock name as per actual clk structure, NOT role
