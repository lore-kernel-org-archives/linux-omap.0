From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 01/11] OMAP: PM: Export the main pm debugfs directory
Date: Mon, 25 Oct 2010 11:29:38 +0200
Message-ID: <4CC54E02.7090008@ti.com>
References: <1285166719-19352-1-git-send-email-thara@ti.com> <1285166719-19352-2-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35672 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816Ab0JYJ3m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Oct 2010 05:29:42 -0400
In-Reply-To: <1285166719-19352-2-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>

On 9/22/2010 4:45 PM, Gopinath, Thara wrote:
> This patch makes generic pm_debug directory  global
> so that other drivers can include it and use it to create
> sub-entries.

That should not be needed, if we expose voltage debugfs entry in the top 
level directly.

Benoit

>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> ---
>   arch/arm/mach-omap2/pm-debug.c |    3 +++
>   arch/arm/mach-omap2/pm.h       |    1 +
>   2 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index af00c17..390f1c6 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -42,6 +42,7 @@ u32 enable_off_mode;
>   u32 sleep_while_idle;
>   u32 wakeup_timer_seconds;
>   u32 wakeup_timer_milliseconds;
> +struct dentry *pm_dbg_main_dir;
>
>   #define DUMP_PRM_MOD_REG(mod, reg)    \
>   	regs[reg_count].name = #mod "." #reg; \
> @@ -641,6 +642,8 @@ static int __init pm_dbg_init(void)
>   	(void) debugfs_create_file("wakeup_timer_milliseconds",
>   			S_IRUGO | S_IWUGO, d,&wakeup_timer_milliseconds,
>   			&pm_dbg_option_fops);
> +
> +	pm_dbg_main_dir = d;
>   	pm_dbg_init_done = 1;
>
>   	return 0;
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index f3ba1e6..c06cedd 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -55,6 +55,7 @@ extern int omap2_pm_debug;
>   #define omap2_pm_dump(mode, resume, us)		do {} while (0);
>   #define omap2_pm_wakeup_on_timer(seconds, milliseconds)	do {} while (0);
>   #define omap2_pm_debug				0
> +#define pm_dbg_main_dir				0
>   #endif
>
>   #if defined(CONFIG_CPU_IDLE)

