Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E64C35257
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177C22396F
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600721551;
	bh=QSsL+CSI3AXchxxz+lidBlleLXKIIKScSMwUhN+nqIg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FChkrgS6WfRXQ5Fi3RjtQc4q1CxzYfgnlDRsB6fchsX3I3Fq6HqmZFyVfUPIfI/fc
	 uM8yXWzjFO5VWtSPqTPG8TIqcR7UNNlJfvBA/J4cv4XzNVDWKgKwLqOjKgPAqZHF//
	 NLYxS0RacOXEI//BmWvaEIYL2LkGy1qnQfZq8C1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgIUUw1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgIUUw1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 16:52:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E68A23976;
        Mon, 21 Sep 2020 20:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721547;
        bh=QSsL+CSI3AXchxxz+lidBlleLXKIIKScSMwUhN+nqIg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CKRPN6pyK1hs+xuYm2MSFPZMr8UtZbSG6IoSCc1v3vxB+Jy51NPBorqk2XjHWn3Kw
         c1xJgVJzAZlXFNpsXGZ1cZL+5WXUf0b92maFxRxFDwHd9M13bXhBZCE09vzYWocWAz
         2i41oYfJ7b2To0uxQDXYx19wqAIG32QxiW4+YXRk=
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
Subject: [PATCH 20/42] mfd: max8997: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:49:54 +0200
Message-Id: <20200921205016.20461-20-krzk@kernel.org>
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
 drivers/mfd/max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 68d8f2b95287..0c5b8baead62 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -212,7 +212,7 @@ static int max8997_i2c_probe(struct i2c_client *i2c,
 
 	max8997_irq_init(max8997);
 
-	ret = mfd_add_devices(max8997->dev, -1, max8997_devs,
+	ret = mfd_add_devices(max8997->dev, PLATFORM_DEVID_NONE, max8997_devs,
 			ARRAY_SIZE(max8997_devs),
 			NULL, 0, NULL);
 	if (ret < 0) {
-- 
2.17.1

