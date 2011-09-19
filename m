From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv8 06/16] power: omap-prm: added chain interrupt handler
Date: Mon, 19 Sep 2011 19:16:18 +0530
Message-ID: <CAAL8m4xb4KsgPdWaQCgiEApY6mwKXCeepzZxOjoC_NSvN-U4SQ@mail.gmail.com>
References: <1316189150-21448-1-git-send-email-t-kristo@ti.com> <1316189150-21448-7-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33402 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab1ISNqj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Sep 2011 09:46:39 -0400
Received: by bkbzt4 with SMTP id zt4so5304869bkb.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Sep 2011 06:46:38 -0700 (PDT)
In-Reply-To: <1316189150-21448-7-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm@lists.arm.linux.org.uk, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, "Avinash.H.M" <avinashhm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>

Hi Tero,

On Fri, Sep 16, 2011 at 9:35 PM, Tero Kristo <t-kristo@ti.com> wrote:
> Introduce a chained interrupt handler mechanism for the PRCM
> interrupt, so that individual PRCM event can cleanly be handled by
> handlers in separate drivers. We do this by introducing PRCM event
> names, which are then matched to the particular PRCM interrupt bit
> depending on the specific OMAP SoC being used.
>
> Driver detects the version of the PRM module in use via PRM hwmod
> revision. This hwmod also defines the interrupt number for the chain
> handler. Driver itself contains SoC specific data for register offset=
s
> within the PRM module, and contains a list of supported PRCM interrup=
t
> events.
>
> PRCM interrupts have two priority levels, high or normal. High priori=
ty
> is needed for IO event handling, so that we can be sure that IO event=
s
> are processed before other events. This reduces latency for IO event
> customers and also prevents incorrect ack sequence on OMAP3.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Avinash.H.M <avinashhm@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> ---
> =A0drivers/power/omap_prm.c =A0 =A0 =A0 | =A0351 ++++++++++++++++++++=
+++++++++++++++++++-
> =A0include/linux/power/omap_prm.h | =A0 19 +++
> =A02 files changed, 368 insertions(+), 2 deletions(-)
> =A0create mode 100644 include/linux/power/omap_prm.h
>

[..]


> diff --git a/include/linux/power/omap_prm.h b/include/linux/power/oma=
p_prm.h
> new file mode 100644
> index 0000000..9b161b5
> --- /dev/null
> +++ b/include/linux/power/omap_prm.h
> @@ -0,0 +1,19 @@
> +/*
> + * OMAP Power and Reset Management (PRM) driver
> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + *
> + * Author: Tero Kristo <t-kristo@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __LINUX_POWER_OMAP_PRM_H__
> +#define __LINUX_POWER_OMAP_PRM_H__
> +
> +int omap_prcm_event_to_irq(const char *name);

Minor comment,

When omap_prm driver is not enabled by default leads to compilation
break as in [1]

So we should either have omap_prm driver default enabled from Kconfig
or Have dummy omap_prcm_event_to_irq func if omap_prm is not defined.

--
Thanks,
Govindraj.R

[1]:
arch/arm/mach-omap2/built-in.o: In function `omap_mux_late_init':
/home/ubnuser/clones/mirror/linux-omap-pm/arch/arm/mach-omap2/mux.c:799=
:
undefined reference to `omap_prcm_event_to_irq'
arch/arm/mach-omap2/built-in.o: In function `omap3_pm_init':
/home/ubnuser/clones/mirror/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:=
817:
undefined reference to `omap_prcm_event_to_irq'
/home/ubnuser/clones/mirror/linux-omap-pm/arch/arm/mach-omap2/pm34xx.c:=
826:
undefined reference to `omap_prcm_event_to_irq'
make: *** [.tmp_vmlinux1] Error 1
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
