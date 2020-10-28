Return-Path: <SRS0=S7ps=ED=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161D4C56201
	for <linux-omap@archiver.kernel.org>; Wed, 28 Oct 2020 22:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9232072E
	for <linux-omap@archiver.kernel.org>; Wed, 28 Oct 2020 22:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603924327;
	bh=cAhBoKIoMZagz11woOBG7hID+3n5gMfP7bvBT6bjHOU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D88X3t2lEhKphVpEuDNvs1PqNeB4GqOv5s4SC4A8l+0FdYrBefHlvTvWOyaaue/5b
	 YCA0IF5zuNZOYiIXgKBaRK4DY1TlFxDH8pRxHOUtrhWdeZABj4j9S/12Au1H9AOtb0
	 d1Z+SeqdeMOzxul/UJ3mys0tMqV2o7Ve19Vvr/ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbgJ1WcG (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387996AbgJ1WcE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 28 Oct 2020 18:32:04 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC4CE2072C;
        Wed, 28 Oct 2020 22:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603924323;
        bh=cAhBoKIoMZagz11woOBG7hID+3n5gMfP7bvBT6bjHOU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qUtWH3KhwpRqhh0cUxMilD4iHwAJfMKDZXislTOoVIc/HhTB58s2RrGJxNAgxK6H+
         8AH0HtvMWAIhlaXpyNsR+HQQx5A/WtfYr/bj7E3qtC386TKT+IN1v18Ndy3dYraEN0
         +cH1UepYTNk3lPE2WDzwI6UliuJ+smXFfo4TOOwA=
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
        Andy Shevchenko <andy@kernel.org>, Milo Kim <milo.kim@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [RESEND PATCH 21/42] mfd: max8998: use PLATFORM_DEVID_NONE
Date:   Wed, 28 Oct 2020 23:29:48 +0100
Message-Id: <20201028223009.369824-21-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028223009.369824-1-krzk@kernel.org>
References: <20201028223009.369824-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Use PLATFORM_DEVID_NONE define instead of "-1" value because:
 - it brings some meaning,
 - it might point attention why auto device ID was not used.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/max8998.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 785f8e9841b7..33d92eddfd06 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -208,12 +208,12 @@ static int max8998_i2c_probe(struct i2c_client *i2c,
 
 	switch (max8998->type) {
 	case TYPE_LP3974:
-		ret = mfd_add_devices(max8998->dev, -1,
+		ret = mfd_add_devices(max8998->dev, PLATFORM_DEVID_NONE,
 				      lp3974_devs, ARRAY_SIZE(lp3974_devs),
 				      NULL, 0, NULL);
 		break;
 	case TYPE_MAX8998:
-		ret = mfd_add_devices(max8998->dev, -1,
+		ret = mfd_add_devices(max8998->dev, PLATFORM_DEVID_NONE,
 				      max8998_devs, ARRAY_SIZE(max8998_devs),
 				      NULL, 0, NULL);
 		break;
-- 
2.25.1

