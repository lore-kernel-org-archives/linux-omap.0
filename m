From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Discussion: OMAP: PM: opp table handling
Date: Wed, 14 Oct 2009 13:04:45 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B236164@dlee02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA0D3D0D@dbde02.ent.ti.com>
 <74583B8642AB8841B30447520659FCA9DDC3EB01@dnce01.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C012A909B24@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48876 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbZJNSFd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 14:05:33 -0400
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C012A909B24@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Nataraju, Kiran" <knataraju@ti.com>, "Premi, Sanjeev" <premi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>, "Joshi, Rhishi" <rhishi@ti.com>, "Giles, Rick" <rgiles@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Wednesday, October 14, 2009 11:12 AM
> > I think we should as well change the naming and use the less confusing
> > naming we are using on OMAP3630/4430.
> > OPPs are now named using the performance delta from the nominal frequency.
> > OPP25, OPP50, OPP80, OPP100, OPP120...
> NAK for two reasons:

I wouldn't NAK too quickly.

What does the load predictor use?  Does it want to know about a million combinations?  Not really.  It is interesting to see if I'm on a 3GHz machine vs. a 1GHz one. But the predictor shouldn't care. What the predictor may care about is percentages and possible spacing between performance points.

A well written user space program hopefully doesn't care in general either.  I can recall the days when old apple games were ported and they were unusable for a bit because of all kinds of hardcoded timing loops.  They were certainly not portable.

Some drivers may practically care about frequency if they need to calculate some kind of QOS parameter but that is not the MPU.

I do agree the hardware definition does at times change based on characterization data.  We know that not every new OPP is even generally useful if its spacing is bad.  A typical system might skip over some OPPs in actual use if spacing is not good.

> a) h/w changes language of OPP definitions every other silicons -> OPP100 is
> not more informative than OPP1 or OPPX for that matter - with proper comments,
> even something like
> /* OPP25 - 25% of nominal performance */
> #define VDD1_OPP_REAAAALLLY_SLOW_OPP 1
> Makes sense.
> b) if you look at discussion - we really DON'T want to use OPP definitions
> anymore - we would like folks to use frequency for precisely that reason - it
> is frequency that matters in the system.
> c) the field for OPP idx is probably redundant once we have proper APIs in
> place.

At the lower level I do practically like some use of validated sets.  Validation of every possible combination doesn't happen.  There are 10 ways to program your DPLL for a similar output range.  We should stick with what has been validated not create very big generalized functions.  This functions get complex and many times miss out on obscure DPLL errata.

At the high level use of percentage might be ideal then comes frequency.  These values then are translated into discrete units which can be well tested.

I'm not say ack or nak.  Just that its not such a black & white choice.

Regards,
Richard W.

