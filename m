From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix AUDIO_MCBSP_DATAREAD/WRITE undefined for OMAP16xx
Date: Thu, 19 Jan 2006 12:05:05 -0800
Message-ID: <20060119200505.GM4425@atomide.com>
References: <43CD3AFF.9080802@de.bosch.com> <43CD43B9.70902@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43CD43B9.70902@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* lamikr <lamikr@cc.jyu.fi> [060117 13:47]:
> For this I think it would be better to take the patch from the message
> titled "omap1510/16xx fixes for the tsc2101 oss driver" I send yesterday.
> It defines the AUDIO_MCBSP_DATAWRITE and AUDIO_MCBSP_DATAREAD for the
> omap1510/16xx in a similar way than is done for the omap24xx.
> 
> Mika
> 
> Dirk Behme wrote:
> 
> >
> > ARM: OMAP: Define AUDIO_MCBSP_DATAREAD/WRITE for OMAP16xx as well
> >
> > Fix error
> >
> > sound/oss/omap-audio-dma-intfc.c:715: error: `AUDIO_MCBSP_DATAWRITE'
> > undeclared (first use in this function)
> > sound/oss/omap-audio-dma-intfc.c:745: error: `AUDIO_MCBSP_DATAREAD'
> > undeclared (first use in this function)
> >
> > Signed-off-by: Dirk Behme <dirk.behme_at_de.bosch.com>
> >
> >------------------------------------------------------------------------
> >
> >--- ./include/asm-arm/arch-omap/mcbsp.h_orig	2006-01-17 18:34:46.000000000 +0100
> >+++ ./include/asm-arm/arch-omap/mcbsp.h	2006-01-17 18:37:11.720163080 +0100
> >@@ -80,6 +80,9 @@
> > #define AUDIO_DMA_TX		OMAP_DMA_MCBSP1_TX
> > #define AUDIO_DMA_RX		OMAP_DMA_MCBSP1_RX
> > 
> >+#define AUDIO_MCBSP_DATAWRITE	(0)
> >+#define AUDIO_MCBSP_DATAREAD	(0)
> >+
> > #elif defined(CONFIG_ARCH_OMAP24XX)
> > 
> > #define OMAP_MCBSP_REG_DRR2	0x00

I'll push Mika's patch at some point today as it also include this one.

Tony
