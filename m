Return-Path: <SRS0=v6vd=BD=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB1C43457
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 07:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADBC20748
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595576509;
	bh=CxLPvsXneuHKMA+oKmRHQgODnfZL3rxyv+X2/YTG+sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MESJ2G0Od8R7VCP4brnfV2133gwHlcgLALcRqdq3z3DbcYB9sV01UqC8mejsRpELL
	 7Re2KoKNREIfm/MhL0hhO3X+8QfCccVkHLwVbFMFPWpZFpRXOjQMpXF09slD6aD5q1
	 Winb5AQ231XHR9MlOkFcHRlKDfFG7E0CSTZ38PEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGXHlq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgGXHlp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 24 Jul 2020 03:41:45 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC9320748;
        Fri, 24 Jul 2020 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595576504;
        bh=CxLPvsXneuHKMA+oKmRHQgODnfZL3rxyv+X2/YTG+sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wF+yB4h69pcE7re6UlZY50v+jBsFA62ePOTESygemAPhYRxAOIorhMB1IFrjBz554
         pRwr6Y9ZWptWVybXUjn1PGb+OoTcNd3hb9m9imRANPd+NoabRTJ88n9TXz6KsIcYuv
         dgqCiqdh6c5RHZhXnW0T9QXazj3AwXEUTiZKNZhQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 07/29] memory: of: Remove unused headers
Date:   Fri, 24 Jul 2020 09:40:16 +0200
Message-Id: <20200724074038.5597-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724074038.5597-1-krzk@kernel.org>
References: <20200724074038.5597-1-krzk@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The of_memory.c does not use platform_device nor linked list.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/of_memory.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/memory/of_memory.c b/drivers/memory/of_memory.c
index 71f26eac7350..cfcb91eeccfb 100644
--- a/drivers/memory/of_memory.c
+++ b/drivers/memory/of_memory.c
@@ -7,8 +7,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/platform_device.h>
-#include <linux/list.h>
 #include <linux/of.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
-- 
2.17.1

