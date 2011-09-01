From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 08/10] OMAP4: DSS2: HDMI: Function pointer approach
 to call
Date: Thu, 01 Sep 2011 11:55:41 +0300
Message-ID: <1314867341.2169.18.camel@lappyti>
References: <1314598500-24005-1-git-send-email-mythripk@ti.com>
	 <1314598500-24005-2-git-send-email-mythripk@ti.com>
	 <1314598500-24005-3-git-send-email-mythripk@ti.com>
	 <1314598500-24005-4-git-send-email-mythripk@ti.com>
	 <1314598500-24005-5-git-send-email-mythripk@ti.com>
	 <1314598500-24005-6-git-send-email-mythripk@ti.com>
	 <1314598500-24005-7-git-send-email-mythripk@ti.com>
	 <1314598500-24005-8-git-send-email-mythripk@ti.com>
	 <1314598500-24005-9-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50397 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756469Ab1IAIzs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 04:55:48 -0400
Received: by bkas6 with SMTP id s6so2700797bka.1
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 01:55:45 -0700 (PDT)
In-Reply-To: <1314598500-24005-9-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org

On Mon, 2011-08-29 at 11:44 +0530, mythripk@ti.com wrote:
> From: Mythri P K <mythripk@ti.com>
> 
> To make the current hdmi DSS driver compatible with future OMAP with different
> IP blocks , add HDMI as a feature in dss_features and abstract the internal
> function in hdmi dss driver.

No space before comma.

The description could use some improvement, HDMI is not "a feature in
dss_features", and I don't understand what the rest of the sentence
means.

> Signed-off-by: Mythri P K <mythripk@ti.com>
> ---
>  drivers/video/omap2/dss/dss_features.c |   24 +++++++++++++++++++++++-
>  drivers/video/omap2/dss/dss_features.h |    1 +
>  drivers/video/omap2/dss/hdmi.c         |   22 +++++++++++-----------
>  include/video/omapdss.h                |   19 +++++++++++++++++++
>  include/video/omaphdmi.h               |    1 +
>  5 files changed, 55 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
> index b63c5f8..edf2929 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -429,6 +429,26 @@ static const struct omap_dss_features omap4_dss_features = {
>  	.burst_size_unit = 16,
>  };
>  
> +const struct omap_hdmi_ip_driver *omap_hdmi_functions;

Should be static, but considering you never use this variable, except to
assign it once, it should be removed.

> +
> +/* HDMI OMAP4 Functions*/
> +const struct omap_hdmi_ip_driver omap4_hdmi_functions = {

Should be static.

> +
> +	.video_configure	=	hdmi_basic_configure,
> +	.phy_enable		=	hdmi_phy_enable,
> +	.phy_disable		=	hdmi_phy_disable,
> +	.read_edid		=	read_edid,
> +	.pll_enable		=	hdmi_pll_enable,
> +	.pll_disable		=	hdmi_pll_disable,
> +	.video_enable		=	hdmi_wp_video_start,
> +};

Check that this compiles if HDMI is disabled.

> +
> +void dss_hdmi_features_init(struct hdmi_ip_data *ip_data)

Perhaps something like dss_init_hdmi_ip_data() would be better?

> +{
> +	if (cpu_is_omap44xx())
> +		ip_data->hdmi_ops = &omap4_hdmi_functions;
> +}
> +
>  /* Functions returning values related to a DSS feature */
>  int dss_feat_get_num_mgrs(void)
>  {
> @@ -512,8 +532,10 @@ void dss_features_init(void)
>  		omap_current_dss_features = &omap3430_dss_features;
>  	else if (omap_rev() == OMAP4430_REV_ES1_0)
>  		omap_current_dss_features = &omap4430_es1_0_dss_features;
> -	else if (cpu_is_omap44xx())
> +	else if (cpu_is_omap44xx()) {
>  		omap_current_dss_features = &omap4_dss_features;
> +		omap_hdmi_functions = &omap4_hdmi_functions;

No need for this code.

> +	}
>  	else
>  		DSSWARN("Unsupported OMAP version");
>  }
> diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
> index 4271e96..ca64b21 100644
> --- a/drivers/video/omap2/dss/dss_features.h
> +++ b/drivers/video/omap2/dss/dss_features.h
> @@ -99,4 +99,5 @@ u32 dss_feat_get_burst_size_unit(void);		/* in bytes */
>  bool dss_has_feature(enum dss_feat_id id);
>  void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
>  void dss_features_init(void);
> +void dss_hdmi_features_init(struct hdmi_ip_data *ip_data);
>  #endif
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index fb7d66f..c508cf6 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -184,7 +184,7 @@ static void hdmi_runtime_put(void)
>  int hdmi_init_display(struct omap_dss_device *dssdev)
>  {
>  	DSSDBG("init_display\n");
> -
> +	dss_hdmi_features_init(&hdmi.hdmi_data);
>  	return 0;
>  }
>  
> @@ -364,8 +364,8 @@ static void hdmi_read_edid(struct omap_video_timings *dp)
>  	memset(hdmi.edid, 0, HDMI_EDID_MAX_LENGTH);
>  
>  	if (!hdmi.edid_set)
> -		ret = read_edid(&hdmi.hdmi_data, hdmi.edid,
> -						HDMI_EDID_MAX_LENGTH);
> +		ret = hdmi.hdmi_data.hdmi_ops->read_edid(&hdmi.hdmi_data,
> +					hdmi.edid, HDMI_EDID_MAX_LENGTH);

