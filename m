From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 04/13] ARM: omap1: convert to using readl/writel instead of
 volatile struct
Date: Tue, 10 May 2011 08:28:37 +0100
Message-ID: <E1QJhMz-0000yZ-NF@rmk-PC.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49627 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab1EJH3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 May 2011 03:29:30 -0400
In-Reply-To: <20110510072700.GA29869@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/time.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index e2c29b4..e7ab616 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -68,49 +68,50 @@ typedef struct {
 } omap_mpu_timer_regs_t;
 
 #define omap_mpu_timer_base(n)							\
-((volatile omap_mpu_timer_regs_t*)OMAP1_IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
+((omap_mpu_timer_regs_t __iomem *)OMAP1_IO_ADDRESS(OMAP_MPU_TIMER_BASE +	\
 				 (n)*OMAP_MPU_TIMER_OFFSET))
 
 static inline unsigned long notrace omap_mpu_timer_read(int nr)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
-	return timer->read_tim;
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
+	return readl(&timer->read_tim);
 }
 
 static inline void omap_mpu_set_autoreset(int nr)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
 
-	timer->cntl = timer->cntl | MPU_TIMER_AR;
+	writel(readl(&timer->cntl) | MPU_TIMER_AR, &timer->cntl);
 }
 
 static inline void omap_mpu_remove_autoreset(int nr)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
 
-	timer->cntl = timer->cntl & ~MPU_TIMER_AR;
+	writel(readl(&timer->cntl) & ~MPU_TIMER_AR, &timer->cntl);
 }
 
 static inline void omap_mpu_timer_start(int nr, unsigned long load_val,
 					int autoreset)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
-	unsigned int timerflags = (MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_ST);
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
+	unsigned int timerflags = MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_ST;
 
-	if (autoreset) timerflags |= MPU_TIMER_AR;
+	if (autoreset)
+		timerflags |= MPU_TIMER_AR;
 
-	timer->cntl = MPU_TIMER_CLOCK_ENABLE;
+	writel(MPU_TIMER_CLOCK_ENABLE, &timer->cntl);
 	udelay(1);
-	timer->load_tim = load_val;
+	writel(load_val, &timer->load_tim);
         udelay(1);
-	timer->cntl = timerflags;
+	writel(timerflags, &timer->cntl);
 }
 
 static inline void omap_mpu_timer_stop(int nr)
 {
-	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(nr);
 
-	timer->cntl &= ~MPU_TIMER_ST;
+	writel(readl(&timer->cntl) & ~MPU_TIMER_ST, &timer->cntl);
 }
 
 /*
-- 
1.7.4.4

