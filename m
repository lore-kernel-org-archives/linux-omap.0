From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Wed, 18 Mar 2009 14:02:14 -0700
Message-ID: <200903181402.14384.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <200903181225.11444.david-b@pacbell.net> <20090318203317.GA6299@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:41524 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755867AbZCRVCR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2009 17:02:17 -0400
In-Reply-To: <20090318203317.GA6299@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Wednesday 18 March 2009, Mark Brown wrote:
> > The $SUBJECT patch will prevent such things from existing.
> 
> I sent a patch backing that specific change out along with the
> late_initcall() patch.

Huh?  $SUBJECT patch hasn't merged.  How could you
have backed it out??

  http://marc.info/?l=linux-kernel&m=123707714131036&w=2

I didn't see such patches.  Could you post URLs so I
know specifically what you're referring to?

In the future, when you're proposing patches you think
address bugs I've reported, please remember to CC me ...

