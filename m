From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH OMAPZOOM] OMAP: DMA: Fix CCR programming for request
	line > 63
Date: Thu, 8 Jan 2009 16:20:31 +0200
Message-ID: <20090108142030.GN27566@atomide.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02DF30302E@dbde02.ent.ti.com> <FCCFB4CDC6E5564B9182F639FC356087024A0ADF11@dbde02.ent.ti.com> <20090108133119.GH27566@atomide.com> <dbdb2ea60901080540k740b7a9dscd940bcd0c9f6c01@mail.gmail.com> <20090108135233.GL27566@atomide.com> <dbdb2ea60901080608y7ff19f50j6399f07619f05eb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63633 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZAHOUc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 09:20:32 -0500
Content-Disposition: inline
In-Reply-To: <dbdb2ea60901080608y7ff19f50j6399f07619f05eb9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

* twebb <taliaferro62@gmail.com> [090108 16:08]:
> >
> > Well l-o tree is short for the linux-omap tree. Then I have various
> > queues of stuff going into the mainline kernel:
> >
> > omap-fixes
> > omap-upstream
> > omap1-upstream
> > omap2-upstream
> > omap3-upstream
> > ...
> >
> > Out of these queues omap-fixes will be sent out as needed during the
> > -rc cycle, while omap*-upstream queues are stuff for the next merge
> > window.
> >
> > These branches show up at the git web interface at the bottom:
> >
> > http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary
> >
> > Not that many patches in these queues right now, btw.
> >
> 
> That's very helpful.  Would you mind confirming/answering a few more questions?
> 
> 1.  Generally, are all fixes/changes that go to any of the queues
> headed to the mainline always pushed into the l-o tree?  If not, why
> not?

If something is updated with the patches going into the mainline, they
may not get updated in the l-o tree until the changes fall down during
the next merge with mainline.

> 2.  How about the reverse - are all l-o fixes/changes eventually
> queued to mainline?  Or is there certain l-o functionality that won't
> ever go to mainline?

Only the ones that apply and are ready to go. Ideally we would just
have everything in sync with the mainline tree so everything in l-o
tree would be going to mainline tree. But we still carry around quite
a bit of code that still needs work before submitting to mainline. Some
examples are the clock and PM changes.

> 3.  By "merge window" do you mean times that you pull mainline updates
> down into l-o tree?

Merge window = About two weeks after Linus tags a major release and
before -rc1 is tagged. Since the omap core stuff gets merged via
Russell, we need to have patches going to mainline ready around -rc5
so Russell has enough time to look at them.

Regards,

Tony
