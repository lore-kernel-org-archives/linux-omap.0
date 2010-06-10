From: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend blockers & Android integration
Date: Thu, 10 Jun 2010 15:58:45 +0200
Message-ID: <20100610135844.GH4514@ucw.cz>
References: <20100603193045.GA7188@elte.hu>
 <AANLkTinsOF3wnxsruR0TvjBAQcHks4tf0ay_sM2xB_p4@mail.gmail.com>
 <20100604075722.GA15181@elte.hu>
 <AANLkTiksGnpL8tkcc5eScWHrGoijyZNUwZik5lXmU_TS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTiksGnpL8tkcc5eScWHrGoijyZNUwZik5lXmU_TS@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Swetland <swetland@google.com>
Cc: Ingo Molnar <mingo@elte.hu>, tytso@mit.edu, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-omap@vger.kernel.org

Hi!

> >> We started here because it's possibly the only api level change we have --
> >> almost everything else is driver or subarch type work or controversial but
> >> entirely self-contained (like the binder, which I would be shocked to see
> >> ever hit mainline). [...]
> >
> > So why arent those bits mainline? It's a 1000 times easier to get drivers and
> > small improvements and non-ABI changes upstream.
> >
> > After basically two years of growing your fork (and some attempts to get your
> > drivers into drivers/staging/ - from where they have meanwhile dropped out
> > again) you re-started with the worst possible thing to merge: a big and
> > difficult kernel feature affecting many subsystems. Why?
> 
> Because a large number of our drivers depend on it.

The dependencies are trivial. Last time I checked, you had about
150KLoC drivers, with about 100 lines depending on wakelock support --
I know, I cleaned it up from staging.

The changes required for merging 150KLoC will be definitely much
bigger than 100 lines...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
