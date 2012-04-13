From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Fri, 13 Apr 2012 22:32:57 +0300
Message-ID: <CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48783 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab2DMTc6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 15:32:58 -0400
Received: by iagz16 with SMTP id z16so4639692iag.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 12:32:57 -0700 (PDT)
In-Reply-To: <87ehrtn6na.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Thu, Apr 12, 2012 at 3:19 AM, Kevin Hilman <khilman@ti.com> wrote:
> It would be helpful now to narrow down what are the big contributors =
to
> the overhead in omap_sram_idle(). =C2=A0Most of the code there is ski=
pped for
> C1 because the next states for MPU and CORE are both ON.

Ok I did some tests, all in mostly idle system with just init, busybox
shell and dd doing a NAND read to /dev/null . MB/s is throughput that
dd reports, mA and approx. current draw during the transfer, read from
fuel gauge that's onboard.

MB/s| mA|comment
 3.7|218|mainline f549e088b80
 3.8|224|nand qos PM_QOS_CPU_DMA_LATENCY 0 [1]
 4.4|220|[1] + pwrdm_p*_transition commented [2]
 3.8|225|[1] + omap34xx_do_sram_idle->cpu_do_idle [3]
 4.2|210|[1] + pwrdm_set_next_pwrst(per_pd, PWRDM_POWER_ON) [4]
 4.0|224|[1] + 'Deny idle' [5]
 5.1|210|[2] + [4] + [5]
 5.2|202|[5] + omap_sram_idle->cpu_do_idle [6]
 5.5|243|!CONFIG_PM
 6.1|282|busywait DMA end (for reference)

> There are 2 primary differences that I see as possible causes. =C2=A0=
I list
> them here with a couple more experiments for you to try to help us
> narrow this down.
>
> 1) powerdomain accounting: pwrdm_pre_transition(), pwrdm_post_transit=
ion()
>
> Could you try using omap_sram_idle() and just commenting out those
> calls? =C2=A0Does that help performance? =C2=A0Those iterate over all=
 the
> powerdomains, so defintely add some overhead, but I don't think it
> would be as significant as what you're seeing.

Seems to be taking good part of it.

> =C2=A0 =C2=A0Much more likely is...
>
> 2) jump to SRAM, SDRC self-refresh, SDRC errata workarounds

Could not notice any difference.

To me it looks like this results from many small things adding up..
Idle is called so often that pwrdm_p*_transition() and those
pwrdm_for_each_clkdm() walks start slowing everything down, perhaps
because they access lots of registers on slow buses? Maybe some
register cache would help us there, or are those registers expected to
be changed by hardware often?
Also trying to idle PER while transfer is ongoing (as reported in
previous mail) doesn't sound like a good idea and is one of the
reasons for slowdown. Seems to also causing more current drain,
ironically.


changes (again, sorry for corrupted diffs, but they should be easy to
reproduce):
[2]:
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -307,7 +307,7 @@ void omap_sram_idle(void)
                        omap3_enable_io_chain();
        }

-       pwrdm_pre_transition();
+//     pwrdm_pre_transition();

        /* PER */
        if (per_next_state < PWRDM_POWER_ON) {
@@ -372,7 +373,7 @@ void omap_sram_idle(void)
        }
        omap3_intc_resume_idle();

-       pwrdm_post_transition();
+//     pwrdm_post_transition();

        /* PER */
        if (per_next_state < PWRDM_POWER_ON) {
[3]:
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -347,7 +347,7 @@ void omap_sram_idle(void)
        if (save_state =3D=3D 1 || save_state =3D=3D 3)
                cpu_suspend(save_state, omap34xx_do_sram_idle);
        else
-               omap34xx_do_sram_idle(save_state);
+               cpu_do_idle();

        /* Restore normal SDRC POWER settings */
        if (cpu_is_omap3430() && omap_rev() >=3D OMAP3430_REV_ES3_0 &&
[4]:
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -107,6 +107,7 @@ static int __omap3_enter_idle(struct cpuidle_device=
 *dev,
        if (index =3D=3D 0) {
                pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
                pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
+               pwrdm_set_next_pwrst(per_pd, PWRDM_POWER_ON);
        }

        /*
[5]:
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -105,8 +105,7 @@ static int __omap3_enter_idle(struct cpuidle_device=
 *dev,

        /* Deny idle for C1 */
        if (index =3D=3D 0) {
-               pwrdm_for_each_clkdm(mpu_pd, _cpuidle_deny_idle);
-               pwrdm_for_each_clkdm(core_pd, _cpuidle_deny_idle);
+               clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
        }

        /*
@@ -128,8 +128,7 @@ static int __omap3_enter_idle(struct cpuidle_device=
 *dev,

        /* Re-allow idle for C1 */
        if (index =3D=3D 0) {
-               pwrdm_for_each_clkdm(mpu_pd, _cpuidle_allow_idle);
-               pwrdm_for_each_clkdm(core_pd, _cpuidle_allow_idle);
+               clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
        }

 return_sleep_time:
[6]:
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -117,7 +116,8 @@ static int __omap3_enter_idle(struct cpuidle_device=
 *dev,
                cpu_pm_enter();

        /* Execute ARM wfi */
-       omap_sram_idle();
+       //omap_sram_idle();
+       cpu_do_idle();

        /*
         * Call idle CPU PM enter notifier chain to restore


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
