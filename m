Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE6C4363C
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DB3238E2
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600721527;
	bh=tAFDqr7IEoU7c1wzHINzdyl2jrFWAgx6ffoopawJ5wo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2EScsuUqB3FQ0RYCILp1aDCJy+Q4TS6ciRwA1fOzsqa4ZLge5PkMj7jQY1fxnQ19
	 uQNPGKH3b8/Xxs2XSUL8OuR7iNxQzHgL+tUSv0lw7TyXmKWqpFFv3i5KJYkBXV3b9y
	 3Qdi7I/DjbCDRX/1qbNdjTLyg8XlDY3qrkv/A/4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIUUwE (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIUUwD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 16:52:03 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813342311D;
        Mon, 21 Sep 2020 20:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721523;
        bh=tAFDqr7IEoU7c1wzHINzdyl2jrFWAgx6ffoopawJ5wo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Zhmxju2mUywDe7uEiOeONti6n2KRSCjjst4m3tUKNuwYgVbBILn5econdnJmsxnSk
         h3r2D3h9pGtpFVYQi6kXwRqx7eEZDOJC6vAXpeYB1L5ODTYqDu6Qd7hd3GZ8iAmAiO
         ag2r64NSn950toG0Mm99VDdCEdwtPNqanpadRxSQ=
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
Subject: [PATCH 16/42] mfd: max77686: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:49:50 +0200
Message-Id: <20200921205016.20461-16-krzk@kernel.org>
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
 drivers/mfd/max77686.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 71faf503844b..1f26d00fdd37 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -217,8 +217,8 @@ static int max77686_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(max77686->dev, -1, cells, n_devs, NULL,
-				   0, NULL);
+	ret = devm_mfd_add_devices(max77686->dev, PLATFORM_DEVID_NONE, cells,
+				   n_devs, NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "failed to add MFD devices: %d\n", ret);
 		return ret;
-- 
2.17.1

