From: Brian Swetland <swetland@google.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 03:11:12 -0700
Message-ID: <AANLkTilUG7xbTVk7n6w91lnEuTG3tonO_S6colNFKBYQ@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<1275644619.27810.39462.camel@twins>
	<1275645245.27810.39493.camel@twins>
	<20100604100306.GB3324@elte.hu>
	<1275646103.27810.39526.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1275646103.27810.39526.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Kevin Hilman <khilman@deeprootsystems.com>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 4, 2010 at 3:08 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, 2010-06-04 at 12:03 +0200, Ingo Molnar wrote:
>
>> > The only 'interesting' issue I can see here is that if you create 1000
>> > CLOCK_MONOTONIC namepaces, we'd need to have a tree of trees in order to
>> > efficiently find the leftmost timer.
>>
>> Realistically Android userspace would create just a single such namespace for
>> all the untrusted/unknown/uncontrolled apps, right?
>
> Possibly, yeah.

Definitely, at least initially.  If we had the ability to do more fine
grained control, we might be tempted to experiment with it, but to
start with we'd feel safer using the big hammer as we are today.

Brian
