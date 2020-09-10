Return-Path: <SRS0=uib+=CT=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E0C07548
	for <linux-omap@archiver.kernel.org>; Thu, 10 Sep 2020 18:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FFB214F1
	for <linux-omap@archiver.kernel.org>; Thu, 10 Sep 2020 18:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599761646;
	bh=sm9QzBKFUt+6hTdQmQnPcOZmNM4hHwtIqsujy8/F9s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bHf8z5AKW6iqMDA57QRLs+VYdX6fp7uBYqLfopMBP4W0x3vXE+s+WKUy+rB73cwTu
	 F1BkpZsen4RKmV+Iv7s2TuyJPymDFX96GaAAqPyh4bkcQlVrLuc5ZSwyvMiXWjzt3R
	 HCQhsB1a8g23FxTRk9xw5j4Wj3SSvdx/1c4Mopss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIJSOE (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgIJR6c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 10 Sep 2020 13:58:32 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443E821D92;
        Thu, 10 Sep 2020 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599760711;
        bh=sm9QzBKFUt+6hTdQmQnPcOZmNM4hHwtIqsujy8/F9s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQwCBB4sEbufgya4UwjGfTc2lMXXJ7NgACNrnQSaaDqu80K4bipy6VY9LPwe8vr6a
         /KRhEPS51XF+yEjnfi3qpe3j80aBU7ck/WsI3LY3xBNDmuLPJGCW/rgpZUBTtSeTkj
         Eek2R8mjFzm+er4wCMV/+/zc1BxhA2kPqbPv+25A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 06/15] arm64: dts: ti: align GPIO hog names with dtschema
Date:   Thu, 10 Sep 2020 19:57:24 +0200
Message-Id: <20200910175733.11046-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910175733.11046-1-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The convention for node names is to use hyphens, not underscores.
dtschema for pca95xx requires GPIO hogs to end with 'hog' prefix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 648267284582..456e7818b521 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -407,7 +407,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		p09 {
+		p09-hog {
 			/* P11 - MCASP/TRACE_MUX_S0 */
 			gpio-hog;
 			gpios = <9 GPIO_ACTIVE_HIGH>;
@@ -415,7 +415,7 @@
 			line-name = "MCASP/TRACE_MUX_S0";
 		};
 
-		p10 {
+		p10-hog {
 			/* P12 - MCASP/TRACE_MUX_S1 */
 			gpio-hog;
 			gpios = <10 GPIO_ACTIVE_HIGH>;
-- 
2.17.1

