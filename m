From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] ARM: OMAP3: cm-t35: add regulator supply for
 ads7846
Date: Fri, 18 Nov 2011 16:14:28 -0800
Message-ID: <20111119001428.GW31337@atomide.com>
References: <1319017160-20391-1-git-send-email-grinberg@compulab.co.il>
 <1319017160-20391-2-git-send-email-grinberg@compulab.co.il>
 <20111104233938.GF31337@atomide.com>
 <20111104235720.GG31337@atomide.com>
 <4EB68974.5090907@compulab.co.il>
 <20111107203110.GX31337@atomide.com>
 <4EB92CE6.1000408@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:59198 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758447Ab1KSAOc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Nov 2011 19:14:32 -0500
Content-Disposition: inline
In-Reply-To: <4EB92CE6.1000408@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [111108 04:47]:
> On 11/07/11 22:31, Tony Lindgren wrote:
> > * Igor Grinberg <grinberg@compulab.co.il> [111106 04:45]:
> >> Hi Tony,
> >>
> >> On 11/05/11 01:57, Tony Lindgren wrote:
> >>> * Tony Lindgren <tony@atomide.com> [111104 16:05]:
> >>>> * Igor Grinberg <grinberg@compulab.co.il> [111019 02:05]:
> >>>>
> >>>> Applying to board branch for v3.3 merge window.
> >>>
> >>> Hmm, actually I suggest you respin patches 2 and 3 so they apply
> >>> on their own to current fixes branch. Then update 1 and 4 to
> >>> apply on top of those.
> >>>
> >>> This way we can apply 2 and 3 during the -rc cycle, and then
> >>> queue 1 and 4 for the next merge window.
> >>
> >> Well, actually all them are fixes, although it cannot be understood
> >> from the subject.
> >> I will adjust the subjects (and may be the commit messages also)
> >> to be more specific and resend.
> > 
> > Hmm 1 & 4 are "features that never worked" type fixes, so they
> > have flame potential. Those have to wait for the next merge window.
> 
> Not exactly:
> 
> 1/4 is a fix that I should have submitted more than a year ago,
> just after the ads7846 got support for the regulators:

Sounds like it's not that urgent then :)

> > Or I can just apply all of them into board branch to wait for the
> > next merge window.
> 
> That can be an option, if it bothers you too much,
> but I prefer to have this already in 3.2.

I'll just apply them into board branch to wait for the next merge
window then.

Thanks,

Tony
