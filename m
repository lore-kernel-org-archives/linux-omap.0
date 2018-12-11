From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3 v2] arm: versatile: Convert boot_lock to raw
Date: Tue, 11 Dec 2018 22:23:22 +0100
Message-ID: <20181211212322.co4ljpolo4bvgxe3@linutronix.de>
References: <20181207102749.15205-1-bigeasy@linutronix.de>
 <20181207102749.15205-2-bigeasy@linutronix.de>
 <20181207130012.GX6920@n2100.armlinux.org.uk>
 <CACRpkdbvyimBfCCBOEr84P+_y6+sBkqz0+nmFyYeOJ4cXjsA6A@mail.gmail.com>
 <20181209004138.GC9507@n2100.armlinux.org.uk>
 <20181210143718.plwd36vdxxd7q2el@linutronix.de>
 <CACRpkdby=Xreh0VPpHBPLhvupgQyEqDiae+e0u=-n3o2SWVMTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdby=Xreh0VPpHBPLhvupgQyEqDiae+e0u=-n3o2SWVMTw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: ext Tony Lindgren <tony@atomide.com>, viresh kumar <viresh.kumar@linaro.org>, David Brown <david.brown@linaro.org>, Xu Wei <xuwei5@hisilicon.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Viresh Kumar <vireshk@kernel.org>, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Kukjin Kim <kgene@kernel.org>, Andy Gross <andy.gross@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Linux-OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Barry Song <baohua@kernel.org>, Frank Rowand <frank.rowand@am.sony.com>, Patrice CHOTARD <patrice.chotard@st.com>, shiraz hashim <shiraz.linux.kernel@gmail.com>, Andreas
List-Id: linux-omap@vger.kernel.org

The arm boot_lock is used by the secondary processor startup code.  The locking
task is the idle thread, which has idle->sched_class == &idle_sched_class.
idle_sched_class->enqueue_task == NULL, so if the idle task blocks on the
lock, the attempt to wake it when the lock becomes available will fail:

try_to_wake_up()
   ...
      activate_task()
         enqueue_task()
            p->sched_class->enqueue_task(rq, p, flags)

Fix by converting boot_lock to a raw spin lock.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
Link: http://lkml.kernel.org/r/4E77B952.3010606@am.sony.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/plat-versatile/platsmp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-versatile/platsmp.c b/arch/arm/plat-versatile/platsmp.c
index c2366510187a8..6b60f582b738c 100644
--- a/arch/arm/plat-versatile/platsmp.c
+++ b/arch/arm/plat-versatile/platsmp.c
@@ -32,7 +32,7 @@ static void write_pen_release(int val)
 	sync_cache_w(&pen_release);
 }
 
-static DEFINE_SPINLOCK(boot_lock);
+static DEFINE_RAW_SPINLOCK(boot_lock);
 
 void versatile_secondary_init(unsigned int cpu)
 {
@@ -45,8 +45,8 @@ void versatile_secondary_init(unsigned int cpu)
 	/*
 	 * Synchronise with the boot thread.
 	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 }
 
 int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
@@ -57,7 +57,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * Set synchronisation state between this boot processor
 	 * and the secondary one
 	 */
-	spin_lock(&boot_lock);
+	raw_spin_lock(&boot_lock);
 
 	/*
 	 * This is really belt and braces; we hold unintended secondary
@@ -87,7 +87,7 @@ int versatile_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * now the secondary core is starting up let it run its
 	 * calibrations, then wait for it to finish
 	 */
-	spin_unlock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
 
 	return pen_release != -1 ? -ENOSYS : 0;
 }
-- 
2.20.0
