From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Fri, 13 Apr 2012 20:32:25 +0300
Message-ID: <CANOLnOPY55qgUuLoSVWQ5TN+oRaxbwqCnX7z-71QyTtGJvqtRg@mail.gmail.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53875 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab2DMRc1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 13:32:27 -0400
Received: by ghrr11 with SMTP id r11so1768524ghr.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Apr 2012 10:32:26 -0700 (PDT)
In-Reply-To: <87ehrtn6na.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Thu, Apr 12, 2012 at 3:19 AM, Kevin Hilman <khilman@ti.com> wrote:
> Grazvydas Ignotas <notasas@gmail.com> writes:
>
>> On Mon, Apr 9, 2012 at 10:03 PM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Grazvydas Ignotas <notasas@gmail.com> writes:
>>>> While SD card performance loss is not that bad (~7%), NAND one is
>>>> worrying (~39%). I've tried disabling/enabling CONFIG_CPU_IDLE, al=
so
>>>> cpuidle states over sysfs, it did not have any significant effect.=
 Is
>>>> there something else to try?
>>>
>>> Looks like we might need a PM QoS constraint when there is DMA acti=
vity
>>> in progress.
>>>
>>> You can try doing a pm_qos_add_request() for PM_QOS_CPU_DMA_LATENCY=
 when
>>> DMA transfers are active and I suspect that will help.
>>
>> I've tried it and it didn't help much. It looks like the only thing =
it
>> does is limiting cpuidle c-states, I tried to set qos dma latency to=
 0
>> and it made it stay in C1 while transfer was ongoing (I watched
>> /sys/devices/system/cpu/cpu0/cpuidle/state*/usage), but performance
>> was still poor.
>
> Great, thanks for doing this experiment.
>
> Assuming we get to a C1 that's low-latency enough, we will still need
> this constraint to ensure C1 during transfers. =C2=A0But first we hav=
e to
> figure out what's going on with C1...

I've been working on this to collect more data, and noticed that PER
is often being put to RET even at C1, is that expected? There is some
additional work being done in that case, like putting GPIOs to sleep,
and it seems to be source of part of performance loss here as it
happens often during NAND transfers.

This can be reproduced while doing mmc transfers too and detected with =
this:
(not a valid patch, sorry, sending through gmail web)

--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -87,6 +87,8 @@ static int _cpuidle_deny_idle(struct powerdomain *pwr=
dm,
        return 0;
 }

+int is_c1;
+
 static int __omap3_enter_idle(struct cpuidle_device *dev,
                                struct cpuidle_driver *drv,
                                int index)
@@ -117,6 +120,7 @@ static int __omap3_enter_idle(struct cpuidle_device=
 *dev,
                cpu_pm_enter();

        /* Execute ARM wfi */
+       is_c1 =3D (index =3D=3D 0);
        omap_sram_idle();

        /*
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index 703bd10..519ce9d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -275,6 +275,7 @@ void omap_sram_idle(void)
        int per_going_off;
        int core_prev_state, per_prev_state;
        u32 sdrc_pwr =3D 0;
+       extern int is_c1;

        mpu_next_state =3D pwrdm_read_next_pwrst(mpu_pwrdm);
        switch (mpu_next_state) {
@@ -299,6 +300,8 @@ void omap_sram_idle(void)
        /* Enable IO-PAD and IO-CHAIN wakeups */
        per_next_state =3D pwrdm_read_next_pwrst(per_pwrdm);
        core_next_state =3D pwrdm_read_next_pwrst(core_pwrdm);
+if (is_c1 && (per_next_state !=3D PWRDM_POWER_ON || core_next_state !=3D
PWRDM_POWER_ON))
+ printk(KERN_ERR "c1 core %d, per %d\n", per_next_state, core_next_sta=
te);
        if (omap3_has_io_wakeup() &&
            (per_next_state < PWRDM_POWER_ON ||
             core_next_state < PWRDM_POWER_ON)) {


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
