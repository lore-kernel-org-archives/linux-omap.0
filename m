Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FDBC48BE6
	for <linux-omap@archiver.kernel.org>; Sat, 12 Jun 2021 01:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DA5261374
	for <linux-omap@archiver.kernel.org>; Sat, 12 Jun 2021 01:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFLBRn (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 11 Jun 2021 21:17:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60920 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFLBRm (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 11 Jun 2021 21:17:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15C1Fcir093924;
        Fri, 11 Jun 2021 20:15:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623460538;
        bh=iH2YPcJJAdmfZaD3mvMXwVRTivIdbFK/pMgaf35Sa0Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kGdaW+FtyylbleQTxcwE+whTdKUt5lQX+gKpCcKl7ffjtU1fwPG+6GI4l6d6lLCtE
         MAyr45qOpLYyGNTfzSfXd8P3HjO0xJIZG3RgDid+SvPF9+olOaePieNNm26OvCcVpp
         ie98Hw/VmnJXZ0OF6pft9Kbwe9YF0yygIWIZkaKI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15C1FcAE127650
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 20:15:38 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 20:15:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 20:15:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15C1Fbrn101854;
        Fri, 11 Jun 2021 20:15:37 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-omap@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Johnson Chen <johnsonch.chen@moxa.com>
Subject: [PATCH next 07/15] ARM: dts: am335x-moxa-uc: switch to new cpsw switch drv
Date:   Sat, 12 Jun 2021 04:14:28 +0300
Message-ID: <20210612011436.10437-8-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210612011436.10437-1-grygorii.strashko@ti.com>
References: <20210612011436.10437-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The dual_mac mode has been preserved the same way between legacy and new
driver, and one port devices works the same as 1 dual_mac port - it's safe
to switch drivers.

So, switch Moxa am335x-moxa-uc-210x/8100 to use new cpsw switch driver.
Those boards have or 2 Ext. port wired and configured in dual_mac mode by
default, or only 1 Ext. port.

Cc: Johnson Chen <johnsonch.chen@moxa.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../arm/boot/dts/am335x-moxa-uc-2100-common.dtsi | 12 ++++++------
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts        |  7 +++----
 .../arm/boot/dts/am335x-moxa-uc-8100-common.dtsi | 16 ++++++----------
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
index 8121a199607c..11e8f64b6606 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -122,24 +122,24 @@
 	regulator-max-microvolt = <5000000>;
 };
 
-&mac {
+&mac_sw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cpsw_default>;
 	status = "okay";
 };
 
-&davinci_mdio {
+&davinci_mdio_sw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&davinci_mdio_default>;
 	status = "okay";
 };
 
-&cpsw_emac0 {
-	status = "okay";
+&cpsw_port1 {
+	ti,dual-emac-pvid = <1>;
 };
 
-&cpsw_emac1 {
-	status = "okay";
+&cpsw_port2 {
+	ti,dual-emac-pvid = <2>;
 };
 
 &sham {
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
index 5923b6e7e1cb..1cc513ed92cc 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2101.dts
@@ -52,18 +52,17 @@
 	};
 };
 
-&davinci_mdio {
+&davinci_mdio_sw {
 	phy0: ethernet-phy@4 {
 		reg = <4>;
 	};
 };
 
-&cpsw_emac0 {
-	status = "okay";
+&cpsw_port1 {
 	phy-handle = <&phy0>;
 	phy-mode = "rmii";
 };
 
-&cpsw_emac1 {
+&cpsw_port2 {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi b/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
index 39e5d2ce600a..a7269b90d795 100644
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-common.dtsi
@@ -310,17 +310,15 @@
 	regulator-max-microvolt = <5000000>;
 };
 
-&mac {
+&mac_sw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&cpsw_default>;
-	dual_emac = <1>;
 	status = "okay";
 };
 
-&davinci_mdio {
+&davinci_mdio_sw {
 	pinctrl-names = "default";
 	pinctrl-0 = <&davinci_mdio_default>;
-	status = "okay";
 
 	ethphy0: ethernet-phy@4 {
 		reg = <4>;
@@ -331,18 +329,16 @@
 	};
 };
 
-&cpsw_emac0 {
-	status = "okay";
+&cpsw_port1 {
 	phy-handle = <&ethphy0>;
 	phy-mode = "rmii";
-	dual_emac_res_vlan = <1>;
+	ti,dual-emac-pvid = <1>;
 };
 
-&cpsw_emac1 {
-	status = "okay";
+&cpsw_port2 {
 	phy-handle = <&ethphy1>;
 	phy-mode = "rmii";
-	dual_emac_res_vlan = <2>;
+	ti,dual-emac-pvid = <2>;
 };
 
 &sham {
-- 
2.17.1

