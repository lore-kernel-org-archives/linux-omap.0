From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch/rfc 2.6.29-rc6 1/2] regulator: enumerate voltages
Date: Thu, 26 Feb 2009 19:05:29 +0000
Message-ID: <20090226190511.GD8595@sirena.org.uk>
References: <200902081037.06645.david-b@pacbell.net> <200902251702.03230.david-b@pacbell.net> <20090226104624.GA4229@sirena.org.uk> <200902261056.05740.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3227 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868AbZBZTFf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 14:05:35 -0500
Content-Disposition: inline
In-Reply-To: <200902261056.05740.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thu, Feb 26, 2009 at 10:56:05AM -0800, David Brownell wrote:
> On Thursday 26 February 2009, Mark Brown wrote:

> > Unless, of course, you happen to be using one of those consumers that
> > wants to know the voltage it's running at to configure itself.

> In which case it can ask the regulator what voltage it's using.  :)

I suspect we're talking at cross purposes here - I was talking about the
fixed voltage regulator driver.  I suspect you were talking about
something else?
