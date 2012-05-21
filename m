From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv2 03/19] ARM: OMAP4: PM: Add device-off support
Date: Mon, 21 May 2012 16:05:45 +0200
Message-ID: <CAORVsuWrDW-JAHWDNGMGshYxUUqZNURotreO7qW96=6+oKjyAQ@mail.gmail.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-4-git-send-email-t-kristo@ti.com>
	<87obpn92jy.fsf@ti.com>
	<1337590125.2149.386.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:44786 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756479Ab2EUOFr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 10:05:47 -0400
Received: by lbbgm6 with SMTP id gm6so3466195lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 07:05:45 -0700 (PDT)
In-Reply-To: <1337590125.2149.386.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Hi Tero, Kevin, Santosh,

On Mon, May 21, 2012 at 10:48 AM, Tero Kristo <t-kristo@ti.com> wrote:
> On Wed, 2012-05-16 at 15:36 -0700, Kevin Hilman wrote:
>> +Jean for functional power states
>>
>> Tero Kristo <t-kristo@ti.com> writes:
>>
>> > This patch adds device off support to OMAP4 device type.
>>
>> Description is rather thin for a patch that is doing so much.
>>
>> > OFF mode is disabled by default,
>>
>> why?
>
> Good question. For historical reference I guess. The device off works
> pretty nicely with the current kernel already, so it should be possib=
le
> to enable it by default and blame the people who break it.
Agree. The next problem is 'who will fix the breakage?'.

>> > however, there are two ways to enable OFF mode:
>> > a) In the board file, call omap4_pm_off_mode_enable(1)
>> > b) Enable OFF mode using the debugfs entry
>> > echo "1">/sys/kernel/debug/pm_debug/enable_off_mode
>> > (conversely echo '0' will disable it as well).
>>
>> This part needs to be a separate patch.
>>
>> But, as stated in the core retention series, I'd like to move away f=
rom
>> these global flags all together.
>>
>> The way we manage the disabling of certain states (like off) is alre=
ady
>> clumsy for OMAP3, and it's getting worse with OMAP4. =A0Basically, I=
 think
>> this feature needs to be supported by using constraints on functiona=
l
>> power states. =A0 Having checks all over the place is getting unwiel=
dy and
>> not attractive to maintain.
>>
>> The combination of constraints and functional power states should ma=
ke
>> this much more manageable. =A0 Until we have that, I'd prefer to kee=
p
>> the debugfs enable/disable stuff as separate patches at the end of t=
he
>> series used only for testing.
>
> Okay, this sounds like a good plan.
>
>>
>> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> > [t-kristo@ti.com: largely re-structured the code]
>>
>> then the sign-off above from Santosh probably doesn't apply anymore.
>> You should change that to a Cc and just mention tht this is based up=
on
>> some original work from Santosh.
>
> Yeah... I am not quite sure where the line goes here as I am modifyin=
g
> the patches quite heavily but try to keep credits to the original
> authors... will change this like so.
>
>>
>> First, =A0some general comments:
>>
>> There is a lot going on in this patch, so it is hard to follow what =
all
>> is related, and why. =A0Just a quick glance suggests it needs to be =
broken
>> up into at least a few parts:
>
> What is the merge plan for the func power state stuff? I don't want t=
o
> create new dependencies if unnecessary. Otherwise the split should be
> okay.
That is something I am interested in too ;p
I did port and test Tero's patches on top of the functional power
states, which is the logical approach to me. Now given the reviews
status on both this patch series and the func power states series I am
not sure which one needs to be ported on top of the other ;-|
[1] https://gitorious.org/jpihet/linux-omap/commits/omap4_dev_off

Using the functional power states for the OMAP4 core and device off
has some advantages in simplifying the code, especially in the
previous/current/next states checking and programming.

