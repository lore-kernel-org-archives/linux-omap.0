Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0449C35257
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8823E239D4
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600721571;
	bh=hE3o37HAl8/p4qX2nqJrTMXoyiiYALc9HXrxjJsJ00g=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VkY4yOz6MG2MDmgBgmJygn2d/iN4NCfkuXS3O9sLubS4Cotu/PfIWbX79ZJ7xafxo
	 vfXWsC0loYiJ0x5S1sUKXIpPOSVDqmaXT67aTCAKeSWNfSd0GLbGnWVe7iirnkY6n6
	 oamyOKwLixmn1k04BoPC3W1f+iUVGukcYhkeq69o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgIUUwq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgIUUwq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 16:52:46 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 182792399C;
        Mon, 21 Sep 2020 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721565;
        bh=hE3o37HAl8/p4qX2nqJrTMXoyiiYALc9HXrxjJsJ00g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gsRJKxxoh+mcFlptxey0q3x8S3T4GD9G7kLspIytq2CPvD556wNwoa1jibU+syoiE
         tsRzrc/yVMRQSHiorqtvQVNjfxLZ1AM1rDMx2Vhfd0q5oV1hxMpsRVxKG706y5uII+
         SOe9FeQouh+g8sPtFBIDXEhlvg+C3zv5LQXqVwx4=
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
Subject: [PATCH 23/42] mfd: rc5t583: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:49:57 +0200
Message-Id: <20200921205016.20461-23-krzk@kernel.org>
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
 drivers/mfd/rc5t583.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
index d0dc48f99096..a4915f411ee8 100644
--- a/drivers/mfd/rc5t583.c
+++ b/drivers/mfd/rc5t583.c
@@ -270,8 +270,9 @@ static int rc5t583_i2c_probe(struct i2c_client *i2c,
 			dev_warn(&i2c->dev, "IRQ init failed: %d\n", ret);
 	}
 
-	ret = devm_mfd_add_devices(rc5t583->dev, -1, rc5t583_subdevs,
-				   ARRAY_SIZE(rc5t583_subdevs), NULL, 0, NULL);
+	ret = devm_mfd_add_devices(rc5t583->dev, PLATFORM_DEVID_NONE,
+				   rc5t583_subdevs, ARRAY_SIZE(rc5t583_subdevs),
+				   NULL, 0, NULL);
 	if (ret) {
 		dev_err(&i2c->dev, "add mfd devices failed: %d\n", ret);
 		return ret;
-- 
2.17.1

