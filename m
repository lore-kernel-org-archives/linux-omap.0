Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB11C433E0
	for <linux-omap@archiver.kernel.org>; Fri,  8 Jan 2021 16:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FE5238E8
	for <linux-omap@archiver.kernel.org>; Fri,  8 Jan 2021 16:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbhAHQa5 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 8 Jan 2021 11:30:57 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53158 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbhAHQa5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2021 11:30:57 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 108GT5nh069149;
        Fri, 8 Jan 2021 10:29:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610123345;
        bh=DUWTy/OhpJ+fGsEK3mva5pm+H3nF6/YECQadrExdfzM=;
        h=From:To:CC:Subject:Date;
        b=HYargC/6sHTb3B65bRL3mwLkmMLWcauMULFCrPpaCftwNHG+WQ0teUStHV8Ni2uLo
         gTkru6BSiUac7VwVdaj5nL8Kqz4o+xx0fbP+8dnyKGgmhsLeRBuCgp3PNZWvn9b/6Y
         GKr0foduKQMykN6GME5jMNw6SCMmZXwE1yHfH8V8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 108GT57u018063
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jan 2021 10:29:05 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 Jan
 2021 10:29:04 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 Jan 2021 10:29:05 -0600
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 108GT5uU119255;
        Fri, 8 Jan 2021 10:29:05 -0600
Received: from localhost ([10.250.66.86])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 108GT4YS059555;
        Fri, 8 Jan 2021 10:29:04 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        David Lechner <david@lechnology.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH] irqchip: Simplify the TI_PRUSS_INTC Kconfig
Date:   Fri, 8 Jan 2021 10:29:01 -0600
Message-ID: <20210108162901.6003-1-s-anna@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The TI PRUSS INTC irqchip driver handles the local interrupt controller
which is a child device of it's parent PRUSS/ICSSG device. The driver
was upstreamed in parallel with the PRUSS platform driver, and was
configurable independently previously. The PRUSS interrupt controller
is an integral part of the overall PRUSS software architecture, and is
not useful at all by itself.

Simplify the TI_PRUSS_INTC Kconfig dependencies by making it silent and
selected automatically when the TI_PRUSS platform driver is enabled.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/irqchip/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 94920a51c628..b147f22a78f4 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -493,8 +493,9 @@ config TI_SCI_INTA_IRQCHIP
 	  TI System Controller, say Y here. Otherwise, say N.
 
 config TI_PRUSS_INTC
-	tristate "TI PRU-ICSS Interrupt Controller"
-	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX || SOC_DRA7XX || ARCH_KEYSTONE || ARCH_K3
+	tristate
+	depends on TI_PRUSS
+	default TI_PRUSS
 	select IRQ_DOMAIN
 	help
 	  This enables support for the PRU-ICSS Local Interrupt Controller
-- 
2.29.2

