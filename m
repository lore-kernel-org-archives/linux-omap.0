Return-Path: <SRS0=6eJi=4M=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A264C38BE7
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 21:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BC124649
	for <linux-omap@archiver.kernel.org>; Mon, 24 Feb 2020 21:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBXVKP (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:10:15 -0500
Received: from muru.com ([72.249.23.125]:57158 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgBXVKP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 24 Feb 2020 16:10:15 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 66B2E81DB;
        Mon, 24 Feb 2020 21:10:59 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH 05/23] ARM: dts: Configure interconnect target module for omap4 dsi1
Date:   Mon, 24 Feb 2020 13:09:41 -0800
Message-Id: <20200224210959.56146-6-tony@atomide.com>
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
module and drop "ti,hwmods" peroperty as this module is a child node
of dispc and has no dependencies to to legacy platform data.

Cc: Jyri Sarha <jsarha@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4.dtsi | 42 +++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -525,18 +525,36 @@ venc: encoder@0 {
 					};
 				};
 
-				dsi1: encoder@4000 {
-					compatible = "ti,omap4-dsi";
-					reg = <0x4000 0x200>,
-					      <0x4200 0x40>,
-					      <0x4300 0x20>;
-					reg-names = "proto", "phy", "pll";
-					interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
-					status = "disabled";
-					ti,hwmods = "dss_dsi1";
-					clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>,
-					<&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
-					clock-names = "fck", "sys_clk";
+				target-module@4000 {
+					compatible = "ti,sysc-omap2", "ti,sysc";
+					reg = <0x4000 0x4>,
+					      <0x4010 0x4>,
+					      <0x4014 0x4>;
+					reg-names = "rev", "sysc", "syss";
+					ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+							<SYSC_IDLE_NO>,
+							<SYSC_IDLE_SMART>;
+					ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+							 SYSC_OMAP2_ENAWAKEUP |
+							 SYSC_OMAP2_SOFTRESET |
+							 SYSC_OMAP2_AUTOIDLE)>;
+					ti,syss-mask = <1>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0x4000 0x1000>;
+
+					dsi1: encoder@0 {
+						compatible = "ti,omap4-dsi";
+						reg = <0 0x200>,
+						      <0x200 0x40>,
+						      <0x300 0x20>;
+						reg-names = "proto", "phy", "pll";
+						interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+						status = "disabled";
+						clocks = <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 8>,
+							 <&l3_dss_clkctrl OMAP4_DSS_CORE_CLKCTRL 10>;
+						clock-names = "fck", "sys_clk";
+					};
 				};
 
 				dsi2: encoder@5000 {
-- 
2.25.1
