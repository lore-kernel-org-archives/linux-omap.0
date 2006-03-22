From: tony@atomide.com
Subject: Re: OSK5912 and CF and network broken?
Date: Wed, 22 Mar 2006 07:07:28 -0800
Message-ID: <20060322150725.GA5748@atomide.com>
References: <20060315183006.GA16873@smtp.west.cox.net>
	<44199A46.3080303@gmail.com>
	<20060316171940.GE16873@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060316171940.GE16873@smtp.west.cox.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tom Rini <trini@kernel.crashing.org> [060316 09:20]:
> On Thu, Mar 16, 2006 at 06:03:02PM +0100, Dirk Behme wrote:
> > Tom Rini wrote:
> > >Has anyone seen this before?  Or should I just looking at the interrupt
> > >routes?  I'm assuming that the board does support me using both CF and
> > >network at the same time.  Thanks!
> > 
> > Yes, board supports both, CF and network. However, OSK CF 
> > hardware is limited and is really troublesome.
> 
> I wonder if my board is just more troublesome than most.  If I turned off
> network (and used a ramdisk for userspace) I then got to the point of:
> 
> pccard: PCMCIA card inserted into slot 0                                      
> pcmcia: registering new device pcmcia0.0                                        
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> hdb: probing with STATUS(0x00) instead of ALTSTATUS(0x51)                       
> ide-cs: ide_register() at 0xc2852000 & 0xc285200e, irq 222 failed
> 
> with an old 16MB CF card.  With my 2.2GB microdrive I get more of the
> messages, but the same result.  FWIW, u-boot won't load if the MD is
> inserted, but will if the CF is.
> 
> But perhaps I need a better cardmgr options file?  I don't have anything
> board-specific in mine.  Thanks!

I believe there may be some different timings needed depending on the
OSK revision.

Tony
