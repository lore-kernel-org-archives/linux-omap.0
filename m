From: David Brownell <david-b@pacbell.net>
Subject: Re: How to port the musb to a new processor?
Date: Wed, 29 Aug 2007 10:37:41 -0700
Message-ID: <200708291037.42496.david-b@pacbell.net>
References: <1188379634.5910.8.camel@roc-desktop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1188379634.5910.8.camel@roc-desktop>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: bryan.wu@analog.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 29 August 2007, Bryan Wu wrote:
> Hi Tony and David,
> 
> There days, I am trying to enable musb stack in my Blackfin Linux tree.
> After comparing the musb_regs.h with the BF54x USB register layout, I
> found it is not very easy to use the musb_regs.h for the porting.
> 
> 1. Offset of the musb_regs.h is different with the BF54x

None of these platforms put the Mentor registers at offset zero.
Usually offset zero has vendor-specific registers.

Chip-specific init is expected to update musb->mregs; it starts
out matching musb->ctrl_base.  All the musb_regs.h offsets are
against musb->mregs.


> 2. Some musb_regs are 8-bit wide, while on BF54x most of them are 16-bit
> or 32-bit.

The Mentor docs define only 8 bit and 16 bit registers, except for
an optional vctrl/vstatus PHY register "up to 32 bits" ... that's
not currently used in the driver.

IMO the choice of only 8 and 16 bit register widths was a design
goof on Mentor's part, especially after seeing the hassles from
putting the tusb6010 on an external 16-bit-only data bus.  But I'd
have thought changing those would be kind of "out of scope" for any
vendor integrating that IP into their own sillcion, and leaving an
option to switch to updated RTL...

Vendor specific registers can be 32 bits (or 64 bits!) very easily,
and that shouldn't affect the Mentor-related bits of the driver.


> 3. Some register not in BF54x and some BF54x register is not in
> musb_reg.h

"Not in BF54x" ... could you elaborate?   The header lists
some registers added by the 1.400 RTL, but those aren't used
by the driver.  (Though it would be nice to rely on getting
more of the configuration data from register reads, like how
big is that FIFO RAM...)


> But most BF54x USB register can found one in musb_regs.h
>
> I just wondering how to abstract this definition to BF54x hardware as
> Davinci or OMAP does.

The expectation is that the Mentor registers are a block that
doesn't change ... wrapped on either side by vendor-added
registers to handle things like saner IRQs and DMA; PHY; plus
power/reset/clock management that's not addressed by the public
registers from Mentor; and so on.

If that's how Analog did it, there should be no worries.  The
core of the driver (and some vendor-specific parts) will use
the block of Mentor registers, offsetting musb->mregs ... while
vendor/platform glue will use the others, using a vendor header
file to define offsets from musb->ctrl_base to other registers.

- Dave
 
