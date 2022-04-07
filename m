Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E0C433FE
	for <linux-omap@archiver.kernel.org>; Thu,  7 Apr 2022 07:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiDGHMQ (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 7 Apr 2022 03:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbiDGHMQ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2022 03:12:16 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC56712AD8;
        Thu,  7 Apr 2022 00:10:16 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A114F8125;
        Thu,  7 Apr 2022 07:07:51 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/4] dt-bindings: timer: Add am6 compatible for ti-timer
Date:   Thu,  7 Apr 2022 10:10:03 +0300
Message-Id: <20220407071006.37031-1-tony@atomide.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Document the dual-mode timers available on am6.

Cc: devicetree@vger.kernel.org
Cc: Keerthy <j-keerthy@ti.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/timer/ti,timer.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/ti,timer.txt b/Documentation/devicetree/bindings/timer/ti,timer.txt
--- a/Documentation/devicetree/bindings/timer/ti,timer.txt
+++ b/Documentation/devicetree/bindings/timer/ti,timer.txt
@@ -14,6 +14,7 @@ Required properties:
 			ti,omap5430-timer (applicable to OMAP543x devices)
 			ti,am335x-timer	(applicable to AM335x devices)
 			ti,am335x-timer-1ms (applicable to AM335x devices)
+			ti,am6-timer (applicable to AM6 devices)
 
 - reg:			Contains timer register address range (base address and
 			length).
-- 
2.35.1
