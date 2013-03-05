From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/4] drm/omap: Fix and improve crtc and overlay manager correlation
Date: Tue, 5 Mar 2013 19:47:48 +0530
Message-ID: <1362493070-17706-3-git-send-email-archit@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52985 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754Ab3CEOSu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 09:18:50 -0500
In-Reply-To: <1362493070-17706-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com, tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

The omapdrm driver currently takes a config/module arg to figure out the number
of crtcs it needs to create. We could create as many crtcs as there are overlay
managers in the DSS hardware, but we don't do that because each crtc eats up
one DSS overlay, and that reduces the number of planes we can attach to a single
crtc.

Since the number of crtcs may be lesser than the number of hardware overlay
managers, we need to figure out which overlay managers to use for our crtcs. The
current approach is to use pipe2chan(), which returns a higher numbered manager
for the crtc.

The problem with this approach is that it assumes that the overlay managers we
choose will connect to the encoders the platform's panels are going to use,
this isn't true, an overlay manager connects only to a few outputs/encoders, and
choosing any overlay manager for our crtc might lead to a situation where the
encoder cannot connect to any of the crtcs we have chosen. For example, an
omap5-panda board has just one hdmi output. If num_crtc is set to 1, with the
current approach, pipe2chan will pick up the LCD2 overlay manager, which cannot
connect to the hdmi encoder at all. The only manager that could have connected
to hdmi was the TV overlay manager.

Therefore, there is a need to choose our overlay managers keeping in mind the
panels we have on that platform. The new approach iterates through all the
available panels, and creates encoders and connectors for them, and then tries
to figure out what overlay manager we could use for our crtc.

We split the overlay managers into 2 sets: the ones which are already tied to a
crtc, and the ones which are free at the moment. For every panel, we first make
a decision about whether we should try to share a crtc with an existing panel,
or try to create a new one. If we want to share an existing crtc, we iterate
through the list of used managers, if we find one which can connect to it's
encoder, we don't create a crtc. If we don't find a used overlay manager, we
try to find an unused one to which it's encoder can connect to and create a
new crtc.

This approach isn't the most optimal one, it can do either good or bad depending
on what sequence the panel drivers were registered. The optimal way would be
some sort of back tracking approach, where we improve the set of managers we use
as we iterate through the list of managers. I haven't tried that out yet though.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c    |   21 ++--
 drivers/gpu/drm/omapdrm/omap_drv.c     |  192 +++++++++++++++++++++++++++-----
 drivers/gpu/drm/omapdrm/omap_drv.h     |   38 +------
 drivers/gpu/drm/omapdrm/omap_encoder.c |    7 ++
 drivers/gpu/drm/omapdrm/omap_irq.c     |   17 ++-
 5 files changed, 202 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index bec66a4..79b200a 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -74,6 +74,13 @@ struct omap_crtc {
 	struct work_struct page_flip_work;
 };
 
+uint32_t pipe2vbl(struct drm_crtc *crtc)
+{
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+
+	return dispc_mgr_get_vsync_irq(omap_crtc->channel);
+}
+
 /*
  * Manager-ops, callbacks from output when they need to configure
  * the upstream part of the video pipe.
@@ -613,7 +620,13 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 	omap_crtc->apply.pre_apply  = omap_crtc_pre_apply;
 	omap_crtc->apply.post_apply = omap_crtc_post_apply;
 
-	omap_crtc->apply_irq.irqmask = pipe2vbl(id);
+	omap_crtc->channel = channel;
+	omap_crtc->plane = plane;
+	omap_crtc->plane->crtc = crtc;
+	omap_crtc->name = channel_names[channel];
+	omap_crtc->pipe = id;
+
+	omap_crtc->apply_irq.irqmask = pipe2vbl(crtc);
 	omap_crtc->apply_irq.irq = omap_crtc_apply_irq;
 
 	omap_crtc->error_irq.irqmask =
@@ -621,12 +634,6 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 	omap_crtc->error_irq.irq = omap_crtc_error_irq;
 	omap_irq_register(dev, &omap_crtc->error_irq);
 
-	omap_crtc->channel = channel;
-	omap_crtc->plane = plane;
-	omap_crtc->plane->crtc = crtc;
-	omap_crtc->name = channel_names[channel];
-	omap_crtc->pipe = id;
-
 	/* temporary: */
 	omap_crtc->mgr.id = channel;
 
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 77b7225..275c373 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -74,53 +74,57 @@ static int get_connector_type(struct omap_dss_device *dssdev)
 	}
 }
 
