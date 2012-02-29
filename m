From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH v6 3/9] ARM: exynos: Consolidate time keeping and irq enable
Date: Wed, 29 Feb 2012 12:11:04 +0530
Message-ID: <CAK44p224NL6+UuLKZ2vrP=CnBOARPBxj5f_+SNX_4j3RfBesEg@mail.gmail.com>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
	<1330485109-7327-4-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1330485109-7327-4-git-send-email-rob.lee@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: Robert Lee <rob.lee@linaro.org>
Cc: len.brown@intel.com, khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

I verified this patch on exynos4 based origen board.

Tested-by: Amit Daniel <amit.kachhap@linaro.org>

Thanks,
Amit D

On 29 February 2012 08:41, Robert Lee <rob.lee@linaro.org> wrote:
> Enable core cpuidle timekeeping and irq enabling and remove that
> handling from this code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> =A0arch/arm/mach-exynos/cpuidle.c | =A0 53 ++++----------------------=
-------------
> =A01 files changed, 6 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cp=
uidle.c
> index 9bf6743..75bb88b 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -20,6 +20,7 @@
> =A0#include <asm/smp_scu.h>
> =A0#include <asm/suspend.h>
> =A0#include <asm/unified.h>
> +#include <asm/cpuidle.h>
> =A0#include <mach/regs-pmu.h>
> =A0#include <mach/pmu.h>
>
> @@ -34,22 +35,12 @@
>
> =A0#define S5P_CHECK_AFTR =A0 =A0 =A0 =A0 0xFCBA0D10
>
> -static int exynos4_enter_idle(struct cpuidle_device *dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct cpuidle_driver *=
drv,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int index);
> =A0static int exynos4_enter_lowpower(struct cpuidle_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct=
 cpuidle_driver *drv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int in=
dex);
>
> =A0static struct cpuidle_state exynos4_cpuidle_set[] =3D {
> - =A0 =A0 =A0 [0] =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=3D exynos4_enter_idle,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =A0 =A0 =A0 =3D 1=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =A0 =A0 =A0 =3D 10000=
0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=3D CPUIDLE_FLAG_TIME_VALID,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D "C0",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D "ARM clock gating(WFI)",
> - =A0 =A0 =A0 },
> + =A0 =A0 =A0 [0] =3D CPUIDLE_ARM_WFI_STATE,
> =A0 =A0 =A0 =A0[1] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.enter =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0=3D exynos4_enter_lowpower,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.exit_latency =A0 =A0 =A0 =A0 =A0 =3D =
300,
> @@ -63,8 +54,9 @@ static struct cpuidle_state exynos4_cpuidle_set[] =3D=
 {
> =A0static DEFINE_PER_CPU(struct cpuidle_device, exynos4_cpuidle_devic=
e);
>
> =A0static struct cpuidle_driver exynos4_idle_driver =3D {
> - =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "exynos4_idle",
> - =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "exynos4_=
idle",
> + =A0 =A0 =A0 .owner =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D THIS_MODU=
LE,
> + =A0 =A0 =A0 .en_core_tk_irqen =A0 =A0 =A0 =3D 1,
> =A0};
>
> =A0/* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
> @@ -103,13 +95,8 @@ static int exynos4_enter_core0_aftr(struct cpuidl=
e_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct=
 cpuidle_driver *drv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int in=
dex)
> =A0{
> - =A0 =A0 =A0 struct timeval before, after;
> - =A0 =A0 =A0 int idle_time;
> =A0 =A0 =A0 =A0unsigned long tmp;
>
> - =A0 =A0 =A0 local_irq_disable();
> - =A0 =A0 =A0 do_gettimeofday(&before);
> -
> =A0 =A0 =A0 =A0exynos4_set_wakeupmask();
>
> =A0 =A0 =A0 =A0/* Set value of power down register for aftr mode */
> @@ -148,34 +135,6 @@ static int exynos4_enter_core0_aftr(struct cpuid=
le_device *dev,
> =A0 =A0 =A0 =A0/* Clear wakeup state register */
> =A0 =A0 =A0 =A0__raw_writel(0x0, S5P_WAKEUP_STAT);
>
> - =A0 =A0 =A0 do_gettimeofday(&after);
> -
> - =A0 =A0 =A0 local_irq_enable();
> - =A0 =A0 =A0 idle_time =3D (after.tv_sec - before.tv_sec) * USEC_PER=
_SEC +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (after.tv_usec - before.tv_usec=
);
> -
> - =A0 =A0 =A0 dev->last_residency =3D idle_time;
> - =A0 =A0 =A0 return index;
> -}
> -
> -static int exynos4_enter_idle(struct cpuidle_device *dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
cpuidle_driver *drv,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ind=
ex)
> -{
> - =A0 =A0 =A0 struct timeval before, after;
> - =A0 =A0 =A0 int idle_time;
> -
> - =A0 =A0 =A0 local_irq_disable();
> - =A0 =A0 =A0 do_gettimeofday(&before);
> -
> - =A0 =A0 =A0 cpu_do_idle();
> -
> - =A0 =A0 =A0 do_gettimeofday(&after);
> - =A0 =A0 =A0 local_irq_enable();
> - =A0 =A0 =A0 idle_time =3D (after.tv_sec - before.tv_sec) * USEC_PER=
_SEC +
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (after.tv_usec - before.tv_usec=
);
> -
> - =A0 =A0 =A0 dev->last_residency =3D idle_time;
> =A0 =A0 =A0 =A0return index;
> =A0}
>
> @@ -190,7 +149,7 @@ static int exynos4_enter_lowpower(struct cpuidle_=
device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_index =3D drv->safe_state_index;
>
> =A0 =A0 =A0 =A0if (new_index =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return exynos4_enter_idle(dev, drv, new=
_index);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return cpuidle_simple_enter(dev, drv, n=
ew_index);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return exynos4_enter_core0_aftr(dev, d=
rv, new_index);
> =A0}
> --
> 1.7.1
>
