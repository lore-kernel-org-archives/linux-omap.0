From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH 0/2 v2] ARM: OMAP1: Fix dpll1 reprogramming related issues
Date: Fri, 2 Dec 2011 18:02:24 +0100
Message-ID: <201112021802.25037.jkrzyszt@tis.icnet.pl>
References: <201112012023.04635.jkrzyszt@tis.icnet.pl> <1322770382-30718-1-git-send-email-jkrzyszt@tis.icnet.pl> <20111202020936.GY31337@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:48894 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755875Ab1LBREI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Dec 2011 12:04:08 -0500
In-Reply-To: <20111202020936.GY31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Friday 02 of December 2011 at 03:09:37, Tony Lindgren wrote:
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [111201 11:38]:
> > After dpll1 reprogramming has been moved from setup_arch() to
> > kernel_init(), I've been observing several issues, resulting in
> > undesired system behaviour on my Amstrad Delta. This series fixes
> > those most important (2/5 and 5/5 v2 previously), with a "stuck at 60MHz
> > rate" issue going to be fixed with Tony's proposed solution instead of
> > my previous 3/5.
> > 
> > Janusz Krzysztofik (2):
> >   ARM: OMAP1: Fix ckctl value used for dpll1 defualt rate
> >   ARM: OMAP1: recalculate loops per jiffy after dpll1 reprogram
> > 
> >  arch/arm/mach-omap1/clock_data.c |    9 +++++++--
> >  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> Thanks, got these three patches now applied into fixes on top of -rc4.
> 
> Can you please try it out to make sure it's all working for you now?

Yes, it works as expected, re-tested with a custom 150 MHz rate only 
.config to the extent possible without removing all rates form .config 
/ omap1_rate_table[], i.e., without triggering the issue addressed by 
fc92dd3a77bfc59822f869627ba81a6418eed987 "ARM: OMAP1: Fix ckctl value 
used for dpll1 defualt rate". Can re-test other cases (omap1_defconfig, 
no rates selected at all) if required.

My only concern left, which I don't feel capable to justify myself, is 
if 6% inaccuracy in BogoMIPS recalculation, compared to the BogoMIPS 
value got either with 3.1 or as a result of recalibration, does matter 
and should still be addressed somehow for next merge window, or can be 
ignored. 

Russell, can you please share your opinion?

Thanks,
Janusz
