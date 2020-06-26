Return-Path: <SRS0=SgDd=AH=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24036C433DF
	for <linux-omap@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBE52082E
	for <linux-omap@archiver.kernel.org>; Fri, 26 Jun 2020 08:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593158818;
	bh=On5Nw2JpCCwElO7JZNv53oCMoWWZnH7BsNSGYOYu//8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=B+yd7xOsN1HuxkzeqkcZStqXiGTal41E6kwXTe66A7AF5sn8cm9EtilwMQ2hfmcHX
	 LRfuw3grnSXEa4PsKyybZWq04hXERMLrzb4lhX7iV9GpwuCJr5sIbssdqWCvxCTO4U
	 fUMS6hQglSauGYDxhQSR88bJt9poeI6Ec1uzWg3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgFZIG4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbgFZIG0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:26 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC8220836;
        Fri, 26 Jun 2020 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158786;
        bh=On5Nw2JpCCwElO7JZNv53oCMoWWZnH7BsNSGYOYu//8=;
        h=From:To:Cc:Subject:Date:From;
        b=JpwCgfBr0BUzGrw2TTqSO1RzFLaCntdG13YqXTvgy4qYnIPgIpe/Qas4JS2nqYXKt
         m3ZlTSgd0KIbDMqZXTccbz0J9AA9TTvF/eIP7W9x6Sg0R+BW0sMWj6uT6rbaTuT4Q1
         ZxiXaRJvaC4r5w/gF65OBSSSGZdIXCQH+8VQAyI4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: omap: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:06:19 +0200
Message-Id: <20200626080619.4017-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache-controller@48242000: $nodename:0:
        'l2-cache-controller@48242000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/omap4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4400f5f8e099..3e1b393f58a7 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -71,7 +71,7 @@
 		interrupt-parent = <&gic>;
 	};
 
-	L2: l2-cache-controller@48242000 {
+	L2: cache-controller@48242000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x48242000 0x1000>;
 		cache-unified;
-- 
2.17.1

