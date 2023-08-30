Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACA2C83F15
	for <linux-omap@archiver.kernel.org>; Wed, 30 Aug 2023 18:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbjH3S5O (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbjH3SUz (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 30 Aug 2023 14:20:55 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A591A2;
        Wed, 30 Aug 2023 11:20:51 -0700 (PDT)
Received: from p200300ccff199c001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff19:9c00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qbPo3-003BYx-Tu; Wed, 30 Aug 2023 20:20:43 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1qbPo3-003gU6-1v;
        Wed, 30 Aug 2023 20:20:43 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bcousson@baylibre.com, tony@atomide.com, mturquette@baylibre.com,
        sboyd@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/5] dt-bindings: mfd: ti,twl: Add clock provider properties
Date:   Wed, 30 Aug 2023 20:20:35 +0200
Message-Id: <20230830182038.878265-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230830182038.878265-1-andreas@kemnade.info>
References: <20230830182038.878265-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Since these devices provide clock outputs, add the corresponding
property.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Documentation/devicetree/bindings/mfd/ti,twl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index 3d7b3e0addafa..6bb781b95ecdb 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -37,6 +37,9 @@ properties:
   "#interrupt-cells":
     const: 1
 
+  "#clock-cells":
+    const: 1
+
 additionalProperties: true
 
 required:
-- 
2.39.2

