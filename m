From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/20] Replace clk_enable/disable APIs with HWMOD APIs
Date: Thu, 26 Aug 2010 16:37:36 -0700
Message-ID: <87sk21t073.fsf@deeprootsystems.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	<1282579089-10487-2-git-send-email-svadivu@ti.com>
	<1282579089-10487-3-git-send-email-svadivu@ti.com>
	<1282579089-10487-4-git-send-email-svadivu@ti.com>
	<1282579089-10487-5-git-send-email-svadivu@ti.com>
	<1282579089-10487-6-git-send-email-svadivu@ti.com>
	<1282579089-10487-7-git-send-email-svadivu@ti.com>
	<1282579089-10487-8-git-send-email-svadivu@ti.com>
	<1282579089-10487-9-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54677 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab0HZXhi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:37:38 -0400
Received: by pwi7 with SMTP id 7so917308pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:37:38 -0700 (PDT)
In-Reply-To: <1282579089-10487-9-git-send-email-svadivu@ti.com> (Guruswamy
	Senthilvadivu's message of "Mon, 23 Aug 2010 21:27:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com

Guruswamy Senthilvadivu <svadivu@ti.com> writes:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> when DSS ICK, FCK are requested, dss HWMOD APIs are used for enable
> and disable. The remaining clocks (dss opt clks in HWMOD database)
> continue to use clk APIs, since HWMOD APIs are not fully available
> for the dss opt clocks without the usage of clk framework.

The clocks that are managed by omap_device/omap_hwmod should be
controlled by using the runtime PM API, not by using pdata function
pointers.

Since the runtime PM core implements use-counting, you can probably get
rid of the use_count management too.

Kevin

> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
>  drivers/video/omap2/dss/dss.c |   28 ++++++++++++++++++++--------
>  1 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 15d0399..098ff96 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -61,6 +61,7 @@ struct dss_reg {
>  
>  static struct {
>  	struct platform_device *pdev;
> +	struct omap_display_platform_data *pdata;
>  
>  	void __iomem    *base;
>  	int		ctx_id;
> @@ -310,14 +311,26 @@ static unsigned count_clk_bits(enum dss_clock clks)
>  	return num_clks;
>  }
>  
> +static inline void enable_clocks(bool enable)
> + {
> +	static int use_count;
> +
> +	use_count += enable ? 1 : -1;
> +	if (use_count < 0)
> +		use_count = 0;
> +
> +	if (enable && use_count == 1)
> +		dss.pdata->device_enable(dss.pdev);
> +	else if (!enable && use_count == 0)
> +		dss.pdata->device_idle(dss.pdev);
> +}
> +
>  static void dss_clk_enable_no_ctx(enum dss_clock clks)
>  {
>  	unsigned num_clks = count_clk_bits(clks);
>  
> -	if (clks & DSS_CLK_ICK)
> -		clk_enable(dss.dss_ick);
> -	if (clks & DSS_CLK_FCK1)
> -		clk_enable(dss.dss1_fck);
> +	if ((clks & DSS_CLK_ICK) || (clks & DSS_CLK_FCK1))
> +		enable_clocks(1);
>  	if (clks & DSS_CLK_FCK2)
>  		clk_enable(dss.dss2_fck);
>  	if (clks & DSS_CLK_54M)
> @@ -342,10 +355,8 @@ static void dss_clk_disable_no_ctx(enum dss_clock clks)
>  {
>  	unsigned num_clks = count_clk_bits(clks);
>  
> -	if (clks & DSS_CLK_ICK)
> -		clk_disable(dss.dss_ick);
> -	if (clks & DSS_CLK_FCK1)
> -		clk_disable(dss.dss1_fck);
> +	if ((clks & DSS_CLK_ICK) || (clks & DSS_CLK_FCK1))
> +		enable_clocks(0);
>  	if (clks & DSS_CLK_FCK2)
>  		clk_disable(dss.dss2_fck);
>  	if (clks & DSS_CLK_54M)
> @@ -447,6 +458,7 @@ static int omap_dsshw_probe(struct platform_device *pdev)
>  	int r;
>  
>  	dss.pdev = pdev;
> +	dss.pdata = dss.pdev->dev.platform_data;
>  
>  	r = dss_get_clocks();
>  	if (r)
