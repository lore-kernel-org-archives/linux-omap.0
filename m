From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 21:26:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006062114550.2933@localhost.localdomain>
References: <1275834706.7227.545.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
	<1275844114.7227.552.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061932240.2933@localhost.localdomain>
	<AANLkTilRbTVbjAt9uodpzecHLUmcDQEKT_EVpjyrSIwn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTilRbTVbjAt9uodpzecHLUmcDQEKT_EVpjyrSIwn@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-omap@vger.kernel.org

On Sun, 6 Jun 2010, Brian Swetland wrote:

> On Sun, Jun 6, 2010 at 11:04 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Right, so the sooner we make it easier for the drivers to use the kernel
> >> as their main repository, the better.
> >
> > Yep, the fastest way is to provide two stub inlines in pm.h and let
> > the driver flood come in.
> 
> As mentioned previously, we didn't know this was an option (stubs
> without an implementation behind them).  If it is, and thus we can

That's what Greg did when he pulled stuff into staging, but there is
no reason not to do it outside of staging as well. We can simply put
the stub functions into Documentation/feature-removal.txt to ensure
that we don't forget about them :)

> simplify the driver merging process short-term while sorting out a
> long-term implementation or replacement for suspend blockers, then I
> think we're making real progress.

Yes, that way we do not lose the annotations. Replacing them, ripping
them out or whatever we agree on, is a nobrainer.

But it gets the drivers into the tree, so they are usable outside of
android as well and the delta between android and mainline shrinks
significantly.

Thanks,

	tglx
