Return-Path: <SRS0=Cm4E=EL=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42A9C63699
	for <linux-omap@archiver.kernel.org>; Thu,  5 Nov 2020 12:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490EF20BED
	for <linux-omap@archiver.kernel.org>; Thu,  5 Nov 2020 12:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qNQq6e3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgKEMFB (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:05:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46412 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbgKEMFA (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 5 Nov 2020 07:05:00 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A5C4q2n070198;
        Thu, 5 Nov 2020 06:04:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604577892;
        bh=bUCQSIAfkR31XW3D81fZ9TD956r790n3MBxFmYcYq64=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qNQq6e3kZRIydqx7OPK6Df4aa4ujxFS/jof2SDTeegJpiP+wyZxusIDvy6Cqva3Bu
         Lcc9q4FHr1qcNqLoQeSxYRZePZwT6Gg08p4ijzw+DHlyO4IhFdlf3zMZVbs/35fKbd
         D/hLAbJstwIU3i6gZk401W85RzA6XRbwFPqSxRVA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A5C4q7g072357
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Nov 2020 06:04:52 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 06:04:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 5 Nov 2020 06:04:52 -0600
Received: from deskari.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A5C3rfL039111;
        Thu, 5 Nov 2020 06:04:50 -0600
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        <linux-omap@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v3 23/56] drm/omap: panel-dsi-cm: use bulk regulator API
Date:   Thu, 5 Nov 2020 14:03:00 +0200
Message-ID: <20201105120333.947408-24-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105120333.947408-1-tomi.valkeinen@ti.com>
References: <20201105120333.947408-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Sebastian Reichel <sebastian.reichel@collabora.com>

Use bulk regulator API to simplify the code. This also switches
from _optional variant to normal variant, which will provide a
dummy regulator (i.e. if some always-enabled regulator is not
described in DT).

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../gpu/drm/omapdrm/displays/panel-dsi-cm.c   | 65 ++++++-------------
 1 file changed, 21 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 2e9de33fc8d4..1e742cf798b6 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -32,6 +32,8 @@
 #define DCS_GET_ID2		0xdb
 #define DCS_GET_ID3		0xdc
 
+#define DCS_REGULATOR_SUPPLY_NUM 2
+
 struct panel_drv_data {
 	struct mipi_dsi_device *dsi;
 
@@ -54,8 +56,7 @@ struct panel_drv_data {
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *ext_te_gpio;
 
-	struct regulator *vpnl;
-	struct regulator *vddi;
+	struct regulator_bulk_data supplies[DCS_REGULATOR_SUPPLY_NUM];
 
 	bool use_dsi_backlight;
 
@@ -557,28 +558,16 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 		.lp_clk_max = 10000000,
 	};
 
-	if (ddata->vpnl) {
-		r = regulator_enable(ddata->vpnl);
-		if (r) {
-			dev_err(&ddata->dsi->dev,
-				"failed to enable VPNL: %d\n", r);
-			return r;
-		}
-	}
-
-	if (ddata->vddi) {
-		r = regulator_enable(ddata->vddi);
-		if (r) {
-			dev_err(&ddata->dsi->dev,
-				"failed to enable VDDI: %d\n", r);
-			goto err_vpnl;
-		}
+	r = regulator_bulk_enable(DCS_REGULATOR_SUPPLY_NUM, ddata->supplies);
+	if (r) {
+		dev_err(&ddata->dsi->dev, "failed to enable supplies: %d\n", r);
+		return r;
 	}
 
 	r = src->ops->dsi.set_config(src, &dsi_config);
 	if (r) {
 		dev_err(&ddata->dsi->dev, "failed to configure DSI\n");
-		goto err_vddi;
+		goto err_regulators;
 	}
 
 	src->ops->enable(src);
@@ -637,12 +626,10 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 	dsicm_hw_reset(ddata);
 
 	src->ops->dsi.disable(src, true, false);
-err_vddi:
-	if (ddata->vddi)
-		regulator_disable(ddata->vddi);
-err_vpnl:
-	if (ddata->vpnl)
-		regulator_disable(ddata->vpnl);
+err_regulators:
+	r = regulator_bulk_disable(DCS_REGULATOR_SUPPLY_NUM, ddata->supplies);
+	if (r)
+		dev_err(&ddata->dsi->dev, "failed to disable supplies: %d\n", r);
 
 	return r;
 }
@@ -666,10 +653,9 @@ static void dsicm_power_off(struct panel_drv_data *ddata)
 
 	src->ops->dsi.disable(src, true, false);
 
-	if (ddata->vddi)
-		regulator_disable(ddata->vddi);
-	if (ddata->vpnl)
-		regulator_disable(ddata->vpnl);
+	r = regulator_bulk_disable(DCS_REGULATOR_SUPPLY_NUM, ddata->supplies);
+	if (r)
+		dev_err(&ddata->dsi->dev, "failed to disable supplies: %d\n", r);
 
 	ddata->enabled = false;
 }
@@ -973,21 +959,12 @@ static int dsicm_probe_of(struct mipi_dsi_device *dsi)
 	ddata->height_mm = 0;
 	of_property_read_u32(node, "height-mm", &ddata->height_mm);
 
-	ddata->vpnl = devm_regulator_get_optional(&dsi->dev, "vpnl");
-	if (IS_ERR(ddata->vpnl)) {
-		err = PTR_ERR(ddata->vpnl);
-		if (err == -EPROBE_DEFER)
-			return err;
-		ddata->vpnl = NULL;
-	}
-
-	ddata->vddi = devm_regulator_get_optional(&dsi->dev, "vddi");
-	if (IS_ERR(ddata->vddi)) {
-		err = PTR_ERR(ddata->vddi);
-		if (err == -EPROBE_DEFER)
-			return err;
-		ddata->vddi = NULL;
-	}
+	ddata->supplies[0].supply = "vpnl";
+	ddata->supplies[1].supply = "vddi";
+	err = devm_regulator_bulk_get(&dsi->dev, DCS_REGULATOR_SUPPLY_NUM,
+				      ddata->supplies);
+	if (err)
+		return err;
 
 	backlight = devm_of_find_backlight(&dsi->dev);
 	if (IS_ERR(backlight))
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

