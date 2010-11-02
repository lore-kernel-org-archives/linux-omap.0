From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP3630: DSS2: Enable Pre-Multiplied Alpha Support
Date: Tue, 02 Nov 2010 16:56:07 +0200
Message-ID: <1288709767.5614.138.camel@tubuntu>
References: <1288174567-24734-1-git-send-email-samreen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47324 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab0KBOzt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 10:55:49 -0400
In-Reply-To: <1288174567-24734-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Samreen <samreen@ti.com>
Cc: "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linufbdev@vger.kernel.org" <linufbdev@vger.kernel.org>, Rajkumar N <rajkumar.nagarajan@ti.com>, Sudeep Basavaraj <sudeep.basavaraj@ti.com>

Hi,

On Wed, 2010-10-27 at 12:16 +0200, ext Samreen wrote:
> From: Rajkumar N <rajkumar.nagarajan@ti.com>
> 
> Enable dss to process color formats with pre-mulitplied alpha.
> With this we can have alpha values defined for each pixel
> and hence can have different blending values for each pixel.
> sysfs entry has been created for this and pre-multiplied alpha
> support is turned off by default.
> 
> Also, the check for '(plane != OMAP_DSS_VIDEO1)'
> in  _dispc_setup_plane has been replaced by the correct
> dss_has_feature check

You're changing too many things in one patch. Please separate the
dss_feature changes and the actual implementation for the pre-multiplied
alpha.

Your naming of this feature is also bit varying: you have "pre_mult",
"PREMUL", "pre_multiplication_alpha". The last one is quite wrong, as
the feature is "premultiplied alpha".

Also a few comments inline.

