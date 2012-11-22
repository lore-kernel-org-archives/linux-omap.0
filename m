From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: AM335x: Beaglebone stops to boot with current git kernel
Date: Thu, 22 Nov 2012 14:56:40 -0600
Message-ID: <CAD=GYparyZ8kB+pX+SptSaNPHD-Ey9vBC1Q4nDcTKJLenpNK=w@mail.gmail.com>
References: <k80da6$61d$1@ger.gmane.org>
	<CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
	<20121121183809.GZ18567@atomide.com>
	<CAK0ocyD25pRcQthN90inWy-95Yaa-B94rw724_uS5Y7FRA4qjQ@mail.gmail.com>
	<50ADBB5B.7090401@ti.com>
	<CAK0ocyCe3oJ8ynpNWpzcCFHtG3J4u7NBeNPTJK0GikFHaPAXOA@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83EB7F222@DBDE01.ent.ti.com>
	<CAK0ocyD7fGzj1GuFP7EhFYqmLv66A0phNrxV6rAL9b9ejPYfvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:33106 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756134Ab2KVU4m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 15:56:42 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so1068528qad.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Nov 2012 12:56:41 -0800 (PST)
In-Reply-To: <CAK0ocyD7fGzj1GuFP7EhFYqmLv66A0phNrxV6rAL9b9ejPYfvg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Mazanov <i.mazanov@gmail.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Tony Lindgren <tony@atomide.com>, Jean Pihet <jean.pihet@newoldbits.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Vaibhav, Igor,

On and off due to vacation time too,..

Not sure but I missed the below patch from Vaibhav as it probably
wasn't copied to linux-omap so I got confused which patch was Igor
testing, whether it was the one in which we set ENABLE_ON_INIT or the
one in which hwmod data is changed.

I think Igor tried the latter and it works. In that case, I guess we
can drop the ENABLE_ON_INIT patch if this is a better fix. I had some
comments though...

On Thu, Nov 22, 2012 at 10:40 AM, Igor Mazanov <i.mazanov@gmail.com> wrote:
> On Thu, Nov 22, 2012 at 6:49 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
[..]
>>> I have quickly created patch for you, can you try below patch and let me
>>> know?
>>>
>>>
>>>
>>> diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
>>> index ea64ad6..c9af78c 100644
>>> --- a/arch/arm/mach-omap2/cclock33xx_data.c
>>> +++ b/arch/arm/mach-omap2/cclock33xx_data.c
>>> @@ -920,6 +920,7 @@ static const char *enable_init_clks[] = {
>>>         "l4hs_gclk",
>>>         "l4fw_gclk",
>>>         "l4ls_gclk",
>>> +       "debugss_ick",
>>>  };
>>>
>>>  int __init am33xx_clk_init(void)
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>>> index ad8d43b..750b897 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
>>> @@ -460,27 +460,6 @@ static struct omap_hwmod am33xx_clkdiv32k_hwmod = {
>>>         },
>>>  };
>>>
>>> -/*
>>> - * 'debugss' class
>>> - * debug sub system
>>> - */
>>> -static struct omap_hwmod_class am33xx_debugss_hwmod_class = {
>>> -       .name           = "debugss",
>>> -};
>>> -
>>> -static struct omap_hwmod am33xx_debugss_hwmod = {
>>> -       .name           = "debugss",
>>> -       .class          = &am33xx_debugss_hwmod_class,
>>> -       .clkdm_name     = "l3_aon_clkdm",
>>> -       .main_clk       = "debugss_ick",
>>> -       .prcm           = {
>>> -               .omap4  = {
>>> -                       .clkctrl_offs   = AM33XX_CM_WKUP_DEBUGSS_CLKCTRL_OFFSET,
>>> -                       .modulemode     = MODULEMODE_SWCTRL,
>>> -               },
>>> -       },
>>> -};
>>> -
>>> /* ocmcram */
>>>  static struct omap_hwmod_class am33xx_ocmcram_hwmod_class = {
>>>         .name = "ocmcram",
>>> @@ -570,6 +549,28 @@ static struct omap_hwmod am33xx_sha0_hwmod = {
>>>
>>>  #endif
>>>
>>> +/*
>>> + * 'debugss' class
>>> + * debug sub system
>>> + */
>>> +static struct omap_hwmod_class am33xx_debugss_hwmod_class = {
>>> +       .name           = "debugss",
>>> +};
>>> +
>>> +static struct omap_hwmod am33xx_debugss_hwmod = {
>>> +       .name           = "debugss",
>>> +       .class          = &am33xx_debugss_hwmod_class,
>>> +       .clkdm_name     = "l3_aon_clkdm",
>>> +       .main_clk       = "debugss_ick",
>>> +       .flags          =  (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),

Setting these flags would still leave the problem where JTAG clocks
are on when its not required no? In that case, what is the advantage
of this patch?


Regards,

Joel
