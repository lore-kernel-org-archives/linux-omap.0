Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2FFC4361A
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914F86523F
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCHPME (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:12:04 -0500
Received: from muru.com ([72.249.23.125]:41016 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhCHPL6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 8 Mar 2021 10:11:58 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 273278117;
        Mon,  8 Mar 2021 15:12:40 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 09/11] ARM: dts: Configure simple-pm-bus for omap5 l4_per
Date:   Mon,  8 Mar 2021 17:11:41 +0200
Message-Id: <20210308151143.27793-10-tony@atomide.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308151143.27793-1-tony@atomide.com>
References: <20210308151143.27793-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We can now probe interconnects with device tree only configuration using
simple-pm-bus and genpd.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5-l4.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-l4.dtsi b/arch/arm/boot/dts/omap5-l4.dtsi
--- a/arch/arm/boot/dts/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/omap5-l4.dtsi
@@ -947,7 +947,10 @@ segment@300000 {					/* 0x4a300000 */
 };
 
 &l4_per {						/* 0x48000000 */
-	compatible = "ti,omap5-l4-per", "simple-bus";
+	compatible = "ti,omap5-l4-per", "simple-pm-bus";
+	power-domains = <&prm_core>;
+	clocks = <&l4per_clkctrl OMAP5_L4_PER_CLKCTRL 0>;
+	clock-names = "fck";
 	reg = <0x48000000 0x800>,
 	      <0x48000800 0x800>,
 	      <0x48001000 0x400>,
@@ -961,7 +964,7 @@ &l4_per {						/* 0x48000000 */
 		 <0x00200000 0x48200000 0x200000>;	/* segment 1 */
 
 	segment@0 {					/* 0x48000000 */
-		compatible = "simple-bus";
+		compatible = "simple-pm-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x00000000 0x00000000 0x000800>,	/* ap 0 */
@@ -2170,7 +2173,7 @@ mmc5: mmc@0 {
 	};
 
 	segment@200000 {					/* 0x48200000 */
-		compatible = "simple-bus";
+		compatible = "simple-pm-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
-- 
2.30.1
