Return-Path: <SRS0=szrX=6I=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BD0C55194
	for <linux-omap@archiver.kernel.org>; Fri, 24 Apr 2020 15:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40AF21569
	for <linux-omap@archiver.kernel.org>; Fri, 24 Apr 2020 15:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NWMXJptZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDXPNJ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:13:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41500 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDXPNI (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2020 11:13:08 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03OFD2UC044754;
        Fri, 24 Apr 2020 10:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587741182;
        bh=oY8Iv1pxCjpBeK+t8WNDjXmRSvBkyl0OaXXJIOziGQA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NWMXJptZ5OZ4exKNUjA4geoN43ogrgiOUi6OvZtJDfVY1cLr4dAm6/yDnbjyqudgJ
         lIYT0C8pRRpAJs0dAD5+ku6bdv2CCrno9Pbv+HZgc85WRlvfOYFdK3sh17HMyU8XkZ
         OneF4eLwaGFyUr8Wficd/8tvSILu7Bc+4qdkBwBQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03OFD2JO099624
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 10:13:02 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 10:13:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 10:13:02 -0500
Received: from sokoban.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03OFCu7B122378;
        Fri, 24 Apr 2020 10:13:01 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <linux-omap@vger.kernel.org>, <tony@atomide.com>
CC:     <s-anna@ti.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 03/17] ARM: dts: DRA74x: Add DSP2 processor device node
Date:   Fri, 24 Apr 2020 18:12:30 +0300
Message-ID: <20200424151244.3225-4-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200424151244.3225-1-t-kristo@ti.com>
References: <20200424151244.3225-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The DRA7xx family of SoCs can contain upto two identical DSP
processor subsystems. The second DSP processor subsystem is
present only on the DRA74x/DRA76x variants. The processor
device DT node has therefore been added in disabled state for
this processor subsystem in the DRA74x specific DTS file.

NOTE:
1. The node does not have any mailboxes, timers or CMA region
   assigned, they should be added in the respective board dts
   files.
2. The node should also be enabled as per the individual product
   configuration in the corresponding board dts files.

Signed-off-by: Suman Anna <s-anna@ti.com>
[t-kristo@ti.com: converted to support ti-sysc from legacy hwmod]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/dra74x.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dra74x.dtsi b/arch/arm/boot/dts/dra74x.dtsi
index 7b1c61298253..94ba80769001 100644
--- a/arch/arm/boot/dts/dra74x.dtsi
+++ b/arch/arm/boot/dts/dra74x.dtsi
@@ -124,6 +124,20 @@
 				ti,syscon-mmuconfig = <&dsp2_system 0x1>;
 			};
 		};
+
+		dsp2: dsp@41000000 {
+			compatible = "ti,dra7-dsp";
+			reg = <0x41000000 0x48000>,
+			      <0x41600000 0x8000>,
+			      <0x41700000 0x8000>;
+			reg-names = "l2ram", "l1pram", "l1dram";
+			ti,bootreg = <&scm_conf 0x560 10>;
+			iommus = <&mmu0_dsp2>, <&mmu1_dsp2>;
+			status = "disabled";
+			resets = <&prm_dsp2 0>;
+			clocks = <&dsp2_clkctrl DRA7_DSP2_MMU0_DSP2_CLKCTRL 0>;
+			firmware-name = "dra7-dsp2-fw.xe66";
+		};
 	};
 };
 
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
