From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 12/17] OMAP2/3: Do not enable AUTOIDLE in interrupt
 controller
Date: Mon, 19 Oct 2009 12:21:56 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B318A18@dlee02.ent.ti.com>
References: <> <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52873 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757145AbZJSRWI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 13:22:08 -0400
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A210F69EEFFB@NOK-EUMSG-02.mgdnok.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>, "Ghongdemath, Girish" <girishsg@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "jouni.hogander@nokia.com" <jouni.hogander@nokia.com>



> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tero.Kristo@nokia.com
> Sent: Monday, October 19, 2009 5:19 AM

> Is there errata number available for this issue by the way? I could attach
> this to the patch.

No.  I expect in the next few weeks it will be published.  The issue is pretty well understood now down to gate level so time to publish should be process.

> Anyway, I guess the optimization would look something like this:

The below looks good.

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
>
>         /*
>         * On EMU/HS devices ROM code restores a SRDC value
> @@ -561,6 +569,8 @@ void omap_sram_idle(void)
>                                                 OMAP3430_GR_MOD,
>
> OMAP3_PRM_VOLTCTRL_OFFSET);
>         }
> +       /* Re-enable interrupt controller autoidle */
> +       omap_writel(OMAP3430_AUTOIDLE, OMAP34XX_IC_BASE + INTC_SYSCONFIG);
>
>         /*
>          * Enable smartreflex after WFI. Only needed if we

