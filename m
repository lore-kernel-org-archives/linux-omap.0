Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C8C4360C
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781726523D
	for <linux-omap@archiver.kernel.org>; Mon,  8 Mar 2021 15:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhCHPMC (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 8 Mar 2021 10:12:02 -0500
Received: from muru.com ([72.249.23.125]:40996 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbhCHPLx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 8 Mar 2021 10:11:53 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 1428180D4;
        Mon,  8 Mar 2021 15:12:34 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 04/11] ARM: dts: Configure interconnect target module for omap5 gpmc
Date:   Mon,  8 Mar 2021 17:11:36 +0200
Message-Id: <20210308151143.27793-5-tony@atomide.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308151143.27793-1-tony@atomide.com>
References: <20210308151143.27793-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We can now probe devices with device tree only configuration using
ti-sysc interconnect target module driver. Let's configure the
module, but keep the legacy "ti,hwmods" property to avoid new boot
time warnings. The legacy property will be removed in later patches
together with the legacy platform data.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap5.dtsi | 49 ++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -177,23 +177,40 @@ ocmcram: sram@40300000 {
 			reg = <0x40300000 0x20000>; /* 128k */
 		};
 
-		gpmc: gpmc@50000000 {
-			compatible = "ti,omap4430-gpmc";
-			reg = <0x50000000 0x1000>;
-			#address-cells = <2>;
-			#size-cells = <1>;
-			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&sdma 4>;
-			dma-names = "rxtx";
-			gpmc,num-cs = <8>;
-			gpmc,num-waitpins = <4>;
-			ti,hwmods = "gpmc";
-			clocks = <&l3_iclk_div>;
+		target-module@50000000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
+			reg = <0x50000000 4>,
+			      <0x50000010 4>,
+			      <0x50000014 4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,syss-mask = <1>;
+			ti,no-idle-on-init;
+			clocks = <&l3main2_clkctrl OMAP5_L3_MAIN_2_GPMC_CLKCTRL 0>;
 			clock-names = "fck";
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			gpio-controller;
-			#gpio-cells = <2>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x50000000 0x50000000 0x00001000>, /* regs */
+				 <0x00000000 0x00000000 0x40000000>; /* data */
+
+			gpmc: gpmc@50000000 {
+				compatible = "ti,omap4430-gpmc";
+				reg = <0x50000000 0x1000>;
+				#address-cells = <2>;
+				#size-cells = <1>;
+				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				dmas = <&sdma 4>;
+				dma-names = "rxtx";
+				gpmc,num-cs = <8>;
+				gpmc,num-waitpins = <4>;
+				clock-names = "fck";
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
 		};
 
 		target-module@55082000 {
-- 
2.30.1
