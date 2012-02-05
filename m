From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
	in non-DMA" added to tty tree
Date: Sun, 5 Feb 2012 16:03:29 +0000
Message-ID: <20120205160329.GO1275@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com> <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com> <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com> <20120204163931.GH1275@n2100.arm.linux.org.uk> <EF62F09C0797D947AD4180A1043C0DF734934E36@DLEE10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <EF62F09C0797D947AD4180A1043C0DF734934E36@DLEE10.ent.ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, NeilBrown <neilb@suse.de>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Feb 05, 2012 at 03:37:21PM +0000, Woodruff, Richard wrote:
> [x] What is acceptable depends is not black and white.  Is there some
> QOS mapping which can be set per channel which allows runtime PM to
> pick a best chose (which may allow for loss and frame issues)?.

What you're asking is whether there's anything in the kernel which can
predict when the next character is to arrive.

For many serial protocols, that would require a non-causal universe.  So
far, I'm afraid, physics hasn't managed to provably invent time travel
in any useful way.  Once physics has, then maybe this can be fixed.

But, the fact of the matter is that deriving the UART clocks from a PLL
which takes a finite time to lock, and the PLL is shut down during runtime
PM _is_ _going_ _to_ _cause_ _problems_.  There is absolutely no getting
away from that.

Let's take your modem example.  Modems today would typically be used with
some IP based protocol, probably PPP based.  Incoming traffic on IP is
entirely unpredictable.  You wouldn't know when the next character would
be received.

One solution to this is to transmit an 0xff character before your real
data to ensure that your end is awake and properly synchronized...

Therefore, if you're running PPP (or, shudder, SLIP) over serial, you'd
have to totally defeat the PM support for the port.  No, not just for the
initial negotiation, but all the time that the PPP connection was
established.

You can't rely on the remote end retrying, because of backoffs.

You'll find that setting a PM timeout of maybe 5 seconds works, but as
soon as you experience a flakey link somewhere, the TCP could backoff to
10 seconds or even minutes with its retry.  At that point you're into a
vicious circle because you're now putting the port into low power mode,
which will drop the first character.  That means that TCP's retry will
get dropped on the floor, which in turn will increase the TCP backoff.
And so the cycle continues with ever increasing TCP backoffs and no
forward progress.

... but the problem with the 0xff character approach here is that most
ISPs won't allow you to drop by and fiddle with their PPP termination to
add that workaround.  They'll rightfully tell you to go screw yourself
and get some hardware which works.

So, go ahead with having PM drop random characters if you want, but don't
expect anyone in their right mind to accept broken workarounds to the
kernel serial driver to try to drop maybe 16 characters or more at a time
on the floor when a framing error occurs just because the PM is broken.

And let's not forget the problem that current kernels have on OMAP34xx
platforms.  Literally minutes to get a dmesg out over a 115200 baud serial
port, 16 characters at a time.  I guess you're going to try to justify
that as 'acceptable behaviour' from the system.  Yes, of course it is.
If you're dealing with a 1960s computer which processes that slowly.

And I thought we were in 2012.
