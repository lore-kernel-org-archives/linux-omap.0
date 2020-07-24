Return-Path: <SRS0=v6vd=BD=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6864BC433E5
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 07:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B75320748
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595576479;
	bh=KiDwqvrscO65tnWPq/R2OB/B66P+AwuiFwhSifChdeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lg0+gjPJAZq/MWPFTfD48+G0K5NrEtAINeoFDLP1R8VZGO2YrA6ksFDhvcfwG5R6y
	 rH+CQqkfT+KqsL6tpYZ12RPU+WwR80fgetVTYUjh3WCcINY0meazofc00jtlb7zd+j
	 1N69iUK6o7vRg9Cs8cfLi1ZJpEtuyatIZriqCtTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGXHlQ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgGXHlP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 24 Jul 2020 03:41:15 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE9B2076A;
        Fri, 24 Jul 2020 07:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595576474;
        bh=KiDwqvrscO65tnWPq/R2OB/B66P+AwuiFwhSifChdeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/rBikX2msY/5l648B45mYjYFJEWzKwO4gggRv1+ATKEAM8Gt4IQ+pRCzXOquN3Qq
         JrJ1gzK66YYv/Sj/kiGpiO4YPWLK6lgzvnGE/S6bpDYZ0G4/PqbW1stqrhvIMxO8qx
         CvoTXNWwmtzbE80yzXs6XfUW4aSl4z3rWSt5Vg/c=
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
Subject: [RFT v2 01/29] memory: omap-gpmc: Remove unneeded asm/mach-types.h inclusion
Date:   Fri, 24 Jul 2020 09:40:10 +0200
Message-Id: <20200724074038.5597-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724074038.5597-1-krzk@kernel.org>
References: <20200724074038.5597-1-krzk@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The driver does not use macros from asm/mach-types.h (neither MACH_TYPE
nor machine_is_xxx()).  Removal of this include allows compile testing
on non-ARM architectures which lack this header.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/omap-gpmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index eff26c1b1394..fc08b5292932 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -32,8 +32,6 @@
 
 #include <linux/platform_data/mtd-nand-omap2.h>
 
-#include <asm/mach-types.h>
-
 #define	DEVICE_NAME		"omap-gpmc"
 
 /* GPMC register offsets */
-- 
2.17.1

