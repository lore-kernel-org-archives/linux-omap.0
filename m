Return-Path: <SRS0=yxN7=5A=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A719C1975A
	for <linux-omap@archiver.kernel.org>; Sun, 15 Mar 2020 01:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BF72071B
	for <linux-omap@archiver.kernel.org>; Sun, 15 Mar 2020 01:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgCOBj1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:39:27 -0400
Received: from muru.com ([72.249.23.125]:60426 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgCOBj1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sat, 14 Mar 2020 21:39:27 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AA1D48043;
        Sat, 14 Mar 2020 17:24:54 +0000 (UTC)
Date:   Sat, 14 Mar 2020 10:24:05 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        devicetree@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: Fix sgx clock rate
Message-ID: <20200314172405.GH37466@atomide.com>
References: <20200310201818.15989-1-tony@atomide.com>
 <20200310210944.GU37466@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310210944.GU37466@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [200310 21:10]:
> * Tony Lindgren <tony@atomide.com> [200310 20:19]:
> > +&sgx_module {
> 
> Sorry the sgx_module label came from the linux_openpvrsgx branch
> I had merged in as Arthur noticed.
> 
> Below is an updated patch against v5.6-rc series.

And looks like this is also needed for at least duovero, so let's
change the clock for all 4430.

Regards,

Tony

8< ----------------------
From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 10 Mar 2020 14:02:48 -0700
Subject: [PATCH] ARM: dts: omap4: Fix sgx clock rate for 4430

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
---
 arch/arm/boot/dts/omap4.dtsi    |  2 +-
 arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -390,7 +390,7 @@ abb_iva: regulator-abb-iva {
 			status = "disabled";
 		};
 
-		target-module@56000000 {
+		sgx_module: target-module@56000000 {
 			compatible = "ti,sysc-omap4", "ti,sysc";
 			reg = <0x5600fe00 0x4>,
 			      <0x5600fe10 0x4>;
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
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
