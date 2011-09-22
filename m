From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Thu, 22 Sep 2011 20:57:34 +0530
Message-ID: <CAC83ZvKa7R_rUe-Fa15m0_5P-GE4WC2thazQ+iqF-HAqn8cE1w@mail.gmail.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:43598 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750948Ab1IVP1i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 11:27:38 -0400
Received: by eyd9 with SMTP id 9so2024444eyd.36
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 08:27:35 -0700 (PDT)
In-Reply-To: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

On Tue, Sep 13, 2011 at 6:32 PM, Tarun Kanti DebBarma
<tarun.kanti@ti.com> wrote:
> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.*
>
> Baseline: git://gitorious.org/khilman/linux-omap-pm.git
> Branch: for_3.2/gpio-cleanup
> Commit: 8323374
Thanks Tony for ack'ing the patches.
Kevin,
Since Tony's has acked the patches, can you please pull them?
Thanks.
--
Tarun
>
> Test Details:
> - Compile tested for omap1_defconfig and omap2plus_defconfig.
> - OMAP1710-H3: Bootup test.
> - OMAP2430/SDP, OMAP3430/SDP, OMAP4430/SDP: Functional testing.
> - PM Testing on OMAP3430-SDP: retention, off_mode, system_wide
> =A0suspend and gpio wakeup.
>
> v7:
> - Use pm_runtime_put() instead of pm_runtime_put_sync_suspend()
>
> - Keep *_runtime_get/put*() =A0outside spinlock
>
> - Remove additional checking of conditions in _restore_context()
> =A0From:
> =A0if (bank->regs->set_dataout && bank->regs->clear_dataout)
> =A0...
> =A0To:
> =A0if (bank->regs->set_dataout)
> =A0...
>
> - Use SET_RUNTIME_PM_OPS and SET_SYSTEM_SLEEP_PM_OPS macros
>
> - In [PATCH 19/25] gpio/omap: cleanup prepare_for_idle and resume_aft=
er_idle,
> =A0protect the bank data elements and register access using spinlock =
in
> =A0runtime_suspend/resume() callbacks.
> =A0This is because these callbacks run with interrupts enabled.
>
> - Add dbclk aliases for all GPIO modules. Without this, GPIO modules =
were not
> =A0getting the correct clock handle to enable/disable debounec clock.
>
> - Fix log comments on the following patches:
> =A0[PATCH 19/25] gpio/omap: cleanup prepare_for_idle and resume_after=
_idle
> =A0[PATCH 20/25] gpio/omap: skip operations in runtime callbacks
> =A0[PATCH 24/25] gpio/omap: restore OE only after setting the output =
level
>
> v6:
> - Save and restore debounce registers for proper driver operation.
> - Restore interrupt enable after all configuration to avoid spurious =
interrupts.
> - Restore dataout register before oe register.
> - Restore dataout into dataout_set or dataout based upon the OMAP ver=
sion.
> - Change register name from wkup_status to wkup_en.
> - Remove wrapper around omap_pm_get_dev_context_loss_count(). Use it =
directly.
> =A0Also, changed the signature of get_context_loss_count in pdata and=
 bank structure
