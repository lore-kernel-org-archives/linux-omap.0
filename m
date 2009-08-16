From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 3/3] [OMAP:I2C]OMAP3430 Silicon Errata 1.153
Date: Sun, 16 Aug 2009 11:39:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908160841160.31720@utopia.booyaka.com>
References: <CD8CC2B65FEE304DA95744A5472698F202958D2F89@dlee06.ent.ti.com> <alpine.DEB.2.00.0908030054390.19529@utopia.booyaka.com> <CD8CC2B65FEE304DA95744A5472698F202959C0D61@dlee06.ent.ti.com> <CD8CC2B65FEE304DA95744A5472698F20295A89778@dlee06.ent.ti.com>
 <alpine.DEB.2.00.0908100950040.5505@utopia.booyaka.com> <CD8CC2B65FEE304DA95744A5472698F20295A89A21@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CD8CC2B65FEE304DA95744A5472698F20295A89A21-UmuGNrFEPrGIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Sonasath, Moiz" <m-sonasath-l0cyMroinI0@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Moiz,

On Tue, 11 Aug 2009, Sonasath, Moiz wrote:

> 1. From the code we have in place now, we are writing 
> num_bytes=dev->fifosize(=XTRSH+1) bytes in case of XRDY OR 
> num_bytes=TXSTAT (last few bytes left) in case of XDR (draining feature)
> 
> Without the errata we were writing these num_bytes in a while loop one 
> by one into I2C_DATA reg (TXFIFO).
> 
> With the errata we are writing num_bytes in a while loop, but now we 
> write one byte wait for XUDF bit to get set and then write another byte. 
> Thereby, we write a byte, wait for it to get out of the TXFIFO and only 
> then we write the second byte and so on.
> 
> 	While(num_bytes)
> 	{
> 		Write one byte to I2C_DATA Reg
> 		Wait for XUDF to set
> 	}
> 	Ack the interrupt

Doesn't your patch do:

 	While(num_bytes)
 	{
 		Wait for XUDF to set
 		Write one byte to I2C_DATA Reg
 	}
 	Ack the interrupt

?

> So irrespective of the XTRSH value, the wait time is actually the same.
> 
> 2. Now if we see it from the perspective of interrupts, we are 
> generating an interrupt after every chunk of 4 bytes (with XTRSH+1=4) 
> written to the TXFIFO because we ACK the interrupt after writing a chunk 
> of 4 bytes (one byte at a time waiting for the XUDF bit to be set in 
> between each byte).
> 
> >From the TRM Figure-18-31, in the XRDY path:
> Write I2Ci.I2C_DATA register for (XTRSH+1) times and then clear XRDY interrupt
> 
> Thus, XTRSH is actually driving how many chunks of data you write before 
> generating a next interrupt. So from this point of view it will be more 
> desirable to make the XTRSH=7 and write chunk of 8 bytes before 
> generating a new interrupt. But we end up staying a longer time in the 
> ISR.
> 
> Essentially we are looking at a tradeoff between:
> 1. Lower XTRSH value: More number of interrupts, less time in an ISR  
> 2. Higher XTRSH value: Less number of interrupts, more time in an ISR 
> 
> Please correct me if I am wrong.

Your analysis looks correct.  I suppose my point is dependent on when the 
XRDY interrupt occurs if XTRSH = 0.

If it occurs one I2C byte transmission time before the XUDF condition 
occurs, then we should just use your busy-waiting patch.  I don't think we 
can do better than that.

But if the XRDY interrupt occurs at the same time as the shift register 
empties, or if there is an undocumented XUDF interrupt that we can use, 
then please consider:

For slower I2C bus speeds, e.g., for a 400KHz I2C bus, emptying a byte out 
of the transmit FIFO should take about 20 microseconds [1].  Another way 
of expressing this is that the duration from when we write a byte to the 
I2C FIFO, to when the controller raises the XRDY/XDR interrupt, should be 
about 20 microseconds when XTRSH = 0.

We can either spend this time busy-looping in the ISR (the tradeoff #2 
that you mention above), or trying to reach WFI and hopefully entering it 
(the tradeoff #1 above).  If possible, tradeoff #1 seems better.  If the 
MPU can reach WFI, it will waste less active power, but it will also 
trigger the PRCM to shut down any inactive power domains, which might not 
need to wake back up when the next system wakeup event occurs.

This should improve over time, from a power efficiency perspective, 
as the amount of time the MPU spends trying to reach WFI should decrease 
[2].

What do you think?


- Paul


1. (8 I2C-cycles/byte / 400000 I2C-cycles/second) = 20 microseconds

2. With currently-available OMAP3 chips, the CPU cycle time can be as 
  short as 1.67 ns (1/600000000 cycles/second).  Future chips will 
  presumably reach at least a 1 ns cycle time, if 
  http://en.wikipedia.org/wiki/Texas_Instruments_OMAP is to be believed. 
  Multiple instructions can be executed per clock cycle.