>
>>
>> - low-level PRM support: new APIs for various off-mode features)
>> =A0 (should probably be done on top of functional power states)
>> - powerdomain core support or "achievable" states
>> =A0 (should probably be done on top of functional power states)
>> - IRQ/GIC context save/restore
>> - secure RAM save/restore (this has been tightly coupled to the GIC
>> =A0 but it's not obvious why)
>
> This is tightly coupled to GIC because the ROM code has following API
> calls:
>
> - save gic
> - save secure RAM
> - save secure all (gic + RAM + some other mysterious stuff)
>
> It is difficult/impossible to separate these without adding redundant
> code execution (e.g. doing a GIC save from the GIC code + then doing =
a
> second GIC save with save secure all from core PM code.)
>
>> - PM debug support to enable/disable off-mode
>> =A0 (for testing only, not for merge)
>>
>> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/omap-mpuss-lowpower.c | =A0 10 ++++-
>> > =A0arch/arm/mach-omap2/omap-wakeupgen.c =A0 =A0 =A0| =A0 47 ++++++=
+++++++++++++-
>> > =A0arch/arm/mach-omap2/pm-debug.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 17 =
+++++--
>> > =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 20 +++++++++
>> > =A0arch/arm/mach-omap2/pm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 4=
5 +++++++++++++++++++
>> > =A0arch/arm/mach-omap2/prm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 66 =
+++++++++++++++++++++++++++++
>> > =A06 files changed, 197 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/=
mach-omap2/omap-mpuss-lowpower.c
>> > index e02c082..7418e7c 100644
>> > --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> > +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
>> > @@ -60,6 +60,7 @@
>> > =A0#include "prcm44xx.h"
>> > =A0#include "prm44xx.h"
>> > =A0#include "prm-regbits-44xx.h"
>> > +#include "cm44xx.h"
>> >
>> > =A0#ifdef CONFIG_SMP
>> >
>> > @@ -263,9 +264,13 @@ int omap4_enter_lowpower(unsigned int cpu, un=
signed int power_state)
>> > =A0 =A0 =A0* In MPUSS OSWR or device OFF, interrupt controller =A0=
contest is lost.
>> > =A0 =A0 =A0*/
>> > =A0 =A0 mpuss_clear_prev_logic_pwrst();
>> > - =A0 if ((pwrdm_read_next_pwrst(mpuss_pd) =3D=3D PWRDM_POWER_RET)=
 &&
>> > + =A0 if (omap4_device_next_state_off())
>> > + =A0 =A0 =A0 =A0 =A0 save_state =3D 3;
>>
>> Why?
>>
>> I don't see why this check is needed in addition to the mpuss_pd che=
ck
>> added just below?
>
> mpuss_pd does not go to off, thats why. It goes to OSWR state during
> standard device-off. It is possible for it to go to OFF mode, but it =
is
> not recommended.
>
>>
>> > + =A0 else if ((pwrdm_read_next_pwrst(mpuss_pd) =3D=3D PWRDM_POWER=
_RET) &&
>> > =A0 =A0 =A0 =A0 =A0 =A0 (pwrdm_read_logic_retst(mpuss_pd) =3D=3D P=
WRDM_POWER_OFF))
>> > =A0 =A0 =A0 =A0 =A0 =A0 save_state =3D 2;
>> > + =A0 else if (pwrdm_read_next_pwrst(mpuss_pd) =3D=3D PWRDM_POWER_=
OFF)
>> > + =A0 =A0 =A0 =A0 =A0 save_state =3D 3;
>> > =A0 =A0 cpu_clear_prev_logic_pwrst(cpu);
>> > =A0 =A0 set_cpu_next_pwrst(cpu, power_state);
>> > @@ -288,6 +293,9 @@ int omap4_enter_lowpower(unsigned int cpu, uns=
igned int power_state)
>> > =A0 =A0 wakeup_cpu =3D smp_processor_id();
>> > =A0 =A0 set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
>> >
>> > + =A0 if (omap4_device_prev_state_off())
>> > + =A0 =A0 =A0 =A0 =A0 omap4_device_clear_prev_off_state();
>> > +
>>
>> The 'clear prev off state' is subsequently removed in the last patch
>> "ARM: OMAP4: powerdomain: update mpu / core off counters during devi=
ce
>> off." =A0 Why is it needed here?
>
> That patch is moving the clear part to the lost_context_rff func, it =
is
> probably not that clear. Should be easier to follow the logic once I
> re-structure the code a bit more (separate the prm support funcs out =
to
> their own set etc.)
>
>>
>> > =A0 =A0 pwrdm_post_transition();
>> >
>> > =A0 =A0 return 0;
>> > diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-=
omap2/omap-wakeupgen.c
>> > index 42cd7fb..805d08d 100644
>> > --- a/arch/arm/mach-omap2/omap-wakeupgen.c
>> > +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
>> > @@ -32,6 +32,7 @@
>> >
>> > =A0#include "omap4-sar-layout.h"
>> > =A0#include "common.h"
>> > +#include "pm.h"
>> >
>> > =A0#define NR_REG_BANKS =A0 =A0 =A0 =A0 =A0 =A0 =A0 4
>> > =A0#define MAX_IRQS =A0 =A0 =A0 =A0 =A0 128
>> > @@ -46,6 +47,8 @@ static void __iomem *sar_base;
>> > =A0static DEFINE_SPINLOCK(wakeupgen_lock);
>> > =A0static unsigned int irq_target_cpu[NR_IRQS];
>> >
>> > +static struct powerdomain *mpuss_pd;
>> > +
>> > =A0/*
>> > =A0 * Static helper functions.
>> > =A0 */
>> > @@ -259,7 +262,7 @@ static void irq_save_context(void)
>> > =A0/*
>> > =A0 * Clear WakeupGen SAR backup status.
>> > =A0 */
>> > -void irq_sar_clear(void)
>> > +static void irq_sar_clear(void)
>> > =A0{
>> > =A0 =A0 u32 val;
>> > =A0 =A0 val =3D __raw_readl(sar_base + SAR_BACKUP_STATUS_OFFSET);
>> > @@ -271,7 +274,7 @@ void irq_sar_clear(void)
>> > =A0 * Save GIC and Wakeupgen interrupt context using secure API
>> > =A0 * for HS/EMU devices.
>> > =A0 */
>> > -static void irq_save_secure_context(void)
>> > +static void irq_save_secure_gic(void)
>> > =A0{
>> > =A0 =A0 u32 ret;
>> > =A0 =A0 ret =3D omap_secure_dispatcher(OMAP4_HAL_SAVEGIC_INDEX,
>> > @@ -282,6 +285,40 @@ static void irq_save_secure_context(void)
>> > =A0}
>> > =A0#endif
>> >
>> > +static void save_secure_ram(void)
>> > +{
>> > + =A0 u32 ret;
>>
>> CodingStyle nit: blank line needed here (and in multiple other place=
s)
>
> Okay.
>
>>
>> > + =A0 ret =3D omap_secure_dispatcher(OMAP4_HAL_SAVESECURERAM_INDEX=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FLAG_START_C=
RITICAL,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, omap_secu=
re_ram_mempool_base(),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, 0, 0);
>> > + =A0 if (ret !=3D API_HAL_RET_VALUE_OK)
>> > + =A0 =A0 =A0 =A0 =A0 pr_err("Secure ram context save failed\n");
>> > +}
>> > +
>> > +static void save_secure_all(void)
>> > +{
>> > + =A0 u32 ret;
>> > + =A0 ret =3D omap_secure_dispatcher(OMAP4_HAL_SAVEALL_INDEX,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 FLAG_START_C=
RITICAL,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, omap_secu=
re_ram_mempool_base(),
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, 0, 0);
>> > + =A0 if (ret !=3D API_HAL_RET_VALUE_OK)
>> > + =A0 =A0 =A0 =A0 =A0 pr_err("Secure all context save failed\n");
>> > +}
>>
>> This secure mode save/restore seems misplaced in the wakeupgen drive=
r.
>> Seems to me like it belongs in omap-secure.c.
>
> Can't really move it there, as described above. Unless we want to sav=
e
> GIC context twice.
>
>>
>> > +
>> > +static void irq_save_secure_context(void)
>> > +{
>> > + =A0 if (omap4_device_next_state_off()) {
>> > + =A0 =A0 =A0 =A0 =A0 save_secure_all();
>> > + =A0 } else if (pwrdm_read_next_pwrst(mpuss_pd) =3D=3D PWRDM_POWE=
R_OFF) {
>>
>> Why is this check needed? =A0This is called from the CPU_CLUSTER_PM_=
ENTER
>> notifier, which AFAICT, is only called when the cluster is going off=
=2E
>
> This is checking against the different MPU PD states we can go into. =
If:
> - MPU OSWR =3D> GIC save needed only
> - MPU OFF =3D> GIC + secure RAM save needed (not recommended to be us=
ed
> though)
> - MPU OSWR / OFF + device-off =3D> save all needed
>
>>
>> > + =A0 =A0 =A0 =A0 =A0 irq_save_secure_gic();
>> > + =A0 =A0 =A0 =A0 =A0 save_secure_ram();
>> > + =A0 } else {
>> > + =A0 =A0 =A0 =A0 =A0 irq_save_secure_gic();
>> > + =A0 }
>> > +}
>> > +
>> > =A0#ifdef CONFIG_HOTPLUG_CPU
>> > =A0static int __cpuinit irq_cpu_hotplug_notify(struct notifier_blo=
ck *self,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned long action, void *hcpu)
>> > @@ -388,5 +425,11 @@ int __init omap_wakeupgen_init(void)
>> > =A0 =A0 irq_hotplug_init();
>> > =A0 =A0 irq_pm_init();
>> >
>> > + =A0 mpuss_pd =3D pwrdm_lookup("mpu_pwrdm");
>> > + =A0 if (!mpuss_pd) {
>> > + =A0 =A0 =A0 =A0 =A0 pr_err("wakeupgen: unable to get mpu_pwrdm\n=
");
>> > + =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> > + =A0 }
>> > +
>> > =A0 =A0 return 0;
>> > =A0}
>> > diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/=
pm-debug.c
>> > index d9a8e42..d8cf5e5 100644
>> > --- a/arch/arm/mach-omap2/pm-debug.c
>> > +++ b/arch/arm/mach-omap2/pm-debug.c
>> > @@ -40,6 +40,7 @@
>> >
>> > =A0u32 enable_off_mode;
>> > =A0static u32 enable_oswr_mode;
>> > +static void (*off_mode_enable_func) (int);
>> >
>> > =A0#ifdef CONFIG_DEBUG_FS
>> > =A0#include <linux/debugfs.h>
>> > @@ -249,7 +250,8 @@ static int option_set(void *data, u64 val)
>> > =A0 =A0 =A0 =A0 =A0 =A0 else
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_pm_disable_off_mode()=
;
>> >
>> > - =A0 =A0 =A0 =A0 =A0 omap3_pm_off_mode_enable(val);
>> > + =A0 =A0 =A0 =A0 =A0 if (off_mode_enable_func)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 off_mode_enable_func(val);
>> > =A0 =A0 }
>> >
>> > =A0 =A0 if (option =3D=3D &enable_oswr_mode)
>> > @@ -278,16 +280,21 @@ static int __init pm_dbg_init(void)
>> >
>> > =A0 =A0 pwrdm_for_each(pwrdms_setup, (void *)d);
>> >
>> > - =A0 if (cpu_is_omap34xx())
>> > - =A0 =A0 =A0 =A0 =A0 (void) debugfs_create_file("enable_off_mode"=
,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S_IRUGO | S_IWUSR, d, &enabl=
e_off_mode,
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pm_dbg_option_fops);
>> > + =A0 (void) debugfs_create_file("enable_off_mode",
>> > + =A0 =A0 =A0 =A0 =A0 S_IRUGO | S_IWUSR, d, &enable_off_mode,
>> > + =A0 =A0 =A0 =A0 =A0 &pm_dbg_option_fops);
>> >
>> > =A0 =A0 if (cpu_is_omap44xx())
>> > =A0 =A0 =A0 =A0 =A0 =A0 (void) debugfs_create_file("enable_oswr_mo=
de",
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S_IRUGO | S_IWUSR, d, &ena=
ble_oswr_mode,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &pm_dbg_option_fops);
>> >
>> > + =A0 if (cpu_is_omap34xx())
>> > + =A0 =A0 =A0 =A0 =A0 off_mode_enable_func =3D omap3_pm_off_mode_e=
nable;
>> > +
>> > + =A0 if (cpu_is_omap44xx())
>> > + =A0 =A0 =A0 =A0 =A0 off_mode_enable_func =3D omap4_pm_off_mode_e=
nable;
>> > +
>> > =A0 =A0 pm_dbg_init_done =3D 1;
>> >
>> > =A0 =A0 return 0;
>> > diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> > index c36ab63..d95f8c5 100644
>> > --- a/arch/arm/mach-omap2/pm.h
>> > +++ b/arch/arm/mach-omap2/pm.h
>> > @@ -18,6 +18,7 @@
>> > =A0extern void *omap3_secure_ram_storage;
>> > =A0extern void omap3_pm_off_mode_enable(int);
>> > =A0extern void omap4_pm_oswr_mode_enable(int);
>> > +extern void omap4_pm_off_mode_enable(int);
>> > =A0extern void omap_sram_idle(void);
>> > =A0extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 =
state);
>> > =A0extern int omap3_idle_init(void);
>> > @@ -25,6 +26,25 @@ extern int omap4_idle_init(void);
>> > =A0extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void=
 *unused);
>> > =A0extern int (*omap_pm_suspend)(void);
>> >
>> > +#ifdef CONFIG_PM
>> > +extern void omap4_device_set_state_off(u8 enable);
>> > +extern bool omap4_device_prev_state_off(void);
>> > +extern bool omap4_device_next_state_off(void);
>> > +extern void omap4_device_clear_prev_off_state(void);
>> > +#else
>> > +static inline void omap4_device_set_state_off(u8 enable)
>> > +{
>> > +}
>> > +static inline bool omap4_device_prev_state_off(void)
>> > +{
>> > + =A0 return false;
>> > +}
>> > +static inline bool omap4_device_next_state_off(void)
>> > +{
>> > + =A0 return false;
>> > +}
>> > +#endif
>> > +
>> > =A0#if defined(CONFIG_PM_OPP)
>> > =A0extern int omap3_opp_init(void);
>> > =A0extern int omap4_opp_init(void);
>> > diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm=
44xx.c
>> > index 07ac0d3..8f0ec56 100644
>> > --- a/arch/arm/mach-omap2/pm44xx.c
>> > +++ b/arch/arm/mach-omap2/pm44xx.c
>> > @@ -87,6 +87,27 @@ static int omap4_pm_suspend(void)
>> > =A0}
>> > =A0#endif /* CONFIG_SUSPEND */
>> >
>> > +/**
>> > + * get_achievable_state() - Provide achievable state
>> > + * @available_states: =A0 =A0 =A0what states are available
>> > + * @req_min_state: what state is the minimum we'd like to hit
>> > + *
>> > + * Power domains have varied capabilities. When attempting a low =
power
>> > + * state such as OFF/RET, a specific min requested state may not =
be
>> > + * supported on the power domain, in which case, the next higher =
power
>> > + * state which is supported is returned. This is because a combin=
ation
>> > + * of system power states where the parent PD's state is not in l=
ine
>> > + * with expectation can result in system instabilities.
>> > + */
>> > +static inline u8 get_achievable_state(u8 available_states, u8 req=
_min_state)
>> > +{
>> > + =A0 u16 mask =3D 0xFF << req_min_state;
>> > +
>> > + =A0 if (available_states & mask)
>> > + =A0 =A0 =A0 =A0 =A0 return __ffs(available_states & mask);
>> > + =A0 return PWRDM_POWER_ON;
>> > +}
>>
>> This feature needs to be generalized (preferably on top of functiona=
l
>> power states) because we have the same need on various AM3xxx SoCs w=
hich
>> don't support RET/OFF. =A0Mark Greer has started on this, but I thin=
k it
>> needs to be part of the functional power states work.
>>
>> It also needs to be part of the powerdomain layer, IMO.
>
> So, are you saying this whole set should be re-based on top of the
> functional power states stuff? If yes, that can be done (Jean actuall=
y
> already did some work on this and got it working I think.)
Indeed, cf. [1]. It has been done and works on OMAP3&4 with cpuidle
and suspend/resume.

