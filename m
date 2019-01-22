From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] ARM: dts: Configure clock parent for pwm vibra
Date: Tue, 22 Jan 2019 09:57:17 -0800
Message-ID: <20190122175717.13428-4-tony@atomide.com>
References: <20190122175717.13428-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122175717.13428-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "H . Nikolaus Schaller" <hns@goldelico.com>, Keerthy <j-keerthy@ti.com>, Ladislav Michl <ladis@linux-mips.org>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Tero Kristo <t-kristo@ti.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andy.shevchenko@gmail.com>
List-Id: linux-omap@vger.kernel.org

Commit 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc") moved some omap4 timers to probe with ti-sysc
interconnect target module. Turns out this broke pwm-omap-dmtimer
for reparenting of the timer clock.

With ti-sysc, we can now configure the clock sources in the dts with
assigned-clocks and assigned-clock-parents.

Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc")
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-droid4-xt894.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
--- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
+++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
@@ -644,6 +644,17 @@
 	};
 };
 
+/* Configure pwm clock source for timers 8 & 9 */
+&timer8 {
+	assigned-clocks = <&abe_clkctrl OMAP4_TIMER8_CLKCTRL 24>;
+	assigned-clock-parents = <&sys_clkin_ck>;
+};
+
+&timer9 {
+	assigned-clocks = <&l4_per_clkctrl OMAP4_TIMER9_CLKCTRL 24>;
+	assigned-clock-parents = <&sys_clkin_ck>;
+};
+
 /*
  * As uart1 is wired to mdm6600 with rts and cts, we can use the cts pin for
  * uart1 wakeirq.
-- 
2.20.1
