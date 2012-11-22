From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: [PATCH] AM33XX: Clock: Fix JTAG disconnect during kernel boot
Date: Thu, 22 Nov 2012 15:04:51 -0600
Message-ID: <CAD=GYpYud6TQ2QTKkHppTjsmGTA_1SNHiZ3FBCmWVbx7PTF9kg@mail.gmail.com>
References: <1353109482-26478-1-git-send-email-joelagnel@ti.com>
	<50A6D672.1020104@ti.com>
	<CAD=GYpaWkKaPyXGvZtYvtcebrWYDTeF7sdgTSRzR18_Ntq6-tw@mail.gmail.com>
	<50AA5B14.6010909@ti.com>
	<50ADB860.2090707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63234 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010Ab2KVVEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 16:04:51 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so1071580qad.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Nov 2012 13:04:51 -0800 (PST)
In-Reply-To: <50ADB860.2090707@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Joel A Fernandes <joelagnel@ti.com>, linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, Matt Porter <mporter@ti.com>, Steve Kipisz <s-kipisz2@ti.com>, Jason Kridner <jkridner@beagleboard.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi Vaibhav,

> The it should be handled is, on kernel_debug option we should keep it
> enabled and default it should be disabled.
>
> Something similar to,
>
>
>
> diff --git a/arch/arm/mach-omap2/clock33xx_data.c
> b/arch/arm/mach-omap2/clock33xx_data.c
> index 17e3de5..60e0b53 100644
> --- a/arch/arm/mach-omap2/clock33xx_data.c
> +++ b/arch/arm/mach-omap2/clock33xx_data.c
> @@ -584,6 +584,9 @@ static struct clk debugss_ick = {
>         .clkdm_name     = "l3_aon_clkdm",
>         .parent         = &dpll_core_m4_ck,
>         .ops            = &clkops_omap2_dflt,
> +#ifdef CONFIG_DEBUG_KERNEL
> +       .flags          = ENABLE_ON_INIT,
> +#endif

Yes, looks like its a good idea to wrap the flag around a config
option, but I see you posted another patch where hwmod data is changed
for debugss_ick and Igor reported it to be working. Either approach is
ok with me.

Regards,
Joel
