From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: MUSB: BUG on potential deadlocks
Date: Fri, 31 Aug 2007 11:41:43 -0700
Message-ID: <46D860E7.6080306@mvista.com>
References: <20070831025359.663866890@mvista.com>
	<20070831025811.887406517@mvista.com>
	<20070831060525.6B49D23744C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<46D83F42.5090004@mvista.com>
	<20070831174932.3FEA123719C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070831174932.3FEA123719C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
>>> This isn't a good patch.  *ADDING* a BUG() is wrong, and that's
>>> especially true for things like spin_is_locked() 
>> I probably should've made this an RFC instead of a patch.  I meant for
>> this to be a debug aid, not to actually go into the tree.  I'm using
>> this to try to track down some deadlocks and thought it may be useful to
>> others.  It has already turned up a couple problems (see below.)
> 
> OK, that's better.  As I presume you've deduced, a lot of the recent
> cleanup effort in this driver is so we can try pushing it upstream
> for 2.6.24 ... abuse of BUG() wouldn't help that!
> 
> 
>>> It'd be much better to actually submit fixes for any locking bugs
>>> than to add BUG_ON() statements.
>> I agree, and I'm working on the fixes.  Just not sure I have the right
>> fix yet.
>>
>> For exaple, I've found a couple paths where the BUG_ON() has definitely
>> turned up a problem:
>>
>> dma_controller_irq
>>  musb_dma_completion
>>   musb_g_rx  (or musb_host_rx in host mode)
>>    musb_g_giveback (musb_advance_schedule --> musb_giveback)
>>
>> In both host and gadget cases, the giveback function is entered without
>> the lock being held and tries to unlock the lock.  The comment in
>> musb_dma_completion says that the lock is held, but it's not when called
>> from the DMA IRQ ( but is when called from davinci_irq via
>> cppi_completion.)
> 
> I presume you mean the OMAP2430 support?  Looked to me like TUSB6010
> got that OK too.  That code for Mentor's DMA engine still has obvious
> bugs; and I don't know that it's ever had more than basic cleanups.

Yes, this is 2430.

So is nobody else trying to use the Mentor's DMA engine?  I know it's
typically disabled on DaVinci, but is it used on tusb?

Kevin