+static bool channel_used(struct drm_device *dev, enum omap_channel channel)
+{
+	struct omap_drm_private *priv = dev->dev_private;
+	int i;
+
+	for (i = 0; i < priv->num_crtcs; i++) {
+		struct drm_crtc *crtc = priv->crtcs[i];
+
+		if (omap_crtc_channel(crtc) == channel)
+			return true;
+	}
+
+	return false;
+}
+
 static int omap_modeset_init(struct drm_device *dev)
 {
 	struct omap_drm_private *priv = dev->dev_private;
 	struct omap_dss_device *dssdev = NULL;
 	int num_ovls = dss_feat_get_num_ovls();
-	int id;
+	int num_mgrs = dss_feat_get_num_mgrs();
+	int num_crtcs, num_panels_left = 0;
+	int i, id = 0;
 
 	drm_mode_config_init(dev);
 
 	omap_drm_irq_install(dev);
 
 	/*
-	 * Create private planes and CRTCs for the last NUM_CRTCs overlay
-	 * plus manager:
+	 * We usually don't want to create a CRTC for each manager, at least
+	 * not until we have a way to expose private planes to userspace.
+	 * Otherwise there would not be enough video pipes left for drm planes.
+	 * We use the num_crtc argument to limit the number of crtcs we create.
 	 */
-	for (id = 0; id < min(num_crtc, num_ovls); id++) {
-		struct drm_plane *plane;
-		struct drm_crtc *crtc;
+	num_crtcs = min3(num_crtc, num_mgrs, num_ovls);
 
-		plane = omap_plane_init(dev, id, true);
-		crtc = omap_crtc_init(dev, plane, pipe2chan(id), id);
-
-		BUG_ON(priv->num_crtcs >= ARRAY_SIZE(priv->crtcs));
-		priv->crtcs[id] = crtc;
-		priv->num_crtcs++;
-
-		priv->planes[id] = plane;
-		priv->num_planes++;
-	}
-
-	/*
-	 * Create normal planes for the remaining overlays:
-	 */
-	for (; id < num_ovls; id++) {
-		struct drm_plane *plane = omap_plane_init(dev, id, false);
+	/* keep a track of the total number of panels */
+	for_each_dss_dev(dssdev) { num_panels_left++; }
 
-		BUG_ON(priv->num_planes >= ARRAY_SIZE(priv->planes));
-		priv->planes[priv->num_planes++] = plane;
-	}
+	dssdev = NULL;
 
 	for_each_dss_dev(dssdev) {
 		struct drm_connector *connector;
 		struct drm_encoder *encoder;
+		bool mgr_found = false;
 
 		if (!dssdev->driver) {
 			dev_warn(dev->dev, "%s has no driver.. skipping it\n",
 					dssdev->name);
+			num_panels_left--;
+
 			continue;
 		}
 
@@ -129,6 +133,8 @@ static int omap_modeset_init(struct drm_device *dev)
 			dev_warn(dev->dev, "%s driver does not support "
 				"get_timings or read_edid.. skipping it!\n",
 				dssdev->name);
+			num_panels_left--;
+
 			continue;
 		}
 
@@ -137,6 +143,8 @@ static int omap_modeset_init(struct drm_device *dev)
 		if (!encoder) {
 			dev_err(dev->dev, "could not create encoder: %s\n",
 					dssdev->name);
+			num_panels_left--;
+
 			return -ENOMEM;
 		}
 
@@ -146,6 +154,8 @@ static int omap_modeset_init(struct drm_device *dev)
 		if (!connector) {
 			dev_err(dev->dev, "could not create connector: %s\n",
 					dssdev->name);
+			num_panels_left--;
+
 			return -ENOMEM;
 		}
 
@@ -157,16 +167,146 @@ static int omap_modeset_init(struct drm_device *dev)
 
 		drm_mode_connector_attach_encoder(connector, encoder);
 
+		/*
+		 * if we have reached the limit of the crtcs we are allowed to
+		 * create, let's not try to look for a crtc for this
+		 * panel/encoder and onwards, we will of course, populate the
+		 * the possible_crtcs field for all the encoders with the final
+		 * set of crtcs we create
+		 */
+		if (id == num_crtcs)
+			continue;
+
+		/*
+		 * if we have more panels/encoders left than the number of crtcs
+		 * we are allowed to create, we want to try to find a crtc which
+		 * is already created, and can be shared between these encoders,
+		 * both encoders won't be able to use the crtc at the same time
+		 * though
+		 */
+		if (num_panels_left > (num_crtcs - id)) {
+			for (i = 0; i < num_mgrs; i++) {
+				bool output_supported =
+					dss_feat_get_supported_outputs(i) &
+					dssdev->output->id;
+
+				if (channel_used(dev, i) && output_supported) {
+					mgr_found = true;
+					break;
+				} else {
+					continue;
+				}
+			}
+		}
+
+		if (mgr_found) {
+			num_panels_left--;
+			continue;
+		}
+
+		/*
+		 * if we have too few panels/encoders to worry about, or if we
+		 * couldn't find an already created crtc for this encoder, we'll
+		 * try to allocate a new crtc and find a free overlay manager
+		 * for it
+		 */
+		for (i = 0; i < num_mgrs; i++) {
+			bool output_supported =
+				dss_feat_get_supported_outputs(i) &
+				dssdev->output->id;
+
+			if (!channel_used(dev, i) && output_supported) {
+				struct drm_plane *plane;
+				struct drm_crtc *crtc;
+
+				plane = omap_plane_init(dev, id, true);
+				crtc = omap_crtc_init(dev, plane, i, id);
+
+				BUG_ON(priv->num_crtcs >= ARRAY_SIZE(priv->crtcs));
+				priv->crtcs[id] = crtc;
+				priv->num_crtcs++;
+
+				priv->planes[id] = plane;
+				priv->num_planes++;
+
+				id++;
+				break;
+			}
+
+			if (i == num_mgrs)
+				DBG("%s doesn't have any valid manager to "
+					"connect to\n", dssdev->name);
+		}
+
+		num_panels_left--;
+	}
+
+	/*
+	 * we have allocated crtcs according to the need of the panels/encoders,
+	 * adding more crtcs here if needed
+	 */
+	for (; id < num_crtcs; id++) {
+
+		/* find a free manager for this crtc */
+		for (i = 0; i < num_mgrs; i++) {
+			if (!channel_used(dev, i)) {
+				struct drm_plane *plane;
+				struct drm_crtc *crtc;
+
+				plane = omap_plane_init(dev, id, true);
+				crtc = omap_crtc_init(dev, plane, i, id);
+
+				BUG_ON(priv->num_crtcs >= ARRAY_SIZE(priv->crtcs));
+				priv->crtcs[id] = crtc;
+				priv->num_crtcs++;
+
+				priv->planes[id] = plane;
+				priv->num_planes++;
+
+				break;
+			} else {
+				continue;
+			}
+		}
+
+		if (i == num_mgrs) {
+			/* this shouldn't really happen */
+			dev_err(dev->dev, "no managers left for crtc\n");
+			return -ENOMEM;
+		}
+	}
+
+	/*
+	 * Create normal planes for the remaining overlays:
+	 */
+	for (; id < num_ovls; id++) {
+		struct drm_plane *plane = omap_plane_init(dev, id, false);
+
+		BUG_ON(priv->num_planes >= ARRAY_SIZE(priv->planes));
+		priv->planes[priv->num_planes++] = plane;
+	}
+
+	for (i = 0; i < priv->num_encoders; i++) {
+		struct drm_encoder *encoder = priv->encoders[i];
+		struct omap_dss_device *dssdev = omap_encoder_get_dssdev(encoder);
+
 		/* figure out which crtc's we can connect the encoder to: */
 		encoder->possible_crtcs = 0;
 		for (id = 0; id < priv->num_crtcs; id++) {
+			struct drm_crtc *crtc = priv->crtcs[id];
+			enum omap_channel crtc_channel = omap_crtc_channel(crtc);
 			enum omap_dss_output_id supported_outputs =
-					dss_feat_get_supported_outputs(pipe2chan(id));
+					dss_feat_get_supported_outputs(crtc_channel);
+
 			if (supported_outputs & dssdev->output->id)
 				encoder->possible_crtcs |= (1 << id);
 		}
 	}
 
