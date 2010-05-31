From: Neil Brown <neilb@suse.de>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Mon, 31 May 2010 14:33:39 +1000
Message-ID: <20100531143339.249ae1f4@notabene.brown>
References: <Pine.LNX.4.44L0.1005271303190.3239-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.1005271924170.3032@localhost.localdomain>
	<201005272315.28475.rjw@sisk.pl>
	<alpine.LFD.2.00.1005272334040.3478@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1005272334040.3478@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, Peter Zijlstra <peterz@infradead.org>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, 27 May 2010 23:40:29 +0200 (CEST)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, 27 May 2010, Rafael J. Wysocki wrote:
> 
> > On Thursday 27 May 2010, Thomas Gleixner wrote:
> > > On Thu, 27 May 2010, Alan Stern wrote:
> > > 
> > > > On Thu, 27 May 2010, Felipe Balbi wrote:
> > > > 
> > > > > On Thu, May 27, 2010 at 05:06:23PM +0200, ext Alan Stern wrote:
> > > > > >If people don't mind, here is a greatly simplified summary of the
> > > > > >comments and objections I have seen so far on this thread:
> > > > > >
> > > > > >	The in-kernel suspend blocker implementation is okay, even
> > > > > >	beneficial.
> > > > > 
> > > > > I disagree here. I believe expressing that as QoS is much better. Let 
> > > > > the kernel decide which power state is better as long as I can say I 
> > > > > need 100us IRQ latency or 100ms wakeup latency.
> > > > 
> > > > Does this mean you believe "echo mem >/sys/power/state" is bad and
> > > > should be removed?  Or "echo disk >/sys/power/state"?  They pay no
> > > 
> > > mem should be replaced by an idle suspend to ram mechanism
> > 
> > Well, what about when I want the machine to suspend _regardless_ of whether
> > or not it's idle at the moment?  That actually happens quite often to me. :-)
> 
> Fair enough. Let's agree on a non ambigous terminology then:
> 
>      forced:
> 
> 	     suspend which you enforce via user interaction, which
>      	     also implies that you risk losing wakeups depending on
>      	     the hardware properties

Reasonable definition I think.  However the current implementation doesn't
exactly match it.
With the current implementation you risk losing wakeups *independent* of the
hardware properties.
Even with ideal hardware events can be lost - by which I mean that they will
not be seen until some other event effects a wake-up.
e.g. the interrupt which signals the event happens immediately before the
suspend is requested (or maybe at the same time as), but the process which
needs to handle the event doesn't get a chance to see it before the suspend
procedure freezes that process, and even if it did it would have no way to
abort the suspend.

So I submit that the current implementation doesn't match your description of
"forced", is therefore buggy, and that if it were fixed, that would be
sufficient to meet the immediate needs of android.

NeilBrown

> 
>      opportunistic:
> 
> 	     suspend driven from the idle context, which guarantees to
> 	     not lose wakeups. Provided only when the hardware does
> 	     provide the necessary capabilities.
> 
> Thanks,
> 
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
