From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP DSS HWMOD fixes
Date: Thu, 18 Aug 2011 10:21:55 +0300
Message-ID: <1313652115.1782.17.camel@deskari>
References: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59859 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754825Ab1HRHWE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Aug 2011 03:22:04 -0400
Received: by mail-bw0-f44.google.com with SMTP id r4so1230298bka.3
        for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 00:21:59 -0700 (PDT)
In-Reply-To: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, archit@ti.com

Hi Paul,

Did you get a chance to look at this series? These fixes will allow us
to remove the temporary hacks from the DSS driver.

 Tomi

On Mon, 2011-08-08 at 12:15 +0300, Tomi Valkeinen wrote:
> Second try with the DSS HWMODs
> 
> This set fixes the DSS clocks in HWMOD data, and implements a new reset
> mechanism for dss_core.
> 
> The new dss_reset function doesn't actually do a reset, it just enables all DSS
> clocks and waits for the reset to complete. This should be better approach than
> actually doing a reset, because:
> 
> OMAP4 - dss_core HW doesn't contain a SW reset bit so doing a reset is
> impossible. But after power-on we need to enable all DSS clocks and wait for
> the power-on reset to complete.
> 
> OMAP2/3 - dss_core does have a SW reset bit, but resetting dss_core also resets
> all the other DSS modules. This means that the other modules could be left
> uninitialized, as the hwmod code handles all modules independently, and in this
> case initializes only dss_core's registers. Thus dss_core's reset shouldn't be
> used, and we should only verify that the power-on reset has completed.
> 
> Tested on OMAP4 and OMAP3.
> 
> The first two HWMOD patches (for OMAP2/3) are not changed since v1.
> 
>  Tomi
> 
> Tomi Valkeinen (5):
>   OMAP2xxx: HWMOD: fix DSS opt clocks
>   OMAP3: HWMOD: fix DSS opt clocks
>   OMAP4: HWMOD: fix DSS opt clocks
>   OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
>   OMAP: HWMOD: Unify DSS resets for all OMAPs
> 
>  arch/arm/mach-omap2/common-board-devices.h         |    4 ++
>  arch/arm/mach-omap2/display.c                      |   35 ++++++++++++++++++++
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   15 +++++++-
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   15 +++++++-
>  .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 ++-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   35 +++++++++++++++++--
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   18 +++-------
>  7 files changed, 106 insertions(+), 21 deletions(-)
> 


