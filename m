From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Tue, 28 Mar 2017 10:09:44 -0700
Message-ID: <20170328170944.GY10760@atomide.com>
References: <20170314180555.23597-1-tony@atomide.com>
 <aa5d7ee3-2e54-2c6c-df5d-b5efff4b365e@ti.com>
 <20170327164308.GK10760@atomide.com>
 <20170328113657.GL23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170328113657.GL23750@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Keerthy <j-keerthy@ti.com>, "Andrew F. Davis" <afd@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170328 04:39]:
> On Mon, Mar 27, 2017 at 09:43:09AM -0700, Tony Lindgren wrote:
> > Yes problems still remains. I think the immediate fix there is to
> > disable kexec during runtime based on some criteria for your use
> > case rather than BUG() though. Somehow kexec needs to know if CPU1
> > reset is acceptable, then reset CPU1 before kexec.
> 
> The only acceptable way to do that is to make the decision when loading
> the image(s), and refuse to load the image(s) if kexec is not possible.
> (As is already done when dealing with whether we can CPU hot-unplug the
> secondary CPUs.)

OK so how about the following to disable kexec for Andrew's
test case?

That is assuming that omap_type() test works for HS dra7
like it does for the other omap2 variants.

Regards,

Tony

8< ---------------------
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -260,6 +260,7 @@ extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
 extern void omap_auxcoreboot_addr(u32 cpu_addr);
 extern u32 omap_read_auxcoreboot0(void);
 
+extern bool omap4_cpu_can_disable(unsigned int cpu);
 extern void omap4_cpu_die(unsigned int cpu);
 extern int omap4_cpu_kill(unsigned int cpu);
 
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -22,6 +22,15 @@
 #include "omap-wakeupgen.h"
 #include "common.h"
 #include "powerdomain.h"
+#include "soc.h"
+
+bool omap4_cpu_can_disable(unsigned int cpu)
+{
+	if (soc_is_dra7xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
+		return false;
+
+	return true;
+}
 
 /*
  * platform-specific code to shutdown a CPU
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -390,6 +390,7 @@ const struct smp_operations omap4_smp_ops __initconst = {
 	.smp_secondary_init	= omap4_secondary_init,
 	.smp_boot_secondary	= omap4_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
+	.cpu_can_disable	= omap4_cpu_can_disable,
 	.cpu_die		= omap4_cpu_die,
 	.cpu_kill		= omap4_cpu_kill,
 #endif
-- 
2.12.1
