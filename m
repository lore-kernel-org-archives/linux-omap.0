Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF53FC4363C
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E8A423A05
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600721601;
	bh=vl9hZRjzQuQZVyZkHFM7WBut7v+d+MhGZ9ZjiUhf3oc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Te9Mro/ETx852aCnO0cCZx0FaY4HR2iUM40AveUxJm+QdpOo0JzHmW6937MN6Qpc8
	 GATpAm6MLnC0+LT+FcVY6liRPY7kKj0JV68INWt/jryYLDCrh7v9tLuFlewpgZvJF+
	 PO4A/Y4Tv92DGlV2+L7lq5av4A6G63wQCFjnnxHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgIUUxR (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbgIUUxP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 16:53:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 615E3239ED;
        Mon, 21 Sep 2020 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721594;
        bh=vl9hZRjzQuQZVyZkHFM7WBut7v+d+MhGZ9ZjiUhf3oc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eQK1UziiQi05ns+e0ZVzoBfRXaWkZovKOxLW/e7bIb2VKrmko+OX4L1dfyQgcTPvK
         WUXzsmbUrvrYt/cNbGtvlvJuMDcrha1cU4ESLDn2kw1NQfWgVSx/+pDpv4kbHVdap7
         /KRWgnLpB9KT7LjwGoRw3zkRDe6rcXbhX0KWSHkU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Support Opensource <support.opensource@diasemi.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Milo Kim <milo.kim@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH 28/42] mfd: sky81452: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:50:02 +0200
Message-Id: <20200921205016.20461-28-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921205016.20461-1-krzk@kernel.org>
References: <20200921205016.20461-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Use PLATFORM_DEVID_NONE define instead of "-1" value because:
 - it brings some meaning,
 - it might point attention why auto device ID was not used.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/sky81452.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/sky81452.c b/drivers/mfd/sky81452.c
index 3ad35bf0c015..a45cad77b87c 100644
--- a/drivers/mfd/sky81452.c
+++ b/drivers/mfd/sky81452.c
@@ -51,8 +51,8 @@ static int sky81452_probe(struct i2c_client *client,
 	cells[1].platform_data = pdata->regulator_init_data;
 	cells[1].pdata_size = sizeof(*pdata->regulator_init_data);
 
-	ret = devm_mfd_add_devices(dev, -1, cells, ARRAY_SIZE(cells),
-				   NULL, 0, NULL);
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, cells,
+				   ARRAY_SIZE(cells), NULL, 0, NULL);
 	if (ret)
 		dev_err(dev, "failed to add child devices. err=%d\n", ret);
 
-- 
2.17.1

