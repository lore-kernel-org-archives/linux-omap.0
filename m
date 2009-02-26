From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch/rfc 2.6.29-rc6 1/2] regulator: enumerate voltages
Date: Thu, 26 Feb 2009 10:46:27 +0000
Message-ID: <20090226104624.GA4229@sirena.org.uk>
References: <200902081037.06645.david-b@pacbell.net> <200902241617.22643.david-b@pacbell.net> <20090225151721.GA31637@sirena.org.uk> <200902251702.03230.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1106 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbZBZKqa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2009 05:46:30 -0500
Content-Disposition: inline
In-Reply-To: <200902251702.03230.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Wed, Feb 25, 2009 at 05:02:03PM -0800, David Brownell wrote:

> Oh, one more comment.  Requiring manual configuration
> of fixed-voltage regulators is pure time-wastage.

Unless, of course, you happen to be using one of those consumers that
wants to know the voltage it's running at to configure itself.  Examples
I've seen include sensors and analogue components which can be
configured for better performance if they know the voltage they run at -
and yes, people do run these things off regulators that they vary at
runtime.

If you want to submit a patch making it optional that's fine.
