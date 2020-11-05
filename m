Return-Path: <SRS0=Cm4E=EL=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F91C4741F
	for <linux-omap@archiver.kernel.org>; Thu,  5 Nov 2020 12:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA2A22256
	for <linux-omap@archiver.kernel.org>; Thu,  5 Nov 2020 12:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="czJPX02K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgKEMF4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 5 Nov 2020 07:05:56 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42910 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKEMF4 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 5 Nov 2020 07:05:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A5C5mC5057212;
        Thu, 5 Nov 2020 06:05:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604577948;
        bh=9f68lCdAbkEjoTga4StooGx0BetPqKE2WxkfM0H7ibk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=czJPX02KGdHySRAMomlPjKbAXRqAngPIG7VwmCK8cJnaXavDr1OpoSi/qE4TkPsie
         uY82yt/5X3O2IJAN1UjNICaDA1n7xyd9cOoYxIupNwvyAo056eE6uCYPbRT2k8f/Qz
         pAhO5hkQDuqiS61i3UwJhbri4OTK8EsRqvTqmVsk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A5C5mdO073973
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Nov 2020 06:05:48 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 5 Nov
 2020 06:05:48 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 5 Nov 2020 06:05:48 -0600
Received: from deskari.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A5C3rfi039111;
        Thu, 5 Nov 2020 06:05:46 -0600
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        <linux-omap@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v3 46/56] drm/omap: drop empty omap_encoder helper functions
Date:   Thu, 5 Nov 2020 14:03:23 +0200
Message-ID: <20201105120333.947408-47-tomi.valkeinen@ti.com>
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

Cleanup empty functions for encoder enable, disable and atomic check.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_encoder.c | 28 --------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 5f5fa01240a7..e24411fb9dac 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -113,36 +113,8 @@ static void omap_encoder_mode_set(struct drm_encoder *encoder,
 	dss_mgr_set_timings(output, &vm);
 }
 
-static void omap_encoder_disable(struct drm_encoder *encoder)
-{
-	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
-	struct omap_dss_device *dssdev = omap_encoder->output;
-	struct drm_device *dev = encoder->dev;
-
-	dev_dbg(dev->dev, "disable(%s)\n", dssdev->name);
-}
-
-static void omap_encoder_enable(struct drm_encoder *encoder)
-{
-	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
-	struct omap_dss_device *dssdev = omap_encoder->output;
-	struct drm_device *dev = encoder->dev;
-
-	dev_dbg(dev->dev, "enable(%s)\n", dssdev->name);
-}
-
-static int omap_encoder_atomic_check(struct drm_encoder *encoder,
-				     struct drm_crtc_state *crtc_state,
-				     struct drm_connector_state *conn_state)
-{
-	return 0;
-}
-
 static const struct drm_encoder_helper_funcs omap_encoder_helper_funcs = {
 	.mode_set = omap_encoder_mode_set,
-	.disable = omap_encoder_disable,
-	.enable = omap_encoder_enable,
-	.atomic_check = omap_encoder_atomic_check,
 };
 
 /* initialize encoder */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

