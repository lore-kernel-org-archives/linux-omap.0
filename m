From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 2/4] ARM: dts: AM4372: Add ti,mbox-send-noirq to wkup_m3 mailbox
Date: Fri, 17 Jul 2015 16:08:02 -0500
Message-ID: <1437167284-25659-3-git-send-email-d-gerlach@ti.com>
References: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Suman Anna <s-anna@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>

Add ti,mbox-send-noirq to wkup_m3 mailbox so that messages using
wkup_m3 mailbox are sent without triggering any further interrupts.
This is required to be able to send multiple messages to the WkupM3
after the mailbox usage logic adjustment in the wkup_m3_ipc driver.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Dave Gerlach <d-gerlach@ti.com>
[s-anna@ti.com: revise commit description]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 6f6f393..5bccc48 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -214,6 +214,7 @@
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <8>;
 			mbox_wkupm3: wkup_m3 {
+				ti,mbox-send-noirq;
 				ti,mbox-tx = <0 0 0>;
 				ti,mbox-rx = <0 0 3>;
 			};
-- 
2.4.5
