From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 05/11] OMAP2+: PM: provide mechanism to describe overall behavior of osc and PMIC.
Date: Fri, 04 Nov 2011 14:02:24 -0700
Message-ID: <87d3d78uu7.fsf@ti.com>
References: <1317835031-8201-1-git-send-email-t-kristo@ti.com>
	<1317835031-8201-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54398 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751926Ab1KDVCa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 17:02:30 -0400
Received: by iadj38 with SMTP id j38so3295109iad.9
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 14:02:29 -0700 (PDT)
In-Reply-To: <1317835031-8201-6-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Wed, 5 Oct 2011 20:17:05 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

Tero Kristo <t-kristo@ti.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> We currently have mechanisms in place to describe the PMIC per
> rail, however we also need to configure the system for situations
> such as OFF mode, where, oscillator switch off and on time, and
> similar durations for PMIC also tends to play a major factor.
> Introduce a few apis to OMAP2's pm framework to use these. OMAP1
> does'nt seem to need this at the moment, hence not a OMAP generic
> framework. The set functions are meant to be used by initialization
> code.
>
> The OMAP specific implementation would need to use this ofcourse.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

> ---
>  arch/arm/mach-omap2/pm.c |  122 ++++++++++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h |   18 +++++++
>  2 files changed, 140 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 659e400..e130d92 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -24,6 +24,52 @@
>  #include "clockdomain.h"
>  #include "pm.h"
>  
> +/**
> + * struct omap2_pm_lp_description - Describe low power behavior of the system
> + * @oscillator_startup_time:	Time rounded up to uSec for the oscillator to
> + *				provide a stable clock from power on.
> + * @oscillator_shutdown_time:	Time rounded up to uSec for oscillator to safely
> + *				switch off.
> + * @pmic_startup_time:		Time rounded up to uSec for the PMIC to
> + *				provide be ready for operation from low power
> + *				state. Note: this is not the same as voltage
> + *				rampup time, instead, consider the PMIC to be
> + *				in lowest power state(say OFF), this is the time
> + *				required for it to become ready for it's DCDCs
> + *				or LDOs to start operation.
> + * @pmic_shutdown_time:		Time rounded up to uSec for the PMIC to
> + *				go to low power after the LDOs are pulled to
> + *				appropriate state. Note: this is not the same as
> + *				voltage rampdown time, instead, consider the
> + *				PMIC to have switched it's LDOs down, this is
> + *				time taken to reach it's lowest power state(say
> + *				sleep/OFF).

IMO, These PMIC times should be part of the existing struct that
describes all the configurable PMIC settings.

Kevin
