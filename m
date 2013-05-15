From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [Resend/PATCHv5 2/3] arm: dts: am33xx: Remove "ti,no_idle_on_suspend" property.
Date: Wed, 15 May 2013 21:31:12 +0530
Message-ID: <1368633673-32308-3-git-send-email-sourav.poddar@ti.com>
References: <1368633673-32308-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368633673-32308-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

The "ti,no_idle_on_suspend" property was required to keep ocmcram clocks
running during idle.

But commit 72bb6f9 (ARM: OMAP: omap_device: don't attempt late suspend
if no driver bound), added in v3.6 should prevent any automatic clock
gating for devices without drivers bound.  Since there is no driver for
the OCM RAM block, we are not affected by the automatic idle on suspend
anyways which means "ti,no_idle_on_suspend" can be safely removed since
there are no users for it.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Rajendra nayak <rnayak@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 1460d9b..a2608c0 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -394,7 +394,6 @@
 			compatible = "ti,am3352-ocmcram";
 			reg = <0x40300000 0x10000>;
 			ti,hwmods = "ocmcram";
-			ti,no_idle_on_suspend;
 		};
 
 		wkup_m3: wkup_m3@44d00000 {
-- 
1.7.1
