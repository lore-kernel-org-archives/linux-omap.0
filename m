From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Fri, 25 Jan 2019 21:03:57 +0000
Message-ID: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
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
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

Executing loops such as:

	while (1)
		cpu_relax();

with interrupts disabled results in a livelock of the entire system,
as other CPUs are prevented making progress.  This is most noticable
as a failure of crashdump kexec, which stops just after issuing:

	Loading crashdump kernel...

to the system console.  A workaround for this is to use 10 nops in
cpu_relax().

We also use wfe() in while (1) loops to avoid burning cycles in a
tight loop, giving the CPU a hint that we're not doing anything
useful.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
It's been a while since this was posted, Will's suggestion was to use
10 nops in cpu_relax() last time around.  I still prefer wfe() in
these infinite-not-doing-anything-ever loops.

 arch/arm/include/asm/barrier.h   | 2 ++
 arch/arm/include/asm/processor.h | 6 +++++-
 arch/arm/kernel/machine_kexec.c  | 5 ++++-
 arch/arm/kernel/smp.c            | 4 +++-
 arch/arm/mach-omap2/prm_common.c | 4 +++-
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 69772e742a0a..83ae97c049d9 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -11,6 +11,8 @@
 #define sev()	__asm__ __volatile__ ("sev" : : : "memory")
 #define wfe()	__asm__ __volatile__ ("wfe" : : : "memory")
 #define wfi()	__asm__ __volatile__ ("wfi" : : : "memory")
+#else
+#define wfe()	do { } while (0)
 #endif
 
 #if __LINUX_ARM_ARCH__ >= 7
diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 120f4c9bbfde..57fe73ea0f72 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -89,7 +89,11 @@ extern void release_thread(struct task_struct *);
 unsigned long get_wchan(struct task_struct *p);
 
 #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
-#define cpu_relax()			smp_mb()
+#define cpu_relax()						\
+	do {							\
+		smp_mb();					\
+		__asm__ __volatile__("nop; nop; nop; nop; nop; nop; nop; nop; nop; nop;");	\
+	} while (0)
 #else
 #define cpu_relax()			barrier()
 #endif
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index dd2eb5f76b9f..76300f3813e8 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -91,8 +91,11 @@ void machine_crash_nonpanic_core(void *unused)
 
 	set_cpu_online(smp_processor_id(), false);
 	atomic_dec(&waiting_for_crash_ipi);
-	while (1)
+
+	while (1) {
 		cpu_relax();
+		wfe();
+	}
 }
 
 void crash_smp_send_stop(void)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index ebac63fe458b..4e785d025771 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -595,8 +595,10 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_fiq_disable();
 	local_irq_disable();
 
-	while (1)
+	while (1) {
 		cpu_relax();
+		wfe();
+	}
 }
 
 static DEFINE_PER_CPU(struct completion *, cpu_completion);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 058a37e6d11c..fd6e0671f957 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -523,8 +523,10 @@ void omap_prm_reset_system(void)
 
 	prm_ll_data->reset_system();
 
-	while (1)
+	while (1) {
 		cpu_relax();
+		wfe();
+	}
 }
 
 /**
-- 
2.7.4
