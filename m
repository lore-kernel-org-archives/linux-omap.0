From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Please help with the OMAP static mapping mess
Date: Tue, 04 Oct 2011 22:39:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1110042232380.9106@xanadu.home>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
	<20111003205658.GJ6324@atomide.com>
	<alpine.LFD.2.02.1110031744100.9106@xanadu.home>
	<20111003223824.GK6324@atomide.com> <4E8AAFF9.3090600@ti.com>
	<alpine.LFD.2.02.1110041458500.9106@xanadu.home>
	<4E8BBC6B.7000500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <4E8BBC6B.7000500@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robherring2@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, 4 Oct 2011, Rob Herring wrote:

> On 10/04/2011 04:21 PM, Nicolas Pitre wrote:
> > On Tue, 4 Oct 2011, Santosh Shilimkar wrote:
> > 
> >> On Tuesday 04 October 2011 04:08 AM, Tony Lindgren wrote:
> >>> * Nicolas Pitre <nico@fluxnic.net> [111003 14:36]:
> >>>> On Mon, 3 Oct 2011, Tony Lindgren wrote:
> >>>>
> >>>>> Having the SRAM base address move around with different sizes also
> >>>>> requires the SoC detection.. Otherwise we can end up mapping wrong
> >>>>> size and end up trying to access secure SRAM that will hang the system.
> >>>>>
> >>>>> The way to fix it is to move SRAM init happen much later so we don't
> >>>>> have to map it early. I guess now we could use ioremap for SRAM,
> >>>>> although we may not want device attributes for the executable code?
> >>>>> Got any suggestions here on how we should map SRAM later on?
> >>>>
> >>>> You can use a variant of ioremap() such as __arm_ioremap() which let you 
> >>>> specify the memory attribute.
> >>>
> >>> OK, I'll take a look at that.
> >>>
> >> I have tried __arm_ioremap_pfn() for some DDR mapping and it didn't
> >> work as expected. The mapping was not getting created.
> > 
> > Did you investigate why it wasn't created?  Must have been a trivial 
> > issue surely?  But you have to wait until memory management is fully 
> > initialized to call the real ioremap() though, which happens later 
> > during the boot.
> > 
> 
> Isn't ioremap prevented from using main memory now?

My point is that the memory allocator has to be fully initialized 
because memory might need to be allocated when ioremap() is called.  At 
the point where static mappings are created, the regular memory 
allocator is not available yet.


Nicolas
