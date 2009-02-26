From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch/rfc 2.6.29-rc6 1/2] regulator: enumerate voltages
Date: Thu, 26 Feb 2009 11:05:10 +0000
Message-ID: <20090226110509.GB4229@sirena.org.uk>
References: <200902081037.06645.david-b@pacbell.net> <200902251412.26855.david-b@pacbell.net> <20090225230123.GA5715@sirena.org.uk> <200902251547.53256.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2087 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbZBZLFN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 06:05:13 -0500
Content-Disposition: inline
In-Reply-To: <200902251547.53256.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Wed, Feb 25, 2009 at 03:47:52PM -0800, David Brownell wrote:
> On Wednesday 25 February 2009, Mark Brown wrote:

> In terms of the consumer interface, not -- "struct regulator"
> is opaque to consumers, and everything is a functional accessor.
> So I'll leave that as-is.

Yes, obviously.

> > At present only continous ranges are possible, though. ?I can't think of
> > any systems I've seen that'd want discontinous constraints, though I'm
> > sure there are some.

> Consider a regulator where voltage selectors 0..3 correspond to
> voltages

> 	{ 3.3V, 1.8V, 4.2V, 5.0V }

> With machine constraints that say voltages go from 3V to 4.5V ...

Continuous ranges of voltages, not continous indexes.  The indexes are
meaningless.  At the minute consumers and machines always supply
constraints as min,max pairs.
