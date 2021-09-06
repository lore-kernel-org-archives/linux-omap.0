Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC2C433FE
	for <linux-omap@archiver.kernel.org>; Mon,  6 Sep 2021 01:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3736120E
	for <linux-omap@archiver.kernel.org>; Mon,  6 Sep 2021 01:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbhIFBZk (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sun, 5 Sep 2021 21:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239946AbhIFBYI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sun, 5 Sep 2021 21:24:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C44A60EBA;
        Mon,  6 Sep 2021 01:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891317;
        bh=Ot+28yzud98tBNnOiqNPW6YBHnIqP50O9qr9lr6+dQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DnNAYlsnFBUMOhW9uRHx8KcsQ8v65g63FJ+TuObbGs7JnYxQt8d/wGSRuGxmOC+J0
         8zR3Rli4fC5g0Y3RagABiWNDM3v+acdJrLMlgvTUkxYXHWdWf5H3rVi5hIKXByj9pC
         fINlXQpFmgfXVx94VqXTgk0Ah/XQDi5/rbKWJFs0w0wWFgSbn17xDDyCGUPZHVf7Yx
         isiL3nr+HibmlOxcm6nuNaePW6dDyOnUnfp+9rSUpvdZoWXEIvc0pVEYgrrFV9a2S2
         sDVaDbUwZygEIffD8E/qo8pXMfc+toSK9iMtHp6I5rXTTfT0iwEY32bUcn+XVvR6CT
         75AP4ESyf3VNQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/39] regulator: tps65910: Silence deferred probe error
Date:   Sun,  5 Sep 2021 21:21:17 -0400
Message-Id: <20210906012153.929962-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012153.929962-1-sashal@kernel.org>
References: <20210906012153.929962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

[ Upstream commit e301df76472cc929fa62d923bc3892931f7ad71d ]

The TPS65910 regulator now gets a deferred probe until supply regulator is
registered. Silence noisy error message about the deferred probe.

Reported-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Link: https://lore.kernel.org/r/20210705201211.16082-1-digetx@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/tps65910-regulator.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/tps65910-regulator.c b/drivers/regulator/tps65910-regulator.c
index 1d5b0a1b86f7..06cbe60c990f 100644
--- a/drivers/regulator/tps65910-regulator.c
+++ b/drivers/regulator/tps65910-regulator.c
@@ -1211,12 +1211,10 @@ static int tps65910_probe(struct platform_device *pdev)
 
 		rdev = devm_regulator_register(&pdev->dev, &pmic->desc[i],
 					       &config);
-		if (IS_ERR(rdev)) {
-			dev_err(tps65910->dev,
-				"failed to register %s regulator\n",
-				pdev->name);
-			return PTR_ERR(rdev);
-		}
+		if (IS_ERR(rdev))
+			return dev_err_probe(tps65910->dev, PTR_ERR(rdev),
+					     "failed to register %s regulator\n",
+					     pdev->name);
 
 		/* Save regulator for cleanup */
 		pmic->rdev[i] = rdev;
-- 
2.30.2

