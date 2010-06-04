From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 12:03:11 +0300
Message-ID: <AANLkTikjfFrcLrG3FzLfPt78B7L1637HCMIfNKo8XeHm@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<AANLkTinsOF3wnxsruR0TvjBAQcHks4tf0ay_sM2xB_p4@mail.gmail.com>
	<20100604075722.GA15181@elte.hu>
	<AANLkTiksGnpL8tkcc5eScWHrGoijyZNUwZik5lXmU_TS@mail.gmail.com>
	<20100604085513.GE15181@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100604085513.GE15181@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Brian Swetland <swetland@google.com>, tytso@mit.edu, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, James Bottomley <James.Bottomley@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 4, 2010 at 11:55 AM, Ingo Molnar <mingo@elte.hu> wrote:
> In any case, this is not to suggest that the suspend-blocker bits are
> 'impossible' to merge. I just say that if you start with your most difficult
> feature you should not be surprised to be on the receiving end of a 1000+
> mails flamewar on lkml ;-)

Indeed. This 'all or nothing' approach hasn't worked well in the past
and I highly doubt it will work now. It's much easier to work with
people when you have a track record of getting things merged and
actually maintaining the code.

                        Pekka
