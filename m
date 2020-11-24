Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA87C63798
	for <linux-omap@archiver.kernel.org>; Tue, 24 Nov 2020 12:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB04E2076E
	for <linux-omap@archiver.kernel.org>; Tue, 24 Nov 2020 12:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p72RHG+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbgKXMsj (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 24 Nov 2020 07:48:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40168 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732709AbgKXMsi (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2020 07:48:38 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AOCmWbQ033241;
        Tue, 24 Nov 2020 06:48:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606222112;
        bh=nFkMBLH7r0qSn+Yb53I/zIFyjV32jr0OF8NCO56iunc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=p72RHG+3RwDOMiOfx8uOoLlqzV1k79vQO2gOE1R3O/gVv7h+e19qZPdgHFCF4Cn2t
         slvyub5k35vhLrnWuBUWF2mWLMszuZLQ23rrDDwWmhTSpTSoDXyiQOjYCDqTW253jJ
         JuTn+rnr7XZiDjWsZlvumkOGboUmrJdyJ5+v6AZQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AOCmW5Y109364
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 06:48:32 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 24
 Nov 2020 06:48:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 24 Nov 2020 06:48:32 -0600
Received: from deskari.lan (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AOCjmpt040922;
        Tue, 24 Nov 2020 06:48:30 -0600
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        <linux-omap@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        <hns@goldelico.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH v4 66/80] drm/omap: dsi: set LP/HS before update
Date:   Tue, 24 Nov 2020 14:45:24 +0200
Message-ID: <20201124124538.660710-67-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124124538.660710-1-tomi.valkeinen@ti.com>
References: <20201124124538.660710-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We currently use a single VC for sending commands and pixel data. The
LP/HS mode for pixel data is correct by accident, as we have set the VC
to HS already earlier.

However, if we use a different VC for video data, the VC is in LP mode.
Fix this by always setting the LP/HS mode before starting a frame
update.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/dss/dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index c3f13226ac26..41d6231d6e31 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -3918,6 +3918,8 @@ static int dsi_update_channel(struct omap_dss_device *dssdev, int vc)
 
 	dsi_set_ulps_auto(dsi, false);
 
+	dsi_vc_enable_hs(dssdev, vc, !(dsi->dsidev->mode_flags & MIPI_DSI_MODE_LPM));
+
 	r = _dsi_send_nop(dsi, vc, dsi->dsidev->channel);
 	if (r < 0) {
 		DSSWARN("failed to send nop between frames: %d\n", r);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

