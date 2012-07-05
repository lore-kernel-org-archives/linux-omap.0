From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: RFC: Simplification of Power Domain Control
Date: Thu, 5 Jul 2012 15:06:59 +0200
Message-ID: <CAORVsuUAjJwybo8_t=RATHCzb3mAtLnsUyS8pjhs0Vg702pRaw@mail.gmail.com>
References: <1341492461-24119-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40471 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579Ab2GENHB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 09:07:01 -0400
Received: by lbbgm6 with SMTP id gm6so12710249lbb.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Jul 2012 06:06:59 -0700 (PDT)
In-Reply-To: <1341492461-24119-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, paul@pwsan.com
Cc: j-pihet@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, b-cousson@ti.com, dderrick@ti.com, linux-omap@vger.kernel.org

Hi Rajendra,

On Thu, Jul 5, 2012 at 2:47 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> Hi,
>
> This RFC is aimed at simplifying the powerdomain control
> (in software) for OMAP. Powerdomains on OMAP have been
> fairly complex to program (as compared to other SoCs)
> mainly due to the multiple memory/logic control exposed
> to software. These controls are limited to achieving
> whats know as 'OSWR: Open Switch Retention' state in OMAP.
> Rest of the states supported (ON, INACTIVE, CSWR, OFF) are
> fairly easy to program needing just a target power state
> to be configured.
>
> While in theory, the hardware does expose multiple ways/
> combinations in which OSWR can be achieved, we in software
> have always been  using just *one* combination all along.
> OSWR has always been configured as *logic lost, all memory
> retained* for all current OMAPs supported.
>
> With future OMAPs planning to get rid of all the memory/logic
> control altogether it makes sense to look at the apis exposed
> through the current powerdomain framework to its users (like
> cpuilde, suspend etc) and see if those could also be simplified.
>
> The RFC is suspend tested on OMAP4430sdp and
> OMAP3630Beagle-Xm.
This looks very similar to the functional power states patches that I
submitted a few times for review [1].
The idea is to simplify the external API to program the power domains
states. The code has been used to implement the OMAP4 device OFF
support (from Tero) and the per-device PM QoS implementation for OMAP
[2].

[1] http://marc.info/?l=linux-omap&m=133968580905048&w=2
[2] http://marc.info/?l=linux-omap&m=133968657005566&w=2

Now that we have more than one implementation, I let it to the
maintainers for decision.

Paul, what do you think?

A few remarks here below.

Thanks for your RFC!

>
> regards,
> Rajendra
>
> ----
> From 5f5e4eb342110286bf719c7d9d7c1959f53e34f9 Mon Sep 17 00:00:00 2001
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Thu, 5 Jul 2012 17:33:28 +0530
> Subject: [RFC] ARM: OMAP: Powerdomain: control memory and logic bits internally
>
> Powerdomain framework exposes various apis for memory and logic
> control for powerdomains, for its users to program OSWR: Open SWitch
> Retention state. While in theory, there are various combinations of
> memory and logic states possible which can be configured as OSWR,
> in practice all OMAPs use just one combination. Logic lost, memory retained.
>
> This can very easily be handled within the powerdomain framework itself,
> without exposing all complex memory/logic control apis to upper layer
> drivers like cpuidle and suspend.
>
> To do this, introduce 2 new power domain states PWRDM_POWER_CSWR and
> PWRDM_POWER_OSWR usable by the users of powerdomain framework and
> make all memory/logic control apis internal to powerdomain framework.
> Change all users of powerdomain framework to get rid of all usage
> of memory/logic control apis and use the newly defined states for
> CSWR and OSWR with the already used powerstate control apis.
>
> Some functions (which are now made internal) are forward declared
> to avoid moving functions around in the file (which can be done in a
> later patch) to help keep the patch reviewable.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c                |    9 +---
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c        |    7 +--
>  arch/arm/mach-omap2/pm24xx.c                     |   17 +------
>  arch/arm/mach-omap2/pm34xx.c                     |    8 ++--
>  arch/arm/mach-omap2/pm44xx.c                     |   11 +---
>  arch/arm/mach-omap2/powerdomain-private.h        |   17 +++++++
>  arch/arm/mach-omap2/powerdomain.c                |   54 +++++++++++++++++++---
>  arch/arm/mach-omap2/powerdomain.h                |   14 +-----
>  arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    1 +
>  arch/arm/mach-omap2/powerdomains2xxx_data.c      |    1 +
>  arch/arm/mach-omap2/powerdomains3xxx_data.c      |    1 +
>  arch/arm/mach-omap2/powerdomains44xx_data.c      |    1 +
>  12 files changed, 85 insertions(+), 56 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/powerdomain-private.h
>
...

> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index 13670aa..41d559b 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
...
> @@ -243,7 +243,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>         case PWRDM_POWER_OFF:
>                 save_state = 1;
>                 break;
> -       case PWRDM_POWER_RET:
> +       case PWRDM_POWER_CSWR:
>         default:
>                 /*
>                  * CPUx CSWR is invalid hardware state. Also CPUx OSWR
> @@ -262,8 +262,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>          * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
>          */
>         mpuss_clear_prev_logic_pwrst();
> -       if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
> -               (pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
> +       if (pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_OSWR)
This is the kind of simplification that proves the benefit of the new API.

>                 save_state = 2;
>
>         cpu_clear_prev_logic_pwrst(cpu);
...
> diff --git a/arch/arm/mach-omap2/powerdomain-private.h b/arch/arm/mach-omap2/powerdomain-private.h
> new file mode 100644
> index 0000000..0c2dd23
> --- /dev/null
> +++ b/arch/arm/mach-omap2/powerdomain-private.h
> @@ -0,0 +1,17 @@
> +/*
> + * Internal powerdomain header
> + *
> + * Copyright (C) 2012 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_PRIVATE_H
> +#define __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_PRIVATE_H
> +
> +#define PWRDM_POWER_RET                0x1
> +
> +#endif /* __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_PRIVATE_H */
I like this ;p
In fact much more of the powerdomain*.[ch] should be hidden in the
private API header file.
My patch series addresses this by separating the private from the
public APIs in powerdomain.h.

...

Regards,
Jean
