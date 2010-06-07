From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] suspend blockers & Android integration
Date: Mon, 7 Jun 2010 11:40:34 -0700 (PDT)
Message-ID: <768161.83147.qm@web180312.mail.gq1.yahoo.com>
References: <1275916830.1645.566.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275916830.1645.566.camel@laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Swetland <swetland@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Christoph Hellwig <hch@infradead.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org



--- On Mon, 6/7/10, Peter Zijlstra <peterz@infradead.org> wrote:
> So what's up with this Binder stuff, from what I can see
> its just
> yet-another-CORBA. Why does it need a kernel part at all,
> can't you
> simply run with a user-space ORB instead?
> 
> I really don't get why people keep re-inventing CORBA,


That made me laugh.  Do you realize that one
of the earliest objections to CORBA was "why do
people keep re-inventing RPC" ...  :)

(Simple answer:  the existing stuff didn't solve
enough of the right problems ... and it was easier
(in a political sense) to come up with something
new than to try fixing DCE or ONC (or whatever).
Similar answers may still apply ... last I looked
at CORBA, it didn't standardize desktop integration
(or cell-phone equivalents), and the pure user-space
versions suffered slowdowns when looking up object
bindings.


> there's some really nice (free) ORBs out there,
