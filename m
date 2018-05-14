From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RFC PATCH 05/10] arm: time: Remove the persistent clock support for ARM
Date: Mon, 14 May 2018 16:55:31 +0800
Message-ID: <8d74ba31d4d2b14f21bea7a9cbc4f029bc59f60f.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, john.stultz@linaro.org, daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com, aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com, marc.zyngier@arm.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, paulmck@linux.vnet.ibm.com, mlichvar@redhat.com, rdunlap@infradead.org, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de, linus.walleij@linaro.org, viresh.kumar@linaro.org, mingo@kernel.org, hpa@zytor.com, peterz@infradead.org, douly.fnst@cn.fujitsu.com, len.brown@intel.com, rajvi.jingar@intel.com, alexandre.belloni@bootlin.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

We have converted all drivers to use common persistent clock framework
to compensate the suspend time, so we can remove the persistent clock,
which only supports the ARM architecture.

Moreover there are no drivers will register read_boot_clock64(), so
remove it too.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm/include/asm/mach/time.h |    4 ----
 arch/arm/kernel/time.c           |   36 ------------------------------------
 2 files changed, 40 deletions(-)

diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index 0f79e4d..3cbcafc 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -12,8 +12,4 @@
 
 extern void timer_tick(void);
 
-typedef void (*clock_access_fn)(struct timespec64 *);
-extern int register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent);
-
 #endif
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cf2701c..713905c 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -76,42 +76,6 @@ void timer_tick(void)
 }
 #endif
 
-static void dummy_clock_access(struct timespec64 *ts)
-{
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
-}
-
-static clock_access_fn __read_persistent_clock = dummy_clock_access;
-static clock_access_fn __read_boot_clock = dummy_clock_access;
-
-void read_persistent_clock64(struct timespec64 *ts)
-{
-	__read_persistent_clock(ts);
-}
-
-void read_boot_clock64(struct timespec64 *ts)
-{
-	__read_boot_clock(ts);
-}
-
-int __init register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent)
-{
-	/* Only allow the clockaccess functions to be registered once */
-	if (__read_persistent_clock == dummy_clock_access &&
-	    __read_boot_clock == dummy_clock_access) {
-		if (read_boot)
-			__read_boot_clock = read_boot;
-		if (read_persistent)
-			__read_persistent_clock = read_persistent;
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
 void __init time_init(void)
 {
 	if (machine_desc->init_time) {
-- 
1.7.9.5
