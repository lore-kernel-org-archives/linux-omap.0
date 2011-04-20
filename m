From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [RFC PATCH V3 4/4] cpuidle: Single/Global registration
	of idle states
Date: Wed, 20 Apr 2011 10:33:25 -0700
Message-ID: <87k4eo6d5m.fsf@ti.com>
References: <20110420065445.332.13688.stgit@tringupt.in.ibm.com>
	<20110420065608.332.30043.stgit@tringupt.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110420065608.332.30043.stgit@tringupt.in.ibm.com> (Trinabh
	Gupta's message of "Wed, 20 Apr 2011 12:26:34 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Cc: venki@google.com, davinci-linux-open-source@linux.davincidsp.com, ak@linux.intel.com, len.brown@intel.com, peterz@infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
List-Id: linux-omap@vger.kernel.org

Trinabh Gupta <trinabh@linux.vnet.ibm.com> writes:

> With this patch there is single copy of cpuidle_states structure
> instead of per-cpu. The statistics needed on per-cpu basis
> by the governor are kept per-cpu. This simplifies the cpuidle
> subsystem as state registration is done by single cpu only.
> Having single copy of cpuidle_states saves memory. Rare case
> of asymmetric C-states can be handled within the cpuidle driverand
> architectures such as POWER do not have asymmetric C-states.

I haven't actually tested this series on OMAP yet, but it currently
doesn't compile.

The patch below (on top of your series) is required to compile on OMAP,
I think it's doing what you intended, but please confirm.

Kevin

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 6641574..ab77ba3 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -512,6 +512,7 @@ static int omap3_cpuidle_driver_init(void)
 	int i, retval, count = 0;
 	struct omap3_processor_cx *cx;
 	struct cpuidle_state *state;
+	struct cpuidle_driver *drv = &omap3_idle_driver;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
@@ -532,7 +533,7 @@ static int omap3_cpuidle_driver_init(void)
 		state->enter = (state->flags & CPUIDLE_FLAG_CHECK_BM) ?
 			omap3_enter_idle_bm : omap3_enter_idle;
 		if (cx->type == OMAP3_STATE_C1)
-			dev->safe_state_index = count;
+			drv->safe_state_index = count;
 		sprintf(state->name, "C%d", count+1);
 		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
 		count++;
