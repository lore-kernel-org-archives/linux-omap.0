From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [patch/rfc 2.6.29-rc6 2/2] regulator: twl4030 voltage
 enumeration (v2)
Date: Fri, 27 Feb 2009 12:32:10 +0000
Message-ID: <1235737930.31223.117.camel@vega.slimlogic.co.uk>
References: <200902081037.06645.david-b@pacbell.net>
	 <200902261150.15125.david-b@pacbell.net>
	 <1235686618.31223.107.camel@vega.slimlogic.co.uk>
	 <200902261602.58832.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from slimlogic.co.uk ([89.16.172.20]:58516 "EHLO slimlogic.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020AbZB0McO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Feb 2009 07:32:14 -0500
In-Reply-To: <200902261602.58832.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Mark Brown <broonie@sirena.org.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thu, 2009-02-26 at 16:02 -0800, David Brownell wrote:
> On Thursday 26 February 2009, Liam Girdwood wrote:
> > > 
> > > Note that the twl4030 regulator patch referred to will need a
> > > minor patch to work with the -next tree, because of interface
> > > change in the regulator framework.
> > > 
> > >  drivers/regulator/twl4030-regulator.c |   62 +++++++++++---------------------
> > >  1 file changed, 23 insertions(+), 39 deletions(-)
> > 
> > Applied.
> 
> .... and here's that "minor patch".
> 
> ====== CUT HERE
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Catch up the twl4030 regulator driver to the regulator
> interface change adding another parameter.  Also, fix
> some comments, and take this opportunity to shrink the
> associated per-regulator memory usage by a word.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/regulator/twl4030-regulator.c |   17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)


Sorry, this didn't apply. It looks like I'm missing an earlier patch(s)
here. Could you regenerate this and your core patch against latest
for-next.

Thanks

Liam

