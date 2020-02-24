Return-Path: <SRS0=6eJi=4M=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF02C38BE7
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 21:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559B6222C2
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 21:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBXVKK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:10:10 -0500
Received: from muru.com ([72.249.23.125]:57130 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgBXVKK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 24 Feb 2020 16:10:10 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id CF67E81B7;
        Mon, 24 Feb 2020 21:10:54 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH 02/23] ARM: dts: Configure interconnect target module for omap4 dispc
Date:   Mon, 24 Feb 2020 13:09:38 -0800
Message-Id: <20200224210959.56146-3-tony@atomide.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200224210959.56146-1-tony@atomide.com>
References: <20200224210959.56146-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

We can now probe devices with device tree only configuration using
ti-sysc interconnect target module driver. Let's configure the
module, but keep the legacy "ti,hwmods" peroperty until the child
devices are probing with ti-sysc interconnect driver.

We must now also configure sys_clk for reset to complete, the top
level module only keeps optional clocks enabled for it's own reset.

Cc: Jyri Sarha <jsarha@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4.dtsi | 37 ++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -445,13 +445,38 @@ dss: dss@0 {
 				#size-cells = <1>;
 				ranges = <0 0 0x1000000>;
 
-				dispc@1000 {
-					compatible = "ti,omap4-dispc";
-					reg = <0x1000 0x1000>;
-					interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+				target-module@1000 {
+					compatible = "ti,sysc-omap2", "ti,sysc";
 					ti,hwmods = "dss_dispc";
-					clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>;
-					clock-names = "fck";
+					reg = <0x1000 0x4>,
+					      <0x1010 0x4>,
+					      <0x1014 0x4>;
+					reg-names = "rev", "sysc", "syss";
+					ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+							<SYSC_IDLE_NO>,
+							<SYSC_IDLE_SMART>;
+					ti,sysc-midle = <SYSC_IDLE_FORCE>,
+							<SYSC_IDLE_NO>,
+							<SYSC_IDLE_SMART>;
+					ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+							 SYSC_OMAP2_ENAWAKEUP |
+							 SYSC_OMAP2_SOFTRESET |
+							 SYSC_OMAP2_AUTOIDLE)>;
+					ti,syss-mask = <1>;
+					clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>,
+						 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
+					clock-names = "fck", "sys_clk";
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0x1000 0x1000>;
+
+					dispc@0 {
+						compatible = "ti,omap4-dispc";
+						reg = <0 0x1000>;
+						interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+						clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>;
+						clock-names = "fck";
+					};
 				};
 
 				rfbi: encoder@2000  {
-- 
2.25.1
