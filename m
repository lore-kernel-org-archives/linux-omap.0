From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2] ARM: avoid Cortex-A9 livelock on tight dmb loops
Date: Sun, 27 Jan 2019 15:28:50 +0000
Message-ID: <20190127152850.gs45h6rppdsuueye@e5254000004ec.dyn.armlinux.org.uk>
References: <E1gn8dp-0004Ai-AW@rmk-PC.armlinux.org.uk>
 <20190125232020.GX5720@atomide.com>
 <alpine.DEB.2.21.999.1901262053130.20293@utopia.booyaka.com>
 <20190126235123.lo6nbuttvdh27qyv@e5254000004ec.dyn.armlinux.org.uk>
 <alpine.DEB.2.21.999.1901270110050.17971@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.999.1901270110050.17971@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@codeaurora.org>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, Jan 27, 2019 at 01:15:31AM +0000, Paul Walmsley wrote:
> On Sat, 26 Jan 2019, Russell King - ARM Linux admin wrote:
> 
> > On Sat, Jan 26, 2019 at 09:00:03PM +0000, Paul Walmsley wrote:
> > > On Fri, 25 Jan 2019, Tony Lindgren wrote:
> > > 
> > > > * Russell King <rmk+kernel@armlinux.org.uk> [190125 21:04]:
> > > > > Executing loops such as:
> > > > > 
> > > > > 	while (1)
> > > > > 		cpu_relax();
> > > > > 
> > > > > with interrupts disabled results in a livelock of the entire system,
> > > > > as other CPUs are prevented making progress.  This is most noticable
> > > > > as a failure of crashdump kexec, which stops just after issuing:
> > > > > 
> > > > > 	Loading crashdump kernel...
> > > > > 
> > > > > to the system console.  A workaround for this is to use 10 nops in
> > > > > cpu_relax().
> > > > > 
> > > > > We also use wfe() in while (1) loops to avoid burning cycles in a
> > > > > tight loop, giving the CPU a hint that we're not doing anything
> > > > > useful.
> > > > > 
> > > > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > > > ---
> > > > > It's been a while since this was posted, Will's suggestion was to use
> > > > > 10 nops in cpu_relax() last time around.  I still prefer wfe() in
> > > > > these infinite-not-doing-anything-ever loops.
> > > > 
> > > > Works for me:
> > > > 
> > > > Tested-by: Tony Lindgren <tony@atomide.com>
> > > 
> > > There was some concern in the past that WFE, like WFI, might cause the 
> > > core to assert an external signal that might cause the SoC integration to 
> > > place the core into a low-power mode from which it might not be able to 
> > > wake up.  This could happen on OMAP, for example, with WFI.
> > > 
> > > I don't recall the outcome of those discussions.  Was a conclusion ever 
> > > reached?
> > 
> > First, we use WFE in spinlocks.  If WFE were to place the CPU in a
> > low power state that it may not be able to wake up from, all our
> > spinlocks would be unsafe.
> 
> Good point.  WFE must not assert the external signal that indicates 
> that the core is inactive.
> 
> > Next, in all of the situations in this patch, we're executing an
> > infinite loop.  If it were to cause the core to go into a low power
> > mode, surely that's a good thing, rather than the core endlessly
> > executing NOPs?  The only way out of that is for the core to receive
> > a reset _anyway_.
> 
> Makes sense.  
> 
> Do you recall what Will's reasoning was for preferring 10 NOPs to a WFE?

I think there may be an erratum for this which specifies 10 NOPs as
its workaround, but I don't have its number.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
