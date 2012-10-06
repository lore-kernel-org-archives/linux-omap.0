From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 00/24] OMAP serial driver flow control fixes, and
	preparation for DMA engine conversion
Date: Sat, 6 Oct 2012 15:23:51 +0100
Message-ID: <20121006142351.GE15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Oct 06, 2012 at 01:38:03PM +0100, Russell King - ARM Linux wrote:
> Hi,
> 
> This series of patches fixes multiple flow control issues with the OMAP
> serial driver, and prepares the driver for DMA engine conversion.  We
> require hardware assisted flow control to work properly for DMA support
> otherwise we have no way to properly pause the transmitter.
> 
> This is generated against v3.6, and has been developed mainly by testing
> on the OMAP4430 SDP platform.
> 
> Flow control seems to be really broken in the OMAP serial driver as things
> stand today.  It just about works with software flow control because the
> generic serial core layer is inserting those characters, but only when the
> legacy DMA support is not being used.  Otherwise, flow control is
> completely non-functional.
> 
> Issues identified in the OMAP serial driver are:
> - set_mctrl() can only assert modem control lines, once asserted it
>   is not possible to deassert them.
> - IXOFF controls sending of XON/XOFF characters, not the reception of
>   these sequences.
> - IXON controls the recognition of XON/XOFF characters, not the transmission
>   of the same.
> - Wrong bitmasks for hardware assisted software flow control.  Bit 2
>   in EFR enables sending of XON2/XOFF2 which are never set.
> - No point comparing received characters against XOFF2 ('special character
>   detect') as XOFF2 is not set.
> - Fix multiple places where bits 6 and 5 of MCR are attempted to be
>   altered, but because EFR ECB is unset, these bits remain unaffected.
>   This effectively prevents us accessing the right XON/XOFF/TCR/TLR
>   registers.
> - Remove unnecessary read-backs of EFR/MCR/LCR registers - these registers
>   don't change beneath us, they are configuration registers which hold their
>   values.  Not only does this simplify the code, but it makes it more
>   readable, and more importantly ensures that we work from a consistent
>   state where ->efr never has ECB set, and ->mcr never has the TCRTLR
>   bit set.
> - Fix disablement of hardware flow control and IXANY modes; once enabled
>   these could never be disabled because nothing in the code ever clears
>   these configuration bits.
> 
> Once that lot is fixed, these patches expand serial_core to permit hardware
> assisted flow control by:
> - adding throttle/unthrottle callbacks into low level serial drivers,
>   which allow them to take whatever action is necessary with hardware
>   assisted flow control to throttle the remote end.  In the case of
>   OMAP serial, this means disabling the RX interrupts so that the FIFO
>   fills to the watermark.
> 
> We then have a number of cleanups to the OMAP serial code to make the
> set_termios() function clearer and less prone to the kinds of mistakes
> identified above.  This results in a great simplification of the flow
> control configuration code.
> 
> The OMAP serial driver hacks around with the transmit buffer allocation;
> lets clean that up so that drivers can cleanly allocate their transmitter
> buffer using coherent memory if that's what they desire.
> 
> Finally, the last few patches clean up the plat/omap-serial.h header file,
> moving most of its contents into the OMAP serial driver itself.  Most of
> this is private to the OMAP serial driver and should never have been
> shared with anything else.
> 
> I have omitted to include the conversion of the transmit paths to DMA
> engine.  Even with all the above fixed, it has issues when DMA transmit
> is in progress, and a program issues a TCSETS call (as `less' does after
> it has written its prompt.)  At the moment, this causes lots of junk to
> be emitted from the serial port when issuing `dmesg | less' which sometimes
> brings the port to a complete halt.
> 
> As the OMAP DMA hardware does not have a clean pause when performing a
> MEM->DEV transfer (it discards its FIFO) I do not see a solution to this,
> which probably means that we can _not_ ever support transmit DMA on OMAP
> platforms.
> 
> This means the xmit buffer allocation patches are not that useful unless
> a solution to that can be found.
> 
> Now, the remaining question is, how much of this patch set do we think
> about merging, and when.  Given that flow control in this driver has been
> broken for a very long time, and no one has apparantly noticed, I don't
> think there's any urgency to this, so given its size, my preference would
> be to queue it up for the next merge window.  The thing that would worry
> me about applying some of the initial patches is that they may change
> the behaviour today and make any problems here more visible.

I'll add another point to this: serial_omap_restore_context() makes no
attempt to restore neither the protected bits in the MCR register nor
the contents of the TCR and TLR registers.  So, hardware assisted flow
control probably won't work at all well after a context loss event.
When I work out how to test this, I'll see about cooking up yet another
fix to this driver.