>>
>> > =A0static int __init pwrdms_setup(struct powerdomain *pwrdm, void =
*unused)
>> > =A0{
>> > =A0 =A0 struct power_state *pwrst;
>> > @@ -115,6 +136,30 @@ static int __init pwrdms_setup(struct powerdo=
main *pwrdm, void *unused)
>> > =A0 =A0 return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_stat=
e);
>> > =A0}
>> >
>> > +void omap4_pm_off_mode_enable(int enable)
>> > +{
>> > + =A0 u32 next_state =3D PWRDM_POWER_RET;
>> > + =A0 u32 next_logic_state =3D PWRDM_POWER_ON;
>> > + =A0 struct power_state *pwrst;
>> > +
>> > + =A0 if (enable) {
>> > + =A0 =A0 =A0 =A0 =A0 next_state =3D PWRDM_POWER_OFF;
>> > + =A0 =A0 =A0 =A0 =A0 next_logic_state =3D PWRDM_POWER_OFF;
>> > + =A0 }
>> > +
>> > + =A0 omap4_device_set_state_off(enable);
>> > +
>> > + =A0 list_for_each_entry(pwrst, &pwrst_list, node) {
>> > + =A0 =A0 =A0 =A0 =A0 pwrst->next_state =3D
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_achievable_state(pwrst->=
pwrdm->pwrsts, next_state);
>> > + =A0 =A0 =A0 =A0 =A0 pwrst->next_logic_state =3D
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_achievable_state(pwrst->=
pwrdm->pwrsts_logic_ret,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_logic_s=
tate);
>> > + =A0 =A0 =A0 =A0 =A0 omap_set_pwrdm_state(pwrst->pwrdm, pwrst->ne=
xt_state);
>> > + =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->n=
ext_logic_state);
>> > + =A0 }
>> > +}
>> > +
>> > =A0void omap4_pm_oswr_mode_enable(int enable)
>> > =A0{
>> > =A0 =A0 u32 next_logic_state;
>> > diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/p=
rm44xx.c
>> > index 09d84de..86c6c6b 100644
>> > --- a/arch/arm/mach-omap2/prm44xx.c
>> > +++ b/arch/arm/mach-omap2/prm44xx.c
>> > @@ -289,6 +289,72 @@ static void __init omap44xx_prm_enable_io_wak=
eup(void)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_PRM_IO_PMCTRL_OFFSET=
);
>> > =A0}
>> >
>> > +/**
>> > + * omap4_device_set_state_off() - setup device off state
>> > + * @enable: =A0 =A0 =A0 =A0set to off or not.
>> > + *
>> > + * When Device OFF is enabled, Device is allowed to perform
>> > + * transition to off mode as soon as all power domains in MPU, IV=
A
>> > + * and CORE voltage are in OFF or OSWR state (open switch retenti=
on)
>> > + */
>> > +void omap4_device_set_state_off(u8 enable)
>> > +{
>> > + =A0 if (enable)
>> > + =A0 =A0 =A0 =A0 =A0 omap4_prminst_write_inst_reg(0x1 <<
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_DEV=
ICE_OFF_ENABLE_SHIFT,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM=
_PARTITION,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM=
_DEVICE_INST,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_PRM_DE=
VICE_OFF_CTRL_OFFSET);
>> > + =A0 else
>> > + =A0 =A0 =A0 =A0 =A0 omap4_prminst_write_inst_reg(0x0 <<
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_DEV=
ICE_OFF_ENABLE_SHIFT,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM=
_PARTITION,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM=
_DEVICE_INST,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_PRM_DE=
VICE_OFF_CTRL_OFFSET);
>> > +}
>>
>> minor: a more compact, and more readable (so it's obvious at first
>> glance that the same register is being written) would be:
>>
>> void omap4_device_set_state_off(u8 enable)
>> {
>> =A0 =A0 =A0 =A0 u8 val =3D enable ? 0x1 : 0x0;
>>
>> =A0 =A0 =A0 omap4_prminst_write_inst_reg(val <<
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430=
_DEVICE_OFF_ENABLE_SHIFT,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430=
_PRM_PARTITION,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430=
_PRM_DEVICE_INST,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_PR=
M_DEVICE_OFF_CTRL_OFFSET);
>> }
>
> True.
>
>>
>> > +/**
>> > + * omap4_device_prev_state_off:
>> > + * returns true if the device hit OFF mode
>> > + * This is API to check whether OMAP is waking up from device OFF=
 mode.
>> > + * There is no other status bit available for SW to read whether =
last state
>> > + * entered was device OFF. To work around this, CORE PD, RFF cont=
ext state
>> > + * is used which is lost only when we hit device OFF state
>> > + */
>> > +bool omap4_device_prev_state_off(void)
>> > +{
>> > + =A0 u32 reg;
>>
>> minor: reg makes me think the result of the read is a register addre=
ss,
>> not a value. =A0How about s/reg/val/.
>
> Yea, good point.
>
>>
>> > + =A0 reg =3D omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM=
_CORE_INST,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_RM_L3_=
1_L3_1_CONTEXT_OFFSET)
>> > + =A0 =A0 =A0 =A0 =A0 & OMAP4430_LOSTCONTEXT_RFF_MASK;
>> > +
>> > + =A0 return reg ? true : false;
>> > +}
>> > +
>> > +void omap4_device_clear_prev_off_state(void)
>> > +{
>> > + =A0 omap4_prminst_write_inst_reg(OMAP4430_LOSTCONTEXT_RFF_MASK |
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_LOS=
TCONTEXT_DFF_MASK,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM=
_PARTITION,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM=
_CORE_INST,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_RM_L3_=
1_L3_1_CONTEXT_OFFSET);
>> > +}
>> > +
>> > +/**
>> > + * omap4_device_next_state_off:
>> > + * returns true if the device next state is OFF
>> > + * This is API to check whether OMAP is programmed for device OFF
>> > + */
>> > +bool omap4_device_next_state_off(void)
>> > +{
>> > + =A0 return omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_INST,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_PRM_DEVICE_OFF_CTRL_OF=
=46SET)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & OMAP4430_DEVICE_OFF_ENABLE=
_MASK ? true : false;
>>
>> minor: when using these long register read helpers, IMO readability
>> improves if this is of the form:
>>
>> =A0 =A0 =A0 =A0val =3D <read register>;
>> =A0 =A0 =A0 =A0val &=3D <mask>;
>> =A0 =A0 =A0 =A0return val ? true : false;
>
> True.
>
>>
>> > +}
>> > +
>> > =A0static int __init omap4xxx_prcm_init(void)
>> > =A0{
>> > =A0 =A0 if (cpu_is_omap44xx()) {
>>
>> Kevin
>>
>
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
