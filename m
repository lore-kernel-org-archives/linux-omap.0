From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH/RFT 0/3] ARM: OMAP: PM: reduce overhead of pwrdm pre/post transitions
Date: Wed, 25 Apr 2012 18:54:25 +0530
Message-ID: <CAMQu2gxExpmtOUtr=-yy0wyU7sZqyTQY=oiwS0AZM+iWgTnQRA@mail.gmail.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:49516 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752243Ab2DYNYr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Apr 2012 09:24:47 -0400
Received: by qcro28 with SMTP id o28so61692qcr.5
        for <linux-omap@vger.kernel.org>; Wed, 25 Apr 2012 06:24:45 -0700 (PDT)
In-Reply-To: <1335277420-29124-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>

On Tue, Apr 24, 2012 at 7:53 PM, Kevin Hilman <khilman@ti.com> wrote:
> Here's a first pass attempt to reduce the overhead of the pre/post
> transitions by allowing them to be called per powerdomain and making
> them conditional on powerdomain transtions.
>
> This can be used for testing/measurements to see the reduction the
> latencies involved in entering/exiting idle with and without these
> patches.
>
> Kevin Hilman (3):
> =A0ARM: OMAP2+: powerdomain: allow pre/post transtion to be per pwrdm
> =A0ARM: OMAP3: PM: call pre/post transition per powerdomain
> =A0ARM: OMAP3: PM: cleanup cam_pwrdm leftovers
>
I have reviewed and tested this series on OMAP4 with coupleidle and sys=
tem
wide supsned. It continues to work as expected. I have done an addition=
al
patch(end of email)  as mentioned to take advantage of per powerdomain
pre/post transition API update.

Thanks for the series. it certainly removes the big over-head we had be=
fore
with the pre-post APIs.

=46WIW,
Reviewed-tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh

=46rom e535b0d8948ed44732c6128ff4236cfe32d2f40a Mon Sep 17 00:00:00 200=
1
=46rom: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 25 Apr 2012 17:04:08 +0530
Subject: [PATCH] ARM: OMAP4: PM: call pre/post transition per powerdoma=
in

Iteration over all power domains in the idle path is unnecessary since
only power domains that are transitioning need to be accounted for.

Update OMAP4 low power code accordingly.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
There is one issue though about MPUSS powerdomain accounting. It will
get called on both CPUs and might result in duplicate pm debug counter
update. There is no functional issue with that as such but needs to
be cleaned up.

Will address that issue in a seperate series.

 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   22 ++++++++++++++++++++-=
-
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index e35a86b..3a709b2 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -117,6 +117,20 @@ static inline void clear_cpu_prev_pwrst(unsigned
int cpu_id)
 }

 /*
+ * CPU powerdomain pre/post transition.
+ */
+static inline void cpu_pwrdm_pre_post_transition(unsigned int cpu_id,
+				bool pre_transition)
+{
+	struct omap4_cpu_pm_info *pm_info =3D &per_cpu(omap4_pm_info, cpu_id)=
;
+
+	if (pre_transition)
+		pwrdm_pre_transition(pm_info->pwrdm);
+	else
+		pwrdm_post_transition(pm_info->pwrdm);
+}
+
+/*
  * Store the SCU power status value to scratchpad memory
  */
 static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_st=
ate)
@@ -255,7 +269,7 @@ int omap4_enter_lowpower(unsigned int cpu,
unsigned int power_state)
 		return -ENXIO;
 	}

-	pwrdm_pre_transition(NULL);
+	pwrdm_pre_transition(mpuss_pd);

 	/*
 	 * Check MPUSS next state and save interrupt controller if needed.
@@ -266,6 +280,7 @@ int omap4_enter_lowpower(unsigned int cpu,
unsigned int power_state)
 		(pwrdm_read_logic_retst(mpuss_pd) =3D=3D PWRDM_POWER_OFF))
 		save_state =3D 2;

+	cpu_pwrdm_pre_post_transition(cpu, 1);
 	cpu_clear_prev_logic_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
 	set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
@@ -285,9 +300,10 @@ int omap4_enter_lowpower(unsigned int cpu,
unsigned int power_state)
 	 * domain transition
 	 */
 	wakeup_cpu =3D smp_processor_id();
+	cpu_pwrdm_pre_post_transition(wakeup_cpu, 0);
 	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);

-	pwrdm_post_transition(NULL);
+	pwrdm_post_transition(mpuss_pd);

 	return 0;
 }
@@ -307,6 +323,7 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu,
unsigned int power_state)
 	if (power_state =3D=3D PWRDM_POWER_OFF)
 		cpu_state =3D 1;

+	cpu_pwrdm_pre_post_transition(cpu, 1);
 	clear_cpu_prev_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
 	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_secondary_startup));
@@ -319,6 +336,7 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu,
unsigned int power_state)
 	 */
 	omap4_finish_suspend(cpu_state);

+	cpu_pwrdm_pre_post_transition(wakeup_cpu, 0);
 	set_cpu_next_pwrst(cpu, PWRDM_POWER_ON);
 	return 0;
 }
--=20
1.7.5.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
