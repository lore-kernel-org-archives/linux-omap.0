From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc7 regulator-next] regulator: refcount fixes
Date: Thu, 12 Mar 2009 12:35:24 -0800
Message-ID: <200903121335.25368.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <20090312103744.GA24376@sirena.org.uk>
Reply-To: dbrownell@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n26.bullet.mail.mud.yahoo.com ([68.142.206.221]:41790 "HELO
	n26.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752118AbZCLUg7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Mar 2009 16:36:59 -0400
In-Reply-To: <20090312103744.GA24376@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thursday 12 March 2009, Mark Brown wrote:
> On Wed, Mar 11, 2009 at 04:43:34PM -0800, David Brownell wrote:
> 
> > Buggy consumers could notice different bug symptoms.  The main
> > example would be refcounting bugs; also, any (out-of-tree) users
> > of the experimental regulator_set_optimum_mode() stuff which
> > don't call it when they're done using a regulator.
> 
> I'm OK with this from a code point of view so
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> However any consumers that take advantage of this won't be able to
> safely share a regulator without extra work since they have no way of
> telling why a regulator is in the state that it's in without extra
> stuff.

Depends what you mean by "safely".  If they weren't buggy
already, I don't see how they'd notice any difference.
Having buggy consumers become non-buggy isn't exactly a
job for the framework itself.


> We should probably have something along the lines of a 
> regulator_get_exclusive() for them.  Previously the consumer counting
> would have stopped them interfering with enables done by other
> consumers.

I'd like to see get()/put() match the design pattern used
elsewhere in the kernel:  those calls signify refcount
operations.

Agreed that the "consumer" access model probably needs a few
interface updates.  I'm not sure what they would be though;
one notion would be to focus on the constraints they apply
(including "enabled") instead of what they do now.

 
> There will be other consumers that can't safely share a regulator anyway
> (eg, requiring additional code to notice and handle voltage changes) so
> it'd be a good thing to have.


