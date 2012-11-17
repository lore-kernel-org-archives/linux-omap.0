From: Joel A Fernandes <agnel.joel@gmail.com>
Subject: Re: [PATCH] AM33XX: Clock: Fix JTAG disconnect during kernel boot
Date: Fri, 16 Nov 2012 20:44:00 -0600
Message-ID: <CAD=GYpaWkKaPyXGvZtYvtcebrWYDTeF7sdgTSRzR18_Ntq6-tw@mail.gmail.com>
References: <1353109482-26478-1-git-send-email-joelagnel@ti.com>
	<50A6D672.1020104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48297 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab2KQCoB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Nov 2012 21:44:01 -0500
Received: by mail-qa0-f46.google.com with SMTP id c11so3732287qad.19
        for <linux-omap@vger.kernel.org>; Fri, 16 Nov 2012 18:44:00 -0800 (PST)
In-Reply-To: <50A6D672.1020104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Joel A Fernandes <joelagnel@ti.com>, linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, Matt Porter <mporter@ti.com>, Steve Kipisz <s-kipisz2@ti.com>, Jason Kridner <jkridner@beagleboard.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Hi Jon,

On Fri, Nov 16, 2012 at 6:12 PM, Jon Hunter <jon-hunter@ti.com> wrote:
> > diff --git a/arch/arm/mach-omap2/clock33xx_data.c
> > b/arch/arm/mach-omap2/clock33xx_data.c
> > index b7b7995..d0b4313 100644
> > --- a/arch/arm/mach-omap2/clock33xx_data.c
> > +++ b/arch/arm/mach-omap2/clock33xx_data.c
> > @@ -585,6 +585,7 @@ static struct clk debugss_ick = {
> >       .clkdm_name     = "l3_aon_clkdm",
> >       .parent         = &dpll_core_m4_ck,
> >       .ops            = &clkops_omap2_dflt,
> > +     .flags          = ENABLE_ON_INIT,
> >       .enable_reg     = AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
> >       .enable_bit     = AM33XX_MODULEMODE_SWCTRL,
> >       .recalc         = &followparent_recalc,
>
> Does this mean this clock will always be enabled, even when not using
> JTAG? If so, is that what you want?

Yes, the clock will always be on, because some times we connect JTAG
on a running Linux system without powering it down. I can't comment
without doing measurements if keeping the clock on has significant
impact on power, but I see what you mean. Definitely low power is a
parameter and folks who want lowest possible power might need to turn
off the clock and not have JTAG in production, but that depends on the
user's requirement. I personally don't care about power as much as I
care about not being able to JTAG, and I think there are other folks
who suffer from the same JTAG problem who wouldn't necessarily want
lowest power.

> I was not sure if you are concerned about power at all. Or if having
> that always enabled can inhibit low power states for suspend/idle etc.

Maybe, suspend/resume code can turn off clock on suspend and enable it
on resume.

> May be worth adding more details to the changelog about if there are
> side-effects to this change or not.

Sure, will do after waiting for any other review comments.

Thanks,
Joel
