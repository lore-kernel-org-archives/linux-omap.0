Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53164C41604
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76AF23787
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600721463;
	bh=vvKw17eRDLLQlVh42aKmJSQlryi7VaH9GJJw2nvfTZM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bPG0D187lDLgIPJ0SmX0qPGQ/83CpGgVQfLfwoYa+QIlfmYZhs9EigtEyAhSRtmtK
	 5fw8dzqcRoMLPwmeU5JCAdBkYo3ToWOXraPhv1PiU+k5Iwj9CoZqt71pJHiEEeFyqx
	 MlBDfijFYU+f351YI9xv5duqpPu9LU0eCtc18VG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgIUUvC (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbgIUUvC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 16:51:02 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7ACE235FA;
        Mon, 21 Sep 2020 20:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721462;
        bh=vvKw17eRDLLQlVh42aKmJSQlryi7VaH9GJJw2nvfTZM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gK0usBgH71IEZhnR6pmLOgSi6oqzWALtql35PfdxLnLmlVlHUdaby+OvgkCS3XvQa
         ygqzDQ4fMfo4lUD0DOZo5RKADnsamWi6w5eH11MCBWlX7w374L7aI7x4rX2oXRPFyC
         szcx7QoAd4VqxW2xzm2f30vQsYcH7UTA6WSNfcYs=
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
Subject: [PATCH 06/42] mfd: bcm2835: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:49:40 +0200
Message-Id: <20200921205016.20461-6-krzk@kernel.org>
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
 drivers/mfd/bcm2835-pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/bcm2835-pm.c b/drivers/mfd/bcm2835-pm.c
index 42fe67f1538e..a76014512bde 100644
--- a/drivers/mfd/bcm2835-pm.c
+++ b/drivers/mfd/bcm2835-pm.c
@@ -44,7 +44,7 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 	if (IS_ERR(pm->base))
 		return PTR_ERR(pm->base);
 
-	ret = devm_mfd_add_devices(dev, -1,
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 				   bcm2835_pm_devs, ARRAY_SIZE(bcm2835_pm_devs),
 				   NULL, 0, NULL);
 	if (ret)
@@ -60,7 +60,7 @@ static int bcm2835_pm_probe(struct platform_device *pdev)
 		if (IS_ERR(pm->asb))
 			return PTR_ERR(pm->asb);
 
-		ret = devm_mfd_add_devices(dev, -1,
+		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 					   bcm2835_power_devs,
 					   ARRAY_SIZE(bcm2835_power_devs),
 					   NULL, 0, NULL);
-- 
2.17.1

