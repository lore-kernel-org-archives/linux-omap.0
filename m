From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] fix n900 dts file to work around 4.1 touchscreen
 regression on n900
Date: Fri, 29 May 2015 13:48:47 -0700
Message-ID: <20150529204847.GA7429@dtor-ws>
References: <20150527145837.GA13223@earth>
 <20150529190816.GA20232@amd>
 <20150529192505.GA28987@amd>
 <20150529193211.GA7599@amd>
 <20150529194955.GV2026@saruman.tx.rr.com>
 <20150529195629.GA9811@amd>
 <20150529201745.GC17267@lukather>
 <20150529202123.GY2026@saruman.tx.rr.com>
 <20150529202954.GA26494@localhost>
 <20150529203456.GC22083@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37351 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757266AbbE2Usw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 May 2015 16:48:52 -0400
Content-Disposition: inline
In-Reply-To: <20150529203456.GC22083@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Felipe Balbi <balbi@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

On Fri, May 29, 2015 at 10:34:56PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > > single DT, you don't even use that property in your driver, and now
> > > > that you realise you meant something else, you want the code that
> > > 
> > > not Pali, Sebastian.
> > > 
> > > > actually parse the *right* property and does the right thing, that all
> > > > other DT agree (and depend on) to be reverted?
> > > 
> > > We shouldn't revert, that I agree. But both properties should be parsed.
> > 
> > No. If the property is wrong, and nobody parsed it, I do not see any reason to
> > start now.
> 
> Agreed.
> 
> But that's not what I'm asking. See a changelog of
> 3eea8b5d68c801fec788b411582b803463834752 and compare it with what it
> actually does.
> 
> It is buggy. If fuzz is specified but maximum is not, it overwites
> maximum with zero.

Yes.

> 
> Plus it introduces new failure "if (!test_bit(axis, dev->absbit))".

That is not a new failure. It actually warns users that they trying to
specify in DT something that will be ignored by the kernel (because
without that absbit kernel will ignore all requests to that event code).

> 
> Plus it fails to distinguish between "value not specified in the dt"
> and "zero is specified in the dt".

Yes. I am not sure if we should care and support all permutations (ah, I
pre-setup fuzz in the driver, but override max on X, and I pre-setup
max on X, but take fuzz from DT). Maybe we should simply document that
specifying one parameter for an axis will change the rest of them to be
0. Not sure though...

Thanks.

-- 
Dmitry
