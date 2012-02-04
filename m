From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 12:37:06 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202041224170.9453@utopia.booyaka.com>
References: <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com> <alpine.DEB.2.00.1202040928320.9453@utopia.booyaka.com> <20120204165736.GI1275@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1202041029520.9453@utopia.booyaka.com> <20120204175528.GL1275@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120204175528.GL1275@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>, khilman@ti.com, NeilBrown <neilb@suse.de>, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:

> On Sat, Feb 04, 2012 at 10:32:16AM -0700, Paul Walmsley wrote:
> > On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:
> > 
> > > [detailed discussion of framing errors]
> > 
> > Thanks for the detailed description.  If the driver is in fact discarding 
> > characters with framing errors -- which I have not personally verified -- 
> > then taking further action there is pointless.
> 
> Paul, I know you don't particularly like me getting involved with OMAP
> issues, but tough.  You don't seem to understand some of these issues so
> you're going to get more explanation.

Hehe.  Oh, hurt me again with more explanation, please ;-)  I can't take 
it ;-)  I happen to enjoy many of your technical explanations.  Doesn't 
necessarily mean that we're always in agreement, though.

As for the part about not wanting you involved with OMAP, that's an 
interesting perspective, considering I mentioned to you at ELC-E last year 
my appreciation of your technical review on the lists.  And you'll 
probably note, if you care to review the lists, that many of my E-mail 
responses express gratitude for your comments... including the one you 
quoted.

Of course the snarky, personal bits can be unnecessarily irritating, but 
anyone who's in this line of work just has to deal with them, it seems.

So if you want to believe otherwise, there's nothing I can do to control 
that.  But you should represent this as your personal perspective, and 
not as someone else's, e.g., mine.


- Paul
