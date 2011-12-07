From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 63/65] OMAPDSS: APPLY: add checking of ovls/mgrs settings
Date: Wed, 7 Dec 2011 18:35:51 +0530
Message-ID: <4EDF64AF.6040008@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com> <1321953724-6350-64-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45250 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755357Ab1LGNGc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Dec 2011 08:06:32 -0500
In-Reply-To: <1321953724-6350-64-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

Hi,

On Tuesday 22 November 2011 02:52 PM, Tomi Valkeinen wrote:
> Add checks for overlay and manager settings. The checks are a bit
> complex, as we need to observe the bigger picture instead of overlays
> and managers independently. Things like the used display and the zorder
> of other overlays affect the validity of the settings.

Minor comment:

dss_ovl_check, dss_mgr_check and dss_mgr_check_zorder don't really 
qualify as functions which do actual applying of configurations, they 
could be moved from apply.c to manager.c and overlay.c.

Archit

>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/apply.c |  215 ++++++++++++++++++++++++++++++++++++++-
>   1 files changed, 212 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index 5d933b9..72afa85 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -166,6 +166,169 @@ static bool mgr_manual_update(struct omap_overlay_manager *mgr)
>   	return mgr->device->caps&  OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
>   }
>
> +/* Check if overlay parameters are compatible with display */
> +static int dss_ovl_check(struct omap_overlay *ovl,
> +		struct omap_overlay_info *info, struct omap_dss_device *dssdev)
> +{
> +	u16 outw, outh;
> +	u16 dw, dh;
> +
> +	if (dssdev == NULL)
> +		return 0;
> +
> +	dssdev->driver->get_resolution(dssdev,&dw,&dh);
> +
> +	if ((ovl->caps&  OMAP_DSS_OVL_CAP_SCALE) == 0) {
> +		outw = info->width;
> +		outh = info->height;
> +	} else {
> +		if (info->out_width == 0)
> +			outw = info->width;
> +		else
> +			outw = info->out_width;
> +
> +		if (info->out_height == 0)
> +			outh = info->height;
> +		else
> +			outh = info->out_height;
> +	}
> +
> +	if (dw<  info->pos_x + outw) {
> +		DSSERR("overlay %d horizontally not inside the display area "
> +				"(%d + %d>= %d)\n",
> +				ovl->id, info->pos_x, outw, dw);
> +		return -EINVAL;
> +	}
> +
> +	if (dh<  info->pos_y + outh) {
> +		DSSERR("overlay %d vertically not inside the display area "
> +				"(%d + %d>= %d)\n",
> +				ovl->id, info->pos_y, outh, dh);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dss_mgr_check_zorder(struct omap_overlay_manager *mgr,
> +		struct omap_overlay_info **overlay_infos)
> +{
> +	struct omap_overlay *ovl1, *ovl2;
> +	struct ovl_priv_data *op1, *op2;
> +	struct omap_overlay_info *info1, *info2;
> +
> +	list_for_each_entry(ovl1,&mgr->overlays, list) {
> +		op1 = get_ovl_priv(ovl1);
> +		info1 = overlay_infos[ovl1->id];
> +
> +		if (info1 == NULL)
> +			continue;
> +
> +		list_for_each_entry(ovl2,&mgr->overlays, list) {
> +			if (ovl1 == ovl2)
> +				continue;
> +
> +			op2 = get_ovl_priv(ovl2);
> +			info2 = overlay_infos[ovl2->id];
> +
> +			if (info2 == NULL)
> +				continue;
> +
> +			if (info1->zorder == info2->zorder) {
> +				DSSERR("overlays %d and %d have the same "
> +						"zorder %d\n",
> +					ovl1->id, ovl2->id, info1->zorder);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int dss_mgr_check(struct omap_overlay_manager *mgr,
> +		struct omap_dss_device *dssdev,
> +		struct omap_overlay_manager_info *info,
> +		struct omap_overlay_info **overlay_infos)
> +{
> +	struct omap_overlay *ovl;
> +	int r;
> +
> +	if (dss_has_feature(FEAT_ALPHA_FREE_ZORDER)) {
> +		r = dss_mgr_check_zorder(mgr, overlay_infos);
> +		if (r)
> +			return r;
> +	}
> +
> +	list_for_each_entry(ovl,&mgr->overlays, list) {
> +		struct omap_overlay_info *oi;
> +		int r;
> +
> +		oi = overlay_infos[ovl->id];
> +
> +		if (oi == NULL)
> +			continue;
> +
> +		r = dss_ovl_check(ovl, oi, dssdev);
> +		if (r)
> +			return r;
> +	}
> +
> +	return 0;
> +}
> +static int dss_check_settings_low(struct omap_overlay_manager *mgr,
> +		struct omap_dss_device *dssdev, bool applying)
> +{
> +	struct omap_overlay_info *oi;
> +	struct omap_overlay_manager_info *mi;
> +	struct omap_overlay *ovl;
> +	struct omap_overlay_info *ois[MAX_DSS_OVERLAYS];
> +	struct ovl_priv_data *op;
> +	struct mgr_priv_data *mp;
> +
> +	mp = get_mgr_priv(mgr);
> +
> +	if (applying&&  mp->user_info_dirty)
> +		mi =&mp->user_info;
> +	else
> +		mi =&mp->info;
> +
> +	/* collect the infos to be tested into the array */
> +	list_for_each_entry(ovl,&mgr->overlays, list) {
> +		op = get_ovl_priv(ovl);
> +
> +		if (!op->enabled)
> +			oi = NULL;
> +		else if (applying&&  op->user_info_dirty)
> +			oi =&op->user_info;
> +		else
> +			oi =&op->info;
> +
> +		ois[ovl->id] = oi;
> +	}
> +
> +	return dss_mgr_check(mgr, dssdev, mi, ois);
> +}
> +
> +/*
> + * check manager and overlay settings using overlay_info from data->info
> + */
> +static int dss_check_settings(struct omap_overlay_manager *mgr,
> +		struct omap_dss_device *dssdev)
> +{
> +	return dss_check_settings_low(mgr, dssdev, false);
> +}
> +
> +/*
> + * check manager and overlay settings using overlay_info from ovl->info if
> + * dirty and from data->info otherwise
> + */
> +static int dss_check_settings_apply(struct omap_overlay_manager *mgr,
> +		struct omap_dss_device *dssdev)
> +{
> +	return dss_check_settings_low(mgr, dssdev, true);
> +}
> +
>   static bool need_isr(void)
>   {
>   	const int num_mgrs = dss_feat_get_num_mgrs();
> @@ -517,6 +680,7 @@ static void dss_write_regs(void)
>   	for (i = 0; i<  num_mgrs; ++i) {
>   		struct omap_overlay_manager *mgr;
>   		struct mgr_priv_data *mp;
> +		int r;
>
>   		mgr = omap_dss_get_overlay_manager(i);
>   		mp = get_mgr_priv(mgr);
> @@ -524,6 +688,13 @@ static void dss_write_regs(void)
>   		if (!mp->enabled || mgr_manual_update(mgr) || mp->busy)
>   			continue;
>
> +		r = dss_check_settings(mgr, mgr->device);
> +		if (r) {
> +			DSSERR("cannot write registers for manager %s: "
> +					"illegal configuration\n", mgr->name);
> +			continue;
> +		}
> +
>   		dss_mgr_write_regs(mgr);
>
>   		if (need_go(mgr)) {
> @@ -541,11 +712,19 @@ void dss_start_update(struct omap_overlay_manager *mgr)
>   {
>   	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>   	unsigned long flags;
> +	int r;
>
>   	spin_lock_irqsave(&data_lock, flags);
>
>   	WARN_ON(mp->updating);
>
> +	r = dss_check_settings(mgr, mgr->device);
> +	if (r) {
> +		DSSERR("cannot start manual update: illegal configuration\n");
> +		spin_unlock_irqrestore(&data_lock, flags);
> +		return;
> +	}
> +
>   	dss_mgr_write_regs(mgr);
>
>   	mp->updating = true;
> @@ -690,11 +869,19 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
>   {
>   	unsigned long flags;
>   	struct omap_overlay *ovl;
> +	int r;
>
>   	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
>
>   	spin_lock_irqsave(&data_lock, flags);
>
> +	r = dss_check_settings_apply(mgr, mgr->device);
> +	if (r) {
> +		spin_unlock_irqrestore(&data_lock, flags);
> +		DSSERR("failed to apply settings: illegal configuration.\n");
> +		return r;
> +	}
> +
>   	/* Configure overlays */
>   	list_for_each_entry(ovl,&mgr->overlays, list)
>   		omap_dss_mgr_apply_ovl(ovl);
> @@ -784,6 +971,7 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
>   {
>   	struct mgr_priv_data *mp = get_mgr_priv(mgr);
>   	unsigned long flags;
> +	int r;
>
>   	mutex_lock(&apply_lock);
>
> @@ -793,6 +981,16 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
>   	spin_lock_irqsave(&data_lock, flags);
>
>   	mp->enabled = true;
> +	r = dss_check_settings(mgr, mgr->device);
> +	mp->enabled = false;
> +	if (r) {
> +		DSSERR("failed to enable manager %d: check_settings failed\n",
> +				mgr->id);
> +		spin_unlock_irqrestore(&data_lock, flags);
> +		goto out;
> +	}
> +
> +	mp->enabled = true;
>
>   	dss_mgr_setup_fifos(mgr);
>
> @@ -1142,16 +1340,25 @@ int dss_ovl_enable(struct omap_overlay *ovl)
>
>   	if (op->enabled) {
>   		r = 0;
> -		goto err;
> +		goto err1;
>   	}
>
>   	if (ovl->manager == NULL || ovl->manager->device == NULL) {
>   		r = -EINVAL;
> -		goto err;
> +		goto err1;
>   	}
>
>   	spin_lock_irqsave(&data_lock, flags);
>
> +	op->enabled = true;
> +	r = dss_check_settings(ovl->manager, ovl->manager->device);
> +	op->enabled = false;
> +	if (r) {
> +		DSSERR("failed to enable overlay %d: check_settings failed\n",
> +				ovl->id);
> +		goto err2;
> +	}
> +
>   	dss_apply_ovl_enable(ovl, true);
>
>   	dss_ovl_setup_fifo(ovl);
> @@ -1163,7 +1370,9 @@ int dss_ovl_enable(struct omap_overlay *ovl)
>   	mutex_unlock(&apply_lock);
>
>   	return 0;
> -err:
> +err2:
> +	spin_unlock_irqrestore(&data_lock, flags);
> +err1:
>   	mutex_unlock(&apply_lock);
>   	return r;
>   }

