From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH] ARM: dts: Protect pinctrl headers against multiple inclusions
Date: Tue, 11 Jun 2013 16:50:50 +0200
Message-ID: <1370962250-9745-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:42908 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751659Ab3FKOvA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 10:51:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Florian Vaussard <florian.vaussard@epfl.ch>

Pinctrl headers were not protected with #ifndef.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 include/dt-bindings/pinctrl/am33xx.h |    5 +++++
 include/dt-bindings/pinctrl/omap.h   |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/dt-bindings/pinctrl/am33xx.h b/include/dt-bindings/pinctrl/am33xx.h
index a3fddd4..469e032 100644
--- a/include/dt-bindings/pinctrl/am33xx.h
+++ b/include/dt-bindings/pinctrl/am33xx.h
@@ -2,6 +2,9 @@
  * This header provides constants specific to AM33XX pinctrl bindings.
  */
 
+#ifndef _DT_BINDINGS_PINCTRL_AM33XX_H
+#define _DT_BINDINGS_PINCTRL_AM33XX_H
+
 #include <include/dt-bindings/pinctrl/omap.h>
 
 /* am33xx specific mux bit defines */
@@ -35,3 +38,5 @@
 #undef PIN_OFF_INPUT_PULLDOWN
 #undef PIN_OFF_WAKEUPENABLE
 
+#endif
+
diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/pinctrl/omap.h
index 370df3f..edbd250 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -5,6 +5,9 @@
  * Copyright (C) 2009-2010 Texas Instruments
  */
 
+#ifndef _DT_BINDINGS_PINCTRL_OMAP_H
+#define _DT_BINDINGS_PINCTRL_OMAP_H
+
 /* 34xx mux mode options for each pin. See TRM for options */
 #define MUX_MODE0	0
 #define MUX_MODE1	1
@@ -48,3 +51,5 @@
 #define PIN_OFF_INPUT_PULLDOWN	(OFF_EN | OFF_PULL_EN)
 #define PIN_OFF_WAKEUPENABLE	WAKEUP_EN
 
+#endif
+
-- 
1.7.5.4

