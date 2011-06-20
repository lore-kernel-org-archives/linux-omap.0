From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap2+: pm: Fix section mismatch in pm_dbg_init()
Date: Mon, 20 Jun 2011 14:09:39 -0700
Message-ID: <87tybk6wh8.fsf@ti.com>
References: <1308256260-15597-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57892 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752454Ab1FTVJo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Jun 2011 17:09:44 -0400
Received: by mail-pv0-f170.google.com with SMTP id 10so8421818pvh.1
        for <linux-omap@vger.kernel.org>; Mon, 20 Jun 2011 14:09:43 -0700 (PDT)
In-Reply-To: <1308256260-15597-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Fri, 17 Jun 2011 02:01:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Sanjeev Premi <premi@ti.com> writes:

> Fix the section mismatch warning:
>
>   WARNING: vmlinux.o(.text+0x21118): Section mismatch
>   in reference from the function pm_dbg_init() to the
>   function .init.text:pwrdms_setup()
>   The function pm_dbg_init() references
>   the function __init pwrdms_setup().
>   This is often because pm_dbg_init lacks a __init
>   annotation or the annotation of pwrdms_setup is wrong.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  Applies to current linux-omap master

A previous commit just removed the __init annotation here because of a
different conflict with the regset init.   The regset code is now
removed in my queue for 3.1, so this patch is fine on top of that
series.

Queueing for v3.1 (branch: for_3.1/pm-misc)

Thanks,

Kevin



>
>  arch/arm/mach-omap2/pm-debug.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index e01da45..ef33273 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -595,7 +595,7 @@ static int option_set(void *data, u64 val)
>  
>  DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set, "%llu\n");
>  
> -static int pm_dbg_init(void)
> +static int __init pm_dbg_init(void)
>  {
>  	int i;
>  	struct dentry *d;
