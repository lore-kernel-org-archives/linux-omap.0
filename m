From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 06/10] ARM: OMAP2+: powerdomain/clockdomain: add a
 per-powerdomain spinlock
Date: Wed, 12 Dec 2012 10:41:07 +0100
Message-ID: <CAORVsuU3f9sf5Z3cVNeJbEKwc_VPpyYv2LfbXtehaMJRN7wARA@mail.gmail.com>
References: <20121209011755.19716.25244.stgit@dusk.lan>
 <20121209012340.19716.62316.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5028304741382457285=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121209012340.19716.62316.stgit@dusk.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============5028304741382457285==
Content-Type: multipart/alternative; boundary=14dae93404f503119104d0a49920

--14dae93404f503119104d0a49920
Content-Type: text/plain; charset=ISO-8859-1

Paul,

On Sun, Dec 9, 2012 at 2:23 AM, Paul Walmsley <paul@pwsan.com> wrote:

> Add a per-powerdomain spinlock.  Use that instead of the clockdomain
> spinlock.  Add pwrdm_lock()/pwrdm_unlock() functions to allow other
> code to acquire or release the powerdomain spinlock without reaching
> directly into the struct powerdomain.
>
Since clockdomains are part of powerdomains it seems weird for the
clockdomain code to take a powerdoamin lock.
Is there a reason why the powerdomain could not take the lock before
calling the clockdomain functions?

Also, are the lock and nolock version the clockdomain function needed?

Regards,
Jean


