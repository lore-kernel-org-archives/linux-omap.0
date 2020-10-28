Return-Path: <SRS0=S7ps=ED=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C3AC55179
	for <linux-omap@archiver.kernel.org>; Wed, 28 Oct 2020 22:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE0720724
	for <linux-omap@archiver.kernel.org>; Wed, 28 Oct 2020 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603924245;
	bh=4t8zrcPE4o8Nqeis7vmtHzncTzgCdna72xDyDxw631Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C1kg3rtY0mzVU1cYyQ+HRvzAfzZ1lVr0BMyDGzTvAgyRx7YyrY4T/3kQcmUrrRmhV
	 pCtSZPAj+/FzALzNWP5QRzCs/bo7YceYIYh1DCm5x1eF5+y8+s7AxwkoFo1ba68q4B
	 ERAlnDS81VbqX3G28jenlJpkWZRVEFtzLbUEbRC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbgJ1Wak (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387750AbgJ1Waj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 28 Oct 2020 18:30:39 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4302320719;
        Wed, 28 Oct 2020 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603924239;
        bh=4t8zrcPE4o8Nqeis7vmtHzncTzgCdna72xDyDxw631Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+FvBYc4U/y9NdU0NTeySTkwuIqsuiLP9hupjAB7cQ9E2wkS55FRVoDbOWXOnyfac
         WbozmzVobO0JS99BQ4Bsg6R5ty+BbJ9FEjawgVKbOnZPY0X6joSGuXCXaTiCsz7XAL
         aPZPhaGrHsOpu2OFFEzIP5sc2wd2Xbnp8C0LQzv4=
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
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [RESEND PATCH 05/42] mfd: axp20x: use PLATFORM_DEVID_NONE
Date:   Wed, 28 Oct 2020 23:29:32 +0100
Message-Id: <20201028223009.369824-5-krzk@kernel.org>
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index aa59496e4376..70aa538a4b64 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -967,7 +967,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		return ret;
 	}
 
-	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
+	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_NONE, axp20x->cells,
 			      axp20x->nr_cells, NULL, 0, NULL);
 
 	if (ret) {
-- 
2.25.1

