From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: omap2: Use a consistent AM33XX SoC option
 description
Date: Wed, 21 Aug 2013 00:55:01 -0700
Message-ID: <20130821075501.GY7656@atomide.com>
References: <1375997528-396-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <CABxcv=keV2Jf4gDwF477a9Msk6b-RgDBcxK1QyhchWffbKAoXw@mail.gmail.com>
 <20130820164251.GC4889@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61585 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab3HUHzE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Aug 2013 03:55:04 -0400
Content-Disposition: inline
In-Reply-To: <20130820164251.GC4889@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Ezequiel Garcia <ezequiel.garcia@free-electrons.com> [130820 09:49]:
> On Fri, Aug 09, 2013 at 11:18:43AM +0200, Javier Martinez Canillas wrote:
> > On Thu, Aug 8, 2013 at 11:32 PM, Ezequiel Garcia
> > <ezequiel.garcia@free-electrons.com> wrote:
> > > Fix the option description to match the other TI SoCs.
> > > This is just a cosmetic change.
> > >
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  arch/arm/mach-omap2/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > > index 76170dd..56021c6 100644
> > > --- a/arch/arm/mach-omap2/Kconfig
> > > +++ b/arch/arm/mach-omap2/Kconfig
> > > @@ -64,7 +64,7 @@ config SOC_OMAP5
> > >         select ARM_ERRATA_798181 if SMP
> > >
> > >  config SOC_AM33XX
> > > -       bool "AM33XX support"
> > > +       bool "TI AM33XX"
> > >         depends on ARCH_MULTI_V7
> > >         select ARCH_OMAP2PLUS
> > >         select ARM_CPU_SUSPEND if PM
> > > --
> > > 1.8.1.5
> > >
> > >
> > 
> > Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>
> 
> ping?

Applying to omap-for-v3.12/fixes-non-critical thanks.

Tony
