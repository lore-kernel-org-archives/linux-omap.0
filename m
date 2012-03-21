From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v8 4/8] ARM: davinci: Consolidate time keeping and irq enable
Date: Wed, 21 Mar 2012 16:36:29 +0200
Message-ID: <CAP245DW9SdTYNc8XXwiuHzo5Y-aZrLc2qP0MekKkyAT2TosjbQ@mail.gmail.com>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
	<1332274969-15782-5-git-send-email-rob.lee@linaro.org>
	<CAMXH7KH5kS=wPFdC8QrtnhE6_sZqmsJ8h=6Gs3kfHOTbeHjacA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47087 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030891Ab2CUOgd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 10:36:33 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so992416wej.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 07:36:32 -0700 (PDT)
In-Reply-To: <CAMXH7KH5kS=wPFdC8QrtnhE6_sZqmsJ8h=6Gs3kfHOTbeHjacA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Lee <rob.lee@linaro.org>
Cc: len.brown@intel.com, "Nori, Sekhar" <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, akpm@linux-foundation.org, rjw@sisk.pl, robherring2@gmail.com, Baohua.Song@csr.com, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

Rob, you should start a new '3.4-fixes' branch containing such
bugfixes that can be pushed to Len after -rc1.

On Wed, Mar 21, 2012 at 4:28 PM, Rob Lee <rob.lee@linaro.org> wrote:
> Sekhar tested this patch on Davinci last night and found a problem. =A0=
I
> looked at the code again and found a mindless omission on my part (se=
e
> below). =A0Fix is trivial. =A0I've check all other platforms and conf=
irmed
> this problem does not exist for those. =A0Will resend a v9 of the
> patchset shortly.
>
> On Tue, Mar 20, 2012 at 3:22 PM, Robert Lee <rob.lee@linaro.org> wrot=
e:
>> Enable core cpuidle timekeeping and irq enabling and remove that
>> handling from this code.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>> Reviewed-by: Kevin Hilman <khilman@ti.com>
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Acked-by: Jean Pihet<j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-davinci/cpuidle.c | =A0 82 ++++++++++++++++--------=
---------------
>> =A01 file changed, 33 insertions(+), 49 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci=
/cpuidle.c
>> index a30c7c5..93ae096 100644
>> --- a/arch/arm/mach-davinci/cpuidle.c
>> +++ b/arch/arm/mach-davinci/cpuidle.c
>> @@ -18,6 +18,7 @@
>> =A0#include <linux/io.h>
>> =A0#include <linux/export.h>
>> =A0#include <asm/proc-fns.h>
>> +#include <asm/cpuidle.h>
>>
>> =A0#include <mach/cpuidle.h>
>> =A0#include <mach/ddr2.h>
>> @@ -30,12 +31,42 @@ struct davinci_ops {
>> =A0 =A0 =A0 =A0u32 flags;
>> =A0};
>>
>> +/* Actual code that puts the SoC in different idle states */
>> +static int davinci_enter_idle(struct cpuidle_device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 cpuidle_driver *drv,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 int index)
>> +{
>> + =A0 =A0 =A0 struct cpuidle_state_usage *state_usage =3D &dev->stat=
es_usage[index];
>> + =A0 =A0 =A0 struct davinci_ops *ops =3D cpuidle_get_statedata(stat=
e_usage);
>> +
>> + =A0 =A0 =A0 if (ops && ops->enter)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ops->enter(ops->flags);
>> +
>> + =A0 =A0 =A0 index =3D cpuidle_wrap_enter(dev, drv, index,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arm_cp=
uidle_simple_enter);
>> +
>> + =A0 =A0 =A0 if (ops && ops->exit)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ops->exit(ops->flags);
>> +
>> + =A0 =A0 =A0 return index;
>> +}
>> +
>> =A0/* fields in davinci_ops.flags */
>> =A0#define DAVINCI_CPUIDLE_FLAGS_DDR2_PWDN =A0 =A0 =A0 =A0BIT(0)
>>
>> =A0static struct cpuidle_driver davinci_idle_driver =3D {
>> - =A0 =A0 =A0 .name =A0 =3D "cpuidle-davinci",
>> - =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
>> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "cpuidle-davinci",
>> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
>
> Argh! I am missing the ".en_core_tk_irqen =3D 1" here.
>
>
>> + =A0 =A0 =A0 .states[0] =A0 =A0 =A0=3D ARM_CPUIDLE_WFI_STATE,
>> + =A0 =A0 =A0 .states[1] =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=3D davinci_enter_idle,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =A0 =A0 =A0 =3D =
10,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =A0 =A0 =A0 =3D 1000=
00,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=3D CPUIDLE_FLAG_TIME_VALID,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =3D "DDR SR",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =3D "WFI and DDR Self Refresh",
>> + =A0 =A0 =A0 },
>> + =A0 =A0 =A0 .state_count =3D DAVINCI_CPUIDLE_MAX_STATES,
>> =A0};
>>
>> =A0static DEFINE_PER_CPU(struct cpuidle_device, davinci_cpuidle_devi=
ce);
>> @@ -77,41 +108,10 @@ static struct davinci_ops davinci_states[DAVINC=
I_CPUIDLE_MAX_STATES] =3D {
>> =A0 =A0 =A0 =A0},
>> =A0};
>>
>> -/* Actual code that puts the SoC in different idle states */
>> -static int davinci_enter_idle(struct cpuidle_device *dev,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 cpuidle_driver *drv,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 int index)
>> -{
>> - =A0 =A0 =A0 struct cpuidle_state_usage *state_usage =3D &dev->stat=
es_usage[index];
>> - =A0 =A0 =A0 struct davinci_ops *ops =3D cpuidle_get_statedata(stat=
e_usage);
>> - =A0 =A0 =A0 struct timeval before, after;
>> - =A0 =A0 =A0 int idle_time;
>> -
>> - =A0 =A0 =A0 local_irq_disable();
>> - =A0 =A0 =A0 do_gettimeofday(&before);
>> -
>> - =A0 =A0 =A0 if (ops && ops->enter)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ops->enter(ops->flags);
>> - =A0 =A0 =A0 /* Wait for interrupt state */
>> - =A0 =A0 =A0 cpu_do_idle();
>> - =A0 =A0 =A0 if (ops && ops->exit)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ops->exit(ops->flags);
>> -
>> - =A0 =A0 =A0 do_gettimeofday(&after);
>> - =A0 =A0 =A0 local_irq_enable();
>> - =A0 =A0 =A0 idle_time =3D (after.tv_sec - before.tv_sec) * USEC_PE=
R_SEC +
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (after.tv_usec - befor=
e.tv_usec);
>> -
>> - =A0 =A0 =A0 dev->last_residency =3D idle_time;
>> -
>> - =A0 =A0 =A0 return index;
>> -}
>> -
>> =A0static int __init davinci_cpuidle_probe(struct platform_device *p=
dev)
>> =A0{
>> =A0 =A0 =A0 =A0int ret;
>> =A0 =A0 =A0 =A0struct cpuidle_device *device;
>> - =A0 =A0 =A0 struct cpuidle_driver *driver =3D &davinci_idle_driver=
;
>> =A0 =A0 =A0 =A0struct davinci_cpuidle_config *pdata =3D pdev->dev.pl=
atform_data;
>>
>> =A0 =A0 =A0 =A0device =3D &per_cpu(davinci_cpuidle_device, smp_proce=
ssor_id());
>> @@ -123,27 +123,11 @@ static int __init davinci_cpuidle_probe(struct=
 platform_device *pdev)
>>
>> =A0 =A0 =A0 =A0ddr2_reg_base =3D pdata->ddr2_ctlr_base;
>>
>> - =A0 =A0 =A0 /* Wait for interrupt state */
>> - =A0 =A0 =A0 driver->states[0].enter =3D davinci_enter_idle;
>> - =A0 =A0 =A0 driver->states[0].exit_latency =3D 1;
>> - =A0 =A0 =A0 driver->states[0].target_residency =3D 10000;
>> - =A0 =A0 =A0 driver->states[0].flags =3D CPUIDLE_FLAG_TIME_VALID;
>> - =A0 =A0 =A0 strcpy(driver->states[0].name, "WFI");
>> - =A0 =A0 =A0 strcpy(driver->states[0].desc, "Wait for interrupt");
>> -
>> - =A0 =A0 =A0 /* Wait for interrupt and DDR self refresh state */
>> - =A0 =A0 =A0 driver->states[1].enter =3D davinci_enter_idle;
>> - =A0 =A0 =A0 driver->states[1].exit_latency =3D 10;
>> - =A0 =A0 =A0 driver->states[1].target_residency =3D 10000;
>> - =A0 =A0 =A0 driver->states[1].flags =3D CPUIDLE_FLAG_TIME_VALID;
>> - =A0 =A0 =A0 strcpy(driver->states[1].name, "DDR SR");
>> - =A0 =A0 =A0 strcpy(driver->states[1].desc, "WFI and DDR Self Refre=
sh");
>> =A0 =A0 =A0 =A0if (pdata->ddr2_pdown)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0davinci_states[1].flags |=3D DAVINCI_=
CPUIDLE_FLAGS_DDR2_PWDN;
>> =A0 =A0 =A0 =A0cpuidle_set_statedata(&device->states_usage[1], &davi=
nci_states[1]);
>>
>> =A0 =A0 =A0 =A0device->state_count =3D DAVINCI_CPUIDLE_MAX_STATES;
>> - =A0 =A0 =A0 driver->state_count =3D DAVINCI_CPUIDLE_MAX_STATES;
>>
>> =A0 =A0 =A0 =A0ret =3D cpuidle_register_driver(&davinci_idle_driver)=
;
>> =A0 =A0 =A0 =A0if (ret) {
>> --
>> 1.7.9.4
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
