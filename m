From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [Patch 1/2] OMAP2PLUS: DSS2: Add dss_opt_clk_roles in pdata
Date: Mon, 28 Feb 2011 11:10:49 +0200
Message-ID: <1298884249.9809.8.camel@deskari>
References: <1298622470-10558-1-git-send-email-sumit.semwal@ti.com>
	 <1298622470-10558-2-git-send-email-sumit.semwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52783 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752985Ab1B1JKx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 04:10:53 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S9AqZN011701
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 03:10:52 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p1S9AqOn002256
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 03:10:52 -0600 (CST)
In-Reply-To: <1298622470-10558-2-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Semwal, Sumit" <sumit.semwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>

On Fri, 2011-02-25 at 02:27 -0600, Semwal, Sumit wrote:
> Provide dss_opt_clks roles in pdata, so that it can be retrieved
> in dss driver, thus avoiding the hardcoding of clock role names.
> 
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> (based on implementation from Senthil)
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
> ---
>  arch/arm/mach-omap2/display.c             |   41 ++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/display.h |    3 +-
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
> index cc7b4f3..f189c07 100644
> --- a/arch/arm/mach-omap2/display.c
> +++ b/arch/arm/mach-omap2/display.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
> +#include <linux/slab.h>
>  
>  #include <plat/display.h>
>  #include <plat/omap_hwmod.h>
> @@ -48,6 +49,7 @@ int __init omap_display_init(struct omap_dss_board_info
>  	int r = 0;
>  	struct omap_hwmod *oh;
>  	struct omap_device *od;
> +	struct omap_hwmod_opt_clk *oc = NULL;
>  	int i;
>  	struct omap_display_platform_data pdata;
>  
> @@ -61,7 +63,7 @@ int __init omap_display_init(struct omap_dss_board_info
>  				"dss_dsi2", "dss_hdmi"};
>  	char *dev_name[] = {"omap_dss", "omap_dispc", "omap_rfbi", "omap_venc", "omap_dsi1",
>  				"omap_dsi2", "omap_hdmi"};
> -	int oh_count;
> +	int oh_count, oc_count;
>  
>  	memset(&pdata, 0, sizeof(pdata));
>  
> @@ -74,7 +76,44 @@ int __init omap_display_init(struct omap_dss_board_info
>  		oh_count = ARRAY_SIZE(oh_name) - 2;
>  		/* last 2 hwmod dev in oh_name are not available for omap3 */
>  
> +	/* opt_clks are always associated with dss hwmod */
> +	oh = omap_hwmod_lookup("dss_core");
> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name[0]);
> +		return -ENODEV;
> +	}
> +	oc = oh->opt_clks;
> +	oc_count = oh->opt_clks_cnt;
> +
> +	/* copy roles of opt_clocks available from hwmod into pdata */
> +	pdata.dss_opt_clk_roles = kzalloc(sizeof(char *) * oc_count,
> +					  GFP_KERNEL);
> +	if (!pdata.dss_opt_clk_roles) {
> +		pr_err("could not allocate memory for dss_opt_clk_roles\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < oc_count; i++) {
> +		int oc_length = strlen(oc[i].role);
> +
> +		pdata.dss_opt_clk_roles[i] = kzalloc(oc_length + 1,
> +						     GFP_KERNEL);
> +		if (!pdata.dss_opt_clk_roles[i]) {
> +			int j = i - 1;
> +
> +			pr_err("kzalloc failed for dss_opt_clk[%i]\n", i);
> +			for (; j >= 0; j--)
> +				kfree(pdata.dss_opt_clk_roles[j]);
> +
> +			kfree(pdata.dss_opt_clk_roles);
> +
> +			return -ENOMEM;
> +		}
> +
> +		strncpy(pdata.dss_opt_clk_roles[i], oc[i].role, oc_length+1);
> +	}

Do you actually need to copy the role strings? Can they every change? If
they are const data, you could just point to the original strings.

And is there even need to create clk_roles array. If I'm not mistaken,
the only use for this data is for the opt_clock_available() function. We
could just have an opt_clock_available() function pointer in the
omap_display_platform_data, and the function itself would be in
display.c. And the function could use the original hwmod data.

 Tomi


