From: Tony Lindgren <tony@atomide.com>
Subject: Re: partial bluetooth success on n900 [was Re: bluetooth/uart
 timeout handling]
Date: Wed, 14 Dec 2016 07:10:56 -0800
Message-ID: <20161214151056.GX4920@atomide.com>
References: <20161016002454.ul5rdqwubvkct4pf@earth>
 <20161018224259.jrwbaal27irzjqyo@earth>
 <20161019092506.GA1461@amd>
 <201612141321.30181@pali>
 <20161214125323.GA4951@amd>
 <20161214133158.mwvs574l4otbc7hf@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161214133158.mwvs574l4otbc7hf@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre@kernel.org> [161214 05:32]:
> Hi Pali & Pavel,
> 
> On Wed, Dec 14, 2016 at 01:53:23PM +0100, Pavel Machek wrote:
> > > > [  220.248596] tty ttyO1: Radio packet sent
> > > > [  220.249328] Bluetooth: hci0: Frame reassembly failed (-84)
> > > > [  220.272949] tty ttyO1: wakeup received: 1 -> 0
> > > > [  221.283477] tty ttyO1: radio packet timeout!
> > > > [  221.283630] enqueue: hu c304cc80 skb cd4a9b40
> > > > [  223.363372] Bluetooth: hci0 command 0xfc18 tx timeout
> > > > pavel@n900:~$
> > > 
> > > In log are still some failures, but ... is bluetooth working now?
> 
> I could scan for devices. The code is still racy, though. It's
> most likely related to the newly introduced idle code. (Without
> sending the BT module to correctly idle the bcm2048 does not
> work correctly at all)
> 
> I was quite busy the last few weeks and did not manage to find
> much time for kernel work. Now I will first have to catch up
> with my power-supply tree.
> 
> > It is... for Sebastian. I'm playing with camera now.
> > 
> > > I see that you applied this patch: 
> > > https://git.kernel.org/cgit/linux/kernel/git/pavel/linux-n900.git/commit/?id=051aa3fbf03ac770d8344690f5a936a7f04c6884
> > > 
> > > Looks like that pinmux is in DTS file incorrect. Can somebody verify it? 
> > > Maybe Tony?
> > 
> > Yes, it is. Sebastian was pretty certain about that.
> 
> Yes, I'm certain. The bootloader enables the pullup resistors.
> Note, that the wrong DTS entry is not in mainline. My bluetooth
> branch has a fixed DTS patch instead of a fixup patch on top of
> the broken one:
> 
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-n900.git/commit/?h=nokia-bluetooth-dev&id=6b63c111a979d100cfbdd76cb4a6bbadace35216

Maybe send it so we can merge it as a fix during the early -rc
cycle?

Regards,

Tony
