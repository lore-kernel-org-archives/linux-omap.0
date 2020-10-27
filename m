Return-Path: <SRS0=J+Ql=EC=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D97C2D0A3
	for <linux-omap@archiver.kernel.org>; Tue, 27 Oct 2020 00:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4E720708
	for <linux-omap@archiver.kernel.org>; Tue, 27 Oct 2020 00:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603758065;
	bh=6HD5ID4ZxIhuO9EUche6iespmWMWoZz25geluMymkUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fcjmMgRXgjDa1jJEmRbgbCnYLtYSTMbXgptdrv2Nt45BZEmWPGkrgbvA4NNrYNDRx
	 bSedtwstMmgF5HgKWDAR+8FR4NMEawdCGeGSJzxBEsyzqCDausUgPac1QbB4ZaQUEo
	 +SKrK9kqv5HTYQISV0Qt877NMS0w+d01I513x5Oo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437445AbgJ0AF6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438186AbgJ0AFS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 26 Oct 2020 20:05:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 712D120791;
        Tue, 27 Oct 2020 00:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603757118;
        bh=6HD5ID4ZxIhuO9EUche6iespmWMWoZz25geluMymkUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1W4j12strcXTncEBvtHM7CEKEkWeQ9w4RA8PpWZa9UnfaQ7R3IdUMyOL8NyqGcJh
         3BKTkZaeERoDAG7WsZsZgt6SiJyqsgZEDKlxa3oTA4fBJcYIdsK67EfiNi+L9fz5Zb
         f26SqHAPjHU6uM1b/kIxP4eGQZuRMJKEghrwK7fU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sre@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 53/60] ARM: dts: omap4: Fix sgx clock rate for 4430
Date:   Mon, 26 Oct 2020 20:04:08 -0400
Message-Id: <20201027000415.1026364-53-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027000415.1026364-1-sashal@kernel.org>
References: <20201027000415.1026364-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 19d3e9a0bdd57b90175f30390edeb06851f5f9f3 ]

We currently have a different clock rate for droid4 compared to the
stock v3.0.8 based Android Linux kernel:

# cat /sys/kernel/debug/clk/dpll_*_m7x2_ck/clk_rate
266666667
307200000
# cat /sys/kernel/debug/clk/l3_gfx_cm:clk:0000:0/clk_rate
307200000

Let's fix this by configuring sgx to use 153.6 MHz instead of 307.2 MHz.
Looks like also at least duover needs this change to avoid hangs, so
let's apply it for all 4430.

This helps a bit with thermal issues that seem to be related to memory
corruption when using sgx. It seems that other driver related issues
still remain though.

Cc: Arthur Demchenkov <spinal.by@gmail.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap4.dtsi    |  2 +-
 arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 1a96d4317c975..8f907c235b02c 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -516,7 +516,7 @@ abb_iva: regulator-abb-iva {
 			status = "disabled";
 		};
 
-		target-module@56000000 {
+		sgx_module: target-module@56000000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			ti,hwmods = "gpu";
 			reg = <0x5601fc00 0x4>,
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index cbcdcb4e7d1c2..86b9caf461dfa 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -74,3 +74,13 @@ &cpu_thermal {
 };
 
 /include/ "omap443x-clocks.dtsi"
+
+/*
+ * Use dpll_per for sgx at 153.6MHz like droid4 stock v3.0.8 Android kernel
+ */
+&sgx_module {
+	assigned-clocks = <&l3_gfx_clkctrl OMAP4_GPU_CLKCTRL 24>,
+			  <&dpll_per_m7x2_ck>;
+	assigned-clock-rates = <0>, <153600000>;
+	assigned-clock-parents = <&dpll_per_m7x2_ck>;
+};
-- 
2.25.1

