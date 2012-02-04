From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
	in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 16:57:36 +0000
Message-ID: <20120204165736.GI1275@n2100.arm.linux.org.uk>
References: <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com> <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com> <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com> <alpine.DEB.2.00.1202040928320.9453@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202040928320.9453@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Feb 04, 2012 at 09:31:29AM -0700, Paul Walmsley wrote:
> Aside from trying some of the muxing suggestions that Neil proposed, 
> perhaps the UART driver should clear the RX FIFO if the UART detects a 
> framing error?  e.g., section 17.4.4.1.3.5 "Error Detection" in the
> 34xx TRM vZT.

Paul, do you have a desire to totally destroy serial ports on OMAP,
because these kinds of suggestions are where you're going with it.
You're also in danger of making the OMAP serial ports not conform to
POSIX conventions.

Errors in received characters are already dealt with.  Depending on the
termios settings, the driver should be detecting framing errors, and
discarding characters with framing errors.

And no amount of FIFO clearing recovers from a framing error.  Consider
this as the transmitted bitstream:

0x67 0x66 0x66 0x66 0x66
S01234567TS01234567TS01234567TS01234567TS01234567T
01110011010011001101001100110100110011010011001101

This can be successfully received without framing errors here, and you'll
never be the wiser.

S01234567TS01234567TS01234567TS01234567TS01234567T
0011010011001101001100110100110011010011001101

So, this gets received as 0x96 0x96 0x96 0x96.  You have no idea that the
stream you're receiving is incorrect - it appears to be correctly framed.

S01234567TS01234567TS01234567TS01234567TS01234567T
010011001101001100110100110011010011001101

Or maybe 0x99 0x99 0x99 0x99 ... again, no framing error.

Take a different pattern - 'linux\n':
0x6c 0x69 0x6e 0x75 0x78 0x0a
S01234567TS01234567TS01234567TS01234567TS01234567TS01234567T
000110110101001011010011101101010101110100001111010010100001

This could be received as:
S01234567T S01234567T   S01234567T   S01234567TS01234567TS01234567T
00110110101001011010011101101010101110100001111010010100001
         *          *            *                      *
0110110101 001011010011101101010101110100001111010010100001
                    *            *                      *
0110101001 0110100111   01101010101110100001111010010100001
                                 *                      *

where the '*' indicates where we end up with framing errors.  Again,
we have some characters which appear to be received validly, others
which aren't.

Let's take the last case.  You've received 0x2b 0xcb before you've
discovered a framing error.  You can't wipe out those two characters
you've already delivered to the upper layers - and it would be totally
incorrect to do so.  The framing error might be a single bit error.

So please, stop trying to bastardize this stuff by coming up with mad
work-arounds which just make things worse for this obviously broken
hardware.

The fact of the matter is - if idling the serial port results in the
clocks being stopped, and you can't _instantly_ restart the clocks when
the RXD line first goes low to start sampling the first bit of the
transmission, you _absolutely_ _can_ _not_ allow the port to have its
clock stopped all the time which you expect to receive a character from
it.  No ifs or buts.  You can't.  There's no getting away from that.
There's no work-around.  There's nothing you can do with a framing error
to solve it.  Emptying the FIFO won't help (as I've shown above with
the valid characters received before the framing error).

So, just admit that this is broken and don't allow the port to be idled
while it's in use.
