From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Tue, 17 Mar 2009 20:08:32 +0000
Message-ID: <20090317200828.GA7060@sirena.org.uk>
References: <200903111743.34708.david-b@pacbell.net> <200903142105.29382.david-b@pacbell.net> <20090316215422.GA6433@sirena.org.uk> <200903171115.06685.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2055 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbZCQUIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 16:08:54 -0400
Content-Disposition: inline
In-Reply-To: <200903171115.06685.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Tue, Mar 17, 2009 at 11:15:06AM -0700, David Brownell wrote:
> On Monday 16 March 2009, Mark Brown wrote:

> > Devices that need to do things like set voltages are fairly likely to
> > own the regulator but with devices that just need to ensure that they
> > have their supplies enabled it's much more likely that the supplies will
> > be shared.

> Right.  Do you have a model how such shared supplies would
> coexist with the "enabled at boot time" model, and still
> support being disabled?

The drivers can essentially ignore the physical status of the regulator
when they start, enabling when they need them and disabling when they're
done.  So long as at least one device has the regulator enabled the
regulator will remain on but when the reference count drops to zero then
the regulator will be disabled.

This works well when the driver will be enabling the regulators at
startup and then disabling them later on.  It will also work well with a
late_initcall which disables any unreferenced regulators - that should
become the default at some future point (2.6.31 might be a good candiate
here, I posted a patch the other day providing an implementation which
warns if there are affected regulators and which machines can activate
if they want).

> My first thought is that the system designer should avoid
> such boot_on modes.  But that's not always going to work.

Yes, that's not something that can realistically be achieved in the
general case.  Machines should probably avoid it but often people want
to do things like bring LCDs up in the bootloader and providing graceful
handover to the actual driver helps the user experience.
