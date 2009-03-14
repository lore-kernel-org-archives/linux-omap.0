From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Overo broken after recent mainline merge
Date: Sat, 14 Mar 2009 20:22:52 +0000
Message-ID: <20090314202250.GA17554@sirena.org.uk>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com> <20090314161252.GX19229@atomide.com> <200903141208.30413.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1097 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbZCNUW6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Mar 2009 16:22:58 -0400
Content-Disposition: inline
In-Reply-To: <200903141208.30413.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Steve Sakoman <sakoman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Sat, Mar 14, 2009 at 12:08:30PM -0700, David Brownell wrote:

> The basic problem is that still-unfixed goofage in the regulator
> framework:  it seriously mis-handles regulators that bootloaders
> leave enabled.  This can be teased apart into at least two bugs,
> possibly as many as four.  The fix for one of them is queued in
> the regulator-next tree.

For clarity, what David is referring to here is that it's not currently
possible for the machine constraints to turn off a regulator that has
been left enabled when the kernel starts.
