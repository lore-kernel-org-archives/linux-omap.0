From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] [OMAPZOOM]  OMAP : DMA: Spurious interrupt fix
Date: Fri, 9 Jan 2009 18:22:44 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB029830F81F@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB029392DE99@dbde02.ent.ti.com>
 <20090108151120.GQ27566@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB029830F705@dbde02.ent.ti.com>
 <20090109112817.GG2536@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52732 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418AbZAIMwy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 07:52:54 -0500
In-Reply-To: <20090109112817.GG2536@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Friday, January 09, 2009 4:58 PM
> To: Shilimkar, Santosh
> Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] [OMAPZOOM] OMAP : DMA: Spurious interrupt fix
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [090109 12:51]:
> > 
> > Tony,
> > Regarding your proposal of doing the no. of channel 
> reservation during runtime has one problem. 
> > 
> > The whole idea was not to restrict users from using all 32 
> channels and hence the config option. For OMAP secure chips, 
> few security drivers which will execute in secure contex 
> needs dedicated DMA channels and kernel dma library can't be 
> used in that case. So in such cases, required DMA channels 
> can be reserved using this config option. For GP devices all 
> 32 channels can be used currently. 
> > 
> > If it can done in better way, please suggest.
> 
> Well how about passing the configuration for the DMA channels
> from board-*.c file then?
This is certainly a good option if the setting is fixed for a particular board type. With this how do we ensure user configurability. Lets say on a particular board, two users/customers wants to use separate configurations for DMA channels because of the needs what mentioned earlier. Then again we need some kind of comfit option.
   Another clean way to achieve this is through 'bootargs'. But this might be too much of a design for this requirement.
 
