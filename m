From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/5] OMAP4: power framework fixes
Date: Tue, 18 May 2010 20:20:08 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005182019180.27473@utopia.booyaka.com>
References: <1273562830-9758-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39747 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752176Ab0ESCUJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:20:09 -0400
In-Reply-To: <1273562830-9758-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com

Hi Rajendra,

On Tue, 11 May 2010, Rajendra Nayak wrote:

> This is a short series of fixes for OMAP4 in the PM frameworks,
> clock/clockdomain and powerdomain.
> 
> regards,
> Rajendra
> 
> Rajendra Nayak (5):
>   OMAP4 clock: Support clk_set_parent
>   OMAP: timers: Fix clock source names for OMAP4
>   OMAP4 powerdomain: Fix pwrsts flags for ALWAYS ON domains
>   OMAP4 clockdomain: Fix omap2_clkdm_clk_enable/disable api for 44xx
>   OMAP4 powerdomain: Support LOWPOWERSTATECHANGE for powerdomains
> 
>  arch/arm/mach-omap2/clockdomain.c             |    6 +++++
>  arch/arm/mach-omap2/powerdomain.c             |   28 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomains44xx.h        |   13 +++++++++-
>  arch/arm/plat-omap/clock.c                    |    3 --
>  arch/arm/plat-omap/dmtimer.c                  |    4 +-
>  arch/arm/plat-omap/include/plat/powerdomain.h |    7 ++++++
>  6 files changed, 54 insertions(+), 7 deletions(-)

Thanks - I've queued patches 1-3 and 5 for 2.6.35; patch 4 I need to think 
about some more.


- Paul
