Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D1AC4707F
	for <linux-omap@archiver.kernel.org>; Fri, 21 May 2021 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D63613F3
	for <linux-omap@archiver.kernel.org>; Fri, 21 May 2021 22:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhEUWeO (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 21 May 2021 18:34:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48992 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhEUWeN (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2021 18:34:13 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14LMWm2M055157;
        Fri, 21 May 2021 17:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621636368;
        bh=wF1jbQtCKVve9yimhbfljuQgOOV7IiP26ZGKETsGmtQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DahIxAhBfwtc/ZGpsvuCnIvjd0CKU+NJX7M3eqc3GLrZji7RbL5ZOKn0vAaiqnDGa
         edgMUGupV3HJ7oMqoRhO+tm/aztDV5wyWYwXkQ3sEOddvpRFxn5bOTaqTy21ge7QIo
         7emBEe/WOoxwM1GKgbRH310in4j6kt/G2EO6UNvk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14LMWmAW117106
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 May 2021 17:32:48 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 21
 May 2021 17:32:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 21 May 2021 17:32:47 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14LMWkbh067511;
        Fri, 21 May 2021 17:32:47 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, <devicetree@vger.kernel.org>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/5] ARM: dts: am437x: align gpio hog names with dt-schema
Date:   Sat, 22 May 2021 01:32:33 +0300
Message-ID: <20210521223236.18324-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210521223236.18324-1-grygorii.strashko@ti.com>
References: <20210521223236.18324-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The GPIO Hog dt-schema node naming convention expect GPIO hogs node names
to end with a 'hog' suffix.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 4 ++--
 arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 033b984ff637..e2677682b540 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -786,7 +786,7 @@
 	pinctrl-0 = <&gpio0_pins>;
 	status = "okay";
 
-	p23 {
+	sel-emmc-nand-hog {
 		gpio-hog;
 		gpios = <23 GPIO_ACTIVE_HIGH>;
 		/* SelEMMCorNAND selects between eMMC and NAND:
@@ -822,7 +822,7 @@
 	pinctrl-0 = <&display_mux_pins>;
 	status = "okay";
 
-	p8 {
+	sel-lcd-hdmi-hog {
 		/*
 		 * SelLCDorHDMI selects between display and audio paths:
 		 * Low: HDMI display with audio via HDMI
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index f517d1e843cf..d717d5ada812 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -725,7 +725,7 @@
 	pinctrl-0 = <&display_mux_pins>;
 	status = "okay";
 
-	p1 {
+	sel-lcd-hdmi-hog {
 		/*
 		 * SelLCDorHDMI selects between display and audio paths:
 		 * Low: HDMI display with audio via HDMI
-- 
2.17.1

