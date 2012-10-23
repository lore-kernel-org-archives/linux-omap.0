From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2] arm: sched: stop sched_clock() during suspend
Date: Tue, 23 Oct 2012 08:57:34 +0300
Message-ID: <1350971854-9161-1-git-send-email-balbi@ti.com>
References: <873916h1yi.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <873916h1yi.fsf@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>, linus.walleij@linaro.org, Daniel Walker <dwalker@fifo99.com>, Lennert Buytenhek <kernel@wantstofly.org>, Kevin Hilman <khilman@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Barry Song <21cnbao@gmail.com>, Bryan Huntsman <bryanh@codeaurora.org>, khilman@deeprootsystems.com, David Brown <davidb@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, John Stultz <john.stultz@linaro.org>, Ben Dooks <ben-linux@fluff.org>, Alexander Schulz <alex@shark-linux.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Kyungmin
List-Id: linux-omap@vger.kernel.org

The scheduler imposes a requirement to sched_clock()
which is to stop the clock during suspend, if we don't
do that any RT thread will be rescheduled in the future
which might cause any sort of problems.

This became an issue on OMAP when we converted omap-i2c.c
to use threaded IRQs, it turned out that depending on how
much time we spent on suspend, the I2C IRQ thread would
end up being rescheduled so far in the future that I2C
transfers would timeout and, because omap_hsmmc depends
on an I2C-connected device to detect if an MMC card is
inserted in the slot, our rootfs would just vanish.

arch/arm/kernel/sched_clock.c already had an optional
implementation (sched_clock_needs_suspend()) which would
handle scheduler's requirement properly, what this patch
does is simply to make that implementation non-optional.

Note that this has the side-effect that printk timings
won't reflect the actual time spent on suspend so other
methods to measure that will have to be used.

This has been tested with beagleboard XM (OMAP3630) and
pandaboard rev A3 (OMAP4430). Suspend to RAM is now working
after this patch.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Changes since v1:
	- changed commit log to mention that all RT threads will be
	  rescheduled to the future.
	- changed commit log to mention the side effect on printk
	  timings

 arch/arm/include/asm/sched_clock.h |  2 --
 arch/arm/kernel/sched_clock.c      | 18 ++++--------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/sched_clock.h b/arch/arm/include/asm/sched_clock.h
index 05b8e82..e3f7572 100644
--- a/arch/arm/include/asm/sched_clock.h
+++ b/arch/arm/include/asm/sched_clock.h
@@ -10,7 +10,5 @@
 
 extern void sched_clock_postinit(void);
 extern void setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate);
-extern void setup_sched_clock_needs_suspend(u32 (*read)(void), int bits,
-		unsigned long rate);
 
 #endif
diff --git a/arch/arm/kernel/sched_clock.c b/arch/arm/kernel/sched_clock.c
index e21bac2..fc6692e 100644
--- a/arch/arm/kernel/sched_clock.c
+++ b/arch/arm/kernel/sched_clock.c
@@ -107,13 +107,6 @@ static void sched_clock_poll(unsigned long wrap_ticks)
 	update_sched_clock();
 }
 
-void __init setup_sched_clock_needs_suspend(u32 (*read)(void), int bits,
-		unsigned long rate)
-{
-	setup_sched_clock(read, bits, rate);
-	cd.needs_suspend = true;
-}
-
 void __init setup_sched_clock(u32 (*read)(void), int bits, unsigned long rate)
 {
 	unsigned long r, w;
@@ -189,18 +182,15 @@ void __init sched_clock_postinit(void)
 static int sched_clock_suspend(void)
 {
 	sched_clock_poll(sched_clock_timer.data);
-	if (cd.needs_suspend)
-		cd.suspended = true;
+	cd.suspended = true;
 	return 0;
 }
 
 static void sched_clock_resume(void)
 {
-	if (cd.needs_suspend) {
-		cd.epoch_cyc = read_sched_clock();
-		cd.epoch_cyc_copy = cd.epoch_cyc;
-		cd.suspended = false;
-	}
+	cd.epoch_cyc = read_sched_clock();
+	cd.epoch_cyc_copy = cd.epoch_cyc;
+	cd.suspended = false;
 }
 
 static struct syscore_ops sched_clock_ops = {
-- 
1.8.0.rc0
