From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: dma: Mark expected switch fall-throughs
Date: Tue, 13 Aug 2019 05:00:49 -0700
Message-ID: <20190813120049.GV52127@atomide.com>
References: <20190728232240.GA22393@embeddedor>
 <201907290934.B2053972E3@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201907290934.B2053972E3@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-omap@vger.kernel.org

* Kees Cook <keescook@chromium.org> [190729 16:35]:
> On Sun, Jul 28, 2019 at 06:22:40PM -0500, Gustavo A. R. Silva wrote:
> > Mark switch cases where we are expecting to fall through.
> > 
> > This patch fixes the following warnings:
> > 
> > arch/arm/plat-omap/dma.c: In function 'omap_set_dma_src_burst_mode':
> > arch/arm/plat-omap/dma.c:384:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    if (dma_omap2plus()) {
> >       ^
> > arch/arm/plat-omap/dma.c:393:2: note: here
> >   case OMAP_DMA_DATA_BURST_16:
> >   ^~~~
> > arch/arm/plat-omap/dma.c:394:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    if (dma_omap2plus()) {
> >       ^
> > arch/arm/plat-omap/dma.c:402:2: note: here
> >   default:
> >   ^~~~~~~
> > arch/arm/plat-omap/dma.c: In function 'omap_set_dma_dest_burst_mode':
> > arch/arm/plat-omap/dma.c:473:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    if (dma_omap2plus()) {
> >       ^
> > arch/arm/plat-omap/dma.c:481:2: note: here
> >   default:
> >   ^~~~~~~
> > 
> > Notice that, in this particular case, the code comment is
> > modified in accordance with what GCC is expecting to find.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applying into fixes thanks.

Tony
