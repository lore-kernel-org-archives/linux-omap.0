From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
	in non-DMA" added to tty tree
Date: Sun, 5 Feb 2012 17:57:40 +0000
Message-ID: <EF62F09C0797D947AD4180A1043C0DF734934E9D@DLEE10.ent.ti.com>
References: <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
 <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
 <20120203205401.5ddf241d@notabene.brown>
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
 <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
 <20120204163931.GH1275@n2100.arm.linux.org.uk>
 <EF62F09C0797D947AD4180A1043C0DF734934E36@DLEE10.ent.ti.com>
 <20120205160329.GO1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120205160329.GO1275@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Paul Walmsley <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, NeilBrown <neilb@suse.de>, "R, Govindraj" <govindraj.raja@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Sunday, February 05, 2012 10:03 AM
> To: Woodruff, Richard

> On Sun, Feb 05, 2012 at 03:37:21PM +0000, Woodruff, Richard wrote:
> > [x] What is acceptable depends is not black and white.  Is there some
> > QOS mapping which can be set per channel which allows runtime PM to
> > pick a best chose (which may allow for loss and frame issues)?.
> 
> What you're asking is whether there's anything in the kernel which can
> predict when the next character is to arrive.

No, this was not the comment's intent.

> But, the fact of the matter is that deriving the UART clocks from a PLL
> which takes a finite time to lock, and the PLL is shut down during runtime
> PM _is_ _going_ _to_ _cause_ _problems_.  There is absolutely no getting
> away from that.

Yes this is one of the issues to be worked around.

> Let's take your modem example.  Modems today would typically be used with
> some IP based protocol, probably PPP based.  Incoming traffic on IP is
> entirely unpredictable.  You wouldn't know when the next character would
> be received.
> 
> One solution to this is to transmit an 0xff character before your real
> data to ensure that your end is awake and properly synchronized...

This approach as you say has issues.  This is solved in different ways for modems.

<sleep>My observation is modem software which many talk over ppp over ip over serial of some sort (might be uart, might be usb), will send a command to the modem to go into a low power mode. Now you can cut clocks with out hurting modem and getting SOC power.

<wake>When some event happens at modem or processor (timer near beacon or other) the modem or apps processor can signal the other with some wake event (maybe over gpio) which then puts system in a state where it can receive data in trusted manner.

The modem channel driver try's to inform kernel about entering/exiting modes to set expectation.

> So, go ahead with having PM drop random characters if you want, but don't
> expect anyone in their right mind to accept broken workarounds to the
> kernel serial driver to try to drop maybe 16 characters or more at a time
> on the floor when a framing error occurs just because the PM is broken.

No character was dropped in modem example.  On the UART-to-Debug console it may be ok to drop a character.  Ether needs a coordination hook.

Each stack needs some way to adjust expectations.  Finding a way to isolate to a sub-layer of stack and not break everything is always the quest.

> And let's not forget the problem that current kernels have on OMAP34xx
> platforms.  Literally minutes to get a dmesg out over a 115200 baud serial
> port, 16 characters at a time.  I guess you're going to try to justify
> that as 'acceptable behaviour' from the system.  Yes, of course it is.
> If you're dealing with a 1960s computer which processes that slowly.
> 
> And I thought we were in 2012.

This looks like a different issue.  Years back with custom kernels with lots of hacks hack this was not the case.  These days the job is harder to make it work more generally.  Evolving for PM tradeoffs is painful in HW and SW.

Regards,
Richard W.

