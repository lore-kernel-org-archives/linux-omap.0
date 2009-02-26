From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.29-rc6 1/2] regulator: enumerate voltages
Date: Thu, 26 Feb 2009 11:38:34 -0800
Message-ID: <200902261138.34859.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902261056.05740.david-b@pacbell.net> <20090226190511.GD8595@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n26.bullet.mail.mud.yahoo.com ([68.142.206.221]:24835 "HELO
	n26.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752825AbZBZTiq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 14:38:46 -0500
In-Reply-To: <20090226190511.GD8595@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thursday 26 February 2009, Mark Brown wrote:
> On Thu, Feb 26, 2009 at 10:56:05AM -0800, David Brownell wrote:
> > On Thursday 26 February 2009, Mark Brown wrote:
> 
> > > Unless, of course, you happen to be using one of those consumers that
> > > wants to know the voltage it's running at to configure itself.
> 
> > In which case it can ask the regulator what voltage it's using.  :)
> 
> I suspect we're talking at cross purposes here - I was talking about the
> fixed voltage regulator driver.  I suspect you were talking about
> something else?

Yes ... e.g. the USB1V5, USB1V, and USB3V1 regulators
exported through the twl4030 regulator driver.


Semi-related:  someone with time to spend on it might
find and fix the bug causing the regulator framework
to oops when regulator/core.c::set_machine_constraints()
returns an error code.

- Dave