> 
> Signed-off-by: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
> Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
> Signed-off-by: Samreen <samreen@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/display.h |    1 +
>  drivers/video/omap2/dss/dispc.c           |   25 +++++++++++++++++---
>  drivers/video/omap2/dss/dss.h             |    3 +-
>  drivers/video/omap2/dss/dss_features.c    |   20 ++++++++++++++--
>  drivers/video/omap2/dss/dss_features.h    |    1 +
>  drivers/video/omap2/dss/manager.c         |    5 +++-
>  drivers/video/omap2/dss/overlay.c         |   35 +++++++++++++++++++++++++++++
>  7 files changed, 81 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
> index c915a66..d433baf 100644
> --- a/arch/arm/plat-omap/include/plat/display.h
> +++ b/arch/arm/plat-omap/include/plat/display.h
> @@ -268,6 +268,7 @@ struct omap_overlay_info {
>  	u16 out_width;	/* if 0, out_width == width */
>  	u16 out_height;	/* if 0, out_height == height */
>  	u8 global_alpha;
> +	u8 pre_mult_alpha;
>  };
>  
>  struct omap_overlay {
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
> index fa40fa5..f1d1797 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -773,6 +773,17 @@ static void _dispc_set_vid_size(enum omap_plane plane, int width, int height)
>  	dispc_write_reg(vsi_reg[plane-1], val);
>  }
>  
> +static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool enable)
> +{
> +	if (!dss_has_feature(FEAT_PREMUL_ALPHA))
> +		return;
> +
> +	BUG_ON(!dss_has_feature(FEAT_GLOBAL_ALPHA_VID1) &&
> +		plane == OMAP_DSS_VIDEO1);

What is the rationale for having the function return, if
FEAT_PREMUL_ALPHA is not supported, but BUG if plane is video1 and
GLOBAL_ALPHA_VID1 is not supported?

> +
> +	REG_FLD_MOD(dispc_reg_att[plane], enable ? 1 : 0, 28, 28);
> +}
> +
>  static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
>  {
>  	if (!dss_has_feature(FEAT_GLOBAL_ALPHA))
> @@ -1507,7 +1518,8 @@ static int _dispc_setup_plane(enum omap_plane plane,
>  		bool ilace,
>  		enum omap_dss_rotation_type rotation_type,
>  		u8 rotation, int mirror,
> -		u8 global_alpha)
> +		u8 global_alpha,
> +		u8 pre_mult_alpha)
>  {
>  	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
>  	bool five_taps = 0;
> @@ -1693,8 +1705,11 @@ static int _dispc_setup_plane(enum omap_plane plane,
>  
>  	_dispc_set_rotation_attrs(plane, rotation, mirror, color_mode);
>  
> -	if (plane != OMAP_DSS_VIDEO1)
> +	if ((plane != OMAP_DSS_VIDEO1) ||
> +		dss_has_feature(FEAT_GLOBAL_ALPHA_VID1)) {
> +		_dispc_set_pre_mult_alpha(plane, pre_mult_alpha);
>  		_dispc_setup_global_alpha(plane, global_alpha);
> +	}
>  
>  	return 0;
>  }
> @@ -3139,7 +3154,8 @@ int dispc_setup_plane(enum omap_plane plane,
>  		       enum omap_color_mode color_mode,
>  		       bool ilace,
>  		       enum omap_dss_rotation_type rotation_type,
> -		       u8 rotation, bool mirror, u8 global_alpha)
> +		       u8 rotation, bool mirror, u8 global_alpha,
> +		       u8 pre_mult_alpha)
>  {
>  	int r = 0;
>  
> @@ -3161,7 +3177,8 @@ int dispc_setup_plane(enum omap_plane plane,
>  			   color_mode, ilace,
>  			   rotation_type,
>  			   rotation, mirror,
> -			   global_alpha);
> +			   global_alpha,
> +			   pre_mult_alpha);
>  
>  	enable_clocks(0);
>  
> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
> index 5c7940d..2bb515c 100644
> --- a/drivers/video/omap2/dss/dss.h
> +++ b/drivers/video/omap2/dss/dss.h
> @@ -359,7 +359,8 @@ int dispc_setup_plane(enum omap_plane plane,
>  		      bool ilace,
>  		      enum omap_dss_rotation_type rotation_type,
>  		      u8 rotation, bool mirror,
> -		      u8 global_alpha);
> +		      u8 global_alpha,
> +		      u8 pre_mult_alpha);
>  
>  bool dispc_go_busy(enum omap_channel channel);
>  void dispc_go(enum omap_channel channel);
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
> index 867f68d..1abb8c5 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -134,7 +134,7 @@ static struct omap_dss_features omap2_dss_features = {
>  };
>  
>  /* OMAP3 DSS Features */
> -static struct omap_dss_features omap3_dss_features = {
> +static struct omap_dss_features omap3430_dss_features = {
>  	.reg_fields = omap3_dss_reg_fields,
>  	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
>  
> @@ -146,6 +146,18 @@ static struct omap_dss_features omap3_dss_features = {
>  	.supported_color_modes = omap3_dss_supported_color_modes,
>  };
>  
> +static struct omap_dss_features omap3630_dss_features = {
> +	.reg_fields = omap3_dss_reg_fields,
> +	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
> +
> +	.has_feature    = FEAT_GLOBAL_ALPHA | FEAT_PREMUL_ALPHA,
> +
> +	.num_mgrs = 2,
> +	.num_ovls = 3,
> +	.supported_displays = omap3_dss_supported_displays,
> +	.supported_color_modes = omap3_dss_supported_color_modes,
> +};
> +
>  /* Functions returning values related to a DSS feature */
>  int dss_feat_get_num_mgrs(void)
>  {
> @@ -186,6 +198,8 @@ void dss_features_init(void)
>  {
>  	if (cpu_is_omap24xx())
>  		omap_current_dss_features = &omap2_dss_features;
> -	else
> -		omap_current_dss_features = &omap3_dss_features;
> +	else if (cpu_is_omap3630())
> +		omap_current_dss_features = &omap3630_dss_features;
> +	else if (cpu_is_omap34xx())
> +		omap_current_dss_features = &omap3430_dss_features;
>  }
> diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
> index cb231ea..f287da8 100644
> --- a/drivers/video/omap2/dss/dss_features.h
> +++ b/drivers/video/omap2/dss/dss_features.h
> @@ -27,6 +27,7 @@
>  enum dss_feat_id {
>  	FEAT_GLOBAL_ALPHA	= 1 << 0,
>  	FEAT_GLOBAL_ALPHA_VID1	= 1 << 1,
> +	FEAT_PREMUL_ALPHA	= 1 << 2,
>  };
>  
>  /* DSS register field id */
> diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
> index 545e9b9..873b334 100644
> --- a/drivers/video/omap2/dss/manager.c
> +++ b/drivers/video/omap2/dss/manager.c
> @@ -406,6 +406,7 @@ struct overlay_cache_data {
>  	u16 out_width;	/* if 0, out_width == width */
>  	u16 out_height;	/* if 0, out_height == height */
>  	u8 global_alpha;
> +	u8 pre_mult_alpha;
>  
>  	enum omap_channel channel;
>  	bool replication;
> @@ -842,7 +843,8 @@ static int configure_overlay(enum omap_plane plane)
>  			c->rotation_type,
>  			c->rotation,
>  			c->mirror,
> -			c->global_alpha);
> +			c->global_alpha,
> +			c->pre_mult_alpha);
>  
>  	if (r) {
>  		/* this shouldn't happen */
> @@ -1265,6 +1267,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
>  		oc->out_width = ovl->info.out_width;
>  		oc->out_height = ovl->info.out_height;
>  		oc->global_alpha = ovl->info.global_alpha;
> +		oc->pre_mult_alpha = ovl->info.pre_mult_alpha;
>  
>  		oc->replication =
>  			dss_use_replication(dssdev, ovl->info.color_mode);
> diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
> index 75642c2..f704d06 100644
> --- a/drivers/video/omap2/dss/overlay.c
> +++ b/drivers/video/omap2/dss/overlay.c
> @@ -257,6 +257,37 @@ static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
>  	return size;
>  }
>  
> +static ssize_t overlay_pre_multiplication_alpha_show(struct omap_overlay *ovl,
> +		char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "%d\n",
> +			ovl->info.pre_mult_alpha);
> +}
> +
> +static ssize_t overlay_pre_multiplication_alpha_store(struct omap_overlay *ovl,
> +		const char *buf, size_t size)
> +{
> +	int r;
> +	struct omap_overlay_info info;
> +
> +	ovl->get_overlay_info(ovl, &info);
> +
> +	/* only GFX and Video2 plane support pre alpha multiplication */

Shouldn't you check what the supported features are, instead of having a
comment?

> +	info.pre_mult_alpha = simple_strtoul(buf, NULL, 10);
> +
> +	r = ovl->set_overlay_info(ovl, &info);
> +	if (r)
> +		return r;
> +
> +	if (ovl->manager) {
> +		r = ovl->manager->apply(ovl->manager);
> +		if (r)
> +			return r;
> +	}
> +
> +	return size;
> +}
> +
>  struct overlay_attribute {
>  	struct attribute attr;
>  	ssize_t (*show)(struct omap_overlay *, char *);
> @@ -280,6 +311,9 @@ static OVERLAY_ATTR(enabled, S_IRUGO|S_IWUSR,
>  		overlay_enabled_show, overlay_enabled_store);
>  static OVERLAY_ATTR(global_alpha, S_IRUGO|S_IWUSR,
>  		overlay_global_alpha_show, overlay_global_alpha_store);
> +static OVERLAY_ATTR(pre_multiplication_alpha, S_IRUGO|S_IWUSR,
> +		overlay_pre_multiplication_alpha_show,
> +		overlay_pre_multiplication_alpha_store);
>  
>  static struct attribute *overlay_sysfs_attrs[] = {
>  	&overlay_attr_name.attr,
> @@ -290,6 +324,7 @@ static struct attribute *overlay_sysfs_attrs[] = {
>  	&overlay_attr_output_size.attr,
>  	&overlay_attr_enabled.attr,
>  	&overlay_attr_global_alpha.attr,
> +	&overlay_attr_pre_multiplication_alpha.attr,
>  	NULL
>  };
>  


