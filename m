From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: Don't warn user about expected behaviour in
	mmc-twl4030
Date: Fri, 3 Apr 2009 17:26:52 -0700
Message-ID: <20090404002652.GF8840@atomide.com>
References: <1238440539-2394-1-git-send-email-broonie@sirena.org.uk> <200903301353.44087.david-b@pacbell.net> <20090331210019.GA12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56277 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762168AbZDDA07 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 20:26:59 -0400
Content-Disposition: inline
In-Reply-To: <20090331210019.GA12304@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

* Mark Brown <broonie@sirena.org.uk> [090331 14:00]:
> On Mon, Mar 30, 2009 at 01:53:43PM -0700, David Brownell wrote:
> 
> > So when are you going to fix the regulator docs to report that:
> 
> > 	ALL regulator consumers must start by enabling and
> > 	then disabling the regulator.
> 
> The documention should not be changed to say that since only consumers
> that need the regulator to be off at startup should do this, and then
> probably only if they find that it is already enabled.
> 
> Other consumers do not need to do this.  Consumers that want to enable a
> regulator at startup can do so directly.  Consumers that don't need a
> specific state (for example, because they are able to share the
> regulator and don't need it enabling) should just leave it alone.

Maybe you guys have gone back and forth on this option too.. But what
if we have something in regulator_init_data that would tell the
regulator to reset the regulator on init? That could be then be
then disabled with some cmdline option if needed for debugging or
while booting from other operating systems etc.

I've applied Mark's patch to l-o, I guess now I need to start sorting
out what we need to mainline for twl4030-mmc.c for this -rc :)

Regards,

Tony
