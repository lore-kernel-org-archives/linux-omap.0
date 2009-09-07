From: "C.A, Subramaniam" <subramaniam.ca@ti.com>
Subject: RE: [PATCH 2/10] omap mailbox: OMAP4 - Add resources and mailbox
 register base address for OMAP4 mailbox
Date: Mon, 7 Sep 2009 14:17:10 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD6C40AC@dbde02.ent.ti.com>
References: <20090905.123552.186330891.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59370 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbZIGIqW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Sep 2009 04:46:22 -0400
In-Reply-To: <20090905.123552.186330891.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>

Hi Hiroshi, 

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Saturday, September 05, 2009 3:06 PM
> To: C.A, Subramaniam
> Cc: linux-omap@vger.kernel.org; tony@atomide.com; 
> rmk@arm.linux.org.uk; Kanigeri, Hari; Gupta, Ramesh
> Subject: Re: [PATCH 2/10] omap mailbox: OMAP4 - Add resources 
> and mailbox register base address for OMAP4 mailbox
> 
> Hi Subramaniam,
> 
> From: "ext C.A, Subramaniam" <subramaniam.ca@ti.com>
> Subject: [PATCH 2/10] omap mailbox: OMAP4 - Add resources and 
> mailbox register base address for OMAP4 mailbox
> Date: Fri, 4 Sep 2009 13:47:43 +0200
> 
> > From 80e74ada510bace7208d59c0f912f9b1077efb45 Mon Sep 17 
> 00:00:00 2001
> > From: C A Subramaniam <subramaniam.ca@ti.com>
> > Date: Wed, 2 Sep 2009 17:58:57 +0530
> > Subject: [PATCH 2/10] omap mailbox: OMAP4 - Add resources 
> and mailbox 
> > register base address  for OMAP4 mailbox
> > 
> > This patch adds resource information of mailbox driver for
> > OMAP4 mailbox module. Register base address also added
> > 
> > Signed-off-by: C A Subramaniam <subramaniam.ca@ti.com>
> > Signed-off-by: Ramesh Gupta G <grgupta@ti.com>
> > ---
> >  arch/arm/mach-omap2/devices.c              |   20 
> +++++++++++++++++++-
> >  arch/arm/plat-omap/include/mach/omap44xx.h |    2 ++
> >  2 files changed, 21 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/devices.c 
> > b/arch/arm/mach-omap2/devices.c index 894cc35..711ed6a 100644
> > --- a/arch/arm/mach-omap2/devices.c
> > +++ b/arch/arm/mach-omap2/devices.c
> > @@ -136,8 +136,11 @@ static inline void omap_init_camera(void)
> >  
> >  #if defined(CONFIG_OMAP_MBOX_FWK) || 
> > defined(CONFIG_OMAP_MBOX_FWK_MODULE)
> >  
> > +#ifdef CONFIG_ARCH_OMAP4
> > +#define MBOX_REG_SIZE   0x130
> > +#else
> >  #define MBOX_REG_SIZE	0x120
> > -
> > +#endif
> 
> I'm not sure if it is still valid or not to support multiple OMAP
> architecture(OMAP1/2/3/4?) with a single vmlinux binary, but 
> the above modification will break this feature.
> 
> If it is still valid, I think that the above should be 
> modified, for example, with using embedded constant values, 
> like other device resources and the rousources should be 
> ifded'ed with architecture #:

I think it is better to #ifdef for each architecture like you have suggested.
> 
> #ifdef CONFIG_ARCH_OMAP2
>   static struct resource omap2_mbox_resources[] = {
>   	{
>   		.start		= OMAP24XX_MAILBOX_BASE,
> 		.end            = OMAP24XX_MAILBOX_BASE + 
> OMAP2_MBOX_REG_SIZE - 1,
> #endif
> 
> #ifdef CONFIG_ARCH_OMAP3
>  @@ -166,6 +169,18 @@ static struct resource 
> omap3_mbox_resources[] = {
>   	},
>   };
> #endif
> 
> #ifdef CONFIG_ARCH_OMAP4
> 
> #define OMAP4_MBOX_REG_SIZE   0x130
> 
> static struct resource omap4_mbox_resources[] = {
> 	{
> 		.start          = OMAP44XX_MAILBOX_BASE,
> 		.end            = OMAP44XX_MAILBOX_BASE + 
> OMAP4_MBOX_REG_SIZE - 1,
> 		.flags          = IORESOURCE_MEM,
> 	},
> 	{
> 		.start          = INT_44XX_MAIL_U0_MPU,
> 		.flags          = IORESOURCE_IRQ,
> 	},
> };
> #endif
> 
> > +
> >  static struct platform_device mbox_device = {
> >  	.name		= "omap2-mailbox",
> >  	.id		= -1,
> > @@ -179,6 +194,9 @@ static inline void omap_init_mbox(void)
> >  	} else if (cpu_is_omap3430()) {
> >  		mbox_device.num_resources = 
> ARRAY_SIZE(omap3_mbox_resources);
> >  		mbox_device.resource = omap3_mbox_resources;
> > +	} else if (cpu_is_omap44xx()) {
> > +		mbox_device.num_resources = 
> ARRAY_SIZE(omap4_mbox_resources);
> > +		mbox_device.resource = omap4_mbox_resources;
> >  	} else {
> >  		pr_err("%s: platform not supported\n", __func__);
> >  		return;
> > diff --git a/arch/arm/plat-omap/include/mach/omap44xx.h 
> > b/arch/arm/plat-omap/include/mach/omap44xx.h
> > index 52f2f85..6a545d3 100644
> > --- a/arch/arm/plat-omap/include/mach/omap44xx.h
> > +++ b/arch/arm/plat-omap/include/mach/omap44xx.h
> > @@ -44,5 +44,7 @@
> >  #define OMAP44XX_WKUPGEN_BASE		0x48281000
> >  #define OMAP44XX_VA_WKUPGEN_BASE	
> IO_ADDRESS(OMAP44XX_WKUPGEN_BASE)
> >  
> > +#define OMAP44xx_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
> 
> From naming consistency, can the above be, "OMAP44XX_MAILBOX_BASE" ?
> 

I agree. I will incoprporate this change and send a patch.

> > +
> >  #endif /* __ASM_ARCH_OMAP44XX_H */
> >  
> > --
> > 1.5.3.2
> 
> 