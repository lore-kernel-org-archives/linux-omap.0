From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [GIT PULL] omap display subsystem changes for 2.6.39
Date: Tue, 22 Mar 2011 07:55:37 +0200
Message-ID: <1300773337.2498.31.camel@deskari>
References: <1300701083.2891.77.camel@deskari>
	 <20110322054049.GB25925@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58667 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754030Ab1CVFzp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Mar 2011 01:55:45 -0400
In-Reply-To: <20110322054049.GB25925@linux-sh.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2011-03-22 at 00:40 -0500, Paul Mundt wrote:
> On Mon, Mar 21, 2011 at 11:51:23AM +0200, Tomi Valkeinen wrote:
> > One problem I noticed just now, the committer names seem a bit messed
> > up. For example, Archit Taneja has three different style names there. Do
> > you think I should rebase and fix them? Not a big job, but it'll mean,
> > well, rebasing.
> > 
> No need, this is what .mailmap is for. It seems there are quite a few
> variations, I've added entries now for all of:
> 
> 	Archit Taneja <archit@ti.com>
> 	Mayuresh Janorkar <mayur@ti.com>
> 	Mythri P K <mythripk@ti.com>
> 	Sumit Semwal <sumit.semwal@ti.com>
> 
> which traps all of the offenders in these patches. There seems to be a
> general issue of author names and sign-offs using reverse order naming, I
> assume because this is some absurd convention used by TI's mail servers.

Yes, TI's mail servers have this nice feature.

> We can of course continue fixing them up as they pop up, but people
> should ideally be aware of the need for consistency before committing
> things, too. A bit of name mangling is certainly a lesser evil than
> rewriting history, though.

I think the mix of multiple different styles is a result of me taking
some patches from emails (thus getting "Lastname, Firstname" style
names) and some directly from git trees or patch attachments (thus
getting whatever was configured in .gitconfig).

We'll need to see (in TI) how to make this more sensible.

> > There's a minor conflict in Overo's board file. I have pushed
> > "for-paul-merged" branch to gitorious, which contains a merge with
> > Linus' tree. I'm not sure that is the best way to show how to fix the
> > conflict, but hopefully it'll give the idea.
> > 
> Seemed pretty straightforward, I took care of it and made sure that it
> still built. I assume Tony or someone will yell loudly if I've
> inadvertently broken something :-)
> 
> Pulled now. I'll send things off to Linus shortly.

Thanks!

 Tomi



