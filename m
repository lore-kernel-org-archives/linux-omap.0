From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 4/5] arm: dts: am33xx: Remove "ti,no_idle_on_suspend" property.
Date: Mon, 22 Apr 2013 19:13:56 +0530
Message-ID: <1366638237-6880-5-git-send-email-sourav.poddar@ti.com>
References: <1366638237-6880-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366638237-6880-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, tony@atomide.com, rmk+kernel@arm.linux.org.uk, khilman@linaro.org
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Rajendra nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

The "ti,no_idle_on_suspend" property was required to keep ocmcram
clocks running during idle.

But the commit below[1], added in v3.6 should prevent the
any automaic clock gating for devices without drivers bound.  Since
there is no driver for the OCM RAM block, we are not affected by
the automatic idle on suspend anyways.
[1]:
commit 72bb6f9b51c82c820ddef892455a85b115460904
Author: Kevin Hilman <khilman@ti.com>
Date:   Tue Jul 10 15:29:04 2012 -0700

    ARM: OMAP: omap_device: don't attempt late suspend if no driver bound

    Currently, the omap_device PM domain layer uses the late suspend and
    early resume callbacks to ensure devices are in their low power
    states.

    However, this is attempted even in cases where a driver probe has
    failed.  If a driver's ->probe() method fails, the driver is likely in
    a state where it is not expecting its runtime PM callbacks to be
    called, yet currently the omap_device PM domain code attempts to call
    the drivers callbacks.

    To fix, use the omap_device driver_status field to check whether a
    driver is bound to the omap_device before attempting to trigger driver
    callbacks.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Rajendra nayak <rnayak@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 74a8125..49a050e 100644
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
