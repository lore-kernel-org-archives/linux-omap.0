Return-Path: <SRS0=mo/n=EE=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D409FC4363A
	for <linux-omap@archiver.kernel.org>; Thu, 29 Oct 2020 00:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7713920838
	for <linux-omap@archiver.kernel.org>; Thu, 29 Oct 2020 00:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603931474;
	bh=4HV55O+DO29mRKeDsXajAt3ZjQOUrw12UsNGy0abuag=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AKFGMX1eienhEzt45oVcNHoqYPeBad2odAOuJUY2p+PJPgfGqZM3ZT3FrbBCLeZSb
	 acB3cGmX2mCvywEJBvnHTp+qKh63K5uE9uQSvRYdJvRIwOnjMfDAlfWAzjj583NnSI
	 YTch4BOj8XFnemnhqlPRASe6AELcrACRsdftJMJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgJ1WdD (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388129AbgJ1Wcn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 28 Oct 2020 18:32:43 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84E4B2070E;
        Wed, 28 Oct 2020 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603924362;
        bh=4HV55O+DO29mRKeDsXajAt3ZjQOUrw12UsNGy0abuag=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bWqMQt/qfyMVI5zKac2mjgFqVmWWlWc2l0bsovNlo7T7zlJtYciG2OFUzqNA5+dKn
         tUHM4tReI2KE2LGfz6nmOl1jzmc3elFIg2XeYH51fJFuEQSxX8qcwRjEBG0s55IGhE
         vZYO1+nWljIFF72gECr1JJxn+xBCjfYHmLCv6QsE=
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
Subject: [RESEND PATCH 28/42] mfd: sky81452: use PLATFORM_DEVID_NONE
Date:   Wed, 28 Oct 2020 23:29:55 +0100
Message-Id: <20201028223009.369824-28-krzk@kernel.org>
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
2.25.1

