From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/1] Activate VDD1, VDD2 and VPLL1 at startup
Date: Thu, 23 Apr 2009 13:31:16 -0700
Message-ID: <200904231331.16962.david-b@pacbell.net>
References: <1240414529-16258-1-git-send-email-peter.de-schrijver@nokia.com> <20090423101711.GN30105@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n26.bullet.mail.mud.yahoo.com ([68.142.206.221]:45551 "HELO
	n26.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752040AbZDWUbT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Apr 2009 16:31:19 -0400
In-Reply-To: <20090423101711.GN30105@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, linux-omap@vger.kernel.org

On Thursday 23 April 2009, Mark Brown wrote:
> Since TWL4030 is in mainline now you really ought to submit this and
> the other patches you posted immediately before this one to mainline.
> It'd be best to CC David Brownell (added here) on TWL4030 regulator
> changes too, he's the expert on the regulator features of the chip.

Just for the record ... I'm pretty sure the Nokia crew is
now exploring more of the funky corners of those features
than me!  Example:  these recent patches.

Agreed that I'm a good person to keep in the loop though;
there aren't enough active non-Nokia folk (there are TI'ers
but most of them don't frequent Linux circles) with enough
relevant knowledge to help check such patches.  :)

- Dave

