From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] OMAP: Don't warn user about expected behaviour in
	mmc-twl4030
Date: Sat, 4 Apr 2009 01:40:52 +0100
Message-ID: <20090404004051.GA13547@sirena.org.uk>
References: <1238440539-2394-1-git-send-email-broonie@sirena.org.uk> <200903301353.44087.david-b@pacbell.net> <20090331210019.GA12304@sirena.org.uk> <20090404002652.GF8840@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:43519 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760093AbZDDAlH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Apr 2009 20:41:07 -0400
Content-Disposition: inline
In-Reply-To: <20090404002652.GF8840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, linux-omap@vger.kernel.org

On Fri, Apr 03, 2009 at 05:26:52PM -0700, Tony Lindgren wrote:

> Maybe you guys have gone back and forth on this option too.. But what
> if we have something in regulator_init_data that would tell the
> regulator to reset the regulator on init? That could be then be
> then disabled with some cmdline option if needed for debugging or
> while booting from other operating systems etc.

Yup, that works perfectly well - in fact, Jonathan Cameron has a patch
adding a new constraint doing exactly that which managed ought to have
been merged but ended up falling through the cracks for 2.6.30.  I'm
expecting him to do the required refresh early on in this cycle.  Since
it's an explicit constraint we can just go ahead and apply it without
needing an ability to override it.

There's also support for powering off any unused regulators in a
late_initcall() which did get merged but that doesn't help with things
like MMC since they'll be probing before late_initcall().
