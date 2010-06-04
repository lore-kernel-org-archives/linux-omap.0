From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Thu, 3 Jun 2010 20:45:21 -0700
Message-ID: <20100603204521.09808a7f@infradead.org>
References: <20100603193045.GA7188@elte.hu>
	<20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<alpine.LFD.2.00.1006031630300.8175@i5.linux-foundation.org>
	<20100603234634.GA21831@elte.hu>
	<alpine.LFD.2.00.1006031856420.8175@i5.linux-foundation.org>
	<alpine.LFD.2.00.1006031917500.8175@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006031917500.8175@i5.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Brian Swetland <swetland@google.com>, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 3 Jun 2010 19:26:50 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> If the system is idle (or almost idle) for long times, I would
> heartily recommend actively shutting down unused cores. Some CPU's
> are hopefully smart enough to not even need that kind of software
> management, but I suspect even the really smart ones might be able to
> take advantage of the kernel saying: "I'm shutting you down, you
> don't have to worry about latency AT ALL, because I'm keeping another
> CPU active to do any real work".

sadly the reality is that "offline" is actually the same as "deepest C
state". At best.

As far as I can see, this is at least true for all Intel and AMD cpus.

And because there's then no power saving (but a performance cost), it's
actually a negative for battery life/total energy.

(lots of experiments inside Intel seem to confirm that, it's not just
theory)





-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
