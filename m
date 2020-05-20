Return-Path: <SRS0=tvBc=7C=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2874BC433E2
	for <linux-omap@archiver.kernel.org>; Wed, 20 May 2020 21:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDF820873
	for <linux-omap@archiver.kernel.org>; Wed, 20 May 2020 21:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgETVNq (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 20 May 2020 17:13:46 -0400
Received: from muru.com ([72.249.23.125]:55306 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbgETVNp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 20 May 2020 17:13:45 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 279DF819C;
        Wed, 20 May 2020 21:14:34 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     "Andrew F . Davis" <afd@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/6] dt-bindings: omap: Update PRM binding for genpd
Date:   Wed, 20 May 2020 14:13:29 -0700
Message-Id: <20200520211334.61814-2-tony@atomide.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520211334.61814-1-tony@atomide.com>
References: <20200520211334.61814-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

The PRM (Power and Reset Module) has registers to enable and disable
power domains, so let's update the binding for that.

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/arm/omap/prm-inst.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/prm-inst.txt b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
--- a/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prm-inst.txt
@@ -18,6 +18,7 @@ Required properties:
 		(base address and length)
 
 Optional properties:
+- #power-domain-cells:	Should be 0 if the PRM instance is a power domain.
 - #reset-cells:	Should be 1 if the PRM instance in question supports resets.
 
 Example:
@@ -25,5 +26,6 @@ Example:
 prm_dsp2: prm@1b00 {
 	compatible = "ti,dra7-prm-inst", "ti,omap-prm-inst";
 	reg = <0x1b00 0x40>;
+	#power-domain-cells = <0>;
 	#reset-cells = <1>;
 };
-- 
2.26.2
