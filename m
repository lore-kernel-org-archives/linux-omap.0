From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 2.6.29-rc6 1/2] regulator: enumerate voltages
Date: Thu, 26 Feb 2009 10:56:05 -0800
Message-ID: <200902261056.05740.david-b@pacbell.net>
References: <200902081037.06645.david-b@pacbell.net> <200902251702.03230.david-b@pacbell.net> <20090226104624.GA4229@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:38987 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752214AbZBZS4J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2009 13:56:09 -0500
In-Reply-To: <20090226104624.GA4229@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Thursday 26 February 2009, Mark Brown wrote:
> On Wed, Feb 25, 2009 at 05:02:03PM -0800, David Brownell wrote:
> 
> > Oh, one more comment.  Requiring manual configuration
> > of fixed-voltage regulators is pure time-wastage.
> 
> Unless, of course, you happen to be using one of those consumers that
> wants to know the voltage it's running at to configure itself.

In which case it can ask the regulator what voltage it's using.  :)