hdmi_ops could be just "ops", there's no possibility to confuse it with
some other ops.

>  	if (!ret) {
>  		if (!memcmp(hdmi.edid, edid_header, sizeof(edid_header))) {
>  			/* search for timings of default resolution */
> @@ -475,16 +475,16 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
>  
>  	hdmi_compute_pll(dssdev, phy, &hdmi.hdmi_data.pll_data);
>  
> -	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
> +	hdmi.hdmi_data.hdmi_ops->video_enable(&hdmi.hdmi_data, 0);
>  
>  	/* config the PLL and PHY hdmi_set_pll_pwrfirst */
> -	r = hdmi_pll_enable(&hdmi.hdmi_data);
> +	r = hdmi.hdmi_data.hdmi_ops->pll_enable(&hdmi.hdmi_data);
>  	if (r) {
>  		DSSDBG("Failed to lock PLL\n");
>  		goto err;
>  	}
>  
> -	r = hdmi_phy_enable(&hdmi.hdmi_data);
> +	r = hdmi.hdmi_data.hdmi_ops->phy_enable(&hdmi.hdmi_data);
>  	if (r) {
>  		DSSDBG("Failed to start PHY\n");
>  		goto err;
> @@ -492,7 +492,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
>  
>  	hdmi.hdmi_data.cfg.cm.mode = hdmi.mode;
>  	hdmi.hdmi_data.cfg.cm.code = hdmi.code;
> -	hdmi_basic_configure(&hdmi.hdmi_data);
> +	hdmi.hdmi_data.hdmi_ops->video_configure(&hdmi.hdmi_data);
>  
>  	/* Make selection of HDMI in DSS */
>  	dss_select_hdmi_venc_clk_source(DSS_HDMI_M_PCLK);
> @@ -514,7 +514,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
>  
>  	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
>  
> -	hdmi_wp_video_start(&hdmi.hdmi_data, 1);
> +	hdmi.hdmi_data.hdmi_ops->video_enable(&hdmi.hdmi_data, 1);
>  
>  	return 0;
>  err:
> @@ -526,9 +526,9 @@ static void hdmi_power_off(struct omap_dss_device *dssdev)
>  {
>  	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 0);
>  
> -	hdmi_wp_video_start(&hdmi.hdmi_data, 0);
> -	hdmi_phy_disable(&hdmi.hdmi_data);
> -	hdmi_pll_disable(&hdmi.hdmi_data);
> +	hdmi.hdmi_data.hdmi_ops->video_enable(&hdmi.hdmi_data, 0);
> +	hdmi.hdmi_data.hdmi_ops->phy_disable(&hdmi.hdmi_data);
> +	hdmi.hdmi_data.hdmi_ops->pll_disable(&hdmi.hdmi_data);
>  	hdmi_runtime_put();
>  
>  	hdmi.edid_set = 0;
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index 9398dd3..bf2aeba 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -21,6 +21,7 @@
>  #include <linux/list.h>
>  #include <linux/kobject.h>
>  #include <linux/device.h>
> +#include <video/omaphdmi.h>

Why do you add this?

>  
>  #define DISPC_IRQ_FRAMEDONE		(1 << 0)
>  #define DISPC_IRQ_VSYNC			(1 << 1)
> @@ -555,6 +556,24 @@ struct omap_dss_driver {
>  	u32 (*get_wss)(struct omap_dss_device *dssdev);
>  };
>  
> +struct omap_hdmi_ip_driver {

The naming is somewhat confusing. Why not just name it omap_hdmi_ip_ops?

> +
> +	void (*video_configure)(struct hdmi_ip_data *ip_data);
> +
> +	int (*phy_enable)(struct hdmi_ip_data *ip_data);
> +
> +	void (*phy_disable)(struct hdmi_ip_data *ip_data);
> +
> +	int (*read_edid)(struct hdmi_ip_data *ip_data,
> +			u8 *pedid, u16 max_length);
> +
> +	int (*pll_enable)(struct hdmi_ip_data *ip_data);
> +
> +	void (*pll_disable)(struct hdmi_ip_data *ip_data);
> +
> +	void (*video_enable)(struct hdmi_ip_data *ip_data, bool start);
> +};
> +
>  int omap_dss_register_driver(struct omap_dss_driver *);
>  void omap_dss_unregister_driver(struct omap_dss_driver *);
>  
> diff --git a/include/video/omaphdmi.h b/include/video/omaphdmi.h
> index 88b1ccb..a740237 100644
> --- a/include/video/omaphdmi.h
> +++ b/include/video/omaphdmi.h
> @@ -80,6 +80,7 @@ struct hdmi_ip_data {
>  	unsigned long	core_av_offset;
>  	unsigned long	pll_offset;
>  	unsigned long	phy_offset;
> +	const struct omap_hdmi_ip_driver *hdmi_ops;
>  	struct hdmi_config cfg;
>  	struct hdmi_pll_info pll_data;
>  };


