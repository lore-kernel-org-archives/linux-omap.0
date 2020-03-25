Return-Path: <SRS0=1+OQ=5K=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531C4C2D0E7
	for <linux-omap@archiver.kernel.org>; Wed, 25 Mar 2020 21:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3625F2070A
	for <linux-omap@archiver.kernel.org>; Wed, 25 Mar 2020 21:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbgCYVhz (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:37:55 -0400
Received: from fgw20-4.mail.saunalahti.fi ([62.142.5.107]:46142 "EHLO
        fgw20-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727525AbgCYVhy (ORCPT
        <rfc822;linux-omap@vger.kernel.org>);
        Wed, 25 Mar 2020 17:37:54 -0400
Received: from localhost.localdomain (85-76-97-57-nat.elisa-mobile.fi [85.76.97.57])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id a3e2473a-6ede-11ea-826c-005056bd6ce9;
        Wed, 25 Mar 2020 23:21:50 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: DTS: OMAP3: disable RNG on N950/N9
Date:   Wed, 25 Mar 2020 23:21:49 +0200
Message-Id: <20200325212149.27547-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Like on N900, we cannot access RNG directly on N950/N9. Mark it disabled in
the DTS to allow kernel to boot.

Fixes: 308607e5545f ("ARM: dts: Configure omap3 rng")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index a075b63f3087..11d41e86f814 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -341,6 +341,11 @@
 	status = "disabled";
 };
 
+/* RNG not directly accessible on N950/N9. */
+&rng_target {
+	status = "disabled";
+};
+
 &usb_otg_hs {
 	interface-type = <0>;
 	usb-phy = <&usb2_phy>;
-- 
2.17.0

