From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Wed, 4 May 2011 12:40:50 +0300
Message-ID: <20110504094050.GI27860@atomide.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
 <1304494704-7285-2-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:31021 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751669Ab1EDJku (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 05:40:50 -0400
Content-Disposition: inline
In-Reply-To: <1304494704-7285-2-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org

* Archit Taneja <archit@ti.com> [110504 10:30]:
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -401,7 +401,7 @@ static struct regulator_consumer_supply sdp3430_vdda_dac_supplies[] = {
>  /* VPLL2 for digital video outputs */
>  static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
>  	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
>  };
>  
>  static struct regulator_consumer_supply sdp3430_vmmc1_supplies[] = {
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 570e83f..eafadb4 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -375,7 +375,7 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
>  };
>  static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
>  	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
> -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
>  };
...

Looks like we should first combine all this cut and paste data
for each board file into some common init function to cut
down the "crazy churn".

Tony
