From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH] Fix CPU spinlock lockups on secondary CPU bringup
Date: Wed, 22 Jun 2011 11:55:50 +0100
Message-ID: <20110622105550.GQ23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

Secondary CPU bringup typically calls calibrate_delay() during its
initialization.  However, calibrate_delay() modifies a global variable
(loops_per_jiffy) used for udelay() and __delay().

A side effect of 71c696b1 (calibrate: extract fall-back calculation
into own helper) introduced in the 2.6.39 merge window means that we
end up with a substantial period where loops_per_jiffy is zero.  This
causes the spinlock debugging code to malfunction:

	u64 loops = loops_per_jiffy * HZ;
	for (;;) {
		for (i = 0; i < loops; i++) {
			if (arch_spin_trylock(&lock->raw_lock))
				return;
			__delay(1);
		}
		...
	}

by never calling arch_spin_trylock() - resulting in the CPU locking
up in an infinite loop inside __spin_lock_debug().

Work around this by only writing to loops_per_jiffy only once we have
completed all the calibration decisions.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: <stable@kernel.org> (2.6.39-stable)

--
Better solutions (such as omitting the calibration for secondary CPUs,
or arranging for calibrate_delay() to return the LPJ value and leave
it to the caller to decide where to store it) are a possibility, but
would be much more invasive into each architecture.

I think this is the best solution for -rc and stable, but it should be
revisited for the next merge window.

 init/calibrate.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/init/calibrate.c b/init/calibrate.c
index 2568d22..aae2f40 100644
--- a/init/calibrate.c
+++ b/init/calibrate.c
@@ -245,30 +245,32 @@ static unsigned long __cpuinit calibrate_delay_converge(void)
 
 void __cpuinit calibrate_delay(void)
 {
+	unsigned long lpj;
 	static bool printed;
 
 	if (preset_lpj) {
-		loops_per_jiffy = preset_lpj;
+		lpj = preset_lpj;
 		if (!printed)
 			pr_info("Calibrating delay loop (skipped) "
 				"preset value.. ");
 	} else if ((!printed) && lpj_fine) {
-		loops_per_jiffy = lpj_fine;
+		lpj = lpj_fine;
 		pr_info("Calibrating delay loop (skipped), "
 			"value calculated using timer frequency.. ");
-	} else if ((loops_per_jiffy = calibrate_delay_direct()) != 0) {
+	} else if ((lpj = calibrate_delay_direct()) != 0) {
 		if (!printed)
 			pr_info("Calibrating delay using timer "
 				"specific routine.. ");
 	} else {
 		if (!printed)
 			pr_info("Calibrating delay loop... ");
-		loops_per_jiffy = calibrate_delay_converge();
+		lpj = calibrate_delay_converge();
 	}
 	if (!printed)
 		pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
-			loops_per_jiffy/(500000/HZ),
-			(loops_per_jiffy/(5000/HZ)) % 100, loops_per_jiffy);
+			lpj/(500000/HZ),
+			(lpj/(5000/HZ)) % 100, lpj);
 
+	loops_per_jiffy = lpj;
 	printed = true;
 }
