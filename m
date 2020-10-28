Return-Path: <SRS0=S7ps=ED=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99809C55179
	for <linux-omap@archiver.kernel.org>; Wed, 28 Oct 2020 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391A72072C
	for <linux-omap@archiver.kernel.org>; Wed, 28 Oct 2020 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603924484;
	bh=hVk9ja+3hAguuqm5mEhVctqclI+AabazSjJrPiDpUHs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kErY2ISa5fnjX4bpmvJdaTddV81AZ3qg2h4eV058MZSyFkaoNXJGuTO0M47twsFPV
	 O4tKgqzbgj2I2UZ75SEEBUPYV9ZoTm6Kh498ZrvHEw1bEnh2PvmeAlTmknLhZNvnUG
	 NOvAW/GeaED07mJqNi7LsltvU5/2YHEgPiH+kRLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbgJ1WcP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388053AbgJ1WcO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 28 Oct 2020 18:32:14 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B6C120725;
        Wed, 28 Oct 2020 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603924334;
        bh=hVk9ja+3hAguuqm5mEhVctqclI+AabazSjJrPiDpUHs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ITnvIR6aAyUxDwczOwSWg6/bTZ/Vbb90rVmIeqFB4rsGReTyoZdWyq6l9KYZKChPJ
         YJyY4lKrfIKA4lMvwLoOWPIPGEjCval8zFbv0jk2xq7UpqEI8nd1K35J2MjQUVrx9y
         M+cAutUVsmMsf7tW9i8VvQ9U6kP2E6HUf//HYFE8=
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
Subject: [RESEND PATCH 23/42] mfd: rc5t583: use PLATFORM_DEVID_NONE
Date:   Wed, 28 Oct 2020 23:29:50 +0100
Message-Id: <20201028223009.369824-23-krzk@kernel.org>
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
2.25.1

