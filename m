Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FD4C4363C
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FCB23A5D
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600721671;
	bh=ukULXBlsraomS8n4zvGbNnhhyrJ6HJH7ioe4zIsa820=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=idmlr4/Uh9uX3e+pzIUPWG2tBpuVWS0AYWxN4lCcc9GwEL9yxFR4+6p6Q7o1NP+52
	 IKAc8GYjB07PoTQSgf5qnIKvVdh46NB6Vm/RWV2Zwi2GceagmpzNByphgaezRf8/xJ
	 DqngN/QAl1UcxWE9rWqPxOD7SZcm+/SVQdMKTq2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgIUUya (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgIUUy2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 16:54:28 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B46B223A5A;
        Mon, 21 Sep 2020 20:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721667;
        bh=ukULXBlsraomS8n4zvGbNnhhyrJ6HJH7ioe4zIsa820=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aUk81OtZI53dO9pnRCKq89k1qzbrAhy1/of9G4MrZO1+c6NGjUbNMAwdZPN7/Byoe
         CWQ/NZ4ED6I22EFJgKx1Q/FKWf5C2setnagzNrR4LbzSujnQG8h39hvhRa0ZgDdQ5r
         2HkOrK37NqS1Yr20cu48+cLEFn5C616YH0DH4Ir0=
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
Subject: [PATCH 40/42] mfd: wl1273: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:50:14 +0200
Message-Id: <20200921205016.20461-40-krzk@kernel.org>
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
 drivers/mfd/wl1273-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/wl1273-core.c b/drivers/mfd/wl1273-core.c
index 1ab5e15a65eb..0af1322fd393 100644
--- a/drivers/mfd/wl1273-core.c
+++ b/drivers/mfd/wl1273-core.c
@@ -214,7 +214,7 @@ static int wl1273_core_probe(struct i2c_client *client,
 	dev_dbg(&client->dev, "%s: number of children: %d.\n",
 		__func__, children);
 
-	r = devm_mfd_add_devices(&client->dev, -1, core->cells,
+	r = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE, core->cells,
 				 children, NULL, 0, NULL);
 	if (r)
 		goto err;
-- 
2.17.1

