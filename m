From: yegorslists@googlemail.com
Subject: [PATCH] regulator: tps65910: fix interrupt documentation link
Date: Mon, 10 Mar 2014 12:55:36 +0100
Message-ID: <1394452536-9595-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hhlx01.vscom.de ([62.145.30.242]:60690 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbaCJL4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Mar 2014 07:56:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 Documentation/devicetree/bindings/mfd/tps65910.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/tps65910.txt b/Documentation/devicetree/bindings/mfd/tps65910.txt
index b4bd98a..38833e6 100644
--- a/Documentation/devicetree/bindings/mfd/tps65910.txt
+++ b/Documentation/devicetree/bindings/mfd/tps65910.txt
@@ -11,7 +11,7 @@ Required properties:
 - #interrupt-cells: the number of cells to describe an IRQ, this should be 2.
   The first cell is the IRQ number.
   The second cell is the flags, encoded as the trigger masks from
-  Documentation/devicetree/bindings/interrupts.txt
+  Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 - regulators: This is the list of child nodes that specify the regulator
   initialization data for defined regulators. Not all regulators for the given
   device need to be present. The definition for each of these nodes is defined
-- 
1.7.7

