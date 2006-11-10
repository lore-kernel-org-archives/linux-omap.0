From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] To add OMAP 2430 Support
Date: Fri, 10 Nov 2006 02:46:06 +0200
Message-ID: <20061110004606.GY16172@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A50884C5B8@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50884C5B8@dlee02.ent.ti.com>
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
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Woodruff, Richard <r-woodruff2@ti.com> [061109 17:02]:
> Yes this in theory it is needed.  It is ARM implementation dependent on
> whether it is needed or not.
> 
> I've included a small graphics (hope it makes it) to help clarify.  The
> TRM also had a section on this.
> 
> - The ARM-CPU has 4 ports of interest here.  An instruction read (IR), a
> data read (DR), a data write (DW), and the peripheral port (PP).
> 
> - There is a write-buffer between the ARM and the peripheral port (there
> is also a familiar write buffer between the ARM and its data port).  A
> write to the port does not necessarily happen immediately.
>   
> - The ARM internal pipeline is NOT synchronized with the peripheral port
> but it is with the others.  This means dependencies are tracked with
> register and CPSR accesses.  This means a write to the DR can cause the
> pipeline to stall.  When you write to the PP the pipeline will never
> stall.  
> 
> ** This means you can write to acknowledge an interrupt then enable
> interrupts at the CPSR and the write to the CPSR can overtake the ACK to
> the PP.  You now have a spurious interrupt.  There are a few some
> combinations.

OK, thanks for explaining. So this means that wmb() would not be enough
because it only blocks memory access instructions, and not other access
like draining writebuffer does?
 
> Interestingly, the L3 bus on the other side of the AHB2OCP bridge also
> has multiple hardware threads and you can have times where accesses to
> one port can overtake others.  This is all ok with ARM11 as it is
> specified to have out of order operations as long as it can tell any
> dependencies/hazards have been taken care of.  How much this happens in
> practice depends on the memory system of the implementer.  There a lot
> of ARM11 memory system optimizations which the standard ARM kernel does
> not take advantage of today.  It takes the simple road with marking
> things as strongly ordered.

Well maybe someday somebody will do a patch for that :)

Tony
