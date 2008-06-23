From: "shekhar, chandra" <x0044955@ti.com>
Subject: Re: [PATCH 11/21] ARM: OMAP: McBSP: Prepare for splitting intoomap1 and omap2 code
Date: Mon, 23 Jun 2008 16:04:22 +0530
Message-ID: <071401c8d51c$b5bf8fd0$6ff6180a@ent.ti.com>
References: <1212802253-17797-5-git-send-email-tony@atomide.com> <1212802253-17797-6-git-send-email-tony@atomide.com> <1212802253-17797-7-git-send-email-tony@atomide.com> <1212802253-17797-8-git-send-email-tony@atomide.com> <1212802253-17797-9-git-send-email-tony@atomide.com> <1212802253-17797-10-git-send-email-tony@atomide.com> <1212802253-17797-11-git-send-email-tony@atomide.com> <1212802253-17797-12-git-send-email-tony@atomide.com> <20080614081720.GK32122@flint.arm.linux.org.uk> <20080617084153.GG13078@atomide.com> <20080623093947.GF7741@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:44804 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754008AbYFWKei (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 06:34:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, linux-omap@vger.kernel.org, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>

Hi,
i was about to send the same patch.  it works fine for me.
chandra Shekhar


----- Original Message ----- 
From: "Tony Lindgren" <tony@atomide.com>
To: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
Cc: <linux-arm-kernel@lists.arm.linux.org.uk>; "Eduardo Valentin" 
<eduardo.valentin@indt.org.br>; <linux-omap@vger.kernel.org>; "Nikula Jarkko 
(NRC/Helsinki)" <jarkko.nikula@nokia.com>
Sent: Monday, June 23, 2008 3:09 PM
Subject: Re: [PATCH 11/21] ARM: OMAP: McBSP: Prepare for splitting intoomap1 
and omap2 code


>* Tony Lindgren <tony@atomide.com> [080617 11:43]:
>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080614 11:17]:
>> > On Fri, Jun 06, 2008 at 06:30:43PM -0700, Tony Lindgren wrote:
>> > > +#if defined(CONFIG_OMAP_MCBSP) || defined(CONFIG_OMAP_MCBSP_MODULE)
>> > > +
>> > > +static struct platform_device 
>> > > omap_mcbsp_devices[OMAP_MAX_MCBSP_COUNT];
>> > > +static int mcbsps_configured;
>> > > +
>> > > +void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data 
>> > > *config,
>> > > + int size)
>> > > +{
>> > > + int i;
>> > > +
>> > > + if (size > OMAP_MAX_MCBSP_COUNT) {
>> > > + printk(KERN_WARNING "Registered too many McBSPs platform_data."
>> > > + " Using maximum (%d) available.\n",
>> > > + OMAP_MAX_MCBSP_COUNT);
>> > > + size = OMAP_MAX_MCBSP_COUNT;
>> > > + }
>> > > +
>> > > + for (i = 0; i < size; i++) {
>> > > + struct platform_device *new_mcbsp = &omap_mcbsp_devices[i];
>> >
>> > Any reason this can't use the platform_device_alloc() API rather than
>> > having a static restriction on the number (coupled with the wastage of
>> > space for smaller 'size's ?)
>>
>> I agree, this should be allocated. Eduardo, any comments?
>
> Here's updated patch that uses platform_device_alloc().
>
> Tony
>


--------------------------------------------------------------------------------


> From 53f2999d681669df0645053dc572d97cda69823d Mon Sep 17 00:00:00 2001
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> Date: Mon, 23 Jun 2008 12:37:30 +0300
> Subject: [PATCH] ARM: OMAP: McBSP: Prepare for splitting into omap1 and 
> omap2 code
>
> This patch transform mcbsp code to use platform data
> from arch/arm/plat-omap/devices.c
>
> It also gets ride of ifdefs on mcbsp.c code.
> To do it, a platform data structure was defined.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index 4a53f9b..81002b7 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -24,6 +24,7 @@
> #include <asm/arch/mux.h>
> #include <asm/arch/gpio.h>
> #include <asm/arch/menelaus.h>
> +#include <asm/arch/mcbsp.h>
>
> #if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
>
> @@ -145,6 +146,53 @@ static inline void omap_init_kp(void) {}
> #endif
>
> /*-------------------------------------------------------------------------*/
> +#if defined(CONFIG_OMAP_MCBSP) || defined(CONFIG_OMAP_MCBSP_MODULE)
> +
> +static struct platform_device **omap_mcbsp_devices;
> +
> +void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data 
> *config,
> + int size)
> +{
> + int i;
> +
> + if (size > OMAP_MAX_MCBSP_COUNT) {
> + printk(KERN_WARNING "Registered too many McBSPs platform_data."
> + " Using maximum (%d) available.\n",
> + OMAP_MAX_MCBSP_COUNT);
> + size = OMAP_MAX_MCBSP_COUNT;
> + }
> +
> + omap_mcbsp_devices = kzalloc(size * sizeof(struct platform_device *),
> +      GFP_KERNEL);
> + if (!omap_mcbsp_devices) {
> + printk(KERN_ERR "Could not register McBSP devices\n");
> + return;
> + }
> +
> + for (i = 0; i < size; i++) {
> + struct platform_device *new_mcbsp;
> + int ret;
> +
> + new_mcbsp = platform_device_alloc("omap-mcbsp", i + 1);
> + if (!new_mcbsp)
> + continue;
> + new_mcbsp->dev.platform_data = &config[i];
> + ret = platform_device_add(new_mcbsp);
> + if (ret) {
> + platform_device_put(new_mcbsp);
> + continue;
> + }
> + omap_mcbsp_devices[i] = new_mcbsp;
> + }
> +}
> +
> +#else
> +void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data 
> *config,
> + int size)
> +{  }
> +#endif
> +
> +/*-------------------------------------------------------------------------*/

