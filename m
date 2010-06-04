From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: suspend blockers & Android integration
Date: Fri, 04 Jun 2010 09:24:06 -0500
Message-ID: <1275661446.4455.33.camel@mulgrave.site>
References: <20100603193045.GA7188@elte.hu>
	 <AANLkTinsOF3wnxsruR0TvjBAQcHks4tf0ay_sM2xB_p4@mail.gmail.com>
	 <20100604075722.GA15181@elte.hu>
	 <AANLkTiksGnpL8tkcc5eScWHrGoijyZNUwZik5lXmU_TS@mail.gmail.com>
	 <20100604085513.GE15181@elte.hu>
	 <AANLkTinphtxn-8pGTYv_mBxKFMa7jU8i1yNbHrs50Vzl@mail.gmail.com>
	 <20100604095917.GA3324@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100604095917.GA3324@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Brian Swetland <swetland@google.com>, tytso@mit.edu, Neil Brown <neilb@suse.de>, Arve Hj?nnev?g <arve@android.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, Felipe Balbi <felipe.balbi@nokia.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-omap@vger.kernel.org

On Fri, 2010-06-04 at 11:59 +0200, Ingo Molnar wrote:
> * Brian Swetland <swetland@google.com> wrote:
> > On Fri, Jun 4, 2010 at 1:55 AM, Ingo Molnar <mingo@elte.hu> wrote:
> > > * Brian Swetland <swetland@google.com> wrote:
[...]
> > > In any case, this is not to suggest that the suspend-blocker bits are 
> > > 'impossible' to merge. I just say that if you start with your most 
> > > difficult feature you should not be surprised to be on the receiving end 
> > > of a 1000+ mails flamewar on lkml ;-)
> > 
> > Yeah, I do understand that we're not making it easy for ourselves here.  I 
> > think we hit the point where Rafael and Matthew signed off on things and 
> > thought "aha, linux-pm maintainers are happy, now we're getting somewhere" 
> > only to realize the light at the end of the tunnel was a bit further out 
> > than we anticipated ^^
> 
> That's a well-known problem on lkml: the light at the end of the tunnel was 
> the other train ;-)
> 
> Anyway, i'm not pessimistic at all: _some_ sort of scheme appears to be 
> crystalising out today. Everyone seems to agree now that the main usecases are 
> indeed useful and need handling one way or another - the rest is really just 
> technological discussions how to achieve the mostly-agreed-upon end goal.

It's still not clear to me whether everyone's revolving around to using
the current suspend block API because it's orthogonal to all other
mechanisms and is therefore separate from the kernel (and can be
compiled out if you don't want it).  Or whether re-expressing what the
android drivers want (minimum idle states and suspend block) in pm_qos
terms which others can use is the way to go.  I think the latter, but
I'd like to know what other people think (because I'm not wedded to this
preference).

> The worst situation are features where one side says 'we dont need this kind 
> of functionality at all' - IMO auto/opportunistic-suspend isnt in that 
> situation, fortunately.

Great ... because deprecating the problem has been one of the persistent
memes by some people on this huge thread.

James
