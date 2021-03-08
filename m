Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82836C433E6
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B7365227
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCHPMb (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:12:31 -0500
Received: from muru.com ([72.249.23.125]:41026 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231512AbhCHPMA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 8 Mar 2021 10:12:00 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 255158117;
        Mon,  8 Mar 2021 15:12:41 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 11/11] ARM: dts: Configure simple-pm-bus for omap5 l3
Date:   Mon,  8 Mar 2021 17:11:43 +0200
Message-Id: <20210308151143.27793-12-tony@atomide.com>
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
 arch/arm/boot/dts/omap5.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -142,7 +142,11 @@ wakeupgen: interrupt-controller@48281000 {
 	 * hierarchy.
 	 */
 	ocp {
-		compatible = "simple-bus";
+		compatible = "simple-pm-bus";
+		power-domains = <&prm_core>;
+		clocks = <&l3main1_clkctrl OMAP5_L3_MAIN_1_CLKCTRL 0>,
+			 <&l3main2_clkctrl OMAP5_L3_MAIN_2_CLKCTRL 0>,
+			 <&l3instr_clkctrl OMAP5_L3_MAIN_3_CLKCTRL 0>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0 0 0 0xc0000000>;
-- 
2.30.1
