From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/5] omap2plus: clockdomain: Trivial fix for build break
 because of clktrctrl_mask
Date: Wed, 5 Jan 2011 00:15:34 +0530
Message-ID: <5a948c5fdbd4d4f8e9ee0404f3b3f348@mail.gmail.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
 <1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com> <alpine.DEB.2.00.1101041141260.19319@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42371 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751104Ab1ADSpg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:45:36 -0500
Received: by yxd39 with SMTP id 39so7541483yxd.26
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 10:45:35 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101041141260.19319@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>, tony@atomide.com, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Wednesday, January 05, 2011 12:13 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; khilman@ti.com; tony@atomide.com;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/5] omap2plus: clockdomain: Trivial fix for
> build break because of clktrctrl_mask
>
> Hi Santosh
>
> On Tue, 4 Jan 2011, Santosh Shilimkar wrote:
>
> > struct clockdomain member clktrctrl_mask is available for only for
> OMAP2
> > and OMAP3 architectures. Technially it is also used only for these
> archs
> > but this breaks the build with custom OMAP4 configuration.
> >
> >  CC      arch/arm/mach-omap2/clockdomain.o
> > arch/arm/mach-omap2/clockdomain.c: In function '_enable_hwsup':
> > arch/arm/mach-omap2/clockdomain.c:251: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > arch/arm/mach-omap2/clockdomain.c:254: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > arch/arm/mach-omap2/clockdomain.c: In function '_disable_hwsup':
> > arch/arm/mach-omap2/clockdomain.c:277: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > arch/arm/mach-omap2/clockdomain.c:280: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > arch/arm/mach-omap2/clockdomain.c: In function
> 'omap2_clkdm_sleep':
> > arch/arm/mach-omap2/clockdomain.c:744: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > arch/arm/mach-omap2/clockdomain.c: In function
> 'omap2_clkdm_wakeup':
> > arch/arm/mach-omap2/clockdomain.c:789: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > arch/arm/mach-omap2/clockdomain.c: In function
> 'omap2_clkdm_clk_enable':
> > arch/arm/mach-omap2/clockdomain.c:922: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > arch/arm/mach-omap2/clockdomain.c:926: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > arch/arm/mach-omap2/clockdomain.c: In function
> 'omap2_clkdm_clk_disable':
> > arch/arm/mach-omap2/clockdomain.c:994: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > arch/arm/mach-omap2/clockdomain.c:998: error: 'struct clockdomain'
> has no member named 'clktrctrl_mask'
> > make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
> > make: *** [arch/arm/mach-omap2] Error 2
> >
> > Fix the build break with use of ARCH_OMAP2PLUS instead of OMAP2 or
> OMAP3
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> >  arch/arm/mach-omap2/clockdomain.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-
> omap2/clockdomain.h
> > index de3faa2..6fa82f5 100644
> > --- a/arch/arm/mach-omap2/clockdomain.h
> > +++ b/arch/arm/mach-omap2/clockdomain.h
> > @@ -103,7 +103,7 @@ struct clockdomain {
> >  		const char *name;
> >  		struct powerdomain *ptr;
> >  	} pwrdm;
> > -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> > +#ifdef CONFIG_ARCH_OMAP2PLUS
>
> No need for this, just drop the #ifdef...
>
Perfect. Will fix this in v2

> >  	const u16 clktrctrl_mask;
>
>
> - Paul
