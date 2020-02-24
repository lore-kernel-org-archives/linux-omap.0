Return-Path: <SRS0=6eJi=4M=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5938DC11D3D
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 23:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DB624650
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 23:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgBXX2c (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:28:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60560 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgBXX2c (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 24 Feb 2020 18:28:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F00172935F8
Received: by earth.universe (Postfix, from userid 1000)
        id 156793C0C98; Tue, 25 Feb 2020 00:21:31 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Rob Herring <robh@kernel.org>, linux-omap@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 21/56] drm/omap: dsi: drop unused enable_te()
Date:   Tue, 25 Feb 2020 00:20:51 +0100
Message-Id: <20200224232126.3385250-22-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224232126.3385250-1-sebastian.reichel@collabora.com>
References: <20200224232126.3385250-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

enable_te() is not used, so the custom API can be dropped.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../gpu/drm/omapdrm/displays/panel-dsi-cm.c   | 39 -------------------
 drivers/gpu/drm/omapdrm/dss/omapdss.h         |  2 -
 2 files changed, 41 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index e4b24c67c45d..64f493c722c0 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -882,43 +882,6 @@ static int _dsicm_enable_te(struct panel_drv_data *ddata, bool enable)
 	return r;
 }
 
-static int dsicm_enable_te(struct omap_dss_device *dssdev, bool enable)
-{
-	struct panel_drv_data *ddata = to_panel_data(dssdev);
-	struct omap_dss_device *src = ddata->src;
-	int r;
-
-	mutex_lock(&ddata->lock);
-
-	if (ddata->te_enabled == enable)
-		goto end;
-
-	src->ops->dsi.bus_lock(src);
-
-	if (ddata->enabled) {
-		r = dsicm_wake_up(ddata);
-		if (r)
-			goto err;
-
-		r = _dsicm_enable_te(ddata, enable);
-		if (r)
-			goto err;
-	}
-
-	ddata->te_enabled = enable;
-
-	src->ops->dsi.bus_unlock(src);
-end:
-	mutex_unlock(&ddata->lock);
-
-	return 0;
-err:
-	src->ops->dsi.bus_unlock(src);
-	mutex_unlock(&ddata->lock);
-
-	return r;
-}
-
 static void dsicm_ulps_work(struct work_struct *work)
 {
 	struct panel_drv_data *ddata = container_of(work, struct panel_drv_data,
@@ -988,8 +951,6 @@ static const struct omap_dss_device_ops dsicm_ops = {
 static const struct omap_dss_driver dsicm_dss_driver = {
 	.update		= dsicm_update,
 	.sync		= dsicm_sync,
-
-	.enable_te	= dsicm_enable_te,
 };
 
 static int dsicm_probe_of(struct mipi_dsi_device *dsi)
diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index a1e78ba665d8..e6832bf22ed0 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -385,8 +385,6 @@ struct omap_dss_driver {
 	int (*update)(struct omap_dss_device *dssdev,
 			       u16 x, u16 y, u16 w, u16 h);
 	int (*sync)(struct omap_dss_device *dssdev);
-
-	int (*enable_te)(struct omap_dss_device *dssdev, bool enable);
 };
 
 struct dss_device *omapdss_get_dss(void);
-- 
2.25.0

