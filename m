From: Paul Walmsley <paul@pwsan.com>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 09:31:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1202040928320.9453@utopia.booyaka.com>
References: <13274430881471@kroah.org> <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com> <20120126042155.GA3185@suse.de> <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com> <20120126191604.GA15516@suse.de> <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com> <20120203150708.386951d2@notabene.brown> <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com> <20120203205401.5ddf241d@notabene.brown> <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com> <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: NeilBrown <neilb@suse.de>, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sat, 4 Feb 2012, Grazvydas Ignotas wrote:

> It's case 1. What I wanted to say is that first char is most often
> nicely dropped and does not get into the terminal, so I can just type
> the command after it. But in some cases terminal gets corrupted char
> instead, so I must then first get rid of it somehow to successfully
> send a command, which is annoying a bit. I thought that maybe there is
> code somewhere that gets rid of first bad char received and maybe it
> can be tuned, but judging on further discussions it's all done by
> hardware?
> 
> I've also noticed if I paste a command instead, up to 3 characters can
> be lost, and in some cases I get 3 corrupted chars there instead. I
> paste a command to both wake the board and read the fuel gauge just
> before it updates to see how much current board was draining while
> suspended. I insert 3 spaces at the start of command to be eaten by
> wakeup, but if it decides to corrupt those chars instead of dropping,
> the whole command is ruined. It's all at 115200 baud rate.

Aside from trying some of the muxing suggestions that Neil proposed, 
perhaps the UART driver should clear the RX FIFO if the UART detects a 
framing error?  e.g., section 17.4.4.1.3.5 "Error Detection" in the
34xx TRM vZT.


- Paul
