From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: suspend blockers & Android integration
Date: Thu, 3 Jun 2010 19:26:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1006031917500.8175@i5.linux-foundation.org>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<alpine.LFD.2.00.1006031630300.8175@i5.linux-foundation.org>
	<20100603234634.GA21831@elte.hu>
	<alpine.LFD.2.00.1006031856420.8175@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006031856420.8175@i5.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org



On Thu, 3 Jun 2010, Linus Torvalds wrote:
> 
> so I'd like to see the opportunistc suspend thing think about CPU 
> offlining

Side note: one reason for me being somewhat interested in the CPU 
offlining is that I think the Android kind of opportunistic suspend is 
_not_ likely something I'd like to see on a desktop. But an the 
"opportunistic CPU offliner"? That might _well_ be useful even outside of 
any other suspend activity.

If the system is idle (or almost idle) for long times, I would heartily 
recommend actively shutting down unused cores. Some CPU's are hopefully 
smart enough to not even need that kind of software management, but I 
suspect even the really smart ones might be able to take advantage of the 
kernel saying: "I'm shutting you down, you don't have to worry about 
latency AT ALL, because I'm keeping another CPU active to do any real 
work".

I'd also be interested to see if it could even improve single-thread 
performance if we end up doing the whole SMP->UP "lock" prefix rewriting 
when the system is idle enough that we'd be better off running just a 
single core. I dunno - just throwing that out there.

Anyway, the only reason I think this is related is literally because I 
think that if we know there is only a single CPU active, I think the 
actual "real" opportunistic suspend is easier. Suddenly you don't have to 
worry about what happens on other run-queues etc, and whether another CPU 
is just about to create a suspend block etc.

So I think they tie together, although it's mostly tangential. And as 
mentioned, I think a opportunistic CPU suspend part is more relevant 
outside of Android, and thus perhaps more widely interesting.

			Linus
