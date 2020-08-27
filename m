Return-Path: <SRS0=2M7l=CF=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8AAC433E3
	for <linux-omap@archiver.kernel.org>; Thu, 27 Aug 2020 20:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB65A208C9
	for <linux-omap@archiver.kernel.org>; Thu, 27 Aug 2020 20:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598558941;
	bh=jqbCUCwaNDypOtzCNXSWzew6krtWZkO/KHBOcaEh1TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X5N8NWIavhUUQPAxuBp63Kny6MHNpcr50W0HQQltbz3waQpxZB6tL+YfiLhbb0pi+
	 TDvsldbG5xJ29hPFIyY2KrKLWbq2J82JEVuUa3+McTD0PVbyUiRVjxtFt1IQ7o7MeJ
	 SREsoDYCgR0w2hhIb5ElYvtO6P7+9uBHZ4jC/T7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgH0UI5 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgH0UI4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 27 Aug 2020 16:08:56 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4B6208FE;
        Thu, 27 Aug 2020 20:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598558935;
        bh=jqbCUCwaNDypOtzCNXSWzew6krtWZkO/KHBOcaEh1TI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXqlSAaruLYKES5GfoaCIjkIXBGmvuw8aRlvNYhegqHJbE3jQLVi2gliQbBq9Z3xE
         6uyX65ypKowMOFwSzVDeI/hstiynecXeTy62V8G5bGMqAReK88sFO4orKu5nLw2MNK
         FzV7xOQPilZpKvfXFITbH6G2tnGGsah1K5NuoSBg=
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
Subject: [PATCH 6/6] gpio: zynq: Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 22:08:27 +0200
Message-Id: <20200827200827.26462-6-krzk@kernel.org>
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
 drivers/gpio/gpio-zynq.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 53d1387592fd..0b5a17ab996f 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -929,11 +929,9 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 
 	/* Retrieve GPIO clock */
 	gpio->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(gpio->clk)) {
-		if (PTR_ERR(gpio->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "input clock not found.\n");
-		return PTR_ERR(gpio->clk);
-	}
+	if (IS_ERR(gpio->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(gpio->clk), "input clock not found.\n");
+
 	ret = clk_prepare_enable(gpio->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to enable clock.\n");
-- 
2.17.1

