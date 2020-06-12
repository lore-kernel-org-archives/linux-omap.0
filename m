Return-Path: <SRS0=KS1d=7Z=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E0EC433DF
	for <linux-omap@archiver.kernel.org>; Fri, 12 Jun 2020 17:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E8920836
	for <linux-omap@archiver.kernel.org>; Fri, 12 Jun 2020 17:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFLRTw (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:19:52 -0400
Received: from muru.com ([72.249.23.125]:57780 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgFLRTw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 12 Jun 2020 13:19:52 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 4ECA080CC;
        Fri, 12 Jun 2020 17:20:44 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: Fix duovero smsc interrupt for suspend
Date:   Fri, 12 Jun 2020 10:19:50 -0700
Message-Id: <20200612171950.59110-1-tony@atomide.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

While testing the recent suspend and resume regressions I noticed that
duovero can still end up losing edge gpio interrupts on runtime
suspend. This causes NFSroot easily stopping working after resume on
duovero.

Let's fix the issue by using gpio level interrupts for smsc as then
the gpio interrupt state is seen by the gpio controller on resume.

Fixes: 731b409878a3 ("ARM: dts: Configure duovero for to allow core retention during idle")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-duovero-parlor.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/dts/omap4-duovero-parlor.dts
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -139,7 +139,7 @@ &gpmc {
 	ethernet@gpmc {
 		reg = <5 0 0xff>;
 		interrupt-parent = <&gpio2>;
-		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;	/* gpio_44 */
+		interrupts = <12 IRQ_TYPE_LEVEL_LOW>;		/* gpio_44 */
 
 		phy-mode = "mii";
 
-- 
2.27.0
