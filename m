From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Mon, 16 Mar 2009 21:54:23 +0000
Message-ID: <20090316215422.GA6433@sirena.org.uk>
References: <200903111743.34708.david-b@pacbell.net> <200903141725.35541.david-b@pacbell.net> <20090315003743.GB11052@sirena.org.uk> <200903142105.29382.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932121AbZCPVyu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200903142105.29382.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 14, 2009 at 09:05:29PM -0700, David Brownell wrote:

> was called.  It's not exactly hard to check if it was enabled, then
> act accordingly, in the typical "single consumer of the regulator"
> case.

How typical that is depends very much on the devices you're looking at.
Devices that need to do things like set voltages are fairly likely to
own the regulator but with devices that just need to ensure that they
have their supplies enabled it's much more likely that the supplies will
be shared.
