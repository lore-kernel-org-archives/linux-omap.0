Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBCDC388F9
	for <linux-omap@archiver.kernel.org>; Wed, 11 Nov 2020 14:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2032074B
	for <linux-omap@archiver.kernel.org>; Wed, 11 Nov 2020 14:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKKOMx (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 11 Nov 2020 09:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgKKOM1 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2020 09:12:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAD4C0613D1
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2020 06:12:27 -0800 (PST)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kcqrB-0003AI-Em; Wed, 11 Nov 2020 15:12:17 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     kernel@pengutronix.de
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: [PATCH] ARM: dts: dra76x: m_can: fix order of clocks
Date:   Wed, 11 Nov 2020 15:12:11 +0100
Message-Id: <20201111141211.1577871-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-omap@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

According to the bosch,m_can.yaml bindings the first clock shall be the "hclk",
while the second clock "cclk".

This patch fixes the order accordingly.

Fixes: 0adbe832f21a ("ARM: dts: dra76x: Add MCAN node")
Cc: Faiz Abbas <faiz_abbas@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/dra76x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra76x.dtsi b/arch/arm/boot/dts/dra76x.dtsi
index b69c7d40f5d8..2f326151116b 100644
--- a/arch/arm/boot/dts/dra76x.dtsi
+++ b/arch/arm/boot/dts/dra76x.dtsi
@@ -32,8 +32,8 @@ m_can0: mcan@1a00 {
 				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "int0", "int1";
-				clocks = <&mcan_clk>, <&l3_iclk_div>;
-				clock-names = "cclk", "hclk";
+				clocks = <&l3_iclk_div>, <&mcan_clk>;
+				clock-names = "hclk", "cclk";
 				bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
 			};
 		};
-- 
2.28.0

