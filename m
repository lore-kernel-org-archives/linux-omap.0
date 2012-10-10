From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 1/3] ARM: dts: Renaming elpida_ecb240abacn.dtsi as lpddr2_data.dtsi
Date: Wed, 10 Oct 2012 17:35:14 +0530
Message-ID: <1349870716-25511-2-git-send-email-lokeshvutla@ti.com>
References: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51462 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab2JJMFd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Oct 2012 08:05:33 -0400
In-Reply-To: <1349870716-25511-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, b-cousson@ti.com, lokeshvutla@ti.com, santosh.shilimkar@ti.com

Renaming elpida_ecb240abacn.dtsi file generic, so that the
same file can be reused for other parts from different vendors.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/{elpida_ecb240abacn.dtsi => lpddr2_data.dtsi} |    0
 arch/arm/boot/dts/omap4-panda.dts                               |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts                                 |    2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{elpida_ecb240abacn.dtsi => lpddr2_data.dtsi} (100%)

diff --git a/arch/arm/boot/dts/elpida_ecb240abacn.dtsi b/arch/arm/boot/dts/lpddr2_data.dtsi
similarity index 100%
rename from arch/arm/boot/dts/elpida_ecb240abacn.dtsi
rename to arch/arm/boot/dts/lpddr2_data.dtsi
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 20b966e..09d3a32 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
-/include/ "elpida_ecb240abacn.dtsi"
+/include/ "lpddr2_data.dtsi"
 
 / {
 	model = "TI OMAP4 PandaBoard";
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 94a23b3..dd749fc 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -8,7 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
-/include/ "elpida_ecb240abacn.dtsi"
+/include/ "lpddr2_data.dtsi"
 
 / {
 	model = "TI OMAP4 SDP board";
-- 
1.7.10.4

