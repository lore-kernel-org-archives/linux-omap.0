From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH] ARM: OMAP1: Move dpll1 rates selection from config to runtime
Date: Fri, 9 Dec 2011 00:13:37 +0100
Message-ID: <201112090013.37529.jkrzyszt@tis.icnet.pl>
References: <20111130222837.GR31337@atomide.com> <1323001021-7322-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:54822 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab1LHXOx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Dec 2011 18:14:53 -0500
In-Reply-To: <1323001021-7322-1-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sunday 04 of December 2011 at 13:17:01, Janusz Krzysztofik wrote:
> For still better multi-OMAP1 support, expand omap1_rate_table with flags
> for different SoC types and match them while selecting clock rates. The
> idea is stolen from current omap24xx clock rate selection algorithm.
> 
> Since clkdev platform flag definitions are reused here, those had to be
> expanded with one extra entry for OMAP1710 subtype, as this is the only
> SoC for which we allow selection of the highest, 216 MHz rate.
> 
> Once done, remove no longer needed clock rate configure time options.
> 
> Created against linux-omap/master tip as of Thu Dec 1,
> commit f83c2a8cbb59981722d1ab610c79adfd034a2667.
> Tested on Amstrad Delta.
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
> Hi,
> Here is a list of changes against the initial version, submitted as
> patch 2a/5 v2 "ARM: OMAP1: select clock rate by CPU type" of the series
> "ARM: OMAP1: Fix dpll1 reprogramming related issues":
> * drop no longer needed .config options, as suggested by Tony (thanks!),
> * follow selection conditions of those removed .config clock rate
>   options more closely (I missed that before, ended up reinventing the
>   wheel),
> * add extra clkdev platform flag for OMAP1710 to be able to limit the
>   216 MHz rate selection to this SoC subtype only,
> * update commit summary and message.
> 
> I still wonder if it is sufficient to select a highest rate for a board
> based on a SoC type only, not on the board type itself. For example, the
> Amstrad Delta has been used to be running at 150 MHz since it was
> introduced first, while from now on it will be running at 168 MHz.
> I haven't noticed any visible issues so far, but who knows...
> Any opinions?

Hi,
I've collected one opinion, or observation, myself: one of my boards 
doesn't work correctly at 168 MHz, but works without problems at 150 
MHz.

Tony,
Is it OK for you if we limit the maximum dpll1 rate for all OMAP1510 
based boards to 150 MHz (now 168 MHz), or do you prefer me to invent an 
alternative solution, which would derive the (maximum) rate from the 
board type?

Thanks,
Janusz
