From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 08/17] OMAP2,3: DSS2: Create platform_driver for each DSS HW IP
Date: Tue, 04 Jan 2011 16:07:42 -0800
Message-ID: <87zkrg43ht.fsf@ti.com>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
	<1294059069-26737-9-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:47235 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750919Ab1AEAHr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 19:07:47 -0500
Received: by mail-yi0-f44.google.com with SMTP id 19so4087663yie.17
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 16:07:46 -0800 (PST)
In-Reply-To: <1294059069-26737-9-git-send-email-svadivu@ti.com> (Guruswamy
	Senthilvadivu's message of "Mon, 3 Jan 2011 18:21:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: tomi.valkeinen@nokia.com, paul@pwsan.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

Guruswamy Senthilvadivu <svadivu@ti.com> writes:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> Hwmod adaptation design requires each of the DSS HW IP to be a platform driver. 
> Platform driver of dsshw has to be registered before of dispc, rfbi, dsi1,
> venc and omapdisplay driver should be after all the HW IPs. Sequence it with
> arch_initcall and device_initcall_sync.
>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>

Rather than creating a bunch of empty/dummy driver here to be populated
later, I'd prefer them to be created as needed in the subsequent
patches.

For example, the dispc parts of this patch should be added in PATCH 9
where you populate the functions.  The RFBI parts of this patch should
be added in PATCH 12, etc. etc.

Kevin


> ---
>  drivers/video/omap2/dss/core.c  |    2 +-
>  drivers/video/omap2/dss/dispc.c |   28 ++++++++++++++++++++++++++++
>  drivers/video/omap2/dss/dsi.c   |   29 ++++++++++++++++++++++++++++-
>  drivers/video/omap2/dss/dss.c   |   27 +++++++++++++++++++++++++++
>  drivers/video/omap2/dss/rfbi.c  |   28 ++++++++++++++++++++++++++++
>  drivers/video/omap2/dss/venc.c  |   28 ++++++++++++++++++++++++++++
>  6 files changed, 140 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 48d20d8..d165434 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -989,7 +989,7 @@ static int __init omap_dss_init2(void)
>  }
>  
>  core_initcall(omap_dss_init);
> -device_initcall(omap_dss_init2);
> +device_initcall_sync(omap_dss_init2);
>  #endif
>  
>  MODULE_AUTHOR("Tomi Valkeinen <tomi.valkeinen@nokia.com>");
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index fa40fa5..942dea5 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -3167,3 +3167,31 @@ int dispc_setup_plane(enum omap_plane plane,
>  
>  	return r;
>  }
> +
> +/* DISPC HW IP initialisation */
> +static int omap_dispchw_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int omap_dispchw_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver omap_dispchw_driver = {
> +	.probe          = omap_dispchw_probe,
> +	.remove         = omap_dispchw_remove,
> +	.driver         = {
> +		.name   = "omap_dispc",
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +static int __init omap_dispc_init(void)
> +{
> +	return platform_driver_register(&omap_dispchw_driver);
> +}
> +
> +device_initcall(omap_dispc_init);
> +
> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> index aa4f7a5..037d366 100644
> --- a/drivers/video/omap2/dss/dsi.c
> +++ b/drivers/video/omap2/dss/dsi.c
> @@ -292,7 +292,6 @@ static inline u32 dsi_read_reg(const struct dsi_reg idx)
>  	return __raw_readl(dsi.base + idx.idx);
>  }
>  
> -
>  void dsi_save_context(void)
>  {
>  }
> @@ -3304,3 +3303,31 @@ void dsi_exit(void)
>  	DSSDBG("omap_dsi_exit\n");
>  }
>  
> +/* DSI1 HW IP initialisation */
> +static int omap_dsi1hw_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int omap_dsi1hw_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver omap_dsi1hw_driver = {
> +	.probe          = omap_dsi1hw_probe,
> +	.remove         = omap_dsi1hw_remove,
> +	.driver         = {
> +		.name   = "omap_dsi1",
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +static int __init omap_dsi1_init(void)
> +{
> +	return platform_driver_register(&omap_dsi1hw_driver);
> +}
> +
> +device_initcall(omap_dsi1_init);
> +
> +
> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
> index 77c3621..6d0bd89 100644
> --- a/drivers/video/omap2/dss/dss.c
> +++ b/drivers/video/omap2/dss/dss.c
> @@ -639,3 +639,30 @@ void dss_exit(void)
>  	iounmap(dss.base);
>  }
>  
> +/* DSS HW IP initialisation */
> +static int omap_dsshw_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int omap_dsshw_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver omap_dsshw_driver = {
> +	.probe          = omap_dsshw_probe,
> +	.remove         = omap_dsshw_remove,
> +	.driver         = {
> +		.name   = "omap_dss",
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +static int __init omap_dss_init1(void)
> +{
> +	return platform_driver_register(&omap_dsshw_driver);
> +}
> +
> +arch_initcall(omap_dss_init1);
> +
> diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
> index bbe6246..a086233 100644
> --- a/drivers/video/omap2/dss/rfbi.c
> +++ b/drivers/video/omap2/dss/rfbi.c
> @@ -1054,3 +1054,31 @@ int rfbi_init_display(struct omap_dss_device *dssdev)
>  	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
>  	return 0;
>  }
> +
> +/* RFBI HW IP initialisation */
> +static int omap_rfbihw_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int omap_rfbihw_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver omap_rfbihw_driver = {
> +	.probe          = omap_rfbihw_probe,
> +	.remove         = omap_rfbihw_remove,
> +	.driver         = {
> +		.name   = "omap_rfbi",
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +static int __init omap_rfbi_init(void)
> +{
> +	return platform_driver_register(&omap_rfbihw_driver);
> +}
> +
> +device_initcall(omap_rfbi_init);
> +
> diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
> index eff3505..ac63cee 100644
> --- a/drivers/video/omap2/dss/venc.c
> +++ b/drivers/video/omap2/dss/venc.c
> @@ -740,3 +740,31 @@ void venc_dump_regs(struct seq_file *s)
>  
>  #undef DUMPREG
>  }
> +
> +/* VENC HW IP initialisation */
> +static int omap_venchw_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int omap_venchw_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static struct platform_driver omap_venchw_driver = {
> +	.probe          = omap_venchw_probe,
> +	.remove         = omap_venchw_remove,
> +	.driver         = {
> +		.name   = "omap_venc",
> +		.owner  = THIS_MODULE,
> +	},
> +};
> +
> +static int __init omap_venc_init(void)
> +{
> +	return platform_driver_register(&omap_venchw_driver);
> +}
> +
> +device_initcall(omap_venc_init);
> +
