From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCHv5 5/6] ARM: OMAP3PLUS PM: Add IO Daisychain support via
 hwmod mux
Date: Fri, 22 Jun 2012 17:15:19 +0530
Message-ID: <4FE45ACF.3070200@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:44283 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752049Ab2FVLp1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 07:45:27 -0400
Received: by obbeh20 with SMTP id eh20so1891619obb.24
        for <linux-omap@vger.kernel.org>; Fri, 22 Jun 2012 04:45:25 -0700 (PDT)
In-Reply-To: <1331046702-2472-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

Hi,

On Tuesday 06 March 2012 08:41 PM, Tero Kristo wrote:
> From: Vishwanath BS<vishwanath.bs@ti.com>
>
> IO Daisychain feature has to be triggered whenever there is a change in
> device's mux configuration (See section 3.9.4 in OMAP4 Public TRM vP).
>
> Now devices can idle independent of the powerdomain, there can be a
> window where device is idled and corresponding powerdomain can be
> ON/INACTIVE state. In such situations, since both module wake up is
> enabled at padlevel as well as io daisychain sequence is triggered,
> there will be 2 PRCM interrupts (Module async wake up via swakeup and
> IO Pad interrupt). But as PRCM Interrupt handler clears the Module
> Padlevel WKST bit in the first interrupt, module specific interrupt
> handler will not triggered for the second time
>
> Also look at detailed explanation given by Rajendra at
> http://www.spinics.net/lists/linux-serial/msg04480.html
>
> Signed-off-by: Vishwanath BS<vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo<t-kristo@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod.c |    9 +++++++--
>   arch/arm/mach-omap2/pm.c         |   21 +++++++++++++++++++++
>   arch/arm/mach-omap2/pm.h         |    1 +
>   3 files changed, 29 insertions(+), 2 deletions(-)
>

>   /* Types of sleep_switch used in omap_set_pwrdm_state */
>   #define FORCEWAKEUP_SWITCH	0
>   #define LOWPOWERSTATE_SWITCH	1
> @@ -221,6 +236,12 @@ static int __init omap2_common_pm_init(void)
>   		omap2_init_processor_devices();
>   	omap_pm_if_init();
>
> +	if (cpu_is_omap34xx()&&  omap3_has_io_chain_ctrl())
> +		io_chain_trigger_func = omap3_trigger_io_chain;

While testing with one of Tero's OMAP4 OFF mode support branches (which
also include these patches) I found a OMAP4 standalone build fails
here..

CC      arch/arm/mach-omap2/omap_hwmod.o
arch/arm/mach-omap2/omap_hwmod.c: In function '_reconfigure_io_chain':
arch/arm/mach-omap2/omap_hwmod.c:1797: error: implicit declaration of 
function 'omap3xxx_prm_reconfigure_io_chain'
make[1]: *** [arch/arm/mach-omap2/omap_hwmod.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

regards,
Rajendra

> +
> +	if (cpu_is_omap44xx())
> +		io_chain_trigger_func = omap4_trigger_io_chain;
> +
>   	return 0;
>   }
>   postcore_initcall(omap2_common_pm_init);
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index b737b11..f9dac40 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -22,6 +22,7 @@ extern int omap3_can_sleep(void);
>   extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>   extern int omap3_idle_init(void);
>   extern int omap4_idle_init(void);
> +extern void omap_trigger_io_chain(void);
>
>   #if defined(CONFIG_PM_OPP)
>   extern int omap3_opp_init(void);

