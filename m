From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 10/20] Move rfbi init to rfbi probe
Date: Fri, 27 Aug 2010 15:54:31 +0200
Message-ID: <4C77C397.5010502@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com> <1282579089-10487-2-git-send-email-svadivu@ti.com> <1282579089-10487-3-git-send-email-svadivu@ti.com> <1282579089-10487-4-git-send-email-svadivu@ti.com> <1282579089-10487-5-git-send-email-svadivu@ti.com> <1282579089-10487-6-git-send-email-svadivu@ti.com> <1282579089-10487-7-git-send-email-svadivu@ti.com> <1282579089-10487-8-git-send-email-svadivu@ti.com> <1282579089-10487-9-git-send-email-svadivu@ti.com> <1282579089-10487-10-git-send-email-svadivu@ti.com> <1282579089-10487-11-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45787 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753769Ab0H0Nyk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Aug 2010 09:54:40 -0400
In-Reply-To: <1282579089-10487-11-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guruswamy, Senthilvadivu" <svadivu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>

On 8/23/2010 5:57 PM, Guruswamy, Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy<svadivu@ti.com>
>
> RFBI init and exit moved to rfbi probe and remove.
>
> Signed-off-by: Senthilvadivu Guruswamy<svadivu@ti.com>
> ---
>   drivers/video/omap2/dss/core.c |   21 +++++++++++----------
>   1 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 90a8f77..5030a84 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -199,12 +199,6 @@ static int omap_dss_probe(struct platform_device *pdev)
>
>   	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
>
> -	r = rfbi_init();
> -	if (r) {
> -		DSSERR("Failed to initialize rfbi\n");
> -		goto err_rfbi;
> -	}
> -
>   	r = dpi_init(pdev);
>   	if (r) {
>   		DSSERR("Failed to initialize dpi\n");
> @@ -278,8 +272,6 @@ err_venc:
>   err_dispc:
>   	dpi_exit();
>   err_dpi:
> -	rfbi_exit();
> -err_rfbi:
>   	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
>
>   	return r;
> @@ -296,7 +288,6 @@ static int omap_dss_remove(struct platform_device *pdev)
>   	venc_exit();
>   	dispc_exit();
>   	dpi_exit();
> -	rfbi_exit();
>   	if (cpu_is_omap34xx()) {
>   		dsi_exit();
>   		sdi_exit();
> @@ -357,11 +348,21 @@ static int omap_dsi1hw_remove(struct platform_device *pdev)
>   /* RFBI HW IP initialisation */
>   static int omap_rfbihw_probe(struct platform_device *pdev)
>   {
> -	return 0;
> +	int r;
> +	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> +	r = rfbi_init();
> +	if (r) {
> +		DSSERR("Failed to initialize rfbi\n");
> +		goto err_rfbi;
> +	}
> +err_rfbi:
> +	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
> +	return r;

There is probably something wrong in this sequence? The same thing is 
done whatever the return state (except the error log).
You should probably return 0 and not disable the clocks if the rfbi_init 
is successful.

Benoit
