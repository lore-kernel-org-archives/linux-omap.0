From: Pavel Machek <pavel@ucw.cz>
Subject: HTC Dream drivers was Re: [linux-pm] suspend blockers & Android
 integration
Date: Fri, 9 Jul 2010 21:11:46 +0200
Message-ID: <20100709191145.GG1669@ucw.cz>
References: <1275834706.7227.545.camel@mulgrave.site>
 <alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
 <1275844114.7227.552.camel@mulgrave.site>
 <20100606190525.GA20517@infradead.org>
 <AANLkTikKx-gXCGtNo3woHLCpBoEQ7hG9Jbiq3hwUTW_w@mail.gmail.com>
 <20100606192405.GA7559@infradead.org>
 <AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi!


> > So for people who really care about running a mainline kernel on their
> > android device doing that part first on a generic ARM board in qemu
> > might be much better first step work.
> 
> > On the other hand I've heard
> > that various hardware vendors or parties closed to them are rather
> > annoyed by their drivers beeing stuck in the android tree - but that
> > can be easily solved by getting removing the suspend blockers (at least
> > temporarily), cleaning up a few bits here and there and getting them in.
> 
> This continues to baffle me.  If we (Google) are such a headache, why
> not just route around us.  The drivers we've written are GPLv2, the

Well, we did route around you, and that's why the HTC Dream drivers
are in
staging.

Unfortunately...

> source is out there for anyone who wants it, etc.  The drivers other
> people have written we have no control over at all. From my point of
> view it'd be an annoyance if somebody took the code we wrote, modified
> it heavily, and pushed it upstream, but fundamentally I can't stop
> that from happening other than by pushing it upstream myself, first.

...you were calling bloody murder when we tried to name them right way
-- thats board_dream, not board_trout -- and AFAIK you still did not
switch to actually using those drivers so that diffs would grow
smaller...

And no, it is not 'just arm architecture #1536'; due to strange
baseband/cpu split in msm drivers end up quite big&complex...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
