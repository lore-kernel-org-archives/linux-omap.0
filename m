Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AAAC2BB48
	for <linux-omap@archiver.kernel.org>; Mon, 14 Dec 2020 21:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF14322512
	for <linux-omap@archiver.kernel.org>; Mon, 14 Dec 2020 21:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503644AbgLNVCR (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 14 Dec 2020 16:02:17 -0500
Received: from fgw21-4.mail.saunalahti.fi ([62.142.5.108]:53762 "EHLO
        fgw21-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503495AbgLNVCG (ORCPT
        <rfc822;linux-omap@vger.kernel.org>);
        Mon, 14 Dec 2020 16:02:06 -0500
Received: from localhost.localdomain (85-76-8-36-nat.elisa-mobile.fi [85.76.8.36])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 84c4f6bd-3e4f-11eb-9eb8-005056bdd08f;
        Mon, 14 Dec 2020 23:01:22 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: OMAP1: OSK: fix ohci-omap breakage
Date:   Mon, 14 Dec 2020 23:01:21 +0200
Message-Id: <20201214210121.22042-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

Commit 45c5775460f3 ("usb: ohci-omap: Fix descriptor conversion") tried to
fix all issues related to ohci-omap descriptor conversion, but a wrong
patch was applied, and one needed change to the OSK board file is still
missing. Fix that.

Fixes: 45c5775460f3 ("usb: ohci-omap: Fix descriptor conversion")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[aaro.koskinen@iki.fi: rebased and updated the changelog]
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

This is the patch that should have been merged:

	https://marc.info/?l=linux-usb&m=160682513710441&w=2

 arch/arm/mach-omap1/board-osk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index a720259099ed..0a4c9b0b13b0 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -203,6 +203,8 @@ static int osk_tps_setup(struct i2c_client *client, void *context)
 	 */
 	gpio_request(OSK_TPS_GPIO_USB_PWR_EN, "n_vbus_en");
 	gpio_direction_output(OSK_TPS_GPIO_USB_PWR_EN, 1);
+	/* Free the GPIO again as the driver will request it */
+	gpio_free(OSK_TPS_GPIO_USB_PWR_EN);
 
 	/* Set GPIO 2 high so LED D3 is off by default */
 	tps65010_set_gpio_out_value(GPIO2, HIGH);
-- 
2.17.0

