From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] McBSP support on omap24xx
Date: Sun, 15 Jan 2006 11:44:43 -0800
Message-ID: <20060115194334.GC5905@atomide.com>
References: <20060114012705.GR5499@atomide.com>
	<20060114133449.21660.qmail@web32903.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060114133449.21660.qmail@web32903.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060114 09:40]:
> --- Tony Lindgren <tony@atomide.com> wrote:
> 
> > 
> > Thanks, updated for clk_enable and manually merged the mux entries.
> > Can
> > you please verify?
> 
> Ooops. I should have replied to this patch earlier. It already broke
> innovator1510 and 730, because of #ifdef in register defines in
> mcbsp.h.

Yeah, we should get rid of the ifdefs... With the mux.h now common for
omap1 and omap2, the ifdefs around muxing should not be needed any
longer.
 
> It is better to have OMAP2_ prefix for McBSP registers, as per my first
> McBSP patch. I will fix this and submit the patch.

OK
 
> Apart from this, McBSP.c getting started looking ugly because of lots
> of #ifdefers, it is better to have platform_data/driver support for
> this McBSP apis _or_ a small framework.

Yes.

Tony
