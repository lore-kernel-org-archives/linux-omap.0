From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 09/11] clocksource: add TI 32.768 Hz counter driver
Date: Fri, 16 Oct 2015 11:22:08 -0500
Message-ID: <1445012530-14126-10-git-send-email-balbi@ti.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Introduce a new clocksource driver for Texas
Instruments 32.768 Hz device which is available
on most OMAP-like devices.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/clocksource/Kconfig        |   7 +++
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-ti-32k.c | 126 +++++++++++++++++++++++++++++=
++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 drivers/clocksource/timer-ti-32k.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a7726db13abb..98b2a9b9bfad 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -115,6 +115,13 @@ config CLKSRC_PISTACHIO
 	bool
 	select CLKSRC_OF
=20
+config CLKSRC_TI_32K
+	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
+	select CLKSRC_OF if OF
+	help
+	  This option enables support for Texas Instruments 32.768 Hz clockso=
urce
+	  available on many OMAP-like platforms.
+
 config CLKSRC_STM32
 	bool "Clocksource for STM32 SoCs" if !ARCH_STM32
 	depends on OF && ARM && (ARCH_STM32 || COMPILE_TEST)
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefil=
e
index 5c00863c3e33..749abc3665b3 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_VF_PIT_TIMER)	+=3D vf_pit_timer.o
 obj-$(CONFIG_CLKSRC_QCOM)	+=3D qcom-timer.o
 obj-$(CONFIG_MTK_TIMER)		+=3D mtk_timer.o
 obj-$(CONFIG_CLKSRC_PISTACHIO)	+=3D time-pistachio.o
+obj-$(CONFIG_CLKSRC_TI_32K)	+=3D timer-ti-32k.o
=20
 obj-$(CONFIG_ARM_ARCH_TIMER)		+=3D arm_arch_timer.o
 obj-$(CONFIG_ARM_GLOBAL_TIMER)		+=3D arm_global_timer.o
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/t=
imer-ti-32k.c
new file mode 100644
index 000000000000..8518d9dfba5c
--- /dev/null
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -0,0 +1,126 @@
+/**
+ * timer-ti-32k.c - OMAP2 32k Timer Support
+ *
+ * Copyright (C) 2009 Nokia Corporation
+ *
+ * Update to use new clocksource/clockevent layers
+ * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
+ * Copyright (C) 2007 MontaVista Software, Inc.
+ *
+ * Original driver:
+ * Copyright (C) 2005 Nokia Corporation
+ * Author: Paul Mundt <paul.mundt@nokia.com>
+ *         Juha Yrj=C3=B6l=C3=A4 <juha.yrjola@nokia.com>
+ * OMAP Dual-mode timer framework support by Timo Teras
+ *
+ * Some parts based off of TI's 24xx code:
+ *
+ * Copyright (C) 2004-2009 Texas Instruments, Inc.
+ *
+ * Roughly modelled after the OMAP1 MPU timer code.
+ * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.c=
om
+ *
+ * This program is free software: you can redistribute it and/or modif=
y
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/=
>.
+ */
+
+#include <linux/init.h>
+#include <linux/time.h>
+#include <linux/sched_clock.h>
+#include <linux/clocksource.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+/*
+ * 32KHz clocksource ... always available, on pretty most chips except
+ * OMAP 730 and 1510.  Other timers could be used as clocksources, wit=
h
+ * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
+ * but systems won't necessarily want to spend resources that way.
+ */
+
+#define OMAP2_32KSYNCNT_REV_OFF		0x0
+#define OMAP2_32KSYNCNT_REV_SCHEME	(0x3 << 30)
+#define OMAP2_32KSYNCNT_CR_OFF_LOW	0x10
+#define OMAP2_32KSYNCNT_CR_OFF_HIGH	0x30
+
+struct ti_32k {
+	void __iomem		*base;
+	void __iomem		*counter;
+	struct clocksource	cs;
+};
+
+static inline struct ti_32k *to_ti_32k(struct clocksource *cs)
+{
+	return container_of(cs, struct ti_32k, cs);
+}
+
+static cycle_t ti_32k_read_cycles(struct clocksource *cs)
+{
+	struct ti_32k *ti =3D to_ti_32k(cs);
+
+	return (cycle_t)readl_relaxed(ti->counter);
+}
+
+static struct ti_32k ti_32k_timer =3D {
+	.cs =3D {
+		.name		=3D "32k_counter",
+		.rating		=3D 250,
+		.read		=3D ti_32k_read_cycles,
+		.mask		=3D CLOCKSOURCE_MASK(32),
+		.flags		=3D CLOCK_SOURCE_IS_CONTINUOUS |
+				CLOCK_SOURCE_SUSPEND_NONSTOP,
+	},
+};
+
+static u64 notrace omap_32k_read_sched_clock(void)
+{
+	return ti_32k_read_cycles(&ti_32k_timer.cs);
+}
+
+static void __init ti_32k_timer_init(struct device_node *np)
+{
+	int ret;
+
+	ti_32k_timer.base =3D of_iomap(np, 0);
+	if (!ti_32k_timer.base) {
+		pr_err("Can't ioremap 32k timer base\n");
+		return;
+	}
+
+	ti_32k_timer.counter =3D ti_32k_timer.base;
+
+	/*
+	 * 32k sync Counter IP register offsets vary between the highlander
+	 * version and the legacy ones.
+	 *
+	 * The 'SCHEME' bits(30-31) of the revision register is used to ident=
ify
+	 * the version.
+	 */
+	if (readl_relaxed(ti_32k_timer.base + OMAP2_32KSYNCNT_REV_OFF) &
+			OMAP2_32KSYNCNT_REV_SCHEME)
+		ti_32k_timer.counter +=3D OMAP2_32KSYNCNT_CR_OFF_HIGH;
+	else
+		ti_32k_timer.counter +=3D OMAP2_32KSYNCNT_CR_OFF_LOW;
+
+	ret =3D clocksource_register_hz(&ti_32k_timer.cs, 32768);
+	if (ret) {
+		pr_err("32k_counter: can't register clocksource\n");
+		return;
+	}
+
+	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
+	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
+}
+CLOCKSOURCE_OF_DECLARE(ti_32k_timer, "ti,omap-counter32k",
+		ti_32k_timer_init);
--=20
2.5.3
