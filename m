Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564DCC43463
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 08:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D7E20EDD
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 08:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgIUIDD (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 04:03:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13787 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbgIUICa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 04:02:30 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B9DCD56D65C1DD58DE1D;
        Mon, 21 Sep 2020 16:02:28 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 16:02:18 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     <linux-omap@vger.kernel.org>, <linux-fbdev@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] omapfb: simplify the return expression of panel_dpi_connect
Date:   Mon, 21 Sep 2020 16:24:43 +0800
Message-ID: <20200921082443.2591721-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
index 37c9f5bfaefe..ff3d1e8e1e7b 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
@@ -37,16 +37,11 @@ static int panel_dpi_connect(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
-	int r;
 
 	if (omapdss_device_is_connected(dssdev))
 		return 0;
 
-	r = in->ops.dpi->connect(in, dssdev);
-	if (r)
-		return r;
-
-	return 0;
+	return in->ops.dpi->connect(in, dssdev);
 }
 
 static void panel_dpi_disconnect(struct omap_dss_device *dssdev)
-- 
2.25.1

