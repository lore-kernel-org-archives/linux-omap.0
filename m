Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822C5C4363C
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7042388E
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600721488;
	bh=kD5LZxwFlQqIhCczTyyacsX6VJTHL5cFskHXz6Jn6dk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FFsZq6r2A9Z5EgNAAb7XJ/3q+EUDxH80YP2cPg17886XfMDsPwEU2MuLhGyR8GEWU
	 //zRbVZCeYDCLLlDjkbMVuI9M2wLBHRCKh5FGLKF3dVmLdikhNOHr2F00DoZa6+209
	 HDwEr4P6qLH0C+tcRVodWF9VugnlE5GiiWxPNXc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgIUUv1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbgIUUv1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 16:51:27 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8608423730;
        Mon, 21 Sep 2020 20:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721487;
        bh=kD5LZxwFlQqIhCczTyyacsX6VJTHL5cFskHXz6Jn6dk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ogkXN71571TXekH4V9mqig56UZhnSkHj4EDSBr7Yk9opwYRGWzf5tCaHC9qNSevo5
         aq3bZanC1aZxLZMDWURlym1P2WV7J9FafGmfsIK5IcWBDigL7nqTIy42n27jabGmrU
         hUlgp6yulHWmZV/zTCehw0+tJQ7k6psqb187dhH8=
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
Subject: [PATCH 10/42] mfd: intel_msic: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:49:44 +0200
Message-Id: <20200921205016.20461-10-krzk@kernel.org>
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
 drivers/mfd/intel_msic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_msic.c b/drivers/mfd/intel_msic.c
index bb24c2a07900..e9944a81dc44 100644
--- a/drivers/mfd/intel_msic.c
+++ b/drivers/mfd/intel_msic.c
@@ -317,8 +317,9 @@ static int intel_msic_init_devices(struct intel_msic *msic)
 		if (!pdata->irq[i])
 			continue;
 
-		ret = mfd_add_devices(&pdev->dev, -1, &msic_devs[i], 1, NULL,
-				      pdata->irq[i], NULL);
+		ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+				      &msic_devs[i], 1, NULL, pdata->irq[i],
+				      NULL);
 		if (ret)
 			goto fail;
 	}
-- 
2.17.1

