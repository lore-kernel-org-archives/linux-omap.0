Return-Path: <SRS0=2M7l=CF=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305FBC433E3
	for <linux-omap@archiver.kernel.org>; Thu, 27 Aug 2020 20:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F137C20848
	for <linux-omap@archiver.kernel.org>; Thu, 27 Aug 2020 20:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598558930;
	bh=yKbOOPdL7+pZyGE3E1+yfNF4h5jwEHoSCybPJ3uzi8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y2YL0r5ehURdunvg5wFikKB3GBlGZw4vQscTz+FtLGRAjI/q1U+vx7FJLJrhWjBTH
	 tjhVPo7sJ8UTvyrZZ3ZnZn32I1Y4RMhzW/gXgCE51rXbnBCFrYzjw5Ym5oK/LGIqPd
	 qTUT7yUKun0xzQNYzHPbD1kMdkhnvI+Wt+hNuwyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgH0UIt (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgH0UIs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 27 Aug 2020 16:08:48 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48205208C9;
        Thu, 27 Aug 2020 20:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598558927;
        bh=yKbOOPdL7+pZyGE3E1+yfNF4h5jwEHoSCybPJ3uzi8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6bLk4HnAq9bJHAHUxEWuDmV6GHGctBbrcdHLb+vrQWQGBE03Vl66RbLLdknLICHQ
         +UMLr5pmALhNjszvyPq5Ch+KLiEGYqrnKzycspwl7K06ZFaairZDo4Z2PnysttwnG0
         1Tt5S/Xzw9GLXfesNCRjntPxgNca4AfPReMwD7Eo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ray Jui <rjui@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Keerthy <j-keerthy@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/6] gpio: pca953x: Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 22:08:25 +0200
Message-Id: <20200827200827.26462-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827200827.26462-1-krzk@kernel.org>
References: <20200827200827.26462-1-krzk@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpio/gpio-pca953x.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index bd2e96c34f82..b5c3e56613a7 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -1000,12 +1000,9 @@ static int pca953x_probe(struct i2c_client *client,
 	chip->client = client;
 
 	reg = devm_regulator_get(&client->dev, "vcc");
-	if (IS_ERR(reg)) {
-		ret = PTR_ERR(reg);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&client->dev, "reg get err: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(reg))
+		return dev_err_probe(&client->dev, PTR_ERR(reg), "reg get err\n");
+
 	ret = regulator_enable(reg);
 	if (ret) {
 		dev_err(&client->dev, "reg en err: %d\n", ret);
-- 
2.17.1

