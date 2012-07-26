From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Thu, 26 Jul 2012 16:06:30 -0700
Message-ID: <20120726230630.GA21004@animalcreek.com>
References: <WC20120713105737.0900A2@terrafix.co.uk>
 <alpine.DEB.2.00.1207131217590.25585@utopia.booyaka.com>
 <20120717004010.GA6612@animalcreek.com>
 <alpine.DEB.2.00.1207161841260.28834@utopia.booyaka.com>
 <WC20120717100848.280191@terrafix.co.uk>
 <alpine.DEB.2.00.1207171326510.28834@utopia.booyaka.com>
 <20120718022035.GC18663@animalcreek.com>
 <WC20120718100634.8301FB@terrafix.co.uk>
 <20120718172654.GA27904@animalcreek.com>
 <CAKvrXUpeC2N-CRLuVGPKNVEV_tqRfGF1EgsYJ8f4mHjo7oEY5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:52928 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab2GZXGf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 19:06:35 -0400
Content-Disposition: inline
In-Reply-To: <CAKvrXUpeC2N-CRLuVGPKNVEV_tqRfGF1EgsYJ8f4mHjo7oEY5w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Thu, Jul 26, 2012 at 02:09:33PM -0700, Juha Kuikka wrote:

Hi Juha.

> A thousand apologizes for double posting, some html sneaked into the
> first email and it got dropped by the list server.
> 
> I am running on a gumstix with OMAP 3503 on it (name escapes me at the
> moment) and it has the same issue.

Okay, I didn't know if the 3503 would have that issue or not.

> Just applying Mark's patch on top of
> 55936cdfaaf11ac352b56bc58e42d6661e65ee13 (linux-omap) is not enough, I
> also need to set the OMAP3_HAS_IVA_REGS for the 3430 as well.
> 
> Inlined patch:
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 4072fbd..45d3eb4 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -244,7 +244,7 @@ void __init omap3xxx_check_features(void)
>         if (cpu_is_omap3630())
>                 omap_features |= OMAP3_HAS_192MHZ_CLK | OMAP3_HAS_IVA_REGS;
>         if (cpu_is_omap3430() || cpu_is_omap3630())
> -               omap_features |= OMAP3_HAS_IO_WAKEUP;
> +               omap_features |= OMAP3_HAS_IO_WAKEUP | OMAP3_HAS_IVA_REGS;
>         if (cpu_is_omap3630() || omap_rev() == OMAP3430_REV_ES3_1 ||
>             omap_rev() == OMAP3430_REV_ES3_1_2)
>                 omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;

Thank you.

> Here is with I see with this patch:
> /debug/pm_debug # echo mem > /sys/power/state
> [ 1058.657928] PM: Syncing filesystems ... done.
> [ 1058.669616] Freezing user space processes ... (elapsed 0.02 seconds) done.
> [ 1058.703094] Freezing remaining freezable tasks ... (elapsed 0.02
> seconds) done.
> [ 1058.734252] Suspending console(s) (use no_console_suspend to debug)
> [ 1058.921936] PM: suspend of devices complete after 161.285 msecs
> [ 1058.938995] PM: late suspend of devices complete after 16.936 msecs
> [ 1058.963134] PM: noirq suspend of devices complete after 23.986 msecs
> [ 1060.013336] Successfully put all powerdomains to target state
> [ 1060.025726] PM: noirq resume of devices complete after 11.810 msecs
> [ 1060.042480] PM: early resume of devices complete after 10.437 msecs
> [ 1060.481353] PM: resume of devices complete after 438.415 msecs
> [ 1060.547912] Restarting tasks ... done.
> 
> /debug/pm_debug # cat /debug/pm_debug/count
> usbhost_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> sgx_pwrdm (OFF),OFF:1,RET:0,INA:0,ON:0,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> core_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0
> per_pwrdm (ON),OFF:0,RET:1,INA:0,ON:2,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> dss_pwrdm (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> cam_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> neon_pwrdm (ON),OFF:0,RET:710,INA:0,ON:711,RET-LOGIC-OFF:0
> mpu_pwrdm (ON),OFF:0,RET:710,INA:0,ON:711,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> iva2_pwrdm (RET),OFF:0,RET:1,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-MEMBANK2-OFF:0,RET-MEMBANK3-OFF:0,RET-MEMBANK4-OFF:0
> usbhost_clkdm->usbhost_pwrdm (1)
> sgx_clkdm->sgx_pwrdm (0)
> per_clkdm->per_pwrdm (18)
> cam_clkdm->cam_pwrdm (0)
> dss_clkdm->dss_pwrdm (1)
> d2d_clkdm->core_pwrdm (0)
> iva2_clkdm->iva2_pwrdm (0)
> mpu_clkdm->mpu_pwrdm (0)
> core_l4_clkdm->core_pwrdm (24)
> core_l3_clkdm->core_pwrdm (4)
> neon_clkdm->neon_pwrdm (0)
> 
> I see that the usbhost domain is still not hitting retention but for
> some reason it is not being complained about in suspend messages.

This may be part of what Kevin Hilman, Keshava Munegowda, et. al.,
have been talking about,

	http://www.spinics.net/lists/linux-omap/msg70743.html

Mark
