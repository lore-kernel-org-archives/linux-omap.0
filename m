Return-Path: <SRS0=E7g0=C6=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC7BC41604
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD3123A60
	for <linux-omap@archiver.kernel.org>; Mon, 21 Sep 2020 20:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600721668;
	bh=qkY9nerV/zBZAaqQ9Kp4zfQVQqMDDSlJ+ScIovfsCTA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jEMBOUyw+BbzJx4MC8Z0enLWzAc3gm5aO3kgCqNqyFCz2+V8lU62GTI08EnyBOGpx
	 kIxm1v3z8tO/KfZ/DjBWA1vDX2nZAwdG0B8y8Ma5DVBYD7u5MakWvyw0PIAPTdMT6G
	 VMw3YSmysZXKO6W3zgBOEQKah/FxTu5ng6lEH/Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgIUUyX (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Sep 2020 16:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgIUUyW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 21 Sep 2020 16:54:22 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C579323A58;
        Mon, 21 Sep 2020 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721662;
        bh=qkY9nerV/zBZAaqQ9Kp4zfQVQqMDDSlJ+ScIovfsCTA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=b1oRNhPsy7yuZYKs3yURLkZfFBId2wTilCqKQk/MgnVQ7PhnFl/bZ6sUI3etBgDRI
         N8RAQxSH2LlHFaTSmbSUL3wxA5WSWUiggUxvzayWNL6vUiHKcIQ7TN4vUEkioGNZqR
         StuIXVjxTjTn1HEAf1I2JRgulUDsNRVeU1m1E6Rg=
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
Subject: [PATCH 39/42] mfd: vx855: use PLATFORM_DEVID_NONE
Date:   Mon, 21 Sep 2020 22:50:13 +0200
Message-Id: <20200921205016.20461-39-krzk@kernel.org>
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
 drivers/mfd/vx855.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/vx855.c b/drivers/mfd/vx855.c
index 985f81c1739c..a53fb4c1ebdb 100644
--- a/drivers/mfd/vx855.c
+++ b/drivers/mfd/vx855.c
@@ -86,8 +86,8 @@ static int vx855_probe(struct pci_dev *pdev,
 	vx855_gpio_resources[1].start = gpio_io_offset + VX855_PMIO_R_GPO;
 	vx855_gpio_resources[1].end = vx855_gpio_resources[1].start + 3;
 
-	ret = mfd_add_devices(&pdev->dev, -1, vx855_cells, ARRAY_SIZE(vx855_cells),
-			NULL, 0, NULL);
+	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, vx855_cells,
+			      ARRAY_SIZE(vx855_cells), NULL, 0, NULL);
 
 	/* we always return -ENODEV here in order to enable other
 	 * drivers like old, not-yet-platform_device ported i2c-viapro */
-- 
2.17.1

