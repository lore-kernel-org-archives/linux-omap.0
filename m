From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] arm: omap3: pm34xx.c: Replace printk() with appropriate
 pr_*()
Date: Fri, 16 Mar 2012 16:42:16 +0400
Message-ID: <4F633528.1040305@ru.mvista.com>
References: <1331852833-4357-1-git-send-email-mgreer@animalcreek.com> <1331852833-4357-3-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:57561 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756300Ab2CPMnj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Mar 2012 08:43:39 -0400
In-Reply-To: <1331852833-4357-3-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 16-03-2012 3:07, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>

> Currently, pm34xx.c has a mix of printk() and pr_*() statements
> so replace the printk() statements with the equivalent pr_*()
> statements.

> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>   arch/arm/mach-omap2/pm34xx.c |   17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)

> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index af8d741..495e509 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
[...]
> @@ -463,7 +462,7 @@ restore:
>   	list_for_each_entry(pwrst,&pwrst_list, node) {
>   		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
>   		if (state>  pwrst->next_state) {
> -			printk(KERN_INFO "Powerdomain (%s) didn't enter "
> +			pr_info("Powerdomain (%s) didn't enter "
>   			       "target state %d\n",

    Last line should have been realigned I think.

>   			       pwrst->pwrdm->name, pwrst->next_state);
>   			ret = -1;
> @@ -471,9 +470,9 @@ restore:
>   		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
>   	}
>   	if (ret)
> -		printk(KERN_ERR "Could not enter target state in pm_suspend\n");
> +		pr_err("Could not enter target state in pm_suspend\n");
>   	else
> -		printk(KERN_INFO "Successfully put all powerdomains "
> +		pr_info("Successfully put all powerdomains "
>   		       "to target state\n");

    Last line should have been realigned I think.

>
>   	return ret;
> @@ -865,7 +864,7 @@ static int __init omap3_pm_init(void)
>   		omap3_secure_ram_storage =
>   			kmalloc(0x803F, GFP_KERNEL);
>   		if (!omap3_secure_ram_storage)
> -			printk(KERN_ERR "Memory allocation failed when"
> +			pr_err("Memory allocation failed when"

    BTW, space after "when" is missing here.

>   					"allocating for secure sram context\n");

    Should have been realigned I think.

WBR, Sergei
