Return-Path: <SRS0=v6vd=BD=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBBAC433E5
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 07:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EEA2074F
	for <linux-omap@archiver.kernel.org>; Fri, 24 Jul 2020 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595576528;
	bh=dKJqleudTNRGvHBta+EdJZhNoV8vaQFq0Rb0f5WhRCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2selJreSgSHz5O2GQ6V/8r7cU3zms6s71AQKrW0mndzYPlAdoVitMDggIS0fFB48A
	 BHDXgbvJQzNeq+Jn8uT9eFA6fIZymUNdv7mRGXYNe3g5+79AZAKSoa22FpZNClDQ3P
	 OksathLRzJqoYwKl2svJrmtN4T6KoBbzbboZ/124=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgGXHmF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgGXHmE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 24 Jul 2020 03:42:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A745520771;
        Fri, 24 Jul 2020 07:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595576524;
        bh=dKJqleudTNRGvHBta+EdJZhNoV8vaQFq0Rb0f5WhRCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGiWibofBIlsSRw6kOPvQOC8WunLRM8UDONcJyHWGZWLTXXP5EcG3SuhHN/G1+3Uo
         +DJ4LUrwd4wtq79pTqxoLGIAtkKhZVTf9B/oExctf/yEY0YUNE+P6Np90CpmA+ZLTM
         r7FzkKhvBbzZNlXQjUUAXKfu5BoeoXSIwKVky+L8=
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
Subject: [PATCH v2 11/29] memory: emif-asm-offsets: Add GPLv2 SPDX license header
Date:   Fri, 24 Jul 2020 09:40:20 +0200
Message-Id: <20200724074038.5597-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724074038.5597-1-krzk@kernel.org>
References: <20200724074038.5597-1-krzk@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Add GPLv2 license header and remove GPL boiler plate text.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Use "GPL-2.0" instead of "GPL-2.0-only". It's shorter.
---
 drivers/memory/emif-asm-offsets.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/memory/emif-asm-offsets.c b/drivers/memory/emif-asm-offsets.c
index db8043019ec6..4b98d1854cd7 100644
--- a/drivers/memory/emif-asm-offsets.c
+++ b/drivers/memory/emif-asm-offsets.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TI AM33XX EMIF PM Assembly Offsets
  *
  * Copyright (C) 2016-2017 Texas Instruments Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 #include <linux/ti-emif-sram.h>
 
-- 
2.17.1

