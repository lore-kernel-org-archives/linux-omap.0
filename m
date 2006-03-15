From: Tom Rini <trini@kernel.crashing.org>
Subject: Re: OSK5912 and CF and network broken?
Date: Wed, 15 Mar 2006 13:31:29 -0700
Message-ID: <20060315203129.GC16873@smtp.west.cox.net>
References: <20060315183006.GA16873@smtp.west.cox.net>
	<20060315183645.GC14010@atomide.com>
	<20060315192251.GB16873@smtp.west.cox.net>
	<20060315194142.GD14010@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060315194142.GD14010@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 15, 2006 at 11:41:42AM -0800, Tony Lindgren wrote:
> * Tom Rini <trini@kernel.crashing.org> [060315 11:28]:
> > On Wed, Mar 15, 2006 at 10:36:45AM -0800, Tony Lindgren wrote:
> > > * Tom Rini <trini@kernel.crashing.org> [060315 10:31]:
> > > > Hello.  I'm trying to use current linux-omap-2.6 (source.mvista.com one)
> > > > git with the omap_osk_5912_defconfig and with U-Boot 1.1.4 release (+ 2
> > > > patches from this list).  I can bring the board up just fine but when I
> > > > insert a CF device I see:
> > > > pccard: PCMCIA card inserted into slot 0
> > > > pcmcia: registering new device pcmcia0.0
> > > > NETDEV WATCHDOG: eth0: transmit timed out
> > > > ...
> > > > NETDEV WATCHDOG: eth0: transmit timed out
> > > > pccard: card ejected from slot 0
> > > > 
> > > > Has anyone seen this before?  Or should I just looking at the interrupt
> > > > routes?  I'm assuming that the board does support me using both CF and
> > > > network at the same time.  Thanks!
> > > 
> > > This should not happen... It sounds like an issue with the flash bus timings.
> > > Might be worth grepping for EMIFS_CS values.
> > 
> > Er, this?
> > linux-omap-2.6]$ grep -r EMIFS_CS arch/arm include/asm-arm
> > arch/arm/mach-omap1/board-osk.c:#define EMIFS_CS3_VAL   (0x88013141)
> > arch/arm/mach-omap1/board-osk.c:        if (EMIFS_CCS(3) != EMIFS_CS3_VAL)
> > arch/arm/mach-omap1/board-osk.c:                EMIFS_CCS(3) = EMIFS_CS3_VAL;
> > include/asm-arm/arch-omap/tc.h:#define EMIFS_CS0_CONFIG (TCMIF_BASE + 0x10)
> > include/asm-arm/arch-omap/tc.h:#define EMIFS_CS1_CONFIG (TCMIF_BASE + 0x14)
> > include/asm-arm/arch-omap/tc.h:#define EMIFS_CS2_CONFIG (TCMIF_BASE + 0x18)
> > include/asm-arm/arch-omap/tc.h:#define EMIFS_CS3_CONFIG (TCMIF_BASE + 0x1c)
> > include/asm-arm/arch-omap/tc.h:#define EMIFS_CCS(n)             __REG32(EMIFS_CS0_CONFIG + (4 * (n)))
> 
> Yes, and then also some settings are done in drivers/pcmcia/omap_cf.c.
> Maybe omap_cf.c undoes some EMIFS_CS settings done in board-osk.c?

Yes, it does change CS2:
omap_cf: cs2, previous ccs ff80fff3 acs 00000002
omap_cf: cs2, current ccs 0004a1b3 acs 00000000

With the comment:
        /* NOTE:  better EMIFS setup might support more cards; but the
         * TRM only shows how to affect regular flash signals, not their
         * CF/PCMCIA variants...
         */


-- 
Tom Rini
http://gate.crashing.org/~trini/
