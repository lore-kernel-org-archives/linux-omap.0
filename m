From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] fix omap3 sram virtual addres overlap vmalloc space
	after increasing vmalloc size
Date: Wed, 5 Aug 2009 16:40:55 +0300
Message-ID: <20090805134055.GH7374@atomide.com>
References: <1247784477.25106.35.camel@debian-nb> <alpine.DEB.2.00.0907171603190.18924@utopia.booyaka.com> <1248192120.3931.7.camel@debian-nb> <alpine.DEB.2.00.0907211009240.19170@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61894 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934393AbZHENlC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 09:41:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0907211009240.19170@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Janboe Ye <yuan-bo.ye@motorola.com>, linux-omap@vger.kernel.org, mans@mansr.com, khilman@deeprootsystems.com, Hong Mei Li <hong-mei.li@motorola.com>

* Paul Walmsley <paul@pwsan.com> [090721 19:10]:
> On Tue, 21 Jul 2009, Janboe Ye wrote:
> 
> > Thanks, Paul
> > 
> > Tony
> > 
> > Is there some issue about this patch?
> 
> Tony's on vacation right now, so you shouldn't expect a response from him 
> until he returns.
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg14015.html

I've added this patch to my omap-fixes queue, had to apply it manually
because of the omap4 defines.

Tony

> 
> 
> - Paul
> 
> > 
> > Thanks
> > 
> > Janboe Ye
> > 
> > On Fri, 2009-07-17 at 16:04 -0600, Paul Walmsley wrote:
> > > On Thu, 16 Jul 2009, Janboe Ye wrote:
> > > 
> > > > resend for mini coding style fixing
> > > > 
> > > > commit e85c205ac1427f2405021a36f083280ff0d0a35e increase vmalloc size.
> > > > vmalloc space will overlap with OMAP3 sram virtual address.
> > > 
> > > Makes sense to me.  I'm not sure how we missed this in the original patch.
> > > 
> > > Reviewed-by: Paul Walmsley <paul@pwsan.com>
> > > 
> > > - Paul
> > > 
> > > > 
> > > > Signed-off-by: Li Hong Mei <hong-mei.li@motorola.com>
> > > > Signed-off-by: Janboe Ye <yuan-bo.ye@motorola.com>
> > > > ---
> > > >  arch/arm/plat-omap/sram.c |    4 ++--
> > > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> > > > index a2e60e7..755ccaa 100644
> > > > --- a/arch/arm/plat-omap/sram.c
> > > > +++ b/arch/arm/plat-omap/sram.c
> > > > @@ -41,9 +41,9 @@
> > > >  #define OMAP2_SRAM_VA          0xe3000000
> > > >  #define OMAP2_SRAM_PUB_VA      (OMAP2_SRAM_VA + 0x800)
> > > >  #define OMAP3_SRAM_PA           0x40200000
> > > > -#define OMAP3_SRAM_VA           0xd7000000
> > > > +#define OMAP3_SRAM_VA           0xe3000000
> > > >  #define OMAP3_SRAM_PUB_PA       0x40208000
> > > > -#define OMAP3_SRAM_PUB_VA       0xd7008000
> > > > +#define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
> > > > 
> > > >  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> > > >  #define SRAM_BOOTLOADER_SZ     0x00
> > > > 
> > > 
> > > 
> > > - Paul
> > 
> 
> 
> - Paul
