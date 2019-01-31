From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Thu, 31 Jan 2019 13:58:05 +0000
Message-ID: <20190131135805.GD21965@fuggles.cambridge.arm.com>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
 <20190125232020.GX5720@atomide.com>
 <alpine.DEB.2.21.999.1901262053130.20293@utopia.booyaka.com>
 <20190126235123.lo6nbuttvdh27qyv@e5254000004ec.dyn.armlinux.org.uk>
 <alpine.DEB.2.21.999.1901270110050.17971@utopia.booyaka.com>
 <20190127152850.gs45h6rppdsuueye@e5254000004ec.dyn.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190127152850.gs45h6rppdsuueye@e5254000004ec.dyn.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Russell, Paul,

On Sun, Jan 27, 2019 at 03:28:50PM +0000, Russell King - ARM Linux admin wrote:
> On Sun, Jan 27, 2019 at 01:15:31AM +0000, Paul Walmsley wrote:
> > On Sat, 26 Jan 2019, Russell King - ARM Linux admin wrote:
> > > On Sat, Jan 26, 2019 at 09:00:03PM +0000, Paul Walmsley wrote:
> > > > There was some concern in the past that WFE, like WFI, might cause the 
> > > > core to assert an external signal that might cause the SoC integration to 
> > > > place the core into a low-power mode from which it might not be able to 
> > > > wake up.  This could happen on OMAP, for example, with WFI.
> > > > 
> > > > I don't recall the outcome of those discussions.  Was a conclusion ever 
> > > > reached?
> > > 
> > > First, we use WFE in spinlocks.  If WFE were to place the CPU in a
> > > low power state that it may not be able to wake up from, all our
> > > spinlocks would be unsafe.
> > 
> > Good point.  WFE must not assert the external signal that indicates 
> > that the core is inactive.
> > 
> > > Next, in all of the situations in this patch, we're executing an
> > > infinite loop.  If it were to cause the core to go into a low power
> > > mode, surely that's a good thing, rather than the core endlessly
> > > executing NOPs?  The only way out of that is for the core to receive
> > > a reset _anyway_.
> > 
> > Makes sense.  
> > 
> > Do you recall what Will's reasoning was for preferring 10 NOPs to a WFE?
> 
> I think there may be an erratum for this which specifies 10 NOPs as
> its workaround, but I don't have its number.

The erratum hits because cpu_relax() is a DMB instruction due to erratum
754327. That then triggers erratum 794072 because a tight loop of DMB
instructions can cause a denial of service. One of the conditions for that
to occur is:

  | * No more than 10 instructions other than the DMB are executed between
  |   each DMB

Digging up the workaround:

  |  This erratum can be worked round by setting bit[4] of the undocumented
  |  Diagnostic Control Register to 1. This register is encoded as
  |  CP15 c15 0 c0 1. This bit can be written in Secure state only, with the
  |  following Read/Modify/Write code sequence:
  |
  |	MRC p15,0,rt,c15,c0,1
  |	ORR rt,rt,#0x10
  |	MCR p15,0,rt,c15,c0,1
  |
  |  When it is set, this bit causes the DMB instruction to be decoded and
  |  executed like a DSB. Using this software workaround is not expected to
  |  have any impact on the overall performance of the processor on a typical
  |  code base.
  |
  |  Other workarounds are also available for this erratum, to either prevent
  |  or interrupt the continuous stream of DMB instructions that causes the
  |  deadlock.
  |
  |  For example:
  |	* Inserting a non-conditional Load or Store instruction in the loop
  |	  between each DMB
  |	* Inserting additional instructions in the loop, such as NOPs, to
  |       avoid the processor seeing back to back DMB instructions.
  |	* Making the processor executing the short loop take regular
  |	  interrupts.

So the reason I prefer the NOPs is because that's guaranteed by the h/w folks
to do the trick, whereas they say nothing about WFE. It should be dead easy to
use NOPs instead, so I'm not sure why we're not just following the workaround
here. We could even use NOPs + WFE if you like!

Will "archaeologist" Deacon