+	DBG("registered %d planes, %d crtcs, %d encoders and %d connectors\n",
+		priv->num_planes, priv->num_crtcs, priv->num_encoders,
+		priv->num_connectors);
+
 	dev->mode_config.min_width = 32;
 	dev->mode_config.min_height = 32;
 
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index d4f997b..215a20d 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -139,8 +139,8 @@ void omap_gem_describe_objects(struct list_head *list, struct seq_file *m);
 int omap_gem_resume(struct device *dev);
 #endif
 
-int omap_irq_enable_vblank(struct drm_device *dev, int crtc);
-void omap_irq_disable_vblank(struct drm_device *dev, int crtc);
+int omap_irq_enable_vblank(struct drm_device *dev, int crtc_id);
+void omap_irq_disable_vblank(struct drm_device *dev, int crtc_id);
 irqreturn_t omap_irq_handler(DRM_IRQ_ARGS);
 void omap_irq_preinstall(struct drm_device *dev);
 int omap_irq_postinstall(struct drm_device *dev);
@@ -271,39 +271,9 @@ static inline int align_pitch(int pitch, int width, int bpp)
 	return ALIGN(pitch, 8 * bytespp);
 }
 
-static inline enum omap_channel pipe2chan(int pipe)
-{
-	int num_mgrs = dss_feat_get_num_mgrs();
-
-	/*
-	 * We usually don't want to create a CRTC for each manager,
-	 * at least not until we have a way to expose private planes
-	 * to userspace.  Otherwise there would not be enough video
-	 * pipes left for drm planes.  The higher #'d managers tend
-	 * to have more features so start in reverse order.
-	 */
-	return num_mgrs - pipe - 1;
-}
-
 /* map crtc to vblank mask */
