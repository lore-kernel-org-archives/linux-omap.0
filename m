From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt controller
Date: Tue, 20 Oct 2009 09:01:38 -0700
Message-ID: <87oco2njfh.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
	<13B9B4C6EF24D648824FF11BE8967162039B2A021C@dlee02.ent.ti.com>
	<004f01ca4e88$be2a6a50$3d1018ac@am.dhcp.ti.com>
	<13B9B4C6EF24D648824FF11BE8967162039B317F66@dlee02.ent.ti.com>
	<005001ca4e8b$ea107c10$3d1018ac@am.dhcp.ti.com>
	<1F18D6510CF0474A8C9500565A7E41A210F69EEFFB@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:44148 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbZJTQBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 12:01:36 -0400
Received: by pzk26 with SMTP id 26so4187417pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 09:01:40 -0700 (PDT)
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A210F69EEFFB@NOK-EUMSG-02.mgdnok.nokia.com> (Tero Kristo's message of "Mon\, 19 Oct 2009 12\:18\:34 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com
Cc: girishsg@ti.com, r-woodruff2@ti.com, linux-omap@vger.kernel.org, jouni.hogander@nokia.com

<Tero.Kristo@nokia.com> writes:

>>> 
>>> There was one report from a custom board when it made a 
>>difference.  I've not tried to double check
>>> this data.  I don't have the reporters setup so there is no 
>>guarantee I could reproduce anyway.  In
>>> general optimization seemed to make sense.
>>
>>I second it.
>>
>>
>>Regards,
>>Girish
>>
>>
>
> Is there errata number available for this issue by the way? I could attach this to the patch.
>
> Anyway, I guess the optimization would look something like this:
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 210a806..7a98321 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -93,6 +93,8 @@ u32 voltage_off_while_idle;
>                 OMAP3430_ST_GPT5_MASK|OMAP3430_ST_GPT4_MASK|\
>                 OMAP3430_ST_GPT3_MASK|OMAP3430_ST_GPT2_MASK)
>
> +#define INTC_SYSCONFIG                 0x10
> +
>  struct power_state {
>         struct powerdomain *pwrdm;
>         u32 next_state;
> @@ -505,6 +507,12 @@ void omap_sram_idle(void)
>                 prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
>                 omap3_enable_io_chain();
>         }
> +       /*
> +        * Disable INTC autoidle as it can cause interrupt controller
> +        * to enter unknown state with right combination of sleep / wakeup
> +        * transitions
> +        */
> +       omap_writel(0x0, OMAP34XX_IC_BASE + INTC_SYSCONFIG);

Except omap_write* functions are deprecated.

I'd rather see a call into the interrupt code.  Something like
omap_intc_prepare_idle()

Also, isn't this only needed if CORE != ON?

>         /*
>         * On EMU/HS devices ROM code restores a SRDC value
> @@ -561,6 +569,8 @@ void omap_sram_idle(void)
>                                                 OMAP3430_GR_MOD,
>                                                 OMAP3_PRM_VOLTCTRL_OFFSET);
>         }
> +       /* Re-enable interrupt controller autoidle */
> +       omap_writel(OMAP3430_AUTOIDLE, OMAP34XX_IC_BASE + INTC_SYSCONFIG);

and omap_intc_resume_idle()

Kevin
