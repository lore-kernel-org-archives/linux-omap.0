From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 1/3] omap3-iommu: reorganize
Date: Fri, 08 May 2009 07:15:10 +0300 (EEST)
Message-ID: <20090508.071510.149819051.Hiroshi.DOYU@nokia.com>
References: <1241727069-15168-1-git-send-email-felipe.contreras@gmail.com>
	<1241727069-15168-2-git-send-email-felipe.contreras@gmail.com>
	<20090507211447.GA30906@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:33716 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbZEHEPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 00:15:18 -0400
In-Reply-To: <20090507211447.GA30906@scadufax.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: felipe.contreras@gmail.com, linux-omap@vger.kernel.org, felipe.contreras@nokia.com, tony@atomide.com

From: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Subject: Re: [RFC/PATCH 1/3] omap3-iommu: reorganize
Date: Thu, 7 May 2009 23:14:47 +0200

> On Thu, May 07, 2009 at 10:11:07PM +0200, ext Felipe Contreras wrote:
> > -static struct resource omap3_iommu_res[] = {
> > -	{ /* Camera ISP MMU */
> > -		.start		= OMAP3_MMU1_BASE,
> > -		.end		= OMAP3_MMU1_BASE + MMU_REG_SIZE - 1,
> > -		.flags		= IORESOURCE_MEM,
> > -	},
> > -	{
> > -		.start		= OMAP3_MMU1_IRQ,
> > -		.flags		= IORESOURCE_IRQ,
> > -	},
> > -	{ /* IVA2.2 MMU */
> > -		.start		= OMAP3_MMU2_BASE,
> > -		.end		= OMAP3_MMU2_BASE + MMU_REG_SIZE - 1,
> > -		.flags		= IORESOURCE_MEM,
> > -	},
> > -	{
> > -		.start		= OMAP3_MMU2_IRQ,
> > -		.flags		= IORESOURCE_IRQ,
> > -	},
> 
> i find this one much more readable :-s
> 
> > +struct iommu_device {
> > +	resource_size_t base;
> > +	resource_size_t irq;
> > +	struct iommu_platform_data pdata;
> 
> generally, platform_data is a void *. Don't know if it matters here.
> 
> > +	struct resource res[2];
> >  };
> > -#define NR_IOMMU_RES (ARRAY_SIZE(omap3_iommu_res) / 2)
> >  
> > -static const struct iommu_platform_data omap3_iommu_pdata[] __initconst = {
> > +static struct iommu_device devices[] = {
> >  	{
> > -		.name = "isp",
> > -		.nr_tlb_entries = 8,
> > -		.clk_name = "cam_ick",
> > +		.base = 0x480bd400,
> > +		.irq = 24,
> > +		.pdata = {
> > +			.name = "isp",
> > +			.nr_tlb_entries = 8,
> > +			.clk_name = "cam_ick",
> 
> still passing clk names ? what about clkdev ?

Useful comment, I'll update mine;) thanks
