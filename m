From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm/omap: use omapdss low level API
Date: Fri, 16 Nov 2012 07:59:04 -0600
Message-ID: <CAF6AEGuo+qUpRv_cTODM9yCAHhWfRfY4wNs=JGqDDWYpGquiVg@mail.gmail.com>
References: <1353024058-11504-1-git-send-email-robdclark@gmail.com>
	<50A5E0BF.1010403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38546 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab2KPN7F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 08:59:05 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so2846488vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Nov 2012 05:59:05 -0800 (PST)
In-Reply-To: <50A5E0BF.1010403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: dri-devel@lists.freedesktop.org, patches@linaro.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg KH <greg@kroah.com>

On Fri, Nov 16, 2012 at 12:44 AM, Archit Taneja <archit@ti.com> wrote:
> On Friday 16 November 2012 05:30 AM, Rob Clark wrote:
>>
>> +static void omap_crtc_set_lcd_config(struct omap_overlay_manager *mgr,
>> +               const struct dss_lcd_mgr_config *config)
>> +{
>> +       struct omap_crtc *omap_crtc = container_of(mgr, struct omap_crtc,
>> mgr);
>> +       DBG("%s", omap_crtc->name);
>> +       dispc_mgr_set_lcd_config(omap_crtc->channel, config);
>
>
> Maybe you should move this dispc write also to omap_crtc_pre_apply, the same
> way it's done for timings. We'll also be confident about having the clocks
> required if this is called in pre_apply.
>

That was the first thing I had tried, although the order doesn't
really work out well and lcd config ends up getting set on the n+1'th
apply.  Currently this is only called indirectly from
omap_encoder_set_enabled() -> dssdrv->enable() which always happens on
apply worker.  In fact no dispc or dssdev fxn that changes state is
called outside of apply worker.  (Only things like detect and reading
edid are happening outside of apply worker.)

When we get to the point of having more sophisticated panel drivers,
these callbacks from the panel are probably going to need some sort of
if (is_in_apply_worker()) sort of check.


>> +static void apply_worker(struct work_struct *work)
>> +{
>> +       struct omap_crtc *omap_crtc =
>> +                       container_of(work, struct omap_crtc, apply_work);
>> +       struct drm_crtc *crtc = &omap_crtc->base;
>> +       struct drm_device *dev = crtc->dev;
>> +       struct omap_drm_apply *apply, *n;
>> +       bool need_apply;
>> +
>> +       /*
>> +        * Synchronize everything on mode_config.mutex, to keep
>> +        * the callbacks and list modification all serialized
>> +        * with respect to modesetting ioctls from userspace.
>> +        */
>> +       mutex_lock(&dev->mode_config.mutex);
>> +       dispc_runtime_get();
>> +
>> +       /*
>> +        * If we are still pending a previous update, wait.. when the
>> +        * pending update completes, we get kicked again.
>> +        */
>> +       if (omap_crtc->apply_irq.registered)
>> +               goto out;
>> +
>> +       /* finish up previous apply's: */
>> +       list_for_each_entry_safe(apply, n,
>> +                       &omap_crtc->pending_applies, pending_node) {
>> +               apply->post_apply(apply);
>> +               list_del(&apply->pending_node);
>> +       }
>> +
>> +       need_apply = !list_empty(&omap_crtc->queued_applies);
>> +
>> +       /* then handle the next round of of queued apply's: */
>> +       list_for_each_entry_safe(apply, n,
>> +                       &omap_crtc->queued_applies, queued_node) {
>> +               apply->pre_apply(apply);
>> +               list_del(&apply->queued_node);
>> +               apply->queued = false;
>> +               list_add_tail(&apply->pending_node,
>> +                               &omap_crtc->pending_applies);
>> +       }
>> +
>> +       if (need_apply) {
>> +               enum omap_channel channel = omap_crtc->channel;
>> +
>> +               DBG("%s: GO", omap_crtc->name);
>> +
>> +               if (dispc_mgr_is_enabled(channel)) {
>> +                       omap_irq_register(dev, &omap_crtc->apply_irq);
>> +                       dispc_mgr_go(channel);
>> +               } else if (!dispc_mgr_go_busy(channel)) {
>
>
> I'm not clear about this. Why would GO be set in the first place if the
> manager isn't enabled? This could be replaced with a simple 'else'
>

Yeah, that extra if should be redundant

>
>> +static void omap_crtc_pre_apply(struct omap_drm_apply *apply)
>> +{
>> +       struct omap_crtc *omap_crtc =
>> +                       container_of(apply, struct omap_crtc, apply);
>> +       struct drm_crtc *crtc = &omap_crtc->base;
>> +       struct drm_encoder *encoder = NULL;
>> +
>> +       DBG("%s: enabled=%d, full=%d", omap_crtc->name,
>> +                       omap_crtc->enabled, omap_crtc->full_update);
>> +
>> +       if (omap_crtc->full_update) {
>
>
> If I get it right, full_update refers to manager properties that previously
> used to propogate downstream from the output driver to dispc, i.e, things
> like timings and so on. and the ones which aren't full_update are upstream
> properties like transparency keys, default_color and so on?
>

Well, it basically means power or timings have changed.  So it means
closer to "full modeset" vs "pageflip".

But this function does deal with one mismatch between DRM and DSS.. in
DRM, everything gets setup in crtc -> downstream order, whereas
omapdss to accommodate more sophisticated panels does things in the
reverse order.  So the crtc here propagates timing/power state change
to the encoder (which may turn into mgr op callbacks), rather than
relying on the encoder-helper fxn ptrs called from KMS.

And in fact other DRM drivers will need the same thing eventually if
they are to support the common panel/display framework.  So I think
eventually a new / alternate set of crtc helpers (at least
drm_crtc_helper_set_{config,mode})()) will be needed.  But I think it
would be easier to introduce after the atomic modeset changes.

>
>>
>> -static int omap_modeset_init(struct drm_device *dev)
>> -{
>> -       const struct omap_drm_platform_data *pdata =
>> dev->dev->platform_data;
>> -       struct omap_kms_platform_data *kms_pdata = NULL;
>> -       struct omap_drm_private *priv = dev->dev_private;
>> -       struct omap_dss_device *dssdev = NULL;
>> -       int i, j;
>> -       unsigned int connected_connectors = 0;
>> +               encoder = omap_encoder_init(dev, dssdev);
>>
>> -       drm_mode_config_init(dev);
>> -
>> -       if (pdata && pdata->kms_pdata) {
>> -               kms_pdata = pdata->kms_pdata;
>> -
>> -               /* if platform data is provided by the board file, use it
>> to
>> -                * control which overlays, managers, and devices we own.
>> -                */
>> -               for (i = 0; i < kms_pdata->mgr_cnt; i++) {
>> -                       struct omap_overlay_manager *mgr =
>> -                               omap_dss_get_overlay_manager(
>> -                                               kms_pdata->mgr_ids[i]);
>> -                       create_encoder(dev, mgr);
>> -               }
>> -
>> -               for (i = 0; i < kms_pdata->dev_cnt; i++) {
>> -                       struct omap_dss_device *dssdev =
>> -                               omap_dss_find_device(
>> -                                       (void *)kms_pdata->dev_names[i],
>> -                                       match_dev_name);
>> -                       if (!dssdev) {
>> -                               dev_warn(dev->dev, "no such dssdev: %s\n",
>> -                                               kms_pdata->dev_names[i]);
>> -                               continue;
>> -                       }
>> -                       create_connector(dev, dssdev);
>> +               if (!encoder) {
>> +                       dev_err(dev->dev, "could not create encoder:
>> %s\n",
>> +                                       dssdev->name);
>> +                       return -ENOMEM;
>>                 }
>>
>> -               connected_connectors = detect_connectors(dev);
>> +               connector = omap_connector_init(dev,
>> +                               get_connector_type(dssdev), dssdev,
>> encoder);
>>
>> -               j = 0;
>> -               for (i = 0; i < kms_pdata->ovl_cnt; i++) {
>> -                       struct omap_overlay *ovl =
>> -
>> omap_dss_get_overlay(kms_pdata->ovl_ids[i]);
>> -                       create_crtc(dev, ovl, &j, connected_connectors);
>> +               if (!connector) {
>> +                       dev_err(dev->dev, "could not create connector:
>> %s\n",
>> +                                       dssdev->name);
>> +                       return -ENOMEM;
>>                 }
>>
>> -               for (i = 0; i < kms_pdata->pln_cnt; i++) {
>> -                       struct omap_overlay *ovl =
>> -
>> omap_dss_get_overlay(kms_pdata->pln_ids[i]);
>> -                       create_plane(dev, ovl, (1 << priv->num_crtcs) -
>> 1);
>> -               }
>> -       } else {
>> -               /* otherwise just grab up to CONFIG_DRM_OMAP_NUM_CRTCS and
>> try
>> -                * to make educated guesses about everything else
>> -                */
>> -               int max_overlays = min(omap_dss_get_num_overlays(),
>> num_crtc);
>> +               BUG_ON(priv->num_encoders >= ARRAY_SIZE(priv->encoders));
>> +               BUG_ON(priv->num_connectors >=
>> ARRAY_SIZE(priv->connectors));
>>
>> -               for (i = 0; i < omap_dss_get_num_overlay_managers(); i++)
>> -                       create_encoder(dev,
>> omap_dss_get_overlay_manager(i));
>> -
>> -               for_each_dss_dev(dssdev) {
>> -                       create_connector(dev, dssdev);
>> -               }
>> +               priv->encoders[priv->num_encoders++] = encoder;
>> +               priv->connectors[priv->num_connectors++] = connector;
>>
>> -               connected_connectors = detect_connectors(dev);
>> +               drm_mode_connector_attach_encoder(connector, encoder);
>>
>> -               j = 0;
>> -               for (i = 0; i < max_overlays; i++) {
>> -                       create_crtc(dev, omap_dss_get_overlay(i),
>> -                                       &j, connected_connectors);
>> -               }
>> -
>> -               /* use any remaining overlays as drm planes */
>> -               for (; i < omap_dss_get_num_overlays(); i++) {
>> -                       struct omap_overlay *ovl =
>> omap_dss_get_overlay(i);
>> -                       create_plane(dev, ovl, (1 << priv->num_crtcs) -
>> 1);
>> +               /* figure out which crtc's we can connect the encoder to:
>> */
>> +               encoder->possible_crtcs = 0;
>> +               for (id = 0; id < priv->num_crtcs; id++) {
>> +                       enum omap_display_type supported_displays =
>> +
>> dss_feat_get_supported_displays(pipe2chan(id));
>
>
> We could use the newer version here: dss_feat_get_supported_outputs(), this
> will tell what all outputs a manager can connect to.

ok, I guess I started on this before that fxn existed

BR,
-R
