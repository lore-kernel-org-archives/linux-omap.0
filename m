From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 06/13] clocksource: add common mmio clocksource
Date: Tue, 10 May 2011 08:29:18 +0100
Message-ID: <E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Eric Miao <eric.y.miao@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Erik Gilling <konkers@android.com>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Krzysztof Halasa <khc@pm.waw.pl>, linux-omap@vger.kernel.org, "Hans J. Koch" <hjk@hansjkoch.de>, Sascha Hauer <kernel@pengutronix.de>, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Imre Kaloz <kaloz@openwrt.org>, Wan ZongShun <mcuos.com@gmail.com>, Lennert Buytenhek <kernel@wantstofly.org>, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-omap@vger.kernel.org

Add a generic mmio clocksource, covering both 32-bit and 16-bit register
access sizes, for up or down counters.  This can be used to easily
create clocksources for simple counter-based implementations.

Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Colin Cross <ccross@android.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Erik Gilling <konkers@android.com>
Cc: "Hans J. Koch" <hjk@hansjkoch.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-omap@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Olof Johansson <olof@lixom.net>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/Kconfig              |    3 ++
 drivers/clocksource/Kconfig  |    2 +
 drivers/clocksource/Makefile |    1 +
 drivers/clocksource/mmio.c   |   72 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/clocksource.h  |    8 +++++
 5 files changed, 86 insertions(+), 0 deletions(-)
 create mode 100644 drivers/clocksource/Kconfig
 create mode 100644 drivers/clocksource/mmio.c

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 177c7d1..557a469 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -119,4 +119,7 @@ source "drivers/platform/Kconfig"
 source "drivers/clk/Kconfig"
 
 source "drivers/hwspinlock/Kconfig"
+
+source "drivers/clocksource/Kconfig"
+
 endmenu
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
new file mode 100644
index 0000000..47f37b1
--- /dev/null
+++ b/drivers/clocksource/Kconfig
@@ -0,0 +1,2 @@
+config CLKSRC_MMIO
+	bool
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index be61ece..9b2ba29 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
 obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o
 obj-$(CONFIG_SH_TIMER_MTU2)	+= sh_mtu2.o
 obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
+obj-$(CONFIG_CLKSRC_MMIO)	+= mmio.o
diff --git a/drivers/clocksource/mmio.c b/drivers/clocksource/mmio.c
new file mode 100644
index 0000000..71ad3a3
--- /dev/null
+++ b/drivers/clocksource/mmio.c
@@ -0,0 +1,72 @@
+/*
+ * Generic MMIO clocksource support
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clocksource.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+
+struct clocksource_mmio {
+	void __iomem *reg;
+	struct clocksource clksrc;
+};
+
+static inline struct clocksource_mmio *to_mmio_clksrc(struct clocksource *c)
+{
+	return container_of(c, struct clocksource_mmio, clksrc);
+}
+
+cycle_t clocksource_mmio_readl_up(struct clocksource *c)
+{
+	return readl_relaxed(to_mmio_clksrc(c)->reg);
+}
+
+cycle_t clocksource_mmio_readl_down(struct clocksource *c)
+{
+	return ~readl_relaxed(to_mmio_clksrc(c)->reg);
+}
+
+cycle_t clocksource_mmio_readw_up(struct clocksource *c)
+{
+	return readw_relaxed(to_mmio_clksrc(c)->reg);
+}
+
+cycle_t clocksource_mmio_readw_down(struct clocksource *c)
+{
+	return ~(unsigned)readw_relaxed(to_mmio_clksrc(c)->reg);
+}
+
+/**
+ * clocksource_mmio_init - Initialize a simple mmio based clocksource
+ * @base:	Virtual address of the clock readout register
+ * @name:	Name of the clocksource
+ * @hz:		Frequency of the clocksource in Hz
+ * @rating:	Rating of the clocksource
+ * @bits:	Number of valid bits
+ * @read:	One of clocksource_mmio_read*() above
+ */
+int __init clocksource_mmio_init(void __iomem *base, const char *name,
+	unsigned long hz, int rating, unsigned bits,
+	cycle_t (*read)(struct clocksource *))
+{
+	struct clocksource_mmio *cs;
+
+	if (bits > 32 || bits < 16)
+		return -EINVAL;
+
+	cs = kzalloc(sizeof(struct clocksource_mmio), GFP_KERNEL);
+	if (!cs)
+		return -ENOMEM;
+
+	cs->clksrc.name = name;
+	cs->clksrc.rating = rating;
+	cs->clksrc.read = read;
+	cs->clksrc.mask = CLOCKSOURCE_MASK(bits);
+	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
+
+	return clocksource_register_hz(&cs->clksrc, hz);
+}
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 94c1f38..a3558fd 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -341,4 +341,12 @@ static inline void update_vsyscall_tz(void)
 
 extern void timekeeping_notify(struct clocksource *clock);
 
+extern cycle_t clocksource_mmio_readl_up(struct clocksource *);
+extern cycle_t clocksource_mmio_readl_down(struct clocksource *);
+extern cycle_t clocksource_mmio_readw_up(struct clocksource *);
+extern cycle_t clocksource_mmio_readw_down(struct clocksource *);
+
+extern int clocksource_mmio_init(void __iomem *, const char *,
+	unsigned long, int, unsigned, cycle_t (*)(struct clocksource *));
+
 #endif /* _LINUX_CLOCKSOURCE_H */
-- 
1.7.4.4
