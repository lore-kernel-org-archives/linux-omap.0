Return-Path: <SRS0=NGSz=7Y=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC55C433DF
	for <linux-omap@archiver.kernel.org>; Thu, 11 Jun 2020 15:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A22920792
	for <linux-omap@archiver.kernel.org>; Thu, 11 Jun 2020 15:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JNIGK39a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgFKPaE (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:30:04 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56140 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbgFKPaB (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2020 11:30:01 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05BFTwhu011625;
        Thu, 11 Jun 2020 10:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591889398;
        bh=Ts4mOPmUuwp74G9T2QNmDc9S2nOXuXjnktWeWg0tJhE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JNIGK39aypt0c6wbZOXG5zQIKDoTZMuHIBsuuwFUsbFxheXyBVzMyjBUyfOcNT+mZ
         P0pYewUA86E6gH77kMePNW9exU+bGU2L3Gqcfk7gR2ziRd1yeZLAH91jRe63uv2a9D
         qbDTNYzuvY7V+rN37xV0pS/EZq0KzexO9UeE5JSE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05BFTwaq040509
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Jun 2020 10:29:58 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 11
 Jun 2020 10:29:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 11 Jun 2020 10:29:55 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05BFTtAK021115;
        Thu, 11 Jun 2020 10:29:55 -0500
Received: from localhost ([10.250.48.148])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 05BFTtiE085869;
        Thu, 11 Jun 2020 10:29:55 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Jason Kridner <jdk@ti.com>, Caleb Robey <c-robey@ti.com>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] ARM: dts: am5729-beaglebone-ai: Disable ununsed mailboxes
Date:   Thu, 11 Jun 2020 10:29:45 -0500
Message-ID: <20200611152945.27656-3-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200611152945.27656-1-s-anna@ti.com>
References: <20200611152945.27656-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The IPU and DSP remote processors use sub-mailbox nodes only from a
limited set of System Mailboxes 5 and 6 to achieve the Remote Processor
Messaging (RPMsg) communication stack between the MPU host processor
and the respective remote processor. These are all defined and enabled
through the inherited common dra74-ipu-dsp-common.dtsi file.

The other System Mailboxes do not define any actual sub-mailboxes, so
they serve no purpose and can all be safely dropped.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am5729-beagleboneai.dts | 52 -----------------------
 1 file changed, 52 deletions(-)

diff --git a/arch/arm/boot/dts/am5729-beagleboneai.dts b/arch/arm/boot/dts/am5729-beagleboneai.dts
index 619e75927224..d3e345d6634a 100644
--- a/arch/arm/boot/dts/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/am5729-beagleboneai.dts
@@ -630,58 +630,6 @@ &bandgap {
 	status = "okay";
 };
 
-&mailbox1 {
-	status = "okay";
-};
-
-&mailbox2 {
-	status = "okay";
-};
-
-&mailbox3 {
-	status = "okay";
-};
-
-&mailbox4 {
-	status = "okay";
-};
-
-&mailbox5 {
-	status = "okay";
-};
-
-&mailbox6 {
-	status = "okay";
-};
-
-&mailbox7 {
-	status = "okay";
-};
-
-&mailbox8 {
-	status = "okay";
-};
-
-&mailbox9 {
-	status = "okay";
-};
-
-&mailbox10 {
-	status = "okay";
-};
-
-&mailbox11 {
-	status = "okay";
-};
-
-&mailbox12 {
-	status = "okay";
-};
-
-&mailbox13 {
-	status = "okay";
-};
-
 &cpu_alert0 {
 	temperature = <55000>; /* milliCelsius */
 };
-- 
2.26.0

