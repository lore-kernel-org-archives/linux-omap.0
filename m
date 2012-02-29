From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 1/9] cpuidle: Add common time keeping and irq enabling
Date: Wed, 29 Feb 2012 10:43:34 -0800
Message-ID: <87obsheazt.fsf@ti.com>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
	<1330485109-7327-2-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59540 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965939Ab2B2Snm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 13:43:42 -0500
Received: by mail-pw0-f47.google.com with SMTP id rp12so5205365pbb.6
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 10:43:41 -0800 (PST)
In-Reply-To: <1330485109-7327-2-git-send-email-rob.lee@linaro.org> (Robert
	Lee's message of "Tue, 28 Feb 2012 21:11:41 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Lee <rob.lee@linaro.org>
Cc: len.brown@intel.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, jean.pihet@newoldbits.com, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org

Robert Lee <rob.lee@linaro.org> writes:

> Make necessary changes to implement time keeping and irq enabling
> in the core cpuidle code.  This will allow the removal of these
> functionalities from various platform cpuidle implementations whose
> timekeeping and irq enabling follows the form in this common code.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
>  arch/arm/include/asm/cpuidle.h |   14 ++++++
>  drivers/cpuidle/cpuidle.c      |   90 ++++++++++++++++++++++++++++++++--------
>  include/linux/cpuidle.h        |   13 ++++++
>  3 files changed, 99 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm/include/asm/cpuidle.h
>
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> new file mode 100644
> index 0000000..1d2075b
> --- /dev/null
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -0,0 +1,14 @@
> +#ifndef __ASM_ARM_CPUIDLE_H
> +#define __ASM_ARM_CPUIDLE_H
> +
> +/* Common ARM WFI state */
> +#define CPUIDLE_ARM_WFI_STATE {\
> +	.enter                  = cpuidle_simple_enter,\
> +	.exit_latency           = 1,\
> +	.target_residency       = 1,\
> +	.flags                  = CPUIDLE_FLAG_TIME_VALID,\
> +	.name                   = "WFI",\
> +	.desc                   = "ARM core clock gating (WFI)",\
> +}

nit: just name this ARM WFI.  Clock gating is platform specific, and
"core" has platform-specific meanings, so in order to keep this truly
generic, I think hat ARM WFI is the best name.

Kevin


