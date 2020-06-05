Return-Path: <SRS0=Ij9V=7S=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FECC433E0
	for <linux-omap@archiver.kernel.org>; Fri,  5 Jun 2020 22:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74635206DB
	for <linux-omap@archiver.kernel.org>; Fri,  5 Jun 2020 22:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="am/Y1U79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgFEWN7 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:13:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39766 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgFEWN5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2020 18:13:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 055MDtJB102392;
        Fri, 5 Jun 2020 17:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591395235;
        bh=CqhMR0vpxK3mUc0IoHvlSWIJeFVNbMt/uzsO/ymUbxA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=am/Y1U79kUIAuWnHkxFomzQlgO0Zo9gQ/MrpJETc4/bZlVXAe1xL2KpQzNqJ6bXhU
         06H5l+zsiLHosFcEksBCSPvL2k+BKAipVnKK5YzxLZgLxGtoaghGgpBsMdJuSmgNCz
         fXrrZNszpMO/YqkrSZD194MIncDKKLu7bTPFcYII=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 055MDtLd074194
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Jun 2020 17:13:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Jun
 2020 17:13:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Jun 2020 17:13:54 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 055MDsI1120118;
        Fri, 5 Jun 2020 17:13:54 -0500
Received: from localhost ([10.250.70.56])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 055MDsbA005514;
        Fri, 5 Jun 2020 17:13:54 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Tero Kristo <t-kristo@ti.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] ARM: dts: dra7-evm-common: Fix duplicate mailbox nodes
Date:   Fri, 5 Jun 2020 17:13:47 -0500
Message-ID: <20200605221347.15735-3-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200605221347.15735-1-s-anna@ti.com>
References: <20200605221347.15735-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The mailbox nodes defined in various dts files have been moved to
common dra7-ipu-dsp-common.dtsi and dra74-ipu-dsp-common.dtsi files
in commit a11a2f73b32d ("ARM: dts: dra7-ipu-dsp-common: Move mailboxes
into common files"), but the nodes were erroneously left out in the
dra7-evm-common.dtsi file. Fix this by removing these duplicate nodes.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7-evm-common.dtsi | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
index f89a64cbcd53..2cf6a529d4ad 100644
--- a/arch/arm/boot/dts/dra7-evm-common.dtsi
+++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
@@ -245,26 +245,6 @@ &mcasp3 {
 	rx-num-evt = <32>;
 };
 
-&mailbox5 {
-	status = "okay";
-	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
-		status = "okay";
-	};
-	mbox_dsp1_ipc3x: mbox_dsp1_ipc3x {
-		status = "okay";
-	};
-};
-
-&mailbox6 {
-	status = "okay";
-	mbox_ipu2_ipc3x: mbox_ipu2_ipc3x {
-		status = "okay";
-	};
-	mbox_dsp2_ipc3x: mbox_dsp2_ipc3x {
-		status = "okay";
-	};
-};
-
 &pcie1_rc {
 	status = "okay";
 };
-- 
2.26.0

