Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C883EC64E90
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 13:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949C1208D5
	for <linux-omap@archiver.kernel.org>; Thu, 19 Nov 2020 13:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgKSNNV (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:13:21 -0500
Received: from muru.com ([72.249.23.125]:48912 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbgKSNNV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 19 Nov 2020 08:13:21 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4A6EA80F5;
        Thu, 19 Nov 2020 13:13:26 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Roger Quadros <rogerq@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Suman Anna <s-anna@ti.com>,
        linux-clk@vger.kernel.org
Subject: [PATCH 7/8] ARM: dts: omap5: add remaining PRM instances
Date:   Thu, 19 Nov 2020 15:12:58 +0200
Message-Id: <20201119131259.63829-8-tony@atomide.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119131259.63829-1-tony@atomide.com>
References: <20201119131259.63829-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

Add remaining PRM instances for the omap5 SoC. Additionally enable the
genpd support for them.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5.dtsi | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -670,10 +670,17 @@ &core_thermal {
 #include "omap54xx-clocks.dtsi"
 
 &prm {
+	prm_mpu: prm@300 {
+		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
+		reg = <0x300 0x100>;
+		#power-domain-cells = <0>;
+	};
+
 	prm_dsp: prm@400 {
 		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
 		reg = <0x400 0x100>;
 		#reset-cells = <1>;
+		#power-domain-cells = <0>;
 	};
 
 	prm_abe: prm@500 {
@@ -682,16 +689,66 @@ prm_abe: prm@500 {
 		#power-domain-cells = <0>;
 	};
 
+	prm_coreaon: prm@600 {
+		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
+		reg = <0x600 0x100>;
+		#power-domain-cells = <0>;
+	};
+
 	prm_core: prm@700 {
 		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
 		reg = <0x700 0x100>;
 		#reset-cells = <1>;
+		#power-domain-cells = <0>;
 	};
 
 	prm_iva: prm@1200 {
 		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
 		reg = <0x1200 0x100>;
 		#reset-cells = <1>;
+		#power-domain-cells = <0>;
+	};
+
+	prm_cam: prm@1300 {
+		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1300 0x100>;
+		#power-domain-cells = <0>;
+	};
+
+	prm_dss: prm@1400 {
+		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1400 0x100>;
+		#power-domain-cells = <0>;
+	};
+
+	prm_gpu: prm@1500 {
+		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1500 0x100>;
+		#power-domain-cells = <0>;
+	};
+
+	prm_l3init: prm@1600 {
+		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1600 0x100>;
+		#power-domain-cells = <0>;
+	};
+
+	prm_custefuse: prm@1700 {
+		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1700 0x100>;
+		#power-domain-cells = <0>;
+	};
+
+	prm_wkupaon: prm@1800 {
+		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1800 0x100>;
+		#power-domain-cells = <0>;
+	};
+
+	prm_emu: prm@1a00 {
+		compatible = "ti,omap5-prm-inst", "ti,omap-prm-inst";
+		reg = <0x1a00 0x100>;
+		#power-domain-cells = <0>;
 	};
 
 	prm_device: prm@1c00 {
-- 
2.29.2
