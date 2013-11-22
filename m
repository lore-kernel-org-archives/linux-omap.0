From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 6/8] devicetree: doc: Document ti,timer-parent property
Date: Thu, 21 Nov 2013 19:56:52 -0600
Message-ID: <1385085414-9034-7-git-send-email-joelf@ti.com>
References: <1385085414-9034-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1385085414-9034-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: benoit.cousson@linaro.org, santosh.shilimkar@ti.com, jgchunter@gmail.com, rnayak@ti.com, balbi@ti.com, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

Timer's parent mux clocks require a parent clock alias, provide the same from
device tree.

Ultimately this will be provided from DT as clock node phandles but clk-mux
driver DT bindings series is still under going review. So to keep things
working during the timer migration, we add this property.  Originally this was
hardcoded in timer.c, now we do the same in DT and would be removing the
hardcoded names from timer.c

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/timer.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/omap/timer.txt b/Documentation/devicetree/bindings/arm/omap/timer.txt
index 6cf7a75..644bc61 100644
--- a/Documentation/devicetree/bindings/arm/omap/timer.txt
+++ b/Documentation/devicetree/bindings/arm/omap/timer.txt
@@ -24,6 +24,11 @@ Required properties:
 			where <X> is the instance number of the timer from the
 			HW spec.
 
+Required properties for system timers (clockevents/clocksource):
+- ti,timer-parent:	System timer's parent mux clock needs to be setup.
+			This is currently hardcoded in code, for DT boot we
+			move this to DT.
+
 Optional properties:
 - ti,timer-alwon:	Indicates the timer is in an alway-on power domain.
 - ti,timer-dsp:		Indicates the timer can interrupt the on-chip DSP in
-- 
1.8.1.2
