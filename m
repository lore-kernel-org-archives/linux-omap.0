From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Tue, 13 Mar 2012 16:52:49 -0700
Message-ID: <8762e8kqi6.fsf@ti.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <4F1929E9.7070707@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F1929E9.7070707@linaro.org> (Daniel Lezcano's message of "Fri,
 20 Jan 2012 09:46:33 +0100")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Colin Cross <ccross@android.com>
Cc: Len Brown <len.brown@intel.com>, Trinabh Gupta <g.trinabh@gmail.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-tegra@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Colin,

On 12/21/2011 01:09 AM, Colin Cross wrote:

> To use coupled cpuidle states, a cpuidle driver must:

[...]

>     Provide a struct cpuidle_state.enter function for each state
>     that affects multiple cpus.  This function is guaranteed to be
>     called on all cpus at approximately the same time.  The driver
>     should ensure that the cpus all abort together if any cpu tries
>     to abort once the function is called.

I've discoved the last sentence above is crucial, and in order to catch
all the corner cases I found it useful to have the struct
cpuidle_coupled in cpuidle.h so that the driver can check ready_count
itself (patch below, on top of $SUBJECT series.)

As you know, on OMAP4, when entering the coupled state, CPU0 has to wait
for CPU1 to enter its low power state before entering itself.  The first
pass at implementing this was to just spin waiting for the powerdomain
of CPU1 to hit off.  That works... most of the time.

If CPU1 wakes up immediately (or before CPU0 starts checking), or more
likely, fails to hit the low-power state because of other hardware
"conditions", CPU0 will end up stuck in the loop waiting for CPU1.

To solve this, in addition to checking the power state of CPU1, I also 
check if (coupled->ready_count != cpumask_weight(&coupled->alive_coupled_cpus)).
If true, it means that CPU1 has already exited/aborted so CPU0 had
better abort as well.

Checking the ready_count seemed like an easy way to do this, but did you
have any other mechanisms in mind for CPUs to communicate that they've
exited/aborted?

Kevin


diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index bf34d67..16e00cc 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -32,15 +32,6 @@ extern void cpuidle_remove_state_sysfs(struct cpuidle_device *device);
 extern int cpuidle_add_sysfs(struct device *dev);
 extern void cpuidle_remove_sysfs(struct device *dev);
 
-/* coupled states */
-struct cpuidle_coupled {
-	spinlock_t lock;
-	int requested_state[NR_CPUS];
-	int ready_count;
-	cpumask_t alive_coupled_cpus;
-	int refcnt;
-};
-
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
 bool cpuidle_state_is_coupled(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int state);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 71f2fba..dbc1f2e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -51,6 +51,15 @@ struct cpuidle_state {
 			int index);
 };
 
+/* coupled states */
+struct cpuidle_coupled {
+	spinlock_t lock;
+	int requested_state[NR_CPUS];
+	int ready_count;
+	cpumask_t alive_coupled_cpus;
+	int refcnt;
+};
+
 /* Idle State Flags */
 #define CPUIDLE_FLAG_TIME_VALID	(0x01) /* is residency time measurable? */
 #define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
