From: Detlef Vollmann <dv@vollmann.ch>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 20:12:07 +0200
Message-ID: <4DA88A77.6050502@vollmann.ch>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA85B49.60209@vollmann.ch>
	<20110415153723.GD4423@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110415153723.GD4423@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@ti.com>, davinci-linux-open-source@linux.davincidsp.com, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 04/15/11 17:37, Russell King - ARM Linux wrote:
> On Fri, Apr 15, 2011 at 04:50:49PM +0200, Detlef Vollmann wrote:
>> I'd love to have the mapping inside the create pool, but that might
>> not be possible in general.
>
> No, think about it.  What if you need to map the RAM area with some
> special attributes - eg, where ioremap() doesn't work.  Eg, OMAP you
> need SRAM mapped as normal memory, except for OMAP34xx where it must
> be mapped normal memory non-cacheable.
>
> It's best to leave the mapping to the architecture.
Ok, I agree.

>>> Another question is whether we should allow multiple SRAM pools or not -
>>> this code does allow multiple pools, but so far we only have one pool
>>> per SoC.  Overdesign?  Maybe, but it prevents SoCs wanting to duplicate
>>> it if they want to partition the SRAM, or have peripheral-local SRAMs.
>> Having the option to partition the SRAM is probably useful.
>> What I'm missing is sram_pool_add: on AT91SAM9G20 you have two banks
>> of SRAM, and you might want to combine them into a single pool.
>
> Do you already combine them into a single pool, or is this a wishlist?
Well, I have it on my list for next week to write a driver that needs
that.  So your proposal came just in time :-)

> I'm really not interested in sorting out peoples wishlist items in
> the process of consolidation.
If your code doesn't support it, then I have three options:
  - implementing my own pool (this actually might make sense, as
    my requirement adds quite some overhead that others don't
    want to pay),
  - providing a patch on top of your implementation (as long as
    struct sram_pool is an opaque type, this doesn't change the API), or
  - forget dynamic allocation and assign buffers statically in the
    board setup.

Of course, if the mirroring mentioned by Nicolas I don't need any
of this...

> Second point is that you'll notice that the code converts to a phys
> address using this: phys = phys_base + (virt - virt_base).  As soon as
> we start allowing multiple regions of SRAM, it becomes impossible to
> provide the phys address without a lot more complexity.
Yes, I understand that.  This either requires some intrusive changes
to gen_pool code or quite some additional code in sram_pool_alloc.


And just one minor point: you might consider to rename sram_* to
pram_* (or similar), as there's nothing specific to SRAM in your
pool, the specific thing that sram_pool adds on top of gen_pool
is the physical address.  And a lot of systems have external SRAM
that will normally not be used with your sram_pool.

   Detlef