> > Time being if needed what best I can do is, to split this 
> patch into two parts as mentioned earlier. This will avoid 
> confusion of spurious interrupt issue and dam channel reservation
> OK
I will do this once I get some time for sure.

 
> Regards,
> 
> Tony
> 
> > 
> > > -----Original Message-----
> > > From: Shilimkar, Santosh 
> > > Sent: Friday, January 09, 2009 10:22 AM
> > > To: 'Tony Lindgren'
> > > Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> > > Subject: RE: [PATCH] [OMAPZOOM] OMAP : DMA: Spurious interrupt fix
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Tony Lindgren [mailto:tony@atomide.com] 
> > > > Sent: Thursday, January 08, 2009 8:41 PM
> > > > To: Shilimkar, Santosh
> > > > Cc: Pandita, Vikram; linux-omap@vger.kernel.org
> > > > Subject: Re: [PATCH] [OMAPZOOM] OMAP : DMA: Spurious 
> interrupt fix
> > > > 
> > > > Hi,
> > > > 
> > > > * Shilimkar, Santosh <santosh.shilimkar@ti.com> [081204 08:21]:
> > > > > From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > > > 
> > > > > This fixes the spurious interrupt issue on a DMA channel. 
> > > > 
> > > > Sounds like we need to do this. But let's rather do it 
> > > during runtime
> > > > in dma init with cpu_is_omapXXXX() and omap_type() macros.
> > > 
> > > Yes we need this. Actually this patch has two parts. One is 
> > > the config option and another one is correcting ISR. I could 
> > > have done two separate patches.
> > >  --- omapkernel.orig/arch/arm/plat-omap/dma.c	
> > >  2008-12-04 10:38:16.732010840 +0530
> > >  +++ omapkernel/arch/arm/plat-omap/dma.c	2008-12-04 
> > >  11:11:07.671274902 +0530
> > >  @@ -1946,7 +1946,7 @@ static int omap2_dma_handle_ch(int ch)
> > >   /* STATUS register count is from 1-32 while our is 0-31 */
> > >   static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
> > >   {
> > >  -	u32 val;
> > >  +	u32 val, enable_reg;
> > >   	int i;
> > >   
> > >   	val = dma_read(IRQSTATUS_L0);
> > >  @@ -1955,6 +1955,8 @@ static irqreturn_t omap2_dma_irq_handler
> > >   			printk(KERN_WARNING "Spurious 
> DMA IRQ\n");
> > >   		return IRQ_HANDLED;
> > >   	}
> > >  +	enable_reg = dma_read(IRQENABLE_L0);
> > >  +	val &= enable_reg; /* Dispatch only relevant 
> interrupts */
> > >   	for (i = 0; i < dma_lch_count && val != 0; i++) {
> > >   		if (val & 1)
> > >   			omap2_dma_handle_ch(i);
> > > 
> > > We should at least update this on mainline because this was a 
> > > real issue. Reserving channel was more of a request from 
> > > security drivers which also helps in this case. 
> > >  
> > > > > 
> > > > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > > > Acked By: Nishant Kamat <nskamat@ti.com>
> > > > > Acked By: Gopinath Thara <thara@ti.com>
> > > > > ---
> > > > > --- omapkernel.orig/arch/arm/plat-omap/include/mach/dma.h	
> > > > 2008-12-04 10:29:08.949018434 +0530
> > > > > +++ omapkernel/arch/arm/plat-omap/include/mach/dma.h	
> > > > 2008-12-04 11:14:25.359087775 +0530
> > > > > @@ -67,7 +67,11 @@
> > > > >  #define OMAP_DMA4_CAPS_4		0x74
> > > > >  
> > > > >  #define OMAP1_LOGICAL_DMA_CH_COUNT	17
> > > > > +#ifdef CONFIG_OMAP_DMA_LIBRARY_CHANNELS
> > > > > +#define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	
> > > > CONFIG_OMAP_DMA_LIBRARY_CHANNELS
> > > > > +#else
> > > > >  #define OMAP_DMA4_LOGICAL_DMA_CH_COUNT	32	/* 
> > > > REVISIT: Is this 32 + 2? */
> > > > > +#endif
> > > > >  
> > > > >  /* Common channel specific registers for omap1 */
> > > > >  #define OMAP1_DMA_CH_BASE(n)		(0x40 * (n) + 0x00)
> > > > > Index: omapkernel/arch/arm/plat-omap/Kconfig
> > > > > 
> > > 
> ===================================================================
> > > > > --- omapkernel.orig/arch/arm/plat-omap/Kconfig	
> > > > 2008-12-04 10:29:08.949018434 +0530
> > > > > +++ omapkernel/arch/arm/plat-omap/Kconfig	2008-12-04 
> > > > 10:38:21.883850512 +0530
> > > > > @@ -256,6 +256,18 @@ config OMAP_SERIAL_WAKE
> > > > >  	  to data on the serial RX line. This allows 
> you to wake the
> > > > >  	  system from serial console.
> > > > >  
> > > > > +
> > > > > +config OMAP_DMA_LIBRARY_CHANNELS
> > > > > +        int "DMA channels controlled by the kernel 
> DMA library"
> > > > > +        range 24 32
> > > > > +        depends on ARCH_OMAP3
> > > > > +        default "32"
> > > > > +        help
> > > > > +          Some of the OMAP System DMA channels may need to be
> > > > > +          reserved for software that don't use the DMA 
> > > > library, such as
> > > > > +          security drivers. Use this option to limit the 
> > > > number of channels
> > > > > +          controlled by the kernel DMA library.
> > > > > +
> > > > >  endmenu
> > > > >  
> > > > >  endif
> > > > > Index: omapkernel/arch/arm/configs/omap_3430sdp_defconfig
> > > > > 
> > > 
> ===================================================================
> > > > > --- omapkernel.orig/arch/arm/configs/omap_3430sdp_defconfig	
> > > > 2008-12-04 10:29:08.949018434 +0530
> > > > > +++ omapkernel/arch/arm/configs/omap_3430sdp_defconfig	
> > > > 2008-12-04 10:38:21.884850481 +0530
> > > > > @@ -177,7 +177,7 @@ CONFIG_ARCH_OMAP_OTG=y
> > > > >  # CONFIG_ARCH_OMAP1 is not set
> > > > >  # CONFIG_ARCH_OMAP2 is not set
> > > > >  CONFIG_ARCH_OMAP3=y
> > > > > -
> > > > > +CONFIG_OMAP_DMA_LIBRARY_CHANNELS=24
> > > > >  #
> > > > >  # OMAP Feature Selections
> > > > >  #
> > > > > Index: omapkernel/arch/arm/plat-omap/dma.c
> > > > > 
> > > 
> ===================================================================
> > > > > --- omapkernel.orig/arch/arm/plat-omap/dma.c	
> > > > 2008-12-04 10:38:16.732010840 +0530
> > > > > +++ omapkernel/arch/arm/plat-omap/dma.c	2008-12-04 
> > > > 11:11:07.671274902 +0530
> > > > > @@ -1946,7 +1946,7 @@ static int omap2_dma_handle_ch(int ch)
> > > > >  /* STATUS register count is from 1-32 while our is 0-31 */
> > > > >  static irqreturn_t omap2_dma_irq_handler(int irq, 
> void *dev_id)
> > > > >  {
> > > > > -	u32 val;
> > > > > +	u32 val, enable_reg;
> > > > >  	int i;
> > > > >  
> > > > >  	val = dma_read(IRQSTATUS_L0);
> > > > > @@ -1955,6 +1955,8 @@ static irqreturn_t omap2_dma_irq_handler
> > > > >  			printk(KERN_WARNING "Spurious 
> DMA IRQ\n");
> > > > >  		return IRQ_HANDLED;
> > > > >  	}
> > > > > +	enable_reg = dma_read(IRQENABLE_L0);
> > > > > +	val &= enable_reg; /* Dispatch only relevant 
> interrupts */
> > > > >  	for (i = 0; i < dma_lch_count && val != 0; i++) {
> > > > >  		if (val & 1)
> > > > >  			omap2_dma_handle_ch(i);
> > > > > Index: omapkernel/arch/arm/configs/omap_ldp_defconfig
> > > > > 
> > > 
> ===================================================================
> > > > > --- omapkernel.orig/arch/arm/configs/omap_ldp_defconfig	
> > > > 2008-12-04 11:18:54.000000000 +0530
> > > > > +++ omapkernel/arch/arm/configs/omap_ldp_defconfig	
> > > > 2008-12-04 11:19:33.507466484 +0530
> > > > > @@ -177,6 +177,7 @@ CONFIG_ARCH_OMAP_OTG=y
> > > > >  # CONFIG_ARCH_OMAP1 is not set
> > > > >  # CONFIG_ARCH_OMAP2 is not set
> > > > >  CONFIG_ARCH_OMAP3=y
> > > > > +CONFIG_OMAP_DMA_LIBRARY_CHANNELS=32
> > > > >  #
> > > > >  # OMAP Feature Selections
> > > > >  #
> > > > > 
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe 
> > > > linux-omap" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> > > > 
> > > > 
> 
> 