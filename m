From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] flush I-cache after omap_sram_push()
Date: Fri, 23 Nov 2007 13:15:28 -0800
Message-ID: <20071123211527.GH559@atomide.com>
References: <20071114083010.938764990@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429027B3E1E@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0711161223280.13378@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290282B603@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0711191208030.25712@utopia.booyaka.com>
	<3B6D69C3A9EBCA4BA5DA60D9130274290282BF37@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290282BF37@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [071120 08:16]:
> > This patch implements a suggestion by Richard Woodruff
> > <r-woodruff2@ti.com>.  omap_sram_push() copies executable code into
> > SRAM memory.  Currently this happens before Linux executes anything
> > from the SRAM, so we don't have to worry about evicting any SRAM lines
> > from the I-cache.  But at some point in the future, the SRAM might be
> > used more dynamically, adding and removing code while the system is
> > running.  So we should ensure that the I-cache is clean or at
> > least up-to-date after the copy.
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> Signedoff-by: Richard Woodruff <r-woodruff2@ti.com>
>  
> > ---
> >  arch/arm/plat-omap/sram.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > Index: linux-omap/arch/arm/plat-omap/sram.c
> > ===================================================================
> > --- linux-omap.orig/arch/arm/plat-omap/sram.c	2007-11-16
> > 17:41:42.000000000 -0700
> > +++ linux-omap/arch/arm/plat-omap/sram.c	2007-11-16 17:43:18.000000000 -
> > 0700
> > @@ -216,6 +216,7 @@
> >  	omap_sram_ceil -= size;
> >  	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
> >  	memcpy((void *)omap_sram_ceil, start, size);
> > +	flush_icache_range((unsigned long)start, (unsigned long)(start +
> > size));
> > 
> >  	return (void *)omap_sram_ceil;
> >  }
> 
> Looks good.

Pushing today.

Tony
