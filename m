From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: select PINCTRL in Kconfig
Date: Wed, 5 Sep 2012 16:29:58 -0700
Message-ID: <20120905232957.GN1303@atomide.com>
References: <1346047244-26909-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA25D99@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:28278 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759890Ab2IEXaB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 19:30:01 -0400
Content-Disposition: inline
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA25D99@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* AnilKumar, Chimata <anilkumar@ti.com> [120903 05:42]:
> Hi Tony,
> 
> On Mon, Aug 27, 2012 at 11:30:44, AnilKumar, Chimata wrote:
> > Select PINCTRL in Kconfig under Typical OMAP configuration, this
> > is required to add pinctrl driver to omap2+ family of devices.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  arch/arm/mach-omap2/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> > index dd2db02..a164568 100644
> > --- a/arch/arm/mach-omap2/Kconfig
> > +++ b/arch/arm/mach-omap2/Kconfig
> > @@ -18,6 +18,7 @@ config ARCH_OMAP2PLUS_TYPICAL
> >  	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
> >  	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
> >  	select HIGHMEM
> > +	select PINCTRL
> >  	help
> >  	  Compile a kernel suitable for booting most boards
> >  
> > -- 
> > 1.7.9.5
> > 
> > 
> 
> If there are no comments on this patch, can you push this patch to devel-dt?

Yes will do, will post first few fixes and support for adding pinctrl-single
controllers for omap2/3/4 that I have here.

Tony
