From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap: OMAP_IOMMU not visible in menuconfig
Date: Thu, 9 Sep 2010 16:22:50 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6D369DF@dbde02.ent.ti.com>
References: <1283957481-16682-1-git-send-email-premi@ti.com>
	<20100909.080445.193715829.Hiroshi.DOYU@nokia.com>
	<20100909055855.GB9098@legolas.emea.dhcp.ti.com>
 <20100909092217.01dc6ec4.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49460 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205Ab0IIKw5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 06:52:57 -0400
In-Reply-To: <20100909092217.01dc6ec4.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Thursday, September 09, 2010 11:52 AM
> To: Balbi, Felipe
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap: OMAP_IOMMU not visible in menuconfig
> 
> On Thu, 9 Sep 2010 07:58:55 +0200
> ext Felipe Balbi <balbi@ti.com> wrote:
> 
> > On Thu, Sep 09, 2010 at 12:04:45AM -0500, Hiroshi DOYU wrote:
> > >Hi Sanjeev,
> > >
> > >From: ext Sanjeev Premi <premi@ti.com>
> > >Subject: [PATCH] omap: OMAP_IOMMU not visible in menuconfig
> > >Date: Wed, 8 Sep 2010 16:51:21 +0200
> > >
> > >> The menu option to select CONFIG_OMAP_IOMMU
> > >> was not visible in the menuconfig due to missing
> > >> description.
> > >
> > >There's no point to make OMAP_IOMMU visible since this is a kind of
> > >feature used by other device implicitly. OMAP_IOMMU on 
> menu might confuse
> > >users at kernel menuconfig. Instead this should be automatically
> > >selected by its clients when it is selected. For exmaple, the case
> > >that DSP or Tesla is selected. There was a discussion about this
> > >before.
> > 
> > in that case...
> > 
> > >> @@ -98,7 +98,7 @@ config OMAP_MBOX_KFIFO_SIZE
> > >>  	  module parameter).
> > >>
> > >>  config OMAP_IOMMU
> > >> -	tristate
> > >> +	tristate "OMAP IOMMU support"
> > 
> > it doesn't have to be tristate as select will always mark it 'y'
> 
> Right;p
> 
[sp] So, we will need to "select" this option with ARCH_OMAP3.
     And maybe for OMAP4...

~sanjeev
