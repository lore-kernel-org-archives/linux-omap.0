From: Janboe Ye <yuan-bo.ye@motorola.com>
Subject: Re: [PATCH] fix omap3 sram virtual addres overlap vmalloc space
 after increasing vmalloc size
Date: Tue, 21 Jul 2009 11:02:00 -0500
Message-ID: <1248192120.3931.7.camel@debian-nb>
References: <1247784477.25106.35.camel@debian-nb>
	 <alpine.DEB.2.00.0907171603190.18924@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail119.messagelabs.com ([216.82.241.195]:39907 "EHLO
	mail119.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbZGUQCi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 12:02:38 -0400
Received: from il27exr04.cig.mot.com (il27exr04.mot.com [10.17.196.73])
	by motgate4.mot.com (8.14.3/8.14.3) with ESMTP id n6LG2Wre000170
	for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 09:02:32 -0700 (MST)
Received: from il27vts02.mot.com (il27vts02.cig.mot.com [10.17.196.86])
	by il27exr04.cig.mot.com (8.13.1/Vontu) with SMTP id n6LG2RvA015960
	for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 11:02:32 -0500 (CDT)
Received: from zmy16exm62.ds.mot.com (zmy16exm62.ap.mot.com [10.179.4.33])
	by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n6LG2P3k015938
	for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 11:02:26 -0500 (CDT)
In-Reply-To: <alpine.DEB.2.00.0907171603190.18924@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, mans@mansr.com, khilman@deeprootsystems.com, tony@atomide.com, Hong Mei Li <hong-mei.li@motorola.com>

Thanks, Paul

Tony

Is there some issue about this patch?

Thanks

Janboe Ye

On Fri, 2009-07-17 at 16:04 -0600, Paul Walmsley wrote:
> On Thu, 16 Jul 2009, Janboe Ye wrote:
> 
> > resend for mini coding style fixing
> > 
> > commit e85c205ac1427f2405021a36f083280ff0d0a35e increase vmalloc size.
> > vmalloc space will overlap with OMAP3 sram virtual address.
> 
> Makes sense to me.  I'm not sure how we missed this in the original patch.
> 
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
> 
> - Paul
> 
> > 
> > Signed-off-by: Li Hong Mei <hong-mei.li@motorola.com>
> > Signed-off-by: Janboe Ye <yuan-bo.ye@motorola.com>
> > ---
> >  arch/arm/plat-omap/sram.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> > index a2e60e7..755ccaa 100644
> > --- a/arch/arm/plat-omap/sram.c
> > +++ b/arch/arm/plat-omap/sram.c
> > @@ -41,9 +41,9 @@
> >  #define OMAP2_SRAM_VA          0xe3000000
> >  #define OMAP2_SRAM_PUB_VA      (OMAP2_SRAM_VA + 0x800)
> >  #define OMAP3_SRAM_PA           0x40200000
> > -#define OMAP3_SRAM_VA           0xd7000000
> > +#define OMAP3_SRAM_VA           0xe3000000
> >  #define OMAP3_SRAM_PUB_PA       0x40208000
> > -#define OMAP3_SRAM_PUB_VA       0xd7008000
> > +#define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
> > 
> >  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> >  #define SRAM_BOOTLOADER_SZ     0x00
> > 
> 
> 
> - Paul