> =A0from int to u32.
>
> - Use 'context' instead of 'ctx' for clarity wherever it is used.
> - Merged two patches into one which are related to bank_is_mpuio() mo=
dification.
> - Use shift operator instead of following:
> + =A0 =A0 =A0 .irqctrl =A0 =A0 =A0 =A0=3D OMAP_MPUIO_GPIO_INT_EDGE / =
2,
>
> - Remove redundant check from the following
> + =A0 =A0 =A0 if (bank_is_mpuio(bank)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bank->regs->wkup_status) <--- redun=
dant check
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpuio_init(bank);
>
> - Change subject of following patch
> =A0[PATCH v5 15/22] gpio/omap: use readl in irq_handler for all acces=
s
> =A0into
> =A0[PATCH 14/25] gpio/omap: remove unnecessary bit-masking for read a=
ccess
>
> - Fix multi-line comments in
> =A0[PATCH v5 20/22] gpio/omap: cleanup prepare_for_idle and resume_af=
ter_idle
>
> v5:
> - Reduce runtime callback overhead when *_get/put_sync() called from =
probe()
> =A0and *_gpio_request/free().
>
> - Dynamic context save within functions where context is modified ins=
tead of
> =A0saving all context within a common function.
>
> - Removed call to mpuio_init() from omap_gpio_mod_init(). Both the fu=
nctions are
> =A0called once during initialization in *_gpio_probe().
> =A0Call to omap_gpio_mod_init() has been removed from omap_gpio_reque=
st() on the
> =A0first access to gpio bank. One time initialization looks sufficien=
t.
>
> - In *_gpio_irq_handler() use *_put_sync_suspend() instead of *_put_s=
ync().
>
> - Removed hardcoding of OMAP16xx sysconfig register value and instead=
 defined an
> =A0associated constant.
>
> - Removed *_get_sync() call from *_gpio_suspend() and *_put_sync() ca=
ll from
> =A0*_gpio_resume(). They got wrongly slipped into the code.
>
> - Removed following redundant zero allocated initialization from mach=
-omap2/gpio.c
> + =A0 =A0 =A0 pdata->regs->irqctrl =3D 0;
> + =A0 =A0 =A0 pdata->regs->edgectrl1 =3D 0;
> + =A0 =A0 =A0 pdata->regs->edgectrl2 =3D 0;
>
> - Removed following redundant code in gpio-omap.c
> =A0-#define bank_is_mpuio(bank) =A0((bank)->method =3D=3D METHOD_MPUI=
O)
>
> v4:
> - since all accesses to registers are 4-byte aligned, removing specia=
l
> =A0checks and handling of 16 and 32-bit wide bank registers and inste=
ad
> =A0use 32-bit read/write access consistently.
>
> - redundant usage of MOD_REG_BIT has been corrected and replaced with
> =A0_gpio_rmw().
>
> - omap_gpio_mod_init() function has been simplified further using _gp=
io_rmw().
>
> - sysconfig register offset specific to omap16xx has been removed alo=
ng
> =A0with its usage.
>
> - additional logic to skip from suspend/resume:
>
> =A0if (!bank->regs->wkup_status || !bank->suspend_wakeup)
> =A0 =A0 =A0 =A0return 0;
>
> =A0if (!bank->regs->wkup_status || !bank->saved_wakeup)
> =A0 =A0 =A0 =A0return 0;
>
> - separated mpuio related changes into a different patch from the pat=
ch where
> =A0wakeup status register related changes are done.
>
> - Incorrect replacement of !cpu_class_is_omap2() in gpio_irq_type()
> =A0corrected:
> + =A0 =A0 =A0 if (!bank->regs->leveldetect0 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LE=
VEL_HIGH)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> v3:
> - Avoid use of wkup_set and wkup_clear registers. Instead use wkup_st=
atus
> =A0register for all platforms. This is because on OMAP4 it is recomme=
nded
> =A0not to use them.
>
> - Remove duplicate code in omap_gpio_mod_init() for handling the same=
 for
> =A032-bit and 16-bit GPIO bank widths. This is accomplished by having=
 two
