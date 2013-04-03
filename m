From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 05/18] ARM: OMAP5: PM: Enables ES2 PM mode by default
Date: Wed, 03 Apr 2013 13:25:22 -0700
Message-ID: <876203wedp.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
	<1364205910-32392-6-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33506 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761353Ab3DCUZZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 16:25:25 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so1050356pdc.14
        for <linux-omap@vger.kernel.org>; Wed, 03 Apr 2013 13:25:24 -0700 (PDT)
In-Reply-To: <1364205910-32392-6-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:34:57 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Enables MPUSS ES2 power management mode using ES2_PM_MODE in
> AMBA_IF_MODE register.
>
> 0x0: ES1 behavior, CPU cores would enter and exit OFF mode together. Broken

What is broken?

> 0x1: ES2 behavior, CPU cores are allowed to enter/exit OFF mode independently.
>
> The AMBA_IF_MODE register value is stored on SAR RAM and restored by
> ROM code.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap-secure.h    |    2 ++
>  arch/arm/mach-omap2/omap-wakeupgen.c |   19 +++++++++++++++++++
>  arch/arm/mach-omap2/omap-wakeupgen.h |    1 +
>  3 files changed, 22 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
> index 0e72917..82b3c4c 100644
> --- a/arch/arm/mach-omap2/omap-secure.h
> +++ b/arch/arm/mach-omap2/omap-secure.h
> @@ -42,6 +42,8 @@
>  #define OMAP4_MON_L2X0_AUXCTRL_INDEX	0x109
>  #define OMAP4_MON_L2X0_PREFETCH_INDEX	0x113
>  
> +#define OMAP5_MON_AMBA_IF_INDEX		0x108
> +
>  /* Secure PPA(Primary Protected Application) APIs */
>  #define OMAP4_PPA_L2_POR_INDEX		0x23
>  #define OMAP4_PPA_CPU_ACTRL_SMP_INDEX	0x25
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index f8bb3b9..8bcaa8c 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -42,6 +42,7 @@
>  #define CPU1_ID			0x1
>  #define OMAP4_NR_BANKS		4
>  #define OMAP4_NR_IRQS		128
> +#define OMAP5_AMBA_IF_PM_MODE	(1 << 5)

nit: use BIT()

Kevin
