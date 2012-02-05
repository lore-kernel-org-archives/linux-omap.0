From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
	in non-DMA" added to tty tree
Date: Sun, 5 Feb 2012 12:16:05 +0000
Message-ID: <20120205121604.GN1275@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com> <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com> <alpine.DEB.2.00.1202040928320.9453@utopia.booyaka.com> <20120204165736.GI1275@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1202041029520.9453@utopia.booyaka.com> <20120204175528.GL1275@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1202041224170.9453@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1202041224170.9453@utopia.booyaka.com>
Sender: linux-serial-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, Feb 04, 2012 at 12:37:06PM -0700, Paul Walmsley wrote:
> On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:
> 
> > On Sat, Feb 04, 2012 at 10:32:16AM -0700, Paul Walmsley wrote:
> > > On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:
> > > 
> > > > [detailed discussion of framing errors]
> > > 
> > > Thanks for the detailed description.  If the driver is in fact discarding 
> > > characters with framing errors -- which I have not personally verified -- 
> > > then taking further action there is pointless.
> > 
> > Paul, I know you don't particularly like me getting involved with OMAP
> > issues, but tough.  You don't seem to understand some of these issues so
> > you're going to get more explanation.
> 
> Hehe.  Oh, hurt me again with more explanation, please ;-)  I can't take 
> it ;-)  I happen to enjoy many of your technical explanations.  Doesn't 
> necessarily mean that we're always in agreement, though.
> 
> As for the part about not wanting you involved with OMAP, that's an 
> interesting perspective, considering I mentioned to you at ELC-E last year 
> my appreciation of your technical review on the lists.  And you'll 
> probably note, if you care to review the lists, that many of my E-mail 
> responses express gratitude for your comments... including the one you 
> quoted.
> 
> Of course the snarky, personal bits can be unnecessarily irritating, but 
> anyone who's in this line of work just has to deal with them, it seems.

Paul, you're being two faced.  You can see the reaction that your message
below gained:

"On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:
"> [detailed discussion of framing errors]
"
"Thanks for the detailed description.  If the driver is in fact discarding
"characters with framing errors -- which I have not personally verified --
"then taking further action there is pointless."

which, _to_ _me_, looks like you're trying to get rid of my input from
this problem, and _that_ is extremely irritating.  You talk of irritating,
but maybe you don't realise that you're _just_ as irritating too at times
- and that's not the first time you've attempted to cut off my input in
that way.

Especially when you start making suggestions like throwing away an entire
FIFO load of data when you get a framing error.  I think you have a
fundamental misunderstanding about UARTs or what's required from them.

Now, the fact is that POSIX allows user programs to tell the TTY drivers
what behaviour they want, and it's essentially one of the following:

1. Ignore errors and receive all characters from the UART whether
   they be in error or not.
2. Receive characters in the FIFO and mark characters in error.
3. Receive all properly received characters.

Which errors cause this behaviour can be controlled individually.  Here's
the extract straight from POSIX:

   If IGNBRK is set, a break condition detected on input shall be ignored;
   that is, not put on the input queue and therefore not read by any process.
   If IGNBRK is not set and BRKINT is set, the break condition shall flush
   the input and output queues, and if the terminal is the controlling
   terminal of a foreground process group, the break condition shall generate
   a single SIGINT signal to that foreground process group. If neither IGNBRK
   nor BRKINT is set, a break condition shall be read as a single 0x00, or if
   PARMRK is set, as 0xff 0x00 0x00.

   If IGNPAR is set, a byte with a framing or parity error (other than break)
   shall be ignored.

   If PARMRK is set, and IGNPAR is not set, a byte with a framing or parity
   error (other than break) shall be given to the application as the
   three-byte sequence 0xff 0x00 X, where 0xff 0x00 is a two-byte flag
   preceding each sequence and X is the data of the byte received in error.
   To avoid ambiguity in this case, if ISTRIP is not set, a valid byte of
   0xff is given to the application as 0xff 0xff. If neither PARMRK nor
   IGNPAR is set, a framing or parity error (other than break) shall be given
   to the application as a single byte 0x00.

So, as you can see, the serial driver does not have the option of throwing
characters away just because an error bit is set - the behaviour required
is left to userspace to decide, and are partly implemented by the tty
layers and partly the serial driver.  The requirements are well defined,
and 8250 follows them - and I've just checked omap-serial against 8250
and it does the same.

The fact is that the way OMAP implements the power management around UARTs
is broken, because it results in corrupted characters being received.
It's as plain and simple as that.

And there's nothing you can to do solve the problem of the broken PM
causing a badly received character which _may_ have a framing error
being passed to userspace.

If the termios settings are correct, the badly framed character shouldn't
be passed to a shell - but that doesn't stop characters which don't have
framing errors but still aren't received as they were transmitted being
passed.  And there's absolutely _nothing_ you can do about that as long
as the broken PM is enabled on the port.

As I illustrated in my 'detailed discussion of framing errors'.
