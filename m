Return-Path: <SRS0=S7ps=ED=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39531C4363A
	for <linux-omap@archiver.kernel.org>; Wed, 28 Oct 2020 22:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E1E20738
	for <linux-omap@archiver.kernel.org>; Wed, 28 Oct 2020 22:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603924615;
	bh=bqv9tuXjLzuFjl/e05MHC5F387twPoXZ645TcerkI5w=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IHSc3HD8iedFuqTnEQ+9AXWYewBwFkWPfw7xFy6uWfshShlF3pzGWcvEgFZUHT/yo
	 XH1RjKBEEgZ97sSLGrMUpUDan/gdWMBK/0iMJqCUbiO0Mr5DaUKTZXSdQkUvTUtUJR
	 XJ50rEJwZT9dueuX/sTAj/+doJmvGH8nA7cYpd5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbgJ1Wgs (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388430AbgJ1Wdh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 28 Oct 2020 18:33:37 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE182072C;
        Wed, 28 Oct 2020 22:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603924417;
        bh=bqv9tuXjLzuFjl/e05MHC5F387twPoXZ645TcerkI5w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FdMdzizSLjwnL2yS2LCeUvPpYEUyLACvTNqkib2gtOH6hP0kyDMRkZ6TThcgLjrKy
         S98caqd+AR8sPC//Gvk3Plx4FcJCF4eXaKm4dqoHh88KIgffLHBX+CpTD7ALfC/MTm
         oxeis1dRK2uC9WwF2UPnEx5VHDGzJ2ZF+1Tj3oKs=
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
Subject: [RESEND PATCH 38/42] mfd: twl6040: use PLATFORM_DEVID_NONE
Date:   Wed, 28 Oct 2020 23:30:05 +0100
Message-Id: <20201028223009.369824-38-krzk@kernel.org>
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
 drivers/mfd/twl6040.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index b9c6d94b4002..702f9e216d42 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -794,8 +794,8 @@ static int twl6040_probe(struct i2c_client *client,
 	regcache_cache_only(twl6040->regmap, true);
 	regcache_mark_dirty(twl6040->regmap);
 
-	ret = mfd_add_devices(&client->dev, -1, twl6040->cells, children,
-			      NULL, 0, NULL);
+	ret = mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE, twl6040->cells,
+			      children, NULL, 0, NULL);
 	if (ret)
 		goto readyirq_err;
 
-- 
2.25.1

