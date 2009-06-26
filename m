From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] [RFC] OMAP4: sDMA: Update the request lines and new
 registers.
Date: Fri, 26 Jun 2009 00:50:40 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906260048570.2676@utopia.booyaka.com>
References: <1242132073-16563-1-git-send-email-santosh.shilimkar@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02B53AB4F3@dbde02.ent.ti.com> <20090626064400.GZ7352@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41682 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbZFZGuh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 02:50:37 -0400
In-Reply-To: <20090626064400.GZ7352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, rnayak@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 26 Jun 2009, Tony Lindgren wrote:

> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [090626 09:39]:
> > > -----Original Message-----
> > > From: Shilimkar, Santosh 
> > > Sent: Tuesday, May 12, 2009 6:11 PM
> > > To: linux-omap@vger.kernel.org
> > > Cc: Shilimkar, Santosh
> > > Subject: [PATCH] [RFC] OMAP4: sDMA: Update the request lines 
> > > and new registers.
> > > 
> > > This patch updates the platform dma.h with new dma request lines
> > > for OMAP4 peripherals. Also additional hardware register of OMAP4
> > > sDMA module are included.
> > > 
> > > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > ---
> > >  arch/arm/plat-omap/include/mach/dma.h |   65 
> > > ++++++++++++++++++++++++++++++++-
> > >  1 files changed, 64 insertions(+), 1 deletions(-)
> > >  mode change 100644 => 100755 arch/arm/plat-omap/include/mach/dma.h
> > > 
> > > diff --git a/arch/arm/plat-omap/include/mach/dma.h 
> > > b/arch/arm/plat-omap/include/mach/dma.h
> > > old mode 100644
> > > new mode 100755
> > > index 8e05b6a..3dc1b14
> > > --- a/arch/arm/plat-omap/include/mach/dma.h
> > > +++ b/arch/arm/plat-omap/include/mach/dma.h
> > > @@ -122,6 +122,10 @@
> > >  #define OMAP_DMA4_CCFN(n)		(0x60 * (n) + 0xc0)
> > >  #define OMAP_DMA4_COLOR(n)		(0x60 * (n) + 0xc4)
> > >  
> > > +#define OMAP_DMA4_CDP_REG(n)           (0x60 * (n) + 0xd0)
> > > +#define OMAP_DMA4_CNDP_REG(n)          (0x60 * (n) + 0xd4)
> > > +#define OMAP_DMA4_CCDN_REG(n)          (0x60 * (n) + 0xd8)
> > > +
> > >  /* Dummy defines to keep multi-omap compiles happy */
> > >  #define OMAP1_DMA_REVISION		0
> > >  #define OMAP1_DMA_IRQSTATUS_L0		0
> > > @@ -209,7 +213,7 @@
> > >  #define OMAP_DMA_MMC2_RX		55
> > >  #define OMAP_DMA_CRYPTO_DES_OUT		56
> > >  
> > > -/* DMA channels for 24xx */
> > > +/* DMA channels for 24xx  34xx and 44xx*/
> > >  #define OMAP24XX_DMA_NO_DEVICE		0
> > >  #define OMAP24XX_DMA_XTI_DMA		1	/* S_DMA_0 */
> > >  #define OMAP24XX_DMA_EXT_DMAREQ0	2	/* S_DMA_1 */
> > > @@ -310,6 +314,65 @@
> > >  #define OMAP34XX_DMA_USIM_TX		79	/* S_DMA_78 */
> > >  #define OMAP34XX_DMA_USIM_RX		80	/* S_DMA_79 */
> > >  
> > > +
> > > +#define OMAP44XX_DMA_DSS_LINE_TRIG      6       /* S_DMA_5 */
> > > +#define OMAP44XX_DMA_MCASP1_AXEVT       8       /* S_DMA_7 */
> > > +#define OMAP44XX_DMA_ISS_DMA_REQ0       9       /* S_DMA_8 */
> > > +#define OMAP44XX_DMA_ISS_DMA_REQ1      10      /* S_DMA_9 */
> > > +#define OMAP44XX_DMA_MCASP1_AREVT      11      /* S_DMA_10 */
> > > +#define OMAP44XX_DMA_ISS_DMA_REQ2      12      /* S_DMA_11 */
> > > +#define OMAP44XX_DMA_ISS_DMA_REQ3      13      /* S_DMA_12 */
> > > +#define OMAP44XX_DMA_DSS_RFBI_DMA_REQ  14      /* S_DMA_13 */
> > > +#define OMAP44XX_DMA_MCBSP2_TX         17      /* S_DMA_16 */
> > > +#define OMAP44XX_DMA_MCBSP2_RX         18      /* S_DMA_17 */
> > > +#define OMAP44XX_DMA_MCBSP3_TX         19      /* S_DMA_18 */
> > > +#define OMAP44XX_DMA_MCBSP3_RX         20      /* S_DMA_19 */
> > > +#define OMAP44XX_DMA_MCBSP4_TX         31      /* S_DMA_30 */
> > > +#define OMAP44XX_DMA_MCBSP4_RX         32      /* S_DMA_31 */
> > > +#define OMAP44XX_DMA_MCBSP1_TX         33      /* S_DMA_32 */
> > > +#define OMAP44XX_DMA_MCBSP1_RX         34      /* S_DMA_33 */
> > > +#define OMAP44XX_DMA_UART4_DMA_TX      55      /* S_DMA_54 */
> > > +#define OMAP44XX_DMA_UART4_DMA_RX      56      /* S_DMA_55 */
> > > +#define OMAP44XX_DMA_MMC4_DMA_TX       57      /* S_DMA_56 */
> > > +#define OMAP44XX_DMA_MMC5_DMA_TX       59      /* S_DMA_58 */
> > > +#define OMAP44XX_DMA_MMC5_DMA_RX       60      /* S_DMA_59 */
> > > +#define OMAP44XX_DMA_MCPDM_UP          65      /* S_DMA_64 */
> > > +#define OMAP44XX_DMA_MCPDM_DL          66      /* S_DMA_65 */
> > > +#define OMAP44XX_DMA_DMIC_DMA_REQ      67      /* S_DMA_66 */
> > > +#define OMAP44XX_DSS_HDMI_DMA_REQ      76      /* S_DMA_75 */
> > > +
> > > +
> > > +#define OMAP44XX_DMM_DSS_DSI2_DMA0     81      /* S_DMA_80 */
> > > +#define OMAP44XX_DMM_DSS_DSI2_DMA1     82      /* S_DMA_81 */
> > > +#define OMAP44XX_DMM_DSS_DSI2_DMA2     83      /* S_DMA_82 */
> > > +#define OMAP44XX_DMM_DSS_DSI2_DMA3     84      /* S_DMA_83 */
> > > +#define OMAP44XX_DMM_SLIMBUS1_DMA_TX0  85      /* S_DMA_84 */
> > > +#define OMAP44XX_DMM_SLIMBUS1_DMA_TX1  86      /* S_DMA_85 */
> > > +#define OMAP44XX_DMM_SLIMBUS1_DMA_TX2  87      /* S_DMA_86 */
> > > +#define OMAP44XX_DMM_SLIMBUS1_DMA_TX3  88      /* S_DMA_87 */
> > > +#define OMAP44XX_DMM_SLIMBUS1_DMA_RX0  89      /* S_DMA_88 */
> > > +#define OMAP44XX_DMM_SLIMBUS1_DMA_RX1  90      /* S_DMA_89 */
> > > +#define OMAP44XX_DMM_SLIMBUS1_DMA_RX2  91      /* S_DMA_90 */
> > > +#define OMAP44XX_DMM_SLIMBUS1_DMA_RX3  92      /* S_DMA_91 */
> > > +#define OMAP44XX_DMM_SLIMBUS2_DMA_TX0  93      /* S_DMA_92 */
> > > +#define OMAP44XX_DMM_SLIMBUS2_DMA_TX1  94      /* S_DMA_93 */
> > > +#define OMAP44XX_DMM_SLIMBUS2_DMA_TX2  95      /* S_DMA_94 */
> > > +#define OMAP44XX_DMM_SLIMBUS2_DMA_TX3  96      /* S_DMA_95 */
> > > +#define OMAP44XX_DMM_SLIMBUS2_DMA_RX0  97      /* S_DMA_96 */
> > > +#define OMAP44XX_DMM_SLIMBUS2_DMA_RX1  98      /* S_DMA_97 */
> > > +#define OMAP44XX_DMM_SLIMBUS2_DMA_RX2  99      /* S_DMA_98 */
> > > +#define OMAP44XX_DMM_SLIMBUS2_DMA_RX3  100     /* S_DMA_99 */
> > > +#define OMAP44XX_DMM_ABE_DMAREQ0       101     /* S_DMA_100*/
> > > +#define OMAP44XX_DMM_ABE_DMAREQ1       102     /* S_DMA_101*/
> > > +#define OMAP44XX_DMM_ABE_DMAREQ2       103     /* S_DMA_102*/
> > > +#define OMAP44XX_DMM_ABE_DMAREQ3       104     /* S_DMA_103*/
> > > +#define OMAP44XX_DMM_ABE_DMAREQ4       105     /* S_DMA_104*/
> > > +#define OMAP44XX_DMM_ABE_DMAREQ5       106     /* S_DMA_105*/
> > > +#define OMAP44XX_DMM_ABE_DMAREQ6       107     /* S_DMA_106*/
> > > +#define OMAP44XX_DMM_ABE_DMAREQ7       108     /* S_DMA_107*/
> > > +#define OMAP44XX_DMM_I2C4_DMA_TX       124     /* S_DMA_123*/
> > > +#define OMAP44XX_DMM_I2C4_DMA_RX       125     /* S_DMA_124*/
> > > +
> > >  
> > > /*------------------------------------------------------------
> > > ----------------*/
> > >  
> > >  /* Hardware registers for LCD DMA */
> > > -- 
> > Tony,
> > Can you also check this patch and 
> > UART4 patch: http://www.spinics.net/lists/linux-omap/msg14161.html 
> > 
> > If you ack these two then we can rebase these on kernel.org and
> > submit it for merge on linux-arm
> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> This should be queued for the next merge window, too late for 2.6.30
> IMHO.

Hi Santosh,

could you compare the autogenerated DMA data that Rajendra has with this 
data, and use the autogenerated names if there are differences?  It would 
be ideal to use the autogenerated DMA macro names if possible, since that 
will simplify the process of autogenerating omap_hwmod structures for 
OMAP4.


- Paul
