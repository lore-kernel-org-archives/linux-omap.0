From: Ingo Molnar <mingo@elte.hu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 10:15:38 +0200
Message-ID: <20100604081538.GC15181@elte.hu>
References: <20100603193045.GA7188@elte.hu>
 <20100603231153.GA11302@elte.hu>
 <20100603232302.GA16184@elte.hu>
 <alpine.LFD.2.00.1006031630300.8175@i5.linux-foundation.org>
 <20100603234634.GA21831@elte.hu>
 <alpine.LFD.2.00.1006031856420.8175@i5.linux-foundation.org>
 <alpine.LFD.2.00.1006031917500.8175@i5.linux-foundation.org>
 <20100603204521.09808a7f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100603204521.09808a7f@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-omap@vger.kernel.org


* Arjan van de Ven <arjan@infradead.org> wrote:

> On Thu, 3 Jun 2010 19:26:50 -0700 (PDT)
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > If the system is idle (or almost idle) for long times, I would heartily 
> > recommend actively shutting down unused cores. Some CPU's are hopefully 
> > smart enough to not even need that kind of software management, but I 
> > suspect even the really smart ones might be able to take advantage of the 
> > kernel saying: "I'm shutting you down, you don't have to worry about 
> > latency AT ALL, because I'm keeping another CPU active to do any real 
> > work".
> 
> sadly the reality is that "offline" is actually the same as "deepest C 
> state". At best.
> 
> As far as I can see, this is at least true for all Intel and AMD cpus.
> 
> And because there's then no power saving (but a performance cost), it's 
> actually a negative for battery life/total energy.
> 
> (lots of experiments inside Intel seem to confirm that, it's not just 
> theory)

Well, the scheme would only be useful if it's _NOT_ just a deep C4 state, but 
something that prevents tasks from being woken to that CPU for a good period 
of time. Hot-unplugging that CPU achieves that (the runqueues are pulled), so 
i think in Linus's idea makes sense in principle.

[ Or have you done deep-idle experiments to that effect as well? ]

I suspect it all depends on the cost: and our current hot-unplug and 
hot-replug code is all but cheap ...

	Ingo
