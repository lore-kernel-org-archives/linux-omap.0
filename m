From: Suman Anna <s-anna@ti.com>
Subject: [PATCH] ARM: dts: OMAP4+: remove multimedia carveouts
Date: Wed, 17 Apr 2013 16:26:30 -0500
Message-ID: <1366233990-29724-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36828 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965578Ab3DQVbX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Apr 2013 17:31:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The carveouts that have been reserved for multimedia usecases
are not being used currently by any driver and so have been
cleaned up. Memory will be allocated runtime through CMA for
enabling the multimedia usecases.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 8 --------
 arch/arm/boot/dts/omap5.dtsi | 8 --------
 2 files changed, 16 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 55c633a..79aaafe 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -6,14 +6,6 @@
  * published by the Free Software Foundation.
  */
 
-/*
- * Carveout for multimedia usecases
- * It should be the last 48MB of the first 512MB memory part
- * In theory, it should not even exist. That zone should be reserved
- * dynamically during the .reserve callback.
- */
-/memreserve/ 0x9d000000 0x03000000;
-
 /include/ "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index c9ecdbe..7006554 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -7,14 +7,6 @@
  * Based on "omap4.dtsi"
  */
 
-/*
- * Carveout for multimedia usecases
- * It should be the last 48MB of the first 512MB memory part
- * In theory, it should not even exist. That zone should be reserved
- * dynamically during the .reserve callback.
- */
-/memreserve/ 0x9d000000 0x03000000;
-
 /include/ "skeleton.dtsi"
 
 / {
-- 
1.8.2

