From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] OMAP: DMA: Cleanup of DMA Request Lines
Date: Wed, 21 Nov 2007 09:06:03 -0800
Message-ID: <20071121170603.GH8138@atomide.com>
References: <20071031131059.GG32547@atomide.com>
	<010C7BAE6783F34D9AC336EE5A01A08804DC0E4B@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A08804DC0E4B@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Gadiyar, Anand <gadiyar@ti.com> [071120 21:12]:
> Hi, 
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com] 
> > Sent: Wednesday, October 31, 2007 6:41 PM
> 
> > > +#ifndef CONFIG_ARCH_OMAP3
> > >  #define OMAP24XX_DMA_CWT		8	/* S_DMA_7 */
> > > +#endif
> > > +
> > >  #define OMAP24XX_DMA_AES_TX		9	/* S_DMA_8 */
> > >  #define OMAP24XX_DMA_AES_RX		10	/* S_DMA_9 */
> > >  #define OMAP24XX_DMA_DES_TX		11	/* S_DMA_10 */
> > >  #define OMAP24XX_DMA_DES_RX		12	/* S_DMA_11 */
> > > +
> > > +#ifdef CONFIG_ARCH_OMAP3
> > > +#define OMAP34XX_DMA_SHA2MD5_RX		13	/* S_DMA_12 */
> > > +#else
> > >  #define OMAP24XX_DMA_SHA1MD5_RX		13	/* S_DMA_12 */
> > > +#endif
> > > +
> > > +#ifdef CONFIG_ARCH_OMAP2420
> > >  #define OMAP24XX_DMA_EXT_DMAREQ2	14	/* S_DMA_13 */
> > >  #define OMAP24XX_DMA_EXT_DMAREQ3	15	/* S_DMA_14 */
> > >  #define OMAP24XX_DMA_EXT_DMAREQ4	16	/* S_DMA_15 */
> > 
> > Let's remove the #ifdefs here, we want to be able to compile 
> > support for
> > 24xx and 34xx into the same kernel eventually. It's OK to 
> > have the same
> > DMA request channel defined in different way for 24xx and 34xx.
> 
> I've just started re-working this patch. Let me check if I have understood
> you correctly. Do you want me to remove only the #ifdefs around the
> OMAP34XX_DMA_SHA2MD5_RX/OMAP24XX_DMA_SHA1MD5_RX?

Yeah.

> If this is the case, then wouldn't we run into trouble when we try to use a
> request line with the same name but a different number - as is the case with
> OMAP24XX_DMA_SHA1MD5_RX (13 on 24XX and 69 on 34XX)

Then we should just define them as OMAP242X_DMA_ and OMAP34XX_DMA.

> Also when you say "we want to be able to compile support for 24xx and 34xx into
> the same kernel...", do you mean there will be a CONFIG_ARCH_OMAP2 as well as a
> CONFIG_ARCH_OMAP3 defined at the same time?

Yeah, that's already working for omap1. With -Wa gcc option we can
mix in assembly for ARMv7.

Regards,

Tony
