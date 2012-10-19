From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] ASoC: omap-mcpdm updates for 3.7
Date: Thu, 18 Oct 2012 19:23:38 -0700
Message-ID: <20121019022338.GM30550@atomide.com>
References: <1349339236-3622-1-git-send-email-peter.ujfalusi@ti.com>
 <20121017195525.GX15569@atomide.com>
 <20121018225237.GJ30550@atomide.com>
 <20121019012751.GA2353@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:25644 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751028Ab2JSCXn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 22:23:43 -0400
Content-Disposition: inline
In-Reply-To: <20121019012751.GA2353@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [121018 18:29]:
> On Thu, Oct 18, 2012 at 03:52:37PM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [121017 13:01]:
> 
> > > Is it OK for me to merge in your ASoC for-3.7 branch at commit
> > > 68214d99 (ASoC: omap-mcpdm: Remove OMAP revision check) also
> > > into my omap cleanup branch for v3.8?
> 
> > > I need that to avoid compile errors with some of my test configs.
> 
> > Never mind, that seems to be merged now.
> 
> That's easy :)  Sorry about the delay, OMAP stuff tends to get delayed
> as there's so many large patch serieses posted in multiple versions that
> I get CCed on I tend to batch process it.

Sure no problem, no kidding with the large multiple revision series..
 
> FWIW signed tags are fair game for merging without asking (in this case
> asoc-3.7) but please don't merge any of my branches directly, I'll make
> a tag.

OK thanks, will do. In this case using the commit above works well
as it's in mainline and actually will only bring in only one extra
omap ASoC commit into my pull request. And I don't have to wait for
-rc2 :)

Regards,

Tony
