Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65621C4363C
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1221722B2D
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600721438;
	bh=9uOe8D3kT7BC8os13k6ok5OVNiP7ajeOe0+DIwsxGR4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b2Ldt6eVS1EU3/FAilwL4l70G1l5Qu5p8cu7Elp5zUBIPFHuY4rPH7FUL/qoQ3PuV
	 9fbp2+A0NIZwpRTIJIc9wUTJ8JQllw5U5uof9W7tE7sdhkcPcPWORGFr1iRbE7CMNi
	 c4LKjDuOah2WCDUP2F2v/Xy4NAvx2HpJj167/fSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgIUUuh (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgIUUuh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 16:50:37 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68BF920866;
        Mon, 21 Sep 2020 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721436;
        bh=9uOe8D3kT7BC8os13k6ok5OVNiP7ajeOe0+DIwsxGR4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bRUGhCi/7/ic+GiS48F9H8sB5n536kRHoWyyajCIGy5hI0FrKrdfsh+1WkRPXf4e/
         7CjU6GZFsRVhB38HStLqgJEkI0PvrcXY+Z5Xt+kmTJkBOhgL4yadgClPQ0A6tOODuB
         Mjqjh+1HfQrJCnBSW2YH3I7Cd9yimmZ1xAqwaFuI=
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
Subject: [PATCH 02/42] mfd: as3711: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:49:36 +0200
Message-Id: <20200921205016.20461-2-krzk@kernel.org>
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
 drivers/mfd/as3711.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
index 3adaec6c37df..5933f322ad52 100644
--- a/drivers/mfd/as3711.c
+++ b/drivers/mfd/as3711.c
@@ -184,8 +184,9 @@ static int as3711_i2c_probe(struct i2c_client *client,
 		as3711_subdevs[AS3711_BACKLIGHT].pdata_size = 0;
 	}
 
-	ret = devm_mfd_add_devices(as3711->dev, -1, as3711_subdevs,
-				   ARRAY_SIZE(as3711_subdevs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(as3711->dev, PLATFORM_DEVID_NONE,
+				   as3711_subdevs, ARRAY_SIZE(as3711_subdevs),
+				   NULL, 0, NULL);
 	if (ret < 0)
 		dev_err(&client->dev, "add mfd devices failed: %d\n", ret);
 
-- 
2.17.1

