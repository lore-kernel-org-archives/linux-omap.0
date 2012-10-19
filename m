From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 0/2] ASoC: omap-mcpdm updates for 3.7
Date: Fri, 19 Oct 2012 02:27:51 +0100
Message-ID: <20121019012751.GA2353@opensource.wolfsonmicro.com>
References: <1349339236-3622-1-git-send-email-peter.ujfalusi@ti.com> <20121017195525.GX15569@atomide.com> <20121018225237.GJ30550@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48960 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752044Ab2JSB1x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Oct 2012 21:27:53 -0400
Content-Disposition: inline
In-Reply-To: <20121018225237.GJ30550@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Thu, Oct 18, 2012 at 03:52:37PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [121017 13:01]:

> > Is it OK for me to merge in your ASoC for-3.7 branch at commit
> > 68214d99 (ASoC: omap-mcpdm: Remove OMAP revision check) also
> > into my omap cleanup branch for v3.8?

> > I need that to avoid compile errors with some of my test configs.

> Never mind, that seems to be merged now.

That's easy :)  Sorry about the delay, OMAP stuff tends to get delayed
as there's so many large patch serieses posted in multiple versions that
I get CCed on I tend to batch process it.

FWIW signed tags are fair game for merging without asking (in this case
asoc-3.7) but please don't merge any of my branches directly, I'll make
a tag.
