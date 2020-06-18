Return-Path: <SRS0=LAuK=77=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D581BC433E0
	for <linux-omap@archiver.kernel.org>; Thu, 18 Jun 2020 02:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D1D21974
	for <linux-omap@archiver.kernel.org>; Thu, 18 Jun 2020 02:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448100;
	bh=eqqdhs6Sudw4/8RR0ac1++R01qSNRzWPhMXqDumOfwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mgAJyqTpLirkQ1SxY0ahdSnkgOjz+2dtyk8Tq9JP/VxKV1+FUHS3+qbSTwJHWJIms
	 jCu6/jGUS0T3BtgNN8NNixrBVPwWRrIj20+bBillL8Dy7qsIXSA0JNHCK2HrHjn9VK
	 bbhhgcDDgTTCCWrCLQCljB7CXFq0RwXEgg8frrFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgFRBMX (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbgFRBMW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 17 Jun 2020 21:12:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0C58214DB;
        Thu, 18 Jun 2020 01:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442741;
        bh=eqqdhs6Sudw4/8RR0ac1++R01qSNRzWPhMXqDumOfwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=blu8ZLwGUxaKfJ4984BjKEymUUjJE6LjgiFkq64dOkVQtI1oT5nc5OjTwfj1xligB
         DuJqEhx3yYHeQ4FZ28/x5sCXj6TZrzvPoCFTjS7nZnA91XuZgsQYlIImvVudCX3v1r
         BHplt+4MqiczWDy4x9TW58UE/KBfiuwolz9cALgU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Peter Ujfalusi <peter.ujflausi@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
        linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 195/388] ASoC: ti: omap-mcbsp: Fix an error handling path in 'asoc_mcbsp_probe()'
Date:   Wed, 17 Jun 2020 21:04:52 -0400
Message-Id: <20200618010805.600873-195-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 03990fd58d2b7c8f7d53e514ba9b8749fac260f9 ]

If an error occurs after the call to 'omap_mcbsp_init()', the reference to
'mcbsp->fclk' must be decremented, as already done in the remove function.

This can be achieved easily by using the devm_ variant of 'clk_get()'
when the reference is taken in 'omap_mcbsp_init()'

This fixes the leak in the probe and has the side effect to simplify both
the error handling path of 'omap_mcbsp_init()' and the remove function.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Peter Ujfalusi <peter.ujflausi@ti.com>
Link: https://lore.kernel.org/r/20200512134325.252073-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/ti/omap-mcbsp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
index 3d41ca2238d4..4f33ddb7b441 100644
--- a/sound/soc/ti/omap-mcbsp.c
+++ b/sound/soc/ti/omap-mcbsp.c
@@ -686,7 +686,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 	mcbsp->dma_data[1].addr = omap_mcbsp_dma_reg_params(mcbsp,
 						SNDRV_PCM_STREAM_CAPTURE);
 
-	mcbsp->fclk = clk_get(&pdev->dev, "fck");
+	mcbsp->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(mcbsp->fclk)) {
 		ret = PTR_ERR(mcbsp->fclk);
 		dev_err(mcbsp->dev, "unable to get fck: %d\n", ret);
@@ -711,7 +711,7 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 		if (ret) {
 			dev_err(mcbsp->dev,
 				"Unable to create additional controls\n");
-			goto err_thres;
+			return ret;
 		}
 	}
 
@@ -724,8 +724,6 @@ static int omap_mcbsp_init(struct platform_device *pdev)
 err_st:
 	if (mcbsp->pdata->buffer_size)
 		sysfs_remove_group(&mcbsp->dev->kobj, &additional_attr_group);
-err_thres:
-	clk_put(mcbsp->fclk);
 	return ret;
 }
 
@@ -1442,8 +1440,6 @@ static int asoc_mcbsp_remove(struct platform_device *pdev)
 
 	omap_mcbsp_st_cleanup(pdev);
 
-	clk_put(mcbsp->fclk);
-
 	return 0;
 }
 
-- 
2.25.1

