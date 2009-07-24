From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC][PATCH 2/3] ARM:OMAP4 iommu:add omap4 support in iommu
Date: Fri, 24 Jul 2009 23:08:47 +0300
Message-ID: <20090724200847.GA14117@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD44@dlee03.ent.ti.com>
 <20090724182702.GA10206@nokia.com>
 <20090724.214757.112593122.Hiroshi.DOYU@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17703 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbZGXUIh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 16:08:37 -0400
Content-Disposition: inline
In-Reply-To: <20090724.214757.112593122.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "h-kanigeri2@ti.com" <h-kanigeri2@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "grgupta@ti.com" <grgupta@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "vpasam@ti.com" <vpasam@ti.com>

hi,

On Fri, Jul 24, 2009 at 08:47:57PM +0200, Doyu Hiroshi (Nokia-D/Helsinki) wrote:
> > > +static unsigned long iommu_base[] __initdata = {
> > > +	OMAP4_MMU1_BASE,
> > > +	OMAP4_MMU2_BASE,
> > > +};
> > > +
> > > +static int iommu_irq[] __initdata = {
> > > +	OMAP4_MMU1_IRQ,
> > > +	OMAP4_MMU2_IRQ,
> > > +};
> > 
> > these two looks really odd :-s
> 
> I think that the above just follows Russeell's proposal as below:
> 
> http://lists.arm.linux.org.uk/lurker/message/20090516.092036.df9420d1.en.html

I see... still looks odd though.

-- 
balbi
