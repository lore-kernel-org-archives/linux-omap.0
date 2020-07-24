Return-Path: <SRS0=v6vd=BD=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C53C433EC
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 18:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15223207FC
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 18:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595615112;
	bh=6vmXqSqcb3PPEIvuDeW52+V74jJx/+EfORuTXaAQGRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NH7zzph5/r17S7x7C/O9Z4rNEjEo/+VKoDhpvGoP0i7lneaGvHFCPzU/nmRm5XemO
	 QvxHvYQqlvJUGxmt30Hf1YaHUoPQ1gUdb8dNf2rjvLUJlCTl5i4wsPdMN85BG0NERO
	 zbxn0HInlQCbY0sDl2H99KBZ6qn4qoQoOOHShDpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGXSY6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgGXSY4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 24 Jul 2020 14:24:56 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7448A207FC;
        Fri, 24 Jul 2020 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595615096;
        bh=6vmXqSqcb3PPEIvuDeW52+V74jJx/+EfORuTXaAQGRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXkhhR7G6pSAwL8sE1LkECQ/6F8GRsV/gAnihb6EZG6tkqzuMSPCcqSzp2BtAg08A
         e8uf0NN94A+Nx0yxyK+dOGAewXfhy/90dy/VAn6o9cGAeP3luuZ9mhUc+HeQlaFS5B
         PI3prAVts3n0s5zpMcT+CrLEwKpHUDZhIDlKiOm8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Markus Mayer <mmayer@broadcom.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/16] memory: omap-gpmc: Consistently use !res for NULL checks
Date:   Fri, 24 Jul 2020 20:23:22 +0200
Message-Id: <20200724182328.3348-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724182328.3348-1-krzk@kernel.org>
References: <20200724182328.3348-1-krzk@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The driver already uses 'if (!res)' pattern in the probe function so be
consistent.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/omap-gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 76a9c700cbd5..ce0e7e2d7cff 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -2393,7 +2393,7 @@ static int gpmc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gpmc);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL)
+	if (!res)
 		return -ENOENT;
 
 	gpmc_base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.17.1