>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> ---
>  arch/arm/mach-omap2/clockdomain-powerdomain.h |   22 +++
>  arch/arm/mach-omap2/clockdomain.c             |  161
> +++++++++++++++++--------
>  arch/arm/mach-omap2/clockdomain.h             |    6 +
>  arch/arm/mach-omap2/powerdomain-clockdomain.h |   27 ++++
>  arch/arm/mach-omap2/powerdomain.c             |   56 ++++++++-
>  arch/arm/mach-omap2/powerdomain.h             |   11 +-
>  6 files changed, 219 insertions(+), 64 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clockdomain-powerdomain.h
>  create mode 100644 arch/arm/mach-omap2/powerdomain-clockdomain.h
>
> diff --git a/arch/arm/mach-omap2/clockdomain-powerdomain.h
> b/arch/arm/mach-omap2/clockdomain-powerdomain.h
> new file mode 100644
> index 0000000..8beee2d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clockdomain-powerdomain.h
> @@ -0,0 +1,22 @@
> +/*
> + * OMAP clockdomain framework functions for use only by the powerdomain
> code
> + *
> + * Copyright (C) 2012 Texas Instruments, Inc.
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_POWERDOMAIN_H
> +#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_POWERDOMAIN_H
> +
> +#include "clockdomain.h"
> +
> +extern void clkdm_allow_idle_nolock(struct clockdomain *clkdm);
> +extern void clkdm_deny_idle_nolock(struct clockdomain *clkdm);
> +extern int clkdm_wakeup_nolock(struct clockdomain *clkdm);
> +extern int clkdm_sleep_nolock(struct clockdomain *clkdm);
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/clockdomain.c
> b/arch/arm/mach-omap2/clockdomain.c
> index 18f65fd..2142dab 100644
> --- a/arch/arm/mach-omap2/clockdomain.c
> +++ b/arch/arm/mach-omap2/clockdomain.c
> @@ -30,6 +30,7 @@
>  #include "soc.h"
>  #include "clock.h"
>  #include "clockdomain.h"
> +#include "powerdomain-clockdomain.h"
>
>  /* clkdm_list contains all registered struct clockdomains */
>  static LIST_HEAD(clkdm_list);
> @@ -91,8 +92,6 @@ static int _clkdm_register(struct clockdomain *clkdm)
>
>         pwrdm_add_clkdm(pwrdm, clkdm);
>
> -       spin_lock_init(&clkdm->lock);
> -
>         pr_debug("clockdomain: registered %s\n", clkdm->name);
>
>         return 0;
> @@ -733,18 +732,17 @@ int clkdm_clear_all_sleepdeps(struct clockdomain
> *clkdm)
>  }
>
>  /**
> - * clkdm_sleep - force clockdomain sleep transition
> + * clkdm_sleep_nolock - force clockdomain sleep transition (lockless)
>   * @clkdm: struct clockdomain *
>   *
>   * Instruct the CM to force a sleep transition on the specified
> - * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if
> - * clockdomain does not support software-initiated sleep; 0 upon
> - * success.
> + * clockdomain @clkdm.  Only for use by the powerdomain code.  Returns
> + * -EINVAL if @clkdm is NULL or if clockdomain does not support
> + * software-initiated sleep; 0 upon success.
>   */
> -int clkdm_sleep(struct clockdomain *clkdm)
> +int clkdm_sleep_nolock(struct clockdomain *clkdm)
>  {
>         int ret;
> -       unsigned long flags;
>
>         if (!clkdm)
>                 return -EINVAL;
> @@ -760,27 +758,45 @@ int clkdm_sleep(struct clockdomain *clkdm)
>
>         pr_debug("clockdomain: forcing sleep on %s\n", clkdm->name);
>
> -       spin_lock_irqsave(&clkdm->lock, flags);
>         clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
>         ret = arch_clkdm->clkdm_sleep(clkdm);
> -       ret |= pwrdm_state_switch(clkdm->pwrdm.ptr);
> -       spin_unlock_irqrestore(&clkdm->lock, flags);
> +       ret |= pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
> +
>         return ret;
>  }
>
>  /**
> - * clkdm_wakeup - force clockdomain wakeup transition
> + * clkdm_sleep - force clockdomain sleep transition
>   * @clkdm: struct clockdomain *
>   *
> - * Instruct the CM to force a wakeup transition on the specified
> - * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if the
> - * clockdomain does not support software-controlled wakeup; 0 upon
> + * Instruct the CM to force a sleep transition on the specified
> + * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if
> + * clockdomain does not support software-initiated sleep; 0 upon
>   * success.
>   */
> -int clkdm_wakeup(struct clockdomain *clkdm)
> +int clkdm_sleep(struct clockdomain *clkdm)
> +{
> +       int ret;
> +
> +       pwrdm_lock(clkdm->pwrdm.ptr);
> +       ret = clkdm_sleep_nolock(clkdm);
> +       pwrdm_unlock(clkdm->pwrdm.ptr);
> +
> +       return ret;
> +}
> +
> +/**
> + * clkdm_wakeup_nolock - force clockdomain wakeup transition (lockless)
> + * @clkdm: struct clockdomain *
> + *
> + * Instruct the CM to force a wakeup transition on the specified
> + * clockdomain @clkdm.  Only for use by the powerdomain code.  Returns
> + * -EINVAL if @clkdm is NULL or if the clockdomain does not support
> + * software-controlled wakeup; 0 upon success.
> + */
> +int clkdm_wakeup_nolock(struct clockdomain *clkdm)
>  {
>         int ret;
> -       unsigned long flags;
>
>         if (!clkdm)
>                 return -EINVAL;
> @@ -796,28 +812,46 @@ int clkdm_wakeup(struct clockdomain *clkdm)
>
>         pr_debug("clockdomain: forcing wakeup on %s\n", clkdm->name);
>
> -       spin_lock_irqsave(&clkdm->lock, flags);
>         clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
>         ret = arch_clkdm->clkdm_wakeup(clkdm);
> -       ret |= pwrdm_state_switch(clkdm->pwrdm.ptr);
> -       spin_unlock_irqrestore(&clkdm->lock, flags);
> +       ret |= pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
> +
>         return ret;
>  }
>
>  /**
> - * clkdm_allow_idle - enable hwsup idle transitions for clkdm
> + * clkdm_wakeup - force clockdomain wakeup transition
>   * @clkdm: struct clockdomain *
>   *
> - * Allow the hardware to automatically switch the clockdomain @clkdm into
> - * active or idle states, as needed by downstream clocks.  If the
> + * Instruct the CM to force a wakeup transition on the specified
> + * clockdomain @clkdm.  Returns -EINVAL if @clkdm is NULL or if the
> + * clockdomain does not support software-controlled wakeup; 0 upon
> + * success.
> + */
> +int clkdm_wakeup(struct clockdomain *clkdm)
> +{
> +       int ret;
> +
> +       pwrdm_lock(clkdm->pwrdm.ptr);
> +       ret = clkdm_wakeup_nolock(clkdm);
> +       pwrdm_unlock(clkdm->pwrdm.ptr);
> +
> +       return ret;
> +}
> +
> +/**
> + * clkdm_allow_idle_nolock - enable hwsup idle transitions for clkdm
> + * @clkdm: struct clockdomain *
> + *
> + * Allow the hardware to automatically switch the clockdomain @clkdm
> + * into active or idle states, as needed by downstream clocks.  If the
>   * clockdomain has any downstream clocks enabled in the clock
>   * framework, wkdep/sleepdep autodependencies are added; this is so
> - * device drivers can read and write to the device.  No return value.
> + * device drivers can read and write to the device.  Only for use by
> + * the powerdomain code.  No return value.
>   */
> -void clkdm_allow_idle(struct clockdomain *clkdm)
> +void clkdm_allow_idle_nolock(struct clockdomain *clkdm)
>  {
> -       unsigned long flags;
> -
>         if (!clkdm)
>                 return;
>
> @@ -833,11 +867,26 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
>         pr_debug("clockdomain: enabling automatic idle transitions for
> %s\n",
>                  clkdm->name);
>
> -       spin_lock_irqsave(&clkdm->lock, flags);
>         clkdm->_flags |= _CLKDM_FLAG_HWSUP_ENABLED;
>         arch_clkdm->clkdm_allow_idle(clkdm);
> -       pwrdm_state_switch(clkdm->pwrdm.ptr);
> -       spin_unlock_irqrestore(&clkdm->lock, flags);
> +       pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
> +}
> +
> +/**
> + * clkdm_allow_idle - enable hwsup idle transitions for clkdm
> + * @clkdm: struct clockdomain *
> + *
> + * Allow the hardware to automatically switch the clockdomain @clkdm into
> + * active or idle states, as needed by downstream clocks.  If the
> + * clockdomain has any downstream clocks enabled in the clock
> + * framework, wkdep/sleepdep autodependencies are added; this is so
> + * device drivers can read and write to the device.  No return value.
> + */
> +void clkdm_allow_idle(struct clockdomain *clkdm)
> +{
> +       pwrdm_lock(clkdm->pwrdm.ptr);
> +       clkdm_allow_idle_nolock(clkdm);
> +       pwrdm_unlock(clkdm->pwrdm.ptr);
>  }
>
>  /**
> @@ -847,12 +896,11 @@ void clkdm_allow_idle(struct clockdomain *clkdm)
>   * Prevent the hardware from automatically switching the clockdomain
>   * @clkdm into inactive or idle states.  If the clockdomain has
>   * downstream clocks enabled in the clock framework, wkdep/sleepdep
> - * autodependencies are removed.  No return value.
> + * autodependencies are removed.  Only for use by the powerdomain
> + * code.  No return value.
>   */
> -void clkdm_deny_idle(struct clockdomain *clkdm)
> +void clkdm_deny_idle_nolock(struct clockdomain *clkdm)
>  {
> -       unsigned long flags;
> -
>         if (!clkdm)
>                 return;
>
> @@ -868,11 +916,25 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
>         pr_debug("clockdomain: disabling automatic idle transitions for
> %s\n",
>                  clkdm->name);
>
> -       spin_lock_irqsave(&clkdm->lock, flags);
>         clkdm->_flags &= ~_CLKDM_FLAG_HWSUP_ENABLED;
>         arch_clkdm->clkdm_deny_idle(clkdm);
> -       pwrdm_state_switch(clkdm->pwrdm.ptr);
> -       spin_unlock_irqrestore(&clkdm->lock, flags);
> +       pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
> +}
> +
> +/**
> + * clkdm_deny_idle - disable hwsup idle transitions for clkdm
> + * @clkdm: struct clockdomain *
> + *
> + * Prevent the hardware from automatically switching the clockdomain
> + * @clkdm into inactive or idle states.  If the clockdomain has
> + * downstream clocks enabled in the clock framework, wkdep/sleepdep
> + * autodependencies are removed.  No return value.
> + */
> +void clkdm_deny_idle(struct clockdomain *clkdm)
> +{
> +       pwrdm_lock(clkdm->pwrdm.ptr);
> +       clkdm_deny_idle_nolock(clkdm);
> +       pwrdm_unlock(clkdm->pwrdm.ptr);
>  }
>
>  /**
> @@ -889,14 +951,11 @@ void clkdm_deny_idle(struct clockdomain *clkdm)
>  bool clkdm_in_hwsup(struct clockdomain *clkdm)
>  {
>         bool ret;
> -       unsigned long flags;
>
>         if (!clkdm)
>                 return false;
>
> -       spin_lock_irqsave(&clkdm->lock, flags);
>         ret = (clkdm->_flags & _CLKDM_FLAG_HWSUP_ENABLED) ? true : false;
> -       spin_unlock_irqrestore(&clkdm->lock, flags);
>
>         return ret;
>  }
> @@ -922,12 +981,10 @@ bool clkdm_missing_idle_reporting(struct clockdomain
> *clkdm)
>
>  static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
>  {
> -       unsigned long flags;
> -
>         if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_enable)
>                 return -EINVAL;
>
> -       spin_lock_irqsave(&clkdm->lock, flags);
> +       pwrdm_lock(clkdm->pwrdm.ptr);
>
>         /*
>          * For arch's with no autodeps, clkcm_clk_enable
> @@ -935,13 +992,13 @@ static int _clkdm_clk_hwmod_enable(struct
> clockdomain *clkdm)
>          * enabled, so the clkdm can be force woken up.
>          */
>         if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps) {
> -               spin_unlock_irqrestore(&clkdm->lock, flags);
> +               pwrdm_unlock(clkdm->pwrdm.ptr);
>                 return 0;
>         }
>
>         arch_clkdm->clkdm_clk_enable(clkdm);
> -       pwrdm_state_switch(clkdm->pwrdm.ptr);
> -       spin_unlock_irqrestore(&clkdm->lock, flags);
> +       pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
> +       pwrdm_unlock(clkdm->pwrdm.ptr);
>
>         pr_debug("clockdomain: %s: enabled\n", clkdm->name);
>
> @@ -950,27 +1007,25 @@ static int _clkdm_clk_hwmod_enable(struct
> clockdomain *clkdm)
>
>  static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)
>  {
> -       unsigned long flags;
> -
>         if (!clkdm || !arch_clkdm || !arch_clkdm->clkdm_clk_disable)
>                 return -EINVAL;
>
> -       spin_lock_irqsave(&clkdm->lock, flags);
> +       pwrdm_lock(clkdm->pwrdm.ptr);
>
>         if (atomic_read(&clkdm->usecount) == 0) {
> -               spin_unlock_irqrestore(&clkdm->lock, flags);
> +               pwrdm_unlock(clkdm->pwrdm.ptr);
>                 WARN_ON(1); /* underflow */
>                 return -ERANGE;
>         }
>
>         if (atomic_dec_return(&clkdm->usecount) > 0) {
> -               spin_unlock_irqrestore(&clkdm->lock, flags);
> +               pwrdm_unlock(clkdm->pwrdm.ptr);
>                 return 0;
>         }
>
>         arch_clkdm->clkdm_clk_disable(clkdm);
> -       pwrdm_state_switch(clkdm->pwrdm.ptr);
> -       spin_unlock_irqrestore(&clkdm->lock, flags);
> +       pwrdm_state_switch_nolock(clkdm->pwrdm.ptr);
> +       pwrdm_unlock(clkdm->pwrdm.ptr);
>
>         pr_debug("clockdomain: %s: disabled\n", clkdm->name);
>
> diff --git a/arch/arm/mach-omap2/clockdomain.h
> b/arch/arm/mach-omap2/clockdomain.h
> index bc42446..e7f1b4b 100644
> --- a/arch/arm/mach-omap2/clockdomain.h
> +++ b/arch/arm/mach-omap2/clockdomain.h
> @@ -15,7 +15,6 @@
>  #define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_H
>
>  #include <linux/init.h>
> -#include <linux/spinlock.h>
>
>  #include "powerdomain.h"
>  #include "clock.h"
> @@ -139,7 +138,6 @@ struct clockdomain {
>         struct clkdm_dep *sleepdep_srcs;
>         atomic_t usecount;
>         struct list_head node;
> -       spinlock_t lock;
>  };
>
>  /**
> @@ -196,12 +194,16 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1,
> struct clockdomain *clkdm2);
>  int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain
> *clkdm2);
>  int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);
>
> +void clkdm_allow_idle_nolock(struct clockdomain *clkdm);
>  void clkdm_allow_idle(struct clockdomain *clkdm);
> +void clkdm_deny_idle_nolock(struct clockdomain *clkdm);
>  void clkdm_deny_idle(struct clockdomain *clkdm);
>  bool clkdm_in_hwsup(struct clockdomain *clkdm);
>  bool clkdm_missing_idle_reporting(struct clockdomain *clkdm);
>
> +int clkdm_wakeup_nolock(struct clockdomain *clkdm);
>  int clkdm_wakeup(struct clockdomain *clkdm);
> +int clkdm_sleep_nolock(struct clockdomain *clkdm);
>  int clkdm_sleep(struct clockdomain *clkdm);
>
>  int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);
> diff --git a/arch/arm/mach-omap2/powerdomain-clockdomain.h
> b/arch/arm/mach-omap2/powerdomain-clockdomain.h
> new file mode 100644
> index 0000000..e404eec
> --- /dev/null
> +++ b/arch/arm/mach-omap2/powerdomain-clockdomain.h
> @@ -0,0 +1,27 @@
> +/*
> + * OMAP powerdomain functions only for use by the OMAP clockdomain code
> + *
> + * Copyright (C) 2012 Texas Instruments, Inc.
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * The point of this file is to try to prevent other code outside of
> + * clockdomain.c from calling the functions listed herein.  Yes, this
> + * means you.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_CLOCKDOMAIN_H
> +#define __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_CLOCKDOMAIN_H
> +
> +#include <linux/types.h>
> +
> +#include "powerdomain.h"
> +
> +extern void pwrdm_lock(struct powerdomain *pwrdm);
> +extern void pwrdm_unlock(struct powerdomain *pwrdm);
> +extern int pwrdm_state_switch_nolock(struct powerdomain *pwrdm);
> +
> +#endif
> diff --git a/arch/arm/mach-omap2/powerdomain.c
> b/arch/arm/mach-omap2/powerdomain.c
> index 05f00660..2a5f15b 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -19,6 +19,7 @@
>  #include <linux/list.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
> +#include <linux/spinlock.h>
>  #include <trace/events/power.h>
>
>  #include "cm2xxx_3xxx.h"
> @@ -31,6 +32,7 @@
>
>  #include "powerdomain.h"
>  #include "clockdomain.h"
> +#include "clockdomain-powerdomain.h"
>
>  #include "soc.h"
>  #include "pm.h"
> @@ -101,6 +103,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>         pwrdm->voltdm.ptr = voltdm;
>         INIT_LIST_HEAD(&pwrdm->voltdm_node);
>         voltdm_add_pwrdm(voltdm, pwrdm);
> +       spin_lock_init(&pwrdm->_lock);
>
>         list_add(&pwrdm->node, &pwrdm_list);
>
> @@ -276,6 +279,30 @@ int pwrdm_complete_init(void)
>  }
>
>  /**
> + * pwrdm_lock - acquire a Linux spinlock on a powerdomain
> + * @pwrdm: struct powerdomain * to lock
> + *
> + * Acquire the powerdomain spinlock on @pwrdm.  No return value.
> + */
> +void pwrdm_lock(struct powerdomain *pwrdm)
> +       __acquires(&pwrdm->_lock)
> +{
> +       spin_lock_irqsave(&pwrdm->_lock, pwrdm->_lock_flags);
> +}
> +
> +/**
> + * pwrdm_unlock - release a Linux spinlock on a powerdomain
> + * @pwrdm: struct powerdomain * to unlock
> + *
> + * Release the powerdomain spinlock on @pwrdm.  No return value.
> + */
> +void pwrdm_unlock(struct powerdomain *pwrdm)
> +       __releases(&pwrdm->_lock)
> +{
> +       spin_unlock_irqrestore(&pwrdm->_lock, pwrdm->_lock_flags);
> +}
> +
> +/**
>   * pwrdm_lookup - look up a powerdomain by name, return a pointer
>   * @name: name of powerdomain
>   *
> @@ -921,7 +948,7 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
>         return (pwrdm && pwrdm->flags & PWRDM_HAS_HDWR_SAR) ? 1 : 0;
>  }
>
> -int pwrdm_state_switch(struct powerdomain *pwrdm)
> +int pwrdm_state_switch_nolock(struct powerdomain *pwrdm)
>  {
>         int ret;
>
> @@ -935,6 +962,17 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
>         return ret;
>  }
>
> +int __deprecated pwrdm_state_switch(struct powerdomain *pwrdm)
> +{
> +       int ret;
> +
> +       pwrdm_lock(pwrdm);
> +       ret = pwrdm_state_switch_nolock(pwrdm);
> +       pwrdm_unlock(pwrdm);
> +
> +       return ret;
> +}
> +
>  int pwrdm_pre_transition(struct powerdomain *pwrdm)
>  {
>         if (pwrdm)
> @@ -973,7 +1011,7 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct
> powerdomain *pwrdm,
>                         sleep_switch = LOWPOWERSTATE_SWITCH;
>                 } else {
>                         *hwsup = clkdm_in_hwsup(pwrdm->pwrdm_clkdms[0]);
> -                       clkdm_wakeup(pwrdm->pwrdm_clkdms[0]);
> +                       clkdm_wakeup_nolock(pwrdm->pwrdm_clkdms[0]);
>                         sleep_switch = FORCEWAKEUP_SWITCH;
>                 }
>         } else {
> @@ -989,15 +1027,15 @@ static void _pwrdm_restore_clkdm_state(struct
> powerdomain *pwrdm,
>         switch (sleep_switch) {
>         case FORCEWAKEUP_SWITCH:
>                 if (hwsup)
> -                       clkdm_allow_idle(pwrdm->pwrdm_clkdms[0]);
> +                       clkdm_allow_idle_nolock(pwrdm->pwrdm_clkdms[0]);
>                 else
> -                       clkdm_sleep(pwrdm->pwrdm_clkdms[0]);
> +                       clkdm_sleep_nolock(pwrdm->pwrdm_clkdms[0]);
>                 break;
>         case LOWPOWERSTATE_SWITCH:
>                 if (pwrdm->flags & PWRDM_HAS_LOWPOWERSTATECHANGE &&
>                     arch_pwrdm->pwrdm_set_lowpwrstchange)
>                         arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
> -               pwrdm_state_switch(pwrdm);
> +               pwrdm_state_switch_nolock(pwrdm);
>                 break;
>         }
>  }
> @@ -1021,9 +1059,13 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm,
> u8 pwrst)
>                 pwrst--;
>         }
>
> +       pwrdm_lock(pwrdm);
> +
>         next_pwrst = pwrdm_read_next_pwrst(pwrdm);
> -       if (next_pwrst == pwrst)
> +       if (next_pwrst == pwrst) {
> +               pwrdm_unlock(pwrdm);
>                 return ret;
> +       }
>
>         sleep_switch = _pwrdm_save_clkdm_state_and_activate(pwrdm, pwrst,
>                                                             &hwsup);
> @@ -1035,6 +1077,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm,
> u8 pwrst)
>
>         _pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);
>
> +       pwrdm_unlock(pwrdm);
> +
>         return ret;
>  }
>
> diff --git a/arch/arm/mach-omap2/powerdomain.h
> b/arch/arm/mach-omap2/powerdomain.h
> index 1edb3b7..83b4892 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -19,8 +19,7 @@
>
>  #include <linux/types.h>
>  #include <linux/list.h>
> -
> -#include <linux/atomic.h>
> +#include <linux/spinlock.h>
>
>  #include "voltage.h"
>
> @@ -103,6 +102,8 @@ struct powerdomain;
>   * @state_counter:
>   * @timer:
>   * @state_timer:
> + * @_lock: spinlock used to serialize powerdomain and some clockdomain ops
> + * @_lock_flags: stored flags when @_lock is taken
>   *
>   * @prcm_partition possible values are defined in mach-omap2/prcm44xx.h.
>   */
> @@ -127,7 +128,8 @@ struct powerdomain {
>         unsigned state_counter[PWRDM_MAX_PWRSTS];
>         unsigned ret_logic_off_counter;
>         unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
> -
> +       spinlock_t _lock;
> +       unsigned long _lock_flags;
>         const u8 pwrstctrl_offs;
>         const u8 pwrstst_offs;
>         const u32 logicretstate_mask;
> @@ -225,6 +227,7 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
>  int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
>  bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
>
> +int pwrdm_state_switch_nolock(struct powerdomain *pwrdm);
>  int pwrdm_state_switch(struct powerdomain *pwrdm);
>  int pwrdm_pre_transition(struct powerdomain *pwrdm);
>  int pwrdm_post_transition(struct powerdomain *pwrdm);
> @@ -252,5 +255,7 @@ extern u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank);
>  extern struct powerdomain wkup_omap2_pwrdm;
>  extern struct powerdomain gfx_omap2_pwrdm;
>
> +extern void pwrdm_lock(struct powerdomain *pwrdm);
> +extern void pwrdm_unlock(struct powerdomain *pwrdm);
>
>  #endif
>
>
>

--14dae93404f503119104d0a49920
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Paul,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun, =
Dec 9, 2012 at 2:23 AM, Paul Walmsley <span dir=3D"ltr">&lt;<a href=3D"mail=
to:paul@pwsan.com" target=3D"_blank">paul@pwsan.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
Add a per-powerdomain spinlock. =A0Use that instead of the clockdomain<br>
spinlock. =A0Add pwrdm_lock()/pwrdm_unlock() functions to allow other<br>
code to acquire or release the powerdomain spinlock without reaching<br>
directly into the struct powerdomain.<br></blockquote><div>Since clockdomai=
ns are part of powerdomains it seems weird for the clockdomain code to take=
 a powerdoamin lock.<br>Is there a reason why the powerdomain could not tak=
e the lock before calling the clockdomain functions?<br>
<br>Also, are the lock and nolock version the clockdomain function needed?<=
br><br>Regards,<br>Jean<br>=A0<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Signed-off-by: Paul Walmsley &lt;<a href=3D"mailto:paul@pwsan.com">paul@pws=
an.com</a>&gt;<br>
Cc: Jean Pihet &lt;<a href=3D"mailto:jean.pihet@newoldbits.com">jean.pihet@=
newoldbits.com</a>&gt;<br>
---<br>
=A0arch/arm/mach-omap2/clockdomain-powerdomain.h | =A0 22 +++<br>
=A0arch/arm/mach-omap2/clockdomain.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0161 +++++=
++++++++++++--------<br>
=A0arch/arm/mach-omap2/clockdomain.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06 +<b=
r>
=A0arch/arm/mach-omap2/powerdomain-clockdomain.h | =A0 27 ++++<br>
=A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 56 +++++=
+++-<br>
=A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +-<br=
>
=A06 files changed, 219 insertions(+), 64 deletions(-)<br>
=A0create mode 100644 arch/arm/mach-omap2/clockdomain-powerdomain.h<br>
=A0create mode 100644 arch/arm/mach-omap2/powerdomain-clockdomain.h<br>
<br>
diff --git a/arch/arm/mach-omap2/clockdomain-powerdomain.h b/arch/arm/mach-=
omap2/clockdomain-powerdomain.h<br>
new file mode 100644<br>
index 0000000..8beee2d<br>
--- /dev/null<br>
+++ b/arch/arm/mach-omap2/clockdomain-powerdomain.h<br>
@@ -0,0 +1,22 @@<br>
+/*<br>
+ * OMAP clockdomain framework functions for use only by the powerdomain co=
de<br>
+ *<br>
+ * Copyright (C) 2012 Texas Instruments, Inc.<br>
+ * Paul Walmsley<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License version 2 as<br>
+ * published by the Free Software Foundation.<br>
+ */<br>
+<br>
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_POWERDOMAIN_H<br>
+#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_POWERDOMAIN_H<br>
+<br>
+#include &quot;clockdomain.h&quot;<br>
+<br>
+extern void clkdm_allow_idle_nolock(struct clockdomain *clkdm);<br>
+extern void clkdm_deny_idle_nolock(struct clockdomain *clkdm);<br>
+extern int clkdm_wakeup_nolock(struct clockdomain *clkdm);<br>
+extern int clkdm_sleep_nolock(struct clockdomain *clkdm);<br>
+<br>
+#endif<br>
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockd=
omain.c<br>
index 18f65fd..2142dab 100644<br>
--- a/arch/arm/mach-omap2/clockdomain.c<br>
+++ b/arch/arm/mach-omap2/clockdomain.c<br>
@@ -30,6 +30,7 @@<br>
=A0#include &quot;soc.h&quot;<br>
=A0#include &quot;clock.h&quot;<br>
=A0#include &quot;clockdomain.h&quot;<br>
+#include &quot;powerdomain-clockdomain.h&quot;<br>
<br>
=A0/* clkdm_list contains all registered struct clockdomains */<br>
=A0static LIST_HEAD(clkdm_list);<br>
@@ -91,8 +92,6 @@ static int _clkdm_register(struct clockdomain *clkdm)<br>
<br>
=A0 =A0 =A0 =A0 pwrdm_add_clkdm(pwrdm, clkdm);<br>
<br>
- =A0 =A0 =A0 spin_lock_init(&amp;clkdm-&gt;lock);<br>
-<br>
=A0 =A0 =A0 =A0 pr_debug(&quot;clockdomain: registered %s\n&quot;, clkdm-&g=
t;name);<br>
<br>
=A0 =A0 =A0 =A0 return 0;<br>
@@ -733,18 +732,17 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clk=
dm)<br>
=A0}<br>
<br>
=A0/**<br>
- * clkdm_sleep - force clockdomain sleep transition<br>
+ * clkdm_sleep_nolock - force clockdomain sleep transition (lockless)<br>
=A0 * @clkdm: struct clockdomain *<br>
=A0 *<br>
=A0 * Instruct the CM to force a sleep transition on the specified<br>
- * clockdomain @clkdm. =A0Returns -EINVAL if @clkdm is NULL or if<br>
- * clockdomain does not support software-initiated sleep; 0 upon<br>
- * success.<br>
+ * clockdomain @clkdm. =A0Only for use by the powerdomain code. =A0Returns=
<br>
+ * -EINVAL if @clkdm is NULL or if clockdomain does not support<br>
+ * software-initiated sleep; 0 upon success.<br>
=A0 */<br>
-int clkdm_sleep(struct clockdomain *clkdm)<br>
+int clkdm_sleep_nolock(struct clockdomain *clkdm)<br>
=A0{<br>
=A0 =A0 =A0 =A0 int ret;<br>
- =A0 =A0 =A0 unsigned long flags;<br>
<br>
=A0 =A0 =A0 =A0 if (!clkdm)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
@@ -760,27 +758,45 @@ int clkdm_sleep(struct clockdomain *clkdm)<br>
<br>
=A0 =A0 =A0 =A0 pr_debug(&quot;clockdomain: forcing sleep on %s\n&quot;, cl=
kdm-&gt;name);<br>
<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;clkdm-&gt;lock, flags);<br>
=A0 =A0 =A0 =A0 clkdm-&gt;_flags &amp;=3D ~_CLKDM_FLAG_HWSUP_ENABLED;<br>
=A0 =A0 =A0 =A0 ret =3D arch_clkdm-&gt;clkdm_sleep(clkdm);<br>
- =A0 =A0 =A0 ret |=3D pwrdm_state_switch(clkdm-&gt;pwrdm.ptr);<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, flags);<br>
+ =A0 =A0 =A0 ret |=3D pwrdm_state_switch_nolock(clkdm-&gt;pwrdm.ptr);<br>
+<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
<br>
=A0/**<br>
- * clkdm_wakeup - force clockdomain wakeup transition<br>
+ * clkdm_sleep - force clockdomain sleep transition<br>
=A0 * @clkdm: struct clockdomain *<br>
=A0 *<br>
- * Instruct the CM to force a wakeup transition on the specified<br>
- * clockdomain @clkdm. =A0Returns -EINVAL if @clkdm is NULL or if the<br>
- * clockdomain does not support software-controlled wakeup; 0 upon<br>
+ * Instruct the CM to force a sleep transition on the specified<br>
+ * clockdomain @clkdm. =A0Returns -EINVAL if @clkdm is NULL or if<br>
+ * clockdomain does not support software-initiated sleep; 0 upon<br>
=A0 * success.<br>
=A0 */<br>
-int clkdm_wakeup(struct clockdomain *clkdm)<br>
+int clkdm_sleep(struct clockdomain *clkdm)<br>
+{<br>
+ =A0 =A0 =A0 int ret;<br>
+<br>
+ =A0 =A0 =A0 pwrdm_lock(clkdm-&gt;pwrdm.ptr);<br>
+ =A0 =A0 =A0 ret =3D clkdm_sleep_nolock(clkdm);<br>
+ =A0 =A0 =A0 pwrdm_unlock(clkdm-&gt;pwrdm.ptr);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+/**<br>
+ * clkdm_wakeup_nolock - force clockdomain wakeup transition (lockless)<br=
>
+ * @clkdm: struct clockdomain *<br>
+ *<br>
+ * Instruct the CM to force a wakeup transition on the specified<br>
+ * clockdomain @clkdm. =A0Only for use by the powerdomain code. =A0Returns=
<br>
+ * -EINVAL if @clkdm is NULL or if the clockdomain does not support<br>
+ * software-controlled wakeup; 0 upon success.<br>
+ */<br>
+int clkdm_wakeup_nolock(struct clockdomain *clkdm)<br>
=A0{<br>
=A0 =A0 =A0 =A0 int ret;<br>
- =A0 =A0 =A0 unsigned long flags;<br>
<br>
=A0 =A0 =A0 =A0 if (!clkdm)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
@@ -796,28 +812,46 @@ int clkdm_wakeup(struct clockdomain *clkdm)<br>
<br>
=A0 =A0 =A0 =A0 pr_debug(&quot;clockdomain: forcing wakeup on %s\n&quot;, c=
lkdm-&gt;name);<br>
<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;clkdm-&gt;lock, flags);<br>
=A0 =A0 =A0 =A0 clkdm-&gt;_flags &amp;=3D ~_CLKDM_FLAG_HWSUP_ENABLED;<br>
=A0 =A0 =A0 =A0 ret =3D arch_clkdm-&gt;clkdm_wakeup(clkdm);<br>
- =A0 =A0 =A0 ret |=3D pwrdm_state_switch(clkdm-&gt;pwrdm.ptr);<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, flags);<br>
+ =A0 =A0 =A0 ret |=3D pwrdm_state_switch_nolock(clkdm-&gt;pwrdm.ptr);<br>
+<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
<br>
=A0/**<br>
- * clkdm_allow_idle - enable hwsup idle transitions for clkdm<br>
+ * clkdm_wakeup - force clockdomain wakeup transition<br>
=A0 * @clkdm: struct clockdomain *<br>
=A0 *<br>
- * Allow the hardware to automatically switch the clockdomain @clkdm into<=
br>
- * active or idle states, as needed by downstream clocks. =A0If the<br>
+ * Instruct the CM to force a wakeup transition on the specified<br>
+ * clockdomain @clkdm. =A0Returns -EINVAL if @clkdm is NULL or if the<br>
+ * clockdomain does not support software-controlled wakeup; 0 upon<br>
+ * success.<br>
+ */<br>
+int clkdm_wakeup(struct clockdomain *clkdm)<br>
+{<br>
+ =A0 =A0 =A0 int ret;<br>
+<br>
+ =A0 =A0 =A0 pwrdm_lock(clkdm-&gt;pwrdm.ptr);<br>
+ =A0 =A0 =A0 ret =3D clkdm_wakeup_nolock(clkdm);<br>
+ =A0 =A0 =A0 pwrdm_unlock(clkdm-&gt;pwrdm.ptr);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+/**<br>
+ * clkdm_allow_idle_nolock - enable hwsup idle transitions for clkdm<br>
+ * @clkdm: struct clockdomain *<br>
+ *<br>
+ * Allow the hardware to automatically switch the clockdomain @clkdm<br>
+ * into active or idle states, as needed by downstream clocks. =A0If the<b=
r>
=A0 * clockdomain has any downstream clocks enabled in the clock<br>
=A0 * framework, wkdep/sleepdep autodependencies are added; this is so<br>
- * device drivers can read and write to the device. =A0No return value.<br=
>
+ * device drivers can read and write to the device. =A0Only for use by<br>
+ * the powerdomain code. =A0No return value.<br>
=A0 */<br>
-void clkdm_allow_idle(struct clockdomain *clkdm)<br>
+void clkdm_allow_idle_nolock(struct clockdomain *clkdm)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long flags;<br>
-<br>
=A0 =A0 =A0 =A0 if (!clkdm)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
<br>
@@ -833,11 +867,26 @@ void clkdm_allow_idle(struct clockdomain *clkdm)<br>
=A0 =A0 =A0 =A0 pr_debug(&quot;clockdomain: enabling automatic idle transit=
ions for %s\n&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clkdm-&gt;name);<br>
<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;clkdm-&gt;lock, flags);<br>
=A0 =A0 =A0 =A0 clkdm-&gt;_flags |=3D _CLKDM_FLAG_HWSUP_ENABLED;<br>
=A0 =A0 =A0 =A0 arch_clkdm-&gt;clkdm_allow_idle(clkdm);<br>
- =A0 =A0 =A0 pwrdm_state_switch(clkdm-&gt;pwrdm.ptr);<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, flags);<br>
+ =A0 =A0 =A0 pwrdm_state_switch_nolock(clkdm-&gt;pwrdm.ptr);<br>
+}<br>
+<br>
+/**<br>
+ * clkdm_allow_idle - enable hwsup idle transitions for clkdm<br>
+ * @clkdm: struct clockdomain *<br>
+ *<br>
+ * Allow the hardware to automatically switch the clockdomain @clkdm into<=
br>
+ * active or idle states, as needed by downstream clocks. =A0If the<br>
+ * clockdomain has any downstream clocks enabled in the clock<br>
+ * framework, wkdep/sleepdep autodependencies are added; this is so<br>
+ * device drivers can read and write to the device. =A0No return value.<br=
>
+ */<br>
+void clkdm_allow_idle(struct clockdomain *clkdm)<br>
+{<br>
+ =A0 =A0 =A0 pwrdm_lock(clkdm-&gt;pwrdm.ptr);<br>
+ =A0 =A0 =A0 clkdm_allow_idle_nolock(clkdm);<br>
+ =A0 =A0 =A0 pwrdm_unlock(clkdm-&gt;pwrdm.ptr);<br>
=A0}<br>
<br>
=A0/**<br>
@@ -847,12 +896,11 @@ void clkdm_allow_idle(struct clockdomain *clkdm)<br>
=A0 * Prevent the hardware from automatically switching the clockdomain<br>
=A0 * @clkdm into inactive or idle states. =A0If the clockdomain has<br>
=A0 * downstream clocks enabled in the clock framework, wkdep/sleepdep<br>
- * autodependencies are removed. =A0No return value.<br>
+ * autodependencies are removed. =A0Only for use by the powerdomain<br>
+ * code. =A0No return value.<br>
=A0 */<br>
-void clkdm_deny_idle(struct clockdomain *clkdm)<br>
+void clkdm_deny_idle_nolock(struct clockdomain *clkdm)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long flags;<br>
-<br>
=A0 =A0 =A0 =A0 if (!clkdm)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;<br>
<br>
@@ -868,11 +916,25 @@ void clkdm_deny_idle(struct clockdomain *clkdm)<br>
=A0 =A0 =A0 =A0 pr_debug(&quot;clockdomain: disabling automatic idle transi=
tions for %s\n&quot;,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clkdm-&gt;name);<br>
<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;clkdm-&gt;lock, flags);<br>
=A0 =A0 =A0 =A0 clkdm-&gt;_flags &amp;=3D ~_CLKDM_FLAG_HWSUP_ENABLED;<br>
=A0 =A0 =A0 =A0 arch_clkdm-&gt;clkdm_deny_idle(clkdm);<br>
- =A0 =A0 =A0 pwrdm_state_switch(clkdm-&gt;pwrdm.ptr);<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, flags);<br>
+ =A0 =A0 =A0 pwrdm_state_switch_nolock(clkdm-&gt;pwrdm.ptr);<br>
+}<br>
+<br>
+/**<br>
+ * clkdm_deny_idle - disable hwsup idle transitions for clkdm<br>
+ * @clkdm: struct clockdomain *<br>
+ *<br>
+ * Prevent the hardware from automatically switching the clockdomain<br>
+ * @clkdm into inactive or idle states. =A0If the clockdomain has<br>
+ * downstream clocks enabled in the clock framework, wkdep/sleepdep<br>
+ * autodependencies are removed. =A0No return value.<br>
+ */<br>
+void clkdm_deny_idle(struct clockdomain *clkdm)<br>
+{<br>
+ =A0 =A0 =A0 pwrdm_lock(clkdm-&gt;pwrdm.ptr);<br>
+ =A0 =A0 =A0 clkdm_deny_idle_nolock(clkdm);<br>
+ =A0 =A0 =A0 pwrdm_unlock(clkdm-&gt;pwrdm.ptr);<br>
=A0}<br>
<br>
=A0/**<br>
@@ -889,14 +951,11 @@ void clkdm_deny_idle(struct clockdomain *clkdm)<br>
=A0bool clkdm_in_hwsup(struct clockdomain *clkdm)<br>
=A0{<br>
=A0 =A0 =A0 =A0 bool ret;<br>
- =A0 =A0 =A0 unsigned long flags;<br>
<br>
=A0 =A0 =A0 =A0 if (!clkdm)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;<br>
<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;clkdm-&gt;lock, flags);<br>
=A0 =A0 =A0 =A0 ret =3D (clkdm-&gt;_flags &amp; _CLKDM_FLAG_HWSUP_ENABLED) =
? true : false;<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, flags);<br>
<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
@@ -922,12 +981,10 @@ bool clkdm_missing_idle_reporting(struct clockdomain =
*clkdm)<br>
<br>
=A0static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long flags;<br>
-<br>
=A0 =A0 =A0 =A0 if (!clkdm || !arch_clkdm || !arch_clkdm-&gt;clkdm_clk_enab=
le)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;clkdm-&gt;lock, flags);<br>
+ =A0 =A0 =A0 pwrdm_lock(clkdm-&gt;pwrdm.ptr);<br>
<br>
=A0 =A0 =A0 =A0 /*<br>
=A0 =A0 =A0 =A0 =A0* For arch&#39;s with no autodeps, clkcm_clk_enable<br>
@@ -935,13 +992,13 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain=
 *clkdm)<br>
=A0 =A0 =A0 =A0 =A0* enabled, so the clkdm can be force woken up.<br>
=A0 =A0 =A0 =A0 =A0*/<br>
=A0 =A0 =A0 =A0 if ((atomic_inc_return(&amp;clkdm-&gt;usecount) &gt; 1) &am=
p;&amp; autodeps) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, f=
lags);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_unlock(clkdm-&gt;pwrdm.ptr);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 arch_clkdm-&gt;clkdm_clk_enable(clkdm);<br>
- =A0 =A0 =A0 pwrdm_state_switch(clkdm-&gt;pwrdm.ptr);<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, flags);<br>
+ =A0 =A0 =A0 pwrdm_state_switch_nolock(clkdm-&gt;pwrdm.ptr);<br>
+ =A0 =A0 =A0 pwrdm_unlock(clkdm-&gt;pwrdm.ptr);<br>
<br>
=A0 =A0 =A0 =A0 pr_debug(&quot;clockdomain: %s: enabled\n&quot;, clkdm-&gt;=
name);<br>
<br>
@@ -950,27 +1007,25 @@ static int _clkdm_clk_hwmod_enable(struct clockdomai=
n *clkdm)<br>
<br>
=A0static int _clkdm_clk_hwmod_disable(struct clockdomain *clkdm)<br>
=A0{<br>
- =A0 =A0 =A0 unsigned long flags;<br>
-<br>
=A0 =A0 =A0 =A0 if (!clkdm || !arch_clkdm || !arch_clkdm-&gt;clkdm_clk_disa=
ble)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
<br>
- =A0 =A0 =A0 spin_lock_irqsave(&amp;clkdm-&gt;lock, flags);<br>
+ =A0 =A0 =A0 pwrdm_lock(clkdm-&gt;pwrdm.ptr);<br>
<br>
=A0 =A0 =A0 =A0 if (atomic_read(&amp;clkdm-&gt;usecount) =3D=3D 0) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, f=
lags);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_unlock(clkdm-&gt;pwrdm.ptr);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1); /* underflow */<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ERANGE;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 if (atomic_dec_return(&amp;clkdm-&gt;usecount) &gt; 0) {<br=
>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, f=
lags);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_unlock(clkdm-&gt;pwrdm.ptr);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 arch_clkdm-&gt;clkdm_clk_disable(clkdm);<br>
- =A0 =A0 =A0 pwrdm_state_switch(clkdm-&gt;pwrdm.ptr);<br>
- =A0 =A0 =A0 spin_unlock_irqrestore(&amp;clkdm-&gt;lock, flags);<br>
+ =A0 =A0 =A0 pwrdm_state_switch_nolock(clkdm-&gt;pwrdm.ptr);<br>
+ =A0 =A0 =A0 pwrdm_unlock(clkdm-&gt;pwrdm.ptr);<br>
<br>
=A0 =A0 =A0 =A0 pr_debug(&quot;clockdomain: %s: disabled\n&quot;, clkdm-&gt=
;name);<br>
<br>
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockd=
omain.h<br>
index bc42446..e7f1b4b 100644<br>
--- a/arch/arm/mach-omap2/clockdomain.h<br>
+++ b/arch/arm/mach-omap2/clockdomain.h<br>
@@ -15,7 +15,6 @@<br>
=A0#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAIN_H<br>
<br>
=A0#include &lt;linux/init.h&gt;<br>
-#include &lt;linux/spinlock.h&gt;<br>
<br>
=A0#include &quot;powerdomain.h&quot;<br>
=A0#include &quot;clock.h&quot;<br>
@@ -139,7 +138,6 @@ struct clockdomain {<br>
=A0 =A0 =A0 =A0 struct clkdm_dep *sleepdep_srcs;<br>
=A0 =A0 =A0 =A0 atomic_t usecount;<br>
=A0 =A0 =A0 =A0 struct list_head node;<br>
- =A0 =A0 =A0 spinlock_t lock;<br>
=A0};<br>
<br>
=A0/**<br>
@@ -196,12 +194,16 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, st=
ruct clockdomain *clkdm2);<br>
=A0int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *=
clkdm2);<br>
=A0int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm);<br>
<br>
+void clkdm_allow_idle_nolock(struct clockdomain *clkdm);<br>
=A0void clkdm_allow_idle(struct clockdomain *clkdm);<br>
+void clkdm_deny_idle_nolock(struct clockdomain *clkdm);<br>
=A0void clkdm_deny_idle(struct clockdomain *clkdm);<br>
=A0bool clkdm_in_hwsup(struct clockdomain *clkdm);<br>
=A0bool clkdm_missing_idle_reporting(struct clockdomain *clkdm);<br>
<br>
+int clkdm_wakeup_nolock(struct clockdomain *clkdm);<br>
=A0int clkdm_wakeup(struct clockdomain *clkdm);<br>
+int clkdm_sleep_nolock(struct clockdomain *clkdm);<br>
=A0int clkdm_sleep(struct clockdomain *clkdm);<br>
<br>
=A0int clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk);<br>
diff --git a/arch/arm/mach-omap2/powerdomain-clockdomain.h b/arch/arm/mach-=
omap2/powerdomain-clockdomain.h<br>
new file mode 100644<br>
index 0000000..e404eec<br>
--- /dev/null<br>
+++ b/arch/arm/mach-omap2/powerdomain-clockdomain.h<br>
@@ -0,0 +1,27 @@<br>
+/*<br>
+ * OMAP powerdomain functions only for use by the OMAP clockdomain code<br=
>
+ *<br>
+ * Copyright (C) 2012 Texas Instruments, Inc.<br>
+ * Paul Walmsley<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License version 2 as<br>
+ * published by the Free Software Foundation.<br>
+ *<br>
+ * The point of this file is to try to prevent other code outside of<br>
+ * clockdomain.c from calling the functions listed herein. =A0Yes, this<br=
>
+ * means you.<br>
+ */<br>
+<br>
+#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_CLOCKDOMAIN_H<br>
+#define __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_CLOCKDOMAIN_H<br>
+<br>
+#include &lt;linux/types.h&gt;<br>
+<br>
+#include &quot;powerdomain.h&quot;<br>
+<br>
+extern void pwrdm_lock(struct powerdomain *pwrdm);<br>
+extern void pwrdm_unlock(struct powerdomain *pwrdm);<br>
+extern int pwrdm_state_switch_nolock(struct powerdomain *pwrdm);<br>
+<br>
+#endif<br>
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerd=
omain.c<br>
index 05f00660..2a5f15b 100644<br>
--- a/arch/arm/mach-omap2/powerdomain.c<br>
+++ b/arch/arm/mach-omap2/powerdomain.c<br>
@@ -19,6 +19,7 @@<br>
=A0#include &lt;linux/list.h&gt;<br>
=A0#include &lt;linux/errno.h&gt;<br>
=A0#include &lt;linux/string.h&gt;<br>
+#include &lt;linux/spinlock.h&gt;<br>
=A0#include &lt;trace/events/power.h&gt;<br>
<br>
=A0#include &quot;cm2xxx_3xxx.h&quot;<br>
@@ -31,6 +32,7 @@<br>
<br>
=A0#include &quot;powerdomain.h&quot;<br>
=A0#include &quot;clockdomain.h&quot;<br>
+#include &quot;clockdomain-powerdomain.h&quot;<br>
<br>
=A0#include &quot;soc.h&quot;<br>
=A0#include &quot;pm.h&quot;<br>
@@ -101,6 +103,7 @@ static int _pwrdm_register(struct powerdomain *pwrdm)<b=
r>
=A0 =A0 =A0 =A0 pwrdm-&gt;voltdm.ptr =3D voltdm;<br>
=A0 =A0 =A0 =A0 INIT_LIST_HEAD(&amp;pwrdm-&gt;voltdm_node);<br>
=A0 =A0 =A0 =A0 voltdm_add_pwrdm(voltdm, pwrdm);<br>
+ =A0 =A0 =A0 spin_lock_init(&amp;pwrdm-&gt;_lock);<br>
<br>
=A0 =A0 =A0 =A0 list_add(&amp;pwrdm-&gt;node, &amp;pwrdm_list);<br>
<br>
@@ -276,6 +279,30 @@ int pwrdm_complete_init(void)<br>
=A0}<br>
<br>
=A0/**<br>
+ * pwrdm_lock - acquire a Linux spinlock on a powerdomain<br>
+ * @pwrdm: struct powerdomain * to lock<br>
+ *<br>
+ * Acquire the powerdomain spinlock on @pwrdm. =A0No return value.<br>
+ */<br>
+void pwrdm_lock(struct powerdomain *pwrdm)<br>
+ =A0 =A0 =A0 __acquires(&amp;pwrdm-&gt;_lock)<br>
+{<br>
+ =A0 =A0 =A0 spin_lock_irqsave(&amp;pwrdm-&gt;_lock, pwrdm-&gt;_lock_flags=
);<br>
+}<br>
+<br>
+/**<br>
+ * pwrdm_unlock - release a Linux spinlock on a powerdomain<br>
+ * @pwrdm: struct powerdomain * to unlock<br>
+ *<br>
+ * Release the powerdomain spinlock on @pwrdm. =A0No return value.<br>
+ */<br>
+void pwrdm_unlock(struct powerdomain *pwrdm)<br>
+ =A0 =A0 =A0 __releases(&amp;pwrdm-&gt;_lock)<br>
+{<br>
+ =A0 =A0 =A0 spin_unlock_irqrestore(&amp;pwrdm-&gt;_lock, pwrdm-&gt;_lock_=
flags);<br>
+}<br>
+<br>
+/**<br>
=A0 * pwrdm_lookup - look up a powerdomain by name, return a pointer<br>
=A0 * @name: name of powerdomain<br>
=A0 *<br>
@@ -921,7 +948,7 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)<br>
=A0 =A0 =A0 =A0 return (pwrdm &amp;&amp; pwrdm-&gt;flags &amp; PWRDM_HAS_HD=
WR_SAR) ? 1 : 0;<br>
=A0}<br>
<br>
-int pwrdm_state_switch(struct powerdomain *pwrdm)<br>
+int pwrdm_state_switch_nolock(struct powerdomain *pwrdm)<br>
=A0{<br>
=A0 =A0 =A0 =A0 int ret;<br>
<br>
@@ -935,6 +962,17 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
<br>
+int __deprecated pwrdm_state_switch(struct powerdomain *pwrdm)<br>
+{<br>
+ =A0 =A0 =A0 int ret;<br>
+<br>
+ =A0 =A0 =A0 pwrdm_lock(pwrdm);<br>
+ =A0 =A0 =A0 ret =3D pwrdm_state_switch_nolock(pwrdm);<br>
+ =A0 =A0 =A0 pwrdm_unlock(pwrdm);<br>
+<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
=A0int pwrdm_pre_transition(struct powerdomain *pwrdm)<br>
=A0{<br>
=A0 =A0 =A0 =A0 if (pwrdm)<br>
@@ -973,7 +1011,7 @@ static u8 _pwrdm_save_clkdm_state_and_activate(struct =
powerdomain *pwrdm,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D LOWPOWERST=
ATE_SWITCH;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *hwsup =3D clkdm_in_hwsup(p=
wrdm-&gt;pwrdm_clkdms[0]);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_wakeup(pwrdm-&gt;pwrdm_=
clkdms[0]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_wakeup_nolock(pwrdm-&gt=
;pwrdm_clkdms[0]);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D FORCEWAKEU=
P_SWITCH;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
=A0 =A0 =A0 =A0 } else {<br>
@@ -989,15 +1027,15 @@ static void _pwrdm_restore_clkdm_state(struct powerd=
omain *pwrdm,<br>
=A0 =A0 =A0 =A0 switch (sleep_switch) {<br>
=A0 =A0 =A0 =A0 case FORCEWAKEUP_SWITCH:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hwsup)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(pwrdm-&gt;pw=
rdm_clkdms[0]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle_nolock(pwrdm=
-&gt;pwrdm_clkdms[0]);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_sleep(pwrdm-&gt;pwrdm_c=
lkdms[0]);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_sleep_nolock(pwrdm-&gt;=
pwrdm_clkdms[0]);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
=A0 =A0 =A0 =A0 case LOWPOWERSTATE_SWITCH:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrdm-&gt;flags &amp; PWRDM_HAS_LOWPOWE=
RSTATECHANGE &amp;&amp;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch_pwrdm-&gt;pwrdm_set_lowpwrstch=
ange)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch_pwrdm-&gt;pwrdm_set_lo=
wpwrstchange(pwrdm);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_state_switch(pwrdm);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_state_switch_nolock(pwrdm);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
=A0 =A0 =A0 =A0 }<br>
=A0}<br>
@@ -1021,9 +1059,13 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, =
u8 pwrst)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst--;<br>
=A0 =A0 =A0 =A0 }<br>
<br>
+ =A0 =A0 =A0 pwrdm_lock(pwrdm);<br>
+<br>
=A0 =A0 =A0 =A0 next_pwrst =3D pwrdm_read_next_pwrst(pwrdm);<br>
- =A0 =A0 =A0 if (next_pwrst =3D=3D pwrst)<br>
+ =A0 =A0 =A0 if (next_pwrst =3D=3D pwrst) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_unlock(pwrdm);<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
+ =A0 =A0 =A0 }<br>
<br>
=A0 =A0 =A0 =A0 sleep_switch =3D _pwrdm_save_clkdm_state_and_activate(pwrdm=
, pwrst,<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;hwsup);<br>
@@ -1035,6 +1077,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u=
8 pwrst)<br>
<br>
=A0 =A0 =A0 =A0 _pwrdm_restore_clkdm_state(pwrdm, sleep_switch, hwsup);<br>
<br>
+ =A0 =A0 =A0 pwrdm_unlock(pwrdm);<br>
+<br>
=A0 =A0 =A0 =A0 return ret;<br>
=A0}<br>
<br>
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerd=
omain.h<br>
index 1edb3b7..83b4892 100644<br>
--- a/arch/arm/mach-omap2/powerdomain.h<br>
+++ b/arch/arm/mach-omap2/powerdomain.h<br>
@@ -19,8 +19,7 @@<br>
<br>
=A0#include &lt;linux/types.h&gt;<br>
=A0#include &lt;linux/list.h&gt;<br>
-<br>
-#include &lt;linux/atomic.h&gt;<br>
+#include &lt;linux/spinlock.h&gt;<br>
<br>
=A0#include &quot;voltage.h&quot;<br>
<br>
@@ -103,6 +102,8 @@ struct powerdomain;<br>
=A0 * @state_counter:<br>
=A0 * @timer:<br>
=A0 * @state_timer:<br>
+ * @_lock: spinlock used to serialize powerdomain and some clockdomain ops=
<br>
+ * @_lock_flags: stored flags when @_lock is taken<br>
=A0 *<br>
=A0 * @prcm_partition possible values are defined in mach-omap2/prcm44xx.h.=
<br>
=A0 */<br>
@@ -127,7 +128,8 @@ struct powerdomain {<br>
=A0 =A0 =A0 =A0 unsigned state_counter[PWRDM_MAX_PWRSTS];<br>
=A0 =A0 =A0 =A0 unsigned ret_logic_off_counter;<br>
=A0 =A0 =A0 =A0 unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];<br>
-<br>
+ =A0 =A0 =A0 spinlock_t _lock;<br>
+ =A0 =A0 =A0 unsigned long _lock_flags;<br>
=A0 =A0 =A0 =A0 const u8 pwrstctrl_offs;<br>
=A0 =A0 =A0 =A0 const u8 pwrstst_offs;<br>
=A0 =A0 =A0 =A0 const u32 logicretstate_mask;<br>
@@ -225,6 +227,7 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);<b=
r>
=A0int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);<br>
=A0bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);<br>
<br>
+int pwrdm_state_switch_nolock(struct powerdomain *pwrdm);<br>
=A0int pwrdm_state_switch(struct powerdomain *pwrdm);<br>
=A0int pwrdm_pre_transition(struct powerdomain *pwrdm);<br>
=A0int pwrdm_post_transition(struct powerdomain *pwrdm);<br>
@@ -252,5 +255,7 @@ extern u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank);=
<br>
=A0extern struct powerdomain wkup_omap2_pwrdm;<br>
=A0extern struct powerdomain gfx_omap2_pwrdm;<br>
<br>
+extern void pwrdm_lock(struct powerdomain *pwrdm);<br>
+extern void pwrdm_unlock(struct powerdomain *pwrdm);<br>
<br>
=A0#endif<br>
<br>
<br>
</blockquote></div><br></div>

--14dae93404f503119104d0a49920--


--===============5028304741382457285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5028304741382457285==--
