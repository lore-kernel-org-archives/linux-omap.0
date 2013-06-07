From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 12/32] OMAPDSS: Implement display (dis)connect support
Date: Fri, 7 Jun 2013 12:16:04 +0530
Message-ID: <51B181AC.3070400@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-13-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43382 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab3FGGrT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 02:47:19 -0400
In-Reply-To: <1369906493-27538-13-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Thursday 30 May 2013 03:04 PM, Tomi Valkeinen wrote:
> We currently have two steps in panel initialization and startup: probing
> and enabling. After the panel has been probed, it's ready and can be
> configured and later enabled.
>
> This model is not enough with more complex display pipelines, where we
> may have, for example, two panels, of which only one can be used at a
> time, connected to the same video output.
>
> To support that kind of scenarios, we need to add new step to the
> initialization: connect.
>
> This patch adds support for connecting and disconnecting panels. After
> probe, but before connect, no panel ops should be called. When the
> connect is called, a proper video pipeline is established, and the panel
> is ready for use. If some part in the video pipeline is already
> connected (by some other panel), the connect call fails.
>
> One key difference with the old style setup is that connect() handles
> also connecting to the overlay manager. This means that the omapfb (or
> omapdrm) no longer needs to figure out which overlay manager to use, but
> it can just call connect() on the panel, and the proper overlay manager
> is connected by omapdss.
>
> This also allows us to add back the support for dynamic switching
> between two exclusive panels. However, the current panel device model is
> not changed to support this, as the new device model is implemented in
> the following patches and the old model will be removed. The new device
> model supports dynamic switching.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/gpu/drm/omapdrm/omap_crtc.c      | 24 +++++++++++++++++
>   drivers/gpu/drm/omapdrm/omap_drv.c       | 12 ++++++++-
>   drivers/video/omap2/dss/apply.c          | 14 ++++++++++
>   drivers/video/omap2/dss/core.c           | 44 +++++++++++++++++++++++++++++++
>   drivers/video/omap2/dss/display-sysfs.c  | 28 +++++++++++---------
>   drivers/video/omap2/dss/manager-sysfs.c  | 45 ++++++++++++++++++++------------
>   drivers/video/omap2/dss/output.c         | 14 ++++++++++
>   drivers/video/omap2/omapfb/omapfb-main.c | 25 ++++++++++--------
>   include/video/omapdss.h                  | 23 ++++++++++++++++
>   9 files changed, 188 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
> index 02075bf..b2ab2f5 100644
> --- a/drivers/gpu/drm/omapdrm/omap_crtc.c
> +++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
> @@ -94,6 +94,28 @@ uint32_t pipe2vbl(struct drm_crtc *crtc)
>   static struct omap_crtc *omap_crtcs[8];
>
>   /* we can probably ignore these until we support command-mode panels: */
> +static int omap_crtc_connect(struct omap_overlay_manager *mgr,
> +		struct omap_dss_output *dst)
> +{
> +	if (mgr->output)
> +		return -EINVAL;
> +
> +	if ((mgr->supported_outputs & dst->id) == 0)
> +		return -EINVAL;
> +
> +	dst->manager = mgr;
> +	mgr->output = dst;
> +
> +	return 0;
> +}
> +
> +static void omap_crtc_disconnect(struct omap_overlay_manager *mgr,
> +		struct omap_dss_output *dst)
> +{
> +	mgr->output->manager = NULL;
> +	mgr->output = NULL;
> +}
> +
>   static void omap_crtc_start_update(struct omap_overlay_manager *mgr)
>   {
>   }
> @@ -138,6 +160,8 @@ static void omap_crtc_unregister_framedone_handler(
>   }
>
>   static const struct dss_mgr_ops mgr_ops = {
> +		.connect = omap_crtc_connect,
> +		.disconnect = omap_crtc_disconnect,
>   		.start_update = omap_crtc_start_update,
>   		.enable = omap_crtc_enable,
>   		.disable = omap_crtc_disable,
> diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
> index f8947f9..58bd259 100644
> --- a/drivers/gpu/drm/omapdrm/omap_drv.c
> +++ b/drivers/gpu/drm/omapdrm/omap_drv.c
> @@ -97,6 +97,7 @@ static int omap_modeset_init(struct drm_device *dev)
>   	int num_mgrs = dss_feat_get_num_mgrs();
>   	int num_crtcs;
>   	int i, id = 0;
> +	int r;
>
>   	omap_crtc_pre_init();
>
> @@ -118,6 +119,7 @@ static int omap_modeset_init(struct drm_device *dev)
>   		struct drm_connector *connector;
>   		struct drm_encoder *encoder;
>   		enum omap_channel channel;
> +		struct omap_overlay_manager *mgr;
>
>   		if (!dssdev->driver) {
>   			dev_warn(dev->dev, "%s has no driver.. skipping it\n",
> @@ -133,6 +135,13 @@ static int omap_modeset_init(struct drm_device *dev)
>   			continue;
>   		}
>
> +		r = dssdev->driver->connect(dssdev);
> +		if (r) {
> +			dev_err(dev->dev, "could not connect display: %s\n",
> +					dssdev->name);
> +			continue;
> +		}
> +
>   		encoder = omap_encoder_init(dev, dssdev);
>
>   		if (!encoder) {
> @@ -174,8 +183,9 @@ static int omap_modeset_init(struct drm_device *dev)
>   		 * other possible channels to which the encoder can connect are
>   		 * not considered.
>   		 */
> -		channel = dssdev->output->dispc_channel;
>
> +		mgr = omapdss_find_mgr_from_display(dssdev);
> +		channel = mgr->id;
>   		/*
>   		 * if this channel hasn't already been taken by a previously
>   		 * allocated crtc, we create a new crtc for it
> diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
> index c844071..dbd3c2f 100644
> --- a/drivers/video/omap2/dss/apply.c
> +++ b/drivers/video/omap2/dss/apply.c
> @@ -790,6 +790,18 @@ static void mgr_clear_shadow_dirty(struct omap_overlay_manager *mgr)
>   	}
>   }
>
> +static int dss_mgr_connect_compat(struct omap_overlay_manager *mgr,
> +		struct omap_dss_output *dst)
> +{
> +	return mgr->set_output(mgr, dst);
> +}
> +
> +static void dss_mgr_disconnect_compat(struct omap_overlay_manager *mgr,
> +		struct omap_dss_output *dst)
> +{
> +	mgr->unset_output(mgr);
> +}
> +
>   static void dss_mgr_start_update_compat(struct omap_overlay_manager *mgr)
>   {
>   	struct mgr_priv_data *mp = get_mgr_priv(mgr);
> @@ -1552,6 +1564,8 @@ static void dss_mgr_unregister_framedone_handler_compat(struct omap_overlay_mana
>   }
>
>   static const struct dss_mgr_ops apply_mgr_ops = {
> +	.connect = dss_mgr_connect_compat,
> +	.disconnect = dss_mgr_disconnect_compat,
>   	.start_update = dss_mgr_start_update_compat,
>   	.enable = dss_mgr_enable_compat,
>   	.disable = dss_mgr_disable_compat,
> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
> index 502ec1b..4bd8f79 100644
> --- a/drivers/video/omap2/dss/core.c
> +++ b/drivers/video/omap2/dss/core.c
> @@ -371,6 +371,46 @@ static int dss_driver_remove(struct device *dev)
>   	return 0;
>   }
>
> +static int omapdss_default_connect(struct omap_dss_device *dssdev)
> +{
> +	struct omap_dss_output *out;
> +	struct omap_overlay_manager *mgr;
> +	int r;
> +
> +	out = dssdev->output;
> +
> +	if (out == NULL)
> +		return -ENODEV;
> +
> +	mgr = omap_dss_get_overlay_manager(out->dispc_channel);
> +	if (!mgr)
> +		return -ENODEV;
> +
> +	r = dss_mgr_connect(mgr, out);
> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
> +static void omapdss_default_disconnect(struct omap_dss_device *dssdev)
> +{
> +	struct omap_dss_output *out;
> +	struct omap_overlay_manager *mgr;
> +
> +	out = dssdev->output;
> +
> +	if (out == NULL)
> +		return;
> +
> +	mgr = out->manager;
> +
> +	if (mgr == NULL)
> +		return;
> +
> +	dss_mgr_disconnect(mgr, out);
> +}
> +
>   int omap_dss_register_driver(struct omap_dss_driver *dssdriver)
>   {
>   	dssdriver->driver.bus = &dss_bus_type;
> @@ -384,6 +424,10 @@ int omap_dss_register_driver(struct omap_dss_driver *dssdriver)
>   			omapdss_default_get_recommended_bpp;
>   	if (dssdriver->get_timings == NULL)
>   		dssdriver->get_timings = omapdss_default_get_timings;
> +	if (dssdriver->connect == NULL)
> +		dssdriver->connect = omapdss_default_connect;
> +	if (dssdriver->disconnect == NULL)
> +		dssdriver->disconnect = omapdss_default_disconnect;

I was wondering if these should be apis rather than driver ops. One 
advantage of having them as functions used by omapfb/omapdrm would be 
that a panel driver wouldn't override the default_connect/disconnect ops.

Even though they are named omapdss_default_connect/disconnect, I don't 
think there is another option by which a panel driver may chose to 
connect to omapdss outputs, right?

Archit

