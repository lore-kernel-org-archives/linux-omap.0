From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] OMAP: Don't warn user about expected behaviour in
	mmc-twl4030
Date: Mon, 6 Apr 2009 16:56:10 +0100
Message-ID: <20090406155609.GD4057@sirena.org.uk>
References: <1238440539-2394-1-git-send-email-broonie@sirena.org.uk> <200903301353.44087.david-b@pacbell.net> <20090331210019.GA12304@sirena.org.uk> <200904031803.33648.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:55675 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbZDFP4O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 11:56:14 -0400
Content-Disposition: inline
In-Reply-To: <200904031803.33648.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Fri, Apr 03, 2009 at 06:03:33PM -0700, David Brownell wrote:
> On Tuesday 31 March 2009, Mark Brown wrote:

> > The documention should not be changed to say that since only consumers
> > that need the regulator to be off at startup should do this, and then
> > probably only if they find that it is already enabled.

> "Probably" shows you still don't have a good answer...

No, it means that I can't think of any reason why they'd want to bounce
the supply but I'm open to the possibility that there could be one.

> I see that mainline now has ca7255614e0861e36480103f4a402a115803d7b5
> which is a variant of the first late-fixup patch I sent.  The isssue
> with that approach is that it leaves a huge window between regulator
> init and its late fixup ... during which driver probe() calls suffer
> the bad effects of the current self-inconsistent initialization.  So
> it doesn't really address the MMC cases.

That change was not intended to do anything for MMC, it's there for
other users like shared regulators and situations where no consumer
driver instantiates.

It is really important that you engage with the feedback you are
getting.  At this point we are all quite familiar with your views and we
do understand them, restating them is not what's needed.  Changes have
to be made with an understanding of the existing interface and how it
supports the use cases the API has, including users other than MMC.
Changes also need to be made with consideration given to merge issues.

> And in fact, that's exactly what I think folk should be doing with
> the recent additions to twl4030-power supporting explicit init of
> all the power resources ... as done with e.g. Beagle.  The benefit

...

> So there's an OMAP-specific workaround now in place, albeit not
> yet headed towards mainline.

With Jonathan's patch there will be support in the regulator API for
doing this with all regulators.
