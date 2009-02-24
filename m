From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2.6.29-rc3-git 1/2] regulator: twl4030 regulators
Date: Tue, 24 Feb 2009 12:41:56 +0000
Message-ID: <20090224124154.GA30130@sirena.org.uk>
References: <200902081037.06645.david-b@pacbell.net> <200902231443.16334.david-b@pacbell.net> <20090224005536.GC3601@sirena.org.uk> <200902231803.50059.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3993 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbZBXMmB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 07:42:01 -0500
Content-Disposition: inline
In-Reply-To: <200902231803.50059.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Mon, Feb 23, 2009 at 06:03:49PM -0800, David Brownell wrote:
> On Monday 23 February 2009, Mark Brown wrote:

> > The change to add voltage range constraints if none were supplied is a
> > noticable policy change from the existing framework standard - it allows
> > machines to enable voltage changes without specifying what the valid
> > values are. 

> "Whatever the hardware handles" *is* a specification.

> And there's no more assurance it's right than any
> other specification would be ... except that, as a

You're right that we can't guarantee that users get everything correct,
the goal is more to ensure that some machine specific checks have been
done and that the regulator API won't go off by itself and start doing
things since it has no idea at all what's supportable.

> rule, hardware designers like to avoid assemblies
> subject to trivial misconfiguration mistakes (like
> firing up a 2.5V-max rail at 5V).

The issue is what happens when software starts changing the
configuration, for static configurations it doesn't make any difference.

> > I'm not convinced that this is a good idea in the first 
> > place and it will result in the opposite behaviour to the current core
> > code (which should end up erroring out in constraint checking at runtime).

> Well, if you really dislike it so much, that can
> easily be removed.  Got any comments on the
> framework patch I sent?  I'll take that as the
> first one, even though it's a different thread.

Yes, I wanted to sleep on it.  I'll reply at some point today.
