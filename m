From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/2] pinctrl: am43xx: dt-bindings: fix SLEWCTRL_FAST binding
Date: Fri, 27 Feb 2015 19:10:27 -0600
Message-ID: <1425085827-4514-3-git-send-email-d-gerlach@ti.com>
References: <1425085827-4514-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48897 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752AbbB1BLI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Feb 2015 20:11:08 -0500
In-Reply-To: <1425085827-4514-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Dave Gerlach <d-gerlach@ti.com>

According to AM437x TRM, Document SPRUHL7B, Revised December 2014,
Section 7.2.1 Pad Control Registers, setting bit 19 of the pad control
registers actually sets the SLEWCTRL value to slow rather than fast as
the current macro indicates. Introduce a new macro, SLEWCTRL_SLOW, that
sets the bit, and modify SLEWCTRL_FAST to 0 but keep it for
completeness.

Current users of the macro (i2c, mdio, and uart) are left unmodified as
SLEWCTRL_FAST was the macro used and actual desired state. Tested on
am437x-gp-evm with no difference in software performance seen.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 include/dt-bindings/pinctrl/am43xx.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/pinctrl/am43xx.h b/include/dt-bindings/pinctrl/am43xx.h
index 9c2e4f8..5f4d0189 100644
--- a/include/dt-bindings/pinctrl/am43xx.h
+++ b/include/dt-bindings/pinctrl/am43xx.h
@@ -18,7 +18,8 @@
 #define PULL_DISABLE		(1 << 16)
 #define PULL_UP			(1 << 17)
 #define INPUT_EN		(1 << 18)
-#define SLEWCTRL_FAST		(1 << 19)
+#define SLEWCTRL_SLOW		(1 << 19)
+#define SLEWCTRL_FAST		0
 #define DS0_PULL_UP_DOWN_EN	(1 << 27)
 
 #define PIN_OUTPUT		(PULL_DISABLE)
-- 
2.3.0

