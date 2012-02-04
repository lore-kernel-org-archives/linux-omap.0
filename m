From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
	in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 17:55:28 +0000
Message-ID: <20120204175528.GL1275@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com> <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com> <alpine.DEB.2.00.1202040928320.9453@utopia.booyaka.com> <20120204165736.GI1275@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1202041029520.9453@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202041029520.9453@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Feb 04, 2012 at 10:32:16AM -0700, Paul Walmsley wrote:
> On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:
> 
> > [detailed discussion of framing errors]
> 
> Thanks for the detailed description.  If the driver is in fact discarding 
> characters with framing errors -- which I have not personally verified -- 
> then taking further action there is pointless.

Paul, I know you don't particularly like me getting involved with OMAP
issues, but tough.  You don't seem to understand some of these issues so
you're going to get more explanation.

And you didn't get the point, and why I included the detailed illustration.
No, the character with a framing error is not discarded out of the FIFO.
It is kept in the FIFO along with its corresponding error bits.

When that character comes to the top of the FIFO, the error bits for that
character become available.

When we read the character, we also read the error bits.  If the termios
settings are such that _userspace_ asks for characters with errors to be
ignored, then even if the UART received a character with a framing error,
the bit pattern that it received _must_ still be passed to userspace.

Userspace can also ask for characters in error to be received, but marked
with special markers

Userspace can also ask for characters in error to be discarded.

Same with parity errors and the like.

But, the thing which really hurts is that you've totally and utterly
failed to understand my point that it is possible to receive characters
in a serial stream _without_ errors but for the received characters to
be completely different from what was transmitted - and there's nothing
you can do about that.

That is why shutting down the clock whenever you're expecting to receive
a character is totally and utterly the wrong thing to be doing in any
case what so ever, even if your protocol retries.