-static inline uint32_t pipe2vbl(int crtc)
-{
-	enum omap_channel channel = pipe2chan(crtc);
-	return dispc_mgr_get_vsync_irq(channel);
-}
-
-static inline int crtc2pipe(struct drm_device *dev, struct drm_crtc *crtc)
-{
-	struct omap_drm_private *priv = dev->dev_private;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(priv->crtcs); i++)
-		if (priv->crtcs[i] == crtc)
-			return i;
-
-	BUG();  /* bogus CRTC ptr */
-	return -1;
-}
+uint32_t pipe2vbl(struct drm_crtc *crtc);
+struct omap_dss_device *omap_encoder_get_dssdev(struct drm_encoder *encoder);
 
 /* should these be made into common util helpers?
  */
diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 21d126d..d48df71 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -41,6 +41,13 @@ struct omap_encoder {
 	struct omap_dss_device *dssdev;
 };
 
+struct omap_dss_device *omap_encoder_get_dssdev(struct drm_encoder *encoder)
+{
+	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
+
+	return omap_encoder->dssdev;
+}
+
 static void omap_encoder_destroy(struct drm_encoder *encoder)
 {
 	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index e01303e..9263db1 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -130,12 +130,13 @@ int omap_irq_wait(struct drm_device *dev, struct omap_irq_wait *wait,
  * Zero on success, appropriate errno if the given @crtc's vblank
  * interrupt cannot be enabled.
  */
-int omap_irq_enable_vblank(struct drm_device *dev, int crtc)
+int omap_irq_enable_vblank(struct drm_device *dev, int crtc_id)
 {
 	struct omap_drm_private *priv = dev->dev_private;
+	struct drm_crtc *crtc = priv->crtcs[crtc_id];
 	unsigned long flags;
 
-	DBG("dev=%p, crtc=%d", dev, crtc);
+	DBG("dev=%p, crtc=%d", dev, crtc_id);
 
 	dispc_runtime_get();
 	spin_lock_irqsave(&list_lock, flags);
@@ -156,12 +157,13 @@ int omap_irq_enable_vblank(struct drm_device *dev, int crtc)
  * a hardware vblank counter, this routine should be a no-op, since
  * interrupts will have to stay on to keep the count accurate.
  */
-void omap_irq_disable_vblank(struct drm_device *dev, int crtc)
+void omap_irq_disable_vblank(struct drm_device *dev, int crtc_id)
 {
 	struct omap_drm_private *priv = dev->dev_private;
+	struct drm_crtc *crtc = priv->crtcs[crtc_id];
 	unsigned long flags;
 
-	DBG("dev=%p, crtc=%d", dev, crtc);
+	DBG("dev=%p, crtc=%d", dev, crtc_id);
 
 	dispc_runtime_get();
 	spin_lock_irqsave(&list_lock, flags);
@@ -186,9 +188,12 @@ irqreturn_t omap_irq_handler(DRM_IRQ_ARGS)
 
 	VERB("irqs: %08x", irqstatus);
 
-	for (id = 0; id < priv->num_crtcs; id++)
-		if (irqstatus & pipe2vbl(id))
+	for (id = 0; id < priv->num_crtcs; id++) {
+		struct drm_crtc *crtc = priv->crtcs[id];
+
+		if (irqstatus & pipe2vbl(crtc))
 			drm_handle_vblank(dev, id);
+	}
 
 	spin_lock_irqsave(&list_lock, flags);
 	list_for_each_entry_safe(handler, n, &priv->irq_list, node) {
-- 
1.7.10.4