> =A0functions to handle each case while assiging a common function poi=
nter
> =A0during initialization.
>
> - Remove OMAP16xx specific one time initialization from omap_gpio_mod=
_init().
> =A0Move it inside omap16xx_gpio_init().
>
> - Avoid usage of USHRT_MAX to indicate undefined values. Use 0 instea=
d.
>
> - In omap_gpio_suspend()/resume() functions remove code that checks
> =A0if the feature is supported. Instead, assign these functions to
> =A0struct platform_driver's suspend & resume function pointers for th=
ose
> =A0OMAP platforms whcih support this feature.
>
> - Remove 'suspend_support' flag because it is redundant. Instead use
> =A0wkup_* registers to decode the same information.
>
> - Restore context also when we don't know if the context is lost.
>
> - Make omap_gpio_save_context() and omap_gpio_restore_context()
> =A0static.
>
> v2:
> - Do special handling of non-wakeup GPIOs only on OMAP2420. Avoid thi=
s
> =A0handling on OMAP3430.
> - Isolate cleanups and fixes into separate set of patches. Keep the c=
leanup
> =A0first followed by the fixes.
> - Avoid calling omap_gpio_get_context_loss() directly and instead cal=
l it
> =A0through function pointer in pdata initialized during init.
> - workaround_enabled flag is not longer needed and is removed.
> - Call pwrdm_post_transition() before calling omap_gpio_resume_after_=
idle().
> - In omap2_gpio_resume_after_idle() do context restore before handlin=
g
> =A0workaround.
> - Use PM runtime framework.
> - Modify register offset names to : wkup_status, wkup_clear, wkup_set=
=2E
> =A0Also use 'base + offset' for readibility in all relevant places.
> - Remove unwanted messages from commit section like TODO, etc.
>
>
> Charulatha V (10):
> =A0gpio/omap: remove dependency on gpio_bank_count
> =A0gpio/omap: use flag to identify wakeup domain
> =A0gpio/omap: make gpio_context part of gpio_bank structure
> =A0gpio/omap: fix pwrdm_post_transition call sequence
> =A0gpio/omap: handle save/restore context in GPIO driver
> =A0gpio/omap: make non-wakeup GPIO part of pdata
> =A0gpio/omap: avoid cpu checks during module ena/disable
> =A0gpio/omap: use pinctrl offset instead of macro
> =A0gpio/omap: remove bank->method & METHOD_* macros
> =A0gpio/omap: fix bankwidth for OMAP7xx MPUIO
>
> Nishanth Menon (4):
> =A0gpio/omap: save and restore debounce registers
> =A0gpio/omap: enable irq at the end of all configuration in restore
> =A0gpio/omap: restore OE only after setting the output level
> =A0gpio/omap: handle set_dataout reg capable IP on restore
>
> Tarun Kanti DebBarma (12):
> =A0gpio/omap: further cleanup using wkup_en register
> =A0gpio/omap: use level/edge detect reg offsets
> =A0gpio/omap: remove hardcoded offsets in context save/restore
> =A0gpio/omap: cleanup set_gpio_triggering function
> =A0gpio/omap: cleanup omap_gpio_mod_init function
> =A0gpio/omap: remove unnecessary bit-masking for read access
> =A0gpio/omap: use pm-runtime framework
> =A0gpio/omap: optimize suspend and resume functions
> =A0gpio/omap: cleanup prepare_for_idle and resume_after_idle
> =A0gpio/omap: skip operations in runtime callbacks
> =A0gpio/omap: remove omap_gpio_save_context overhead
> =A0gpio/omap: add dbclk aliases for all gpio modules
>
> =A0arch/arm/mach-omap1/gpio15xx.c =A0 =A0 =A0 =A0 | =A0 =A07 +-
> =A0arch/arm/mach-omap1/gpio16xx.c =A0 =A0 =A0 =A0 | =A0 47 ++-
> =A0arch/arm/mach-omap1/gpio7xx.c =A0 =A0 =A0 =A0 =A0| =A0 14 +-
> =A0arch/arm/mach-omap2/clock3xxx_data.c =A0 | =A0 =A06 +
> =A0arch/arm/mach-omap2/clock44xx_data.c =A0 | =A0 =A06 +
> =A0arch/arm/mach-omap2/gpio.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 36 +-
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0 =A0 =A0 | =A0 21 +-
> =A0arch/arm/plat-omap/include/plat/gpio.h | =A0 29 +-
> =A0drivers/gpio/gpio-omap.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 1051 ++++++=
+++++++-------------------
> =A09 files changed, 524 insertions(+), 693 deletions(-)
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
