From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv3 4/6] ARM: OMAP3 PM: Enable IO Wake up
Date: Thu, 01 Mar 2012 12:22:42 +0530
Message-ID: <4F4F1CBA.7040502@ti.com>
References: <1330525621-29836-1-git-send-email-t-kristo@ti.com> <1330525621-29836-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:57438 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756671Ab2CAGwt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Mar 2012 01:52:49 -0500
Received: by mail-yw0-f45.google.com with SMTP id o21so87247yho.32
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 22:52:48 -0800 (PST)
In-Reply-To: <1330525621-29836-5-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

On Wednesday 29 February 2012 07:56 PM, Tero Kristo wrote:
> From: Vishwanath BS<vishwanath.bs@ti.com>
>
> Enable IO Wake up for OMAP3 as part of PM Init. Currently this has been
> managed in cpuidle path which is not the right place. Subsequent patch
> will remove IO Daisy chain handling in cpuidle path once daisy chain is
> handled as part of hwmod mux.
>
> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
> Tested-by: Govindraj.R<govindraj.raja@ti.com>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/pm34xx.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index e97ec3f..e6c2d39 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -793,6 +793,10 @@ static int __init omap3_pm_init(void)
>   		goto err1;
>   	}
>
> +	if (omap3_has_io_wakeup())
> +		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
> +					   PM_WKEN);

On OMAP4 this GLOBAL IO chain enable happens as part of the trigger
function itself, it might make sense to do that for OMAP3 too to avoid
similar issues as seen on OMAP4 when the GLOBAL switch is enabled too
late in boot. The best however would be to get rid of it in the trigger
function and enable this early during PM init, but I am not sure whats
a good place to do this 'early' enough.

regards,
Rajendra

> +
>   	ret = pwrdm_for_each(pwrdms_setup, NULL);
>   	if (ret) {
>   		printk(KERN_ERR "Failed to setup powerdomains\n");

