From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 6/6] OMAPDSS: use runtime PM's autosuspend
Date: Mon, 25 Nov 2013 06:59:24 +0530
Message-ID: <5292A7F4.8030106@ti.com>
References: <1384779009-10512-1-git-send-email-tomi.valkeinen@ti.com> <1384779009-10512-7-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55943 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518Ab3KYN3N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Nov 2013 08:29:13 -0500
In-Reply-To: <1384779009-10512-7-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Monday 18 November 2013 06:20 PM, Tomi Valkeinen wrote:
> Use runtime PM's autosuspend support with delay of 100ms.
>
> This will prevent the driver from turning the DSS modules off and on
> multiple times e.g. when loading the module.

Could you explain this a bit more?

Are you saying that when we insert the omapdss module, we have a lot of 
runtime_get/put pairs in probe, which leads to us excessive writing of 
DISPC the registers during resume, and the autosuspend feature would 
delay the effect of runtime_put() for a while?

Also, do we need to do this for all the platform devices? Could we use 
autosuspend only for the parent platform device, and the children 
platform devices don't use it? Or am I understanding things wrongly here?

Archit

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/dispc.c | 5 ++++-
>   drivers/video/omap2/dss/dsi.c   | 5 ++++-
>   drivers/video/omap2/dss/dss.c   | 5 ++++-
>   drivers/video/omap2/dss/dss.h   | 2 ++
>   drivers/video/omap2/dss/hdmi4.c | 5 ++++-
>   drivers/video/omap2/dss/rfbi.c  | 5 ++++-
>   drivers/video/omap2/dss/venc.c  | 5 ++++-
>   7 files changed, 26 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index 58f3626..0643eb0 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -258,7 +258,8 @@ void dispc_runtime_put(void)
>
>   	DSSDBG("dispc_runtime_put\n");
>
> -	r = pm_runtime_put_sync(&dispc.pdev->dev);
> +	pm_runtime_mark_last_busy(&dispc.pdev->dev);
> +	r = pm_runtime_put_autosuspend(&dispc.pdev->dev);
>   	WARN_ON(r < 0 && r != -ENOSYS);
>   }
>   EXPORT_SYMBOL(dispc_runtime_put);
> @@ -3440,6 +3441,8 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
>   	}
>
>   	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, DSS_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&pdev->dev);
>
>   	r = dispc_runtime_get();
>   	if (r)
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index 6b30a58..19e4cad 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -1110,7 +1110,8 @@ void dsi_runtime_put(struct platform_device *dsidev)
>
>   	DSSDBG("dsi_runtime_put\n");
>
> -	r = pm_runtime_put_sync(&dsi->pdev->dev);
> +	pm_runtime_mark_last_busy(&dsi->pdev->dev);
> +	r = pm_runtime_put_autosuspend(&dsi->pdev->dev);
>   	WARN_ON(r < 0 && r != -ENOSYS);
>   }
>
> @@ -5416,6 +5417,8 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
>   		return r;
>
>   	pm_runtime_enable(&dsidev->dev);
> +	pm_runtime_set_autosuspend_delay(&dsidev->dev, DSS_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&dsidev->dev);
>
>   	r = dsi_runtime_get(dsidev);
>   	if (r)
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index fa7bc00..d3b0122 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -689,7 +689,8 @@ static void dss_runtime_put(void)
>
>   	DSSDBG("dss_runtime_put\n");
>
> -	r = pm_runtime_put_sync(&dss.pdev->dev);
> +	pm_runtime_mark_last_busy(&dss.pdev->dev);
> +	r = pm_runtime_put_autosuspend(&dss.pdev->dev);
>   	WARN_ON(r < 0 && r != -ENOSYS && r != -EBUSY);
>   }
>
> @@ -821,6 +822,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
>   		goto err_setup_clocks;
>
>   	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, DSS_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&pdev->dev);
>
>   	r = dss_runtime_get();
>   	if (r)
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index af83c4d..96505f0 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -73,6 +73,8 @@
>   #define FLD_MOD(orig, val, start, end) \
>   	(((orig) & ~FLD_MASK(start, end)) | FLD_VAL(val, start, end))
>
> +#define DSS_AUTOSUSPEND_DELAY 100	/* in ms */
> +
>   enum dss_io_pad_mode {
>   	DSS_IO_PAD_MODE_RESET,
>   	DSS_IO_PAD_MODE_RFBI,
> diff --git a/drivers/video/omap2/dss/hdmi4.c b/drivers/video/omap2/dss/hdmi4.c
> index f1a45fe..f255641 100644
> --- a/drivers/video/omap2/dss/hdmi4.c
> +++ b/drivers/video/omap2/dss/hdmi4.c
> @@ -77,7 +77,8 @@ static void hdmi_runtime_put(void)
>
>   	DSSDBG("hdmi_runtime_put\n");
>
> -	r = pm_runtime_put_sync(&hdmi.pdev->dev);
> +	pm_runtime_mark_last_busy(&hdmi.pdev->dev);
> +	r = pm_runtime_put_autosuspend(&hdmi.pdev->dev);
>   	WARN_ON(r < 0 && r != -ENOSYS);
>   }
>
> @@ -631,6 +632,8 @@ static int omapdss_hdmihw_probe(struct platform_device *pdev)
>   	}
>
>   	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, DSS_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&pdev->dev);
>
>   	hdmi_init_output(pdev);
>
> diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
> index 74d3ed1..20dcbfb 100644
> --- a/drivers/video/omap2/dss/rfbi.c
> +++ b/drivers/video/omap2/dss/rfbi.c
> @@ -147,7 +147,8 @@ static void rfbi_runtime_put(void)
>
>   	DSSDBG("rfbi_runtime_put\n");
>
> -	r = pm_runtime_put_sync(&rfbi.pdev->dev);
> +	pm_runtime_mark_last_busy(&rfbi.pdev->dev);
> +	r = pm_runtime_put_autosuspend(&rfbi.pdev->dev);
>   	WARN_ON(r < 0 && r != -ENOSYS);
>   }
>
> @@ -981,6 +982,8 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
>   	clk_put(clk);
>
>   	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, DSS_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&pdev->dev);
>
>   	r = rfbi_runtime_get();
>   	if (r)
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
> index e173961..bbd35bb 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -410,7 +410,8 @@ static void venc_runtime_put(void)
>
>   	DSSDBG("venc_runtime_put\n");
>
> -	r = pm_runtime_put_sync(&venc.pdev->dev);
> +	pm_runtime_mark_last_busy(&venc.pdev->dev);
> +	r = pm_runtime_put_autosuspend(&venc.pdev->dev);
>   	WARN_ON(r < 0 && r != -ENOSYS);
>   }
>
> @@ -835,6 +836,8 @@ static int omap_venchw_probe(struct platform_device *pdev)
>   		return r;
>
>   	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, DSS_AUTOSUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(&pdev->dev);
>
>   	r = venc_runtime_get();
>   	if (r)
>

