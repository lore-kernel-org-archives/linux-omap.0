From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch/rfc 2.6.29-rc6 1/2] regulator: enumerate voltages
Date: Thu, 26 Feb 2009 20:02:28 +0000
Message-ID: <1235678548.31223.47.camel@vega.slimlogic.co.uk>
References: <200902081037.06645.david-b@pacbell.net>
	 <200902261056.05740.david-b@pacbell.net>
	 <20090226190511.GD8595@sirena.org.uk>
	 <200902261138.34859.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757999AbZBZUCw@vger.kernel.org>
In-Reply-To: <200902261138.34859.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 2009-02-26 at 11:38 -0800, David Brownell wrote:

> 
> Semi-related:  someone with time to spend on it might
> find and fix the bug causing the regulator framework
> to oops when regulator/core.c::set_machine_constraints()
> returns an error code.

Any chance you can post the oops. Is it happening within the
set_constraints() error path or sometime later on ?  

Thanks

Liam
