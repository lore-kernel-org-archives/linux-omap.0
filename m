Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354C3C4167B
	for <linux-omap@archiver.kernel.org>; Tue,  8 Dec 2020 14:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E7C23A6C
	for <linux-omap@archiver.kernel.org>; Tue,  8 Dec 2020 14:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgLHOIw (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:08:52 -0500
Received: from muru.com ([72.249.23.125]:49880 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729265AbgLHOIw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 8 Dec 2020 09:08:52 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 0B0CA813E;
        Tue,  8 Dec 2020 14:08:18 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] soc: ti: omap-prm: Fix boot time errors for rst_map_012 bits 0 and 1
Date:   Tue,  8 Dec 2020 16:08:02 +0200
Message-Id: <20201208140802.38757-1-tony@atomide.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We have rst_map_012 used for various accelerators like dsp, ipu and iva.
For these use cases, we have rstctrl bit 2 control the subsystem module
reset, and have and bits 0 and 1 control the accelerator specific
features.

If the bootloader, or kexec boot, has left any accelerator specific
reset bits deasserted, deasserting bit 2 reset will potentially enable
an accelerator with unconfigured MMU and no firmware. And we may get
spammed with a lot by warnings on boot with "Data Access in User mode
during Functional access", or depending on the accelerator, the system
can also just hang.

This issue can be quite easily reproduced by setting a rst_map_012 type
rstctrl register to 0 or 4 in the bootloader, and booting the system.

Let's just assert all reset bits for rst_map_012 type resets. So far
it looks like the other rstctrl types don't need this. If it turns out
that the other type rstctrl bits also need reset on init, we need to
add an instance specific reset mask for the bits to avoid resetting
unwanted bits.

Reported-by: Carl Philipp Klemm <philipp@uvos.xyz>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Suman Anna <s-anna@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/soc/ti/omap_prm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -860,6 +860,7 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 	const struct omap_rst_map *map;
 	struct ti_prm_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	char buf[32];
+	u32 v;
 
 	/*
 	 * Check if we have controllable resets. If either rstctrl is non-zero
@@ -907,6 +908,16 @@ static int omap_prm_reset_init(struct platform_device *pdev,
 		map++;
 	}
 
+	/* Quirk handling to assert rst_map_012 bits on reset and avoid errors */
+	if (prm->data->rstmap == rst_map_012) {
+		v = readl_relaxed(reset->prm->base + reset->prm->data->rstctrl);
+		if ((v & reset->mask) != reset->mask) {
+			dev_dbg(&pdev->dev, "Asserting all resets: %08x\n", v);
+			writel_relaxed(reset->mask, reset->prm->base +
+				       reset->prm->data->rstctrl);
+		}
+	}
+
 	return devm_reset_controller_register(&pdev->dev, &reset->rcdev);
 }
 
-- 
2.29.2
