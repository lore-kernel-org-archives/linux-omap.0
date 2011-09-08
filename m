From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 14/25] OMAP4: PM: Add CPUX OFF mode support
Date: Thu, 8 Sep 2011 21:39:28 +0200
Message-ID: <CAORVsuUXtiitSTMB0MTJPobppqKymmYFsDpsOqALP8UV7Pm+dQ@mail.gmail.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315144466-9395-15-git-send-email-santosh.shilimkar@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: khilman@ti.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, rnayak@ti.com
List-Id: linux-omap@vger.kernel.org

On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> This patch adds the CPU0 and CPU1 off mode support. CPUX close switch
> retention (CSWR) is not supported by hardware design.
>
> The CPUx OFF mode isn't supported on OMAP4430 ES1.0
>
> CPUx sleep code is common for hotplug, suspend and CPUilde.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A03 +-
> =A0arch/arm/mach-omap2/include/mach/omap-secure.h =A0| =A0 =A08 +
> =A0arch/arm/mach-omap2/include/mach/omap4-common.h | =A0 25 +++
> =A0arch/arm/mach-omap2/omap-mpuss-lowpower.c =A0 =A0 =A0 | =A0249 +++++++=
++++++++++++++++
> =A0arch/arm/mach-omap2/omap-smp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A06 +
> =A0arch/arm/mach-omap2/omap4-sar-layout.h =A0 =A0 =A0 =A0 =A0| =A0 =A09 +
> =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A06 +
> =A0arch/arm/mach-omap2/sleep44xx.S =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A02=
13 +++++++++++++++++++
> =A08 files changed, 518 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/omap-mpuss-lowpower.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index b032c21..b4f2eeb 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -63,7 +63,8 @@ obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D pm24xx.o
> =A0obj-$(CONFIG_ARCH_OMAP2) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D sleep24xx.o
> =A0obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm34xx.o sle=
ep34xx.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 cpuidle34xx.o
> -obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm44xx.o sleep=
44xx.o
> +obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm44xx.o sleep=
44xx.o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0omap-mpuss-lowpower.o
> =A0obj-$(CONFIG_PM_DEBUG) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pm-debug.o
> =A0obj-$(CONFIG_OMAP_SMARTREFLEX) =A0 =A0 =A0 =A0 =A0+=3D sr_device.o sma=
rtreflex.o
> =A0obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3) =A0+=3D smartreflex-class3.o
> diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h b/arch/arm/ma=
ch-omap2/include/mach/omap-secure.h
> index e2f95a0..0062d49 100644
> --- a/arch/arm/mach-omap2/include/mach/omap-secure.h
> +++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
> @@ -35,10 +35,18 @@
> =A0#define OMAP4_HAL_SAVEALL_INDEX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1c
> =A0#define OMAP4_HAL_SAVEGIC_INDEX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1d
>
> +/* Secure Monitor mode APIs */
> +#define OMAP4_MON_SCU_PWR_INDEX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x108
> +
> +/* Secure PPA(Primary Protected Application) APIs */
> +#define OMAP4_PPA_CPU_ACTRL_SMP_INDEX =A00x25
> +
> +#ifndef __ASSEMBLER__
> =A0extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 arg1, =
u32 arg2, u32 arg3, u32 arg4);
> =A0extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
> =A0extern phys_addr_t omap_secure_ram_mempool_base(void);
> =A0extern int omap_secure_ram_reserve_memblock(void);
>
> +#endif /* __ASSEMBLER__ */
> =A0#endif /* OMAP_ARCH_OMAP_SECURE_H */
> diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/m=
ach-omap2/include/mach/omap4-common.h
> index 040dcf6..662f37c 100644
> --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
> +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
> @@ -45,5 +45,30 @@ extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 =
clear_mask);
> =A0extern void omap_auxcoreboot_addr(u32 cpu_addr);
> =A0extern u32 omap_read_auxcoreboot0(void);
> =A0#endif
> +
> +#if defined(CONFIG_SMP) && defined(CONFIG_PM)
> +extern int omap4_mpuss_init(void);
> +extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_sta=
te);
> +extern int omap4_finish_suspend(unsigned long cpu_state);
> +extern void omap4_cpu_resume(void);
> +#else
> +static inline int omap4_enter_lowpower(unsigned int cpu,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned int power_state)
> +{
> + =A0 =A0 =A0 omap_do_wfi();
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static inline int omap4_mpuss_init(void)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static inline int omap4_finish_suspend(unsigned long cpu_state)
> +{}
The int function should return something (0?)
Has the code been test compiled without SMP and/or PM?

> +static inline void omap4_cpu_resume(void)
> +{}
> +#endif
> +
> =A0#endif /* __ASSEMBLER__ */
> =A0#endif /* OMAP_ARCH_OMAP4_COMMON_H */
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-om=
ap2/omap-mpuss-lowpower.c
...

> +/**
> + * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
> + * The purpose of this function is to manage low power programming
> + * of OMAP4 MPUSS subsystem
> + * @cpu : CPU ID
> + * @power_state: Low power state.
> + */
> +int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
> +{
> + =A0 =A0 =A0 unsigned int save_state =3D 0;
> + =A0 =A0 =A0 unsigned int wakeup_cpu;
> +
> + =A0 =A0 =A0 if (omap_rev() =3D=3D OMAP4430_REV_ES1_0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
> +
> + =A0 =A0 =A0 switch (power_state) {
> + =A0 =A0 =A0 case PWRDM_POWER_ON:
> + =A0 =A0 =A0 case PWRDM_POWER_INACTIVE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_state =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_POWER_OFF:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_state =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_POWER_RET:
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* CPUx CSWR is invalid hardware state. A=
lso CPUx OSWR
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* doesn't make much scense, since logic =
is lost and $L1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* needs to be cleaned because of coheren=
cy. This makes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* CPUx OSWR equivalent to CPUX OFF and h=
ence not supported
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENXIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clear_cpu_prev_pwrst(cpu);
> + =A0 =A0 =A0 set_cpu_next_pwrst(cpu, power_state);
> + =A0 =A0 =A0 set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
> + =A0 =A0 =A0 scu_pwrst_prepare(cpu, power_state);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Call low level function =A0with targeted CPU id
> + =A0 =A0 =A0 =A0* and its low power state.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 cpu_suspend(save_state, omap4_finish_suspend);
There is no CPU id parameter to the call although the above comment says so.

...

> diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep4=
4xx.S
...

> +/*
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> + * =3D=3D CPU suspend finisher =3D=3D
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> + *
> + * void omap4_finish_suspend(unsigned long cpu_state)
> + *
> + * This function code saves the CPU context and performs the CPU
> + * power down sequence. Calling WFI effectively changes the CPU
> + * power domains states to the desired target power state.
> + *
> + * @cpu_state : contains context save state (r0)
> + * =A0 =A0 0 - No context lost
> + * =A0 =A0 1 - CPUx L1 and logic lost: MPUSS CSWR
> + * =A0 =A0 2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
> + * =A0 =A0 3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
> + * @return: This function never returns for CPU OFF and DORMANT power st=
ates.
> + * Post WFI, CPU transitions to DORMANT or OFF power state and on wake-up
> + * from this follows a full CPU reset path via ROM code to CPU restore c=
ode.
Is the ROM code jumping to the physical address of omap4_cpu_resume?
If so please add it in the comment.

...

> +/*
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> + * =3D=3D CPU resume entry point =3D=3D
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> + *
> + * void omap4_cpu_resume(void)
> + *
> + * ROM code jumps to this function while waking up from CPU
> + * OFF or DORMANT state. Physical address of the function is
> + * stored in the SAR RAM while entering to OFF or DORMANT mode.
Which code stores the address in the SAR RAM? Please describe it here.

> + */
> +ENTRY(omap4_cpu_resume)
> + =A0 =A0 =A0 /*
...

Regards,
Jean
