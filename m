From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCHv2 0/5] OMAP DSS HWMOD fixes
Date: Mon, 8 Aug 2011 17:13:24 +0530
Message-ID: <4E3FCBDC.1080208@ti.com>
References: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34258 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753040Ab1HHLes (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Aug 2011 07:34:48 -0400
In-Reply-To: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

Hi,

On Monday 08 August 2011 02:45 PM, Valkeinen, Tomi wrote:
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

If the bootloader enables DSS, we need to do a reset so that DSS2 driver 
can start with DSS HW in a clean state. With this patch set, how do we 
take care of such a scenario?

Archit

>
> Tested on OMAP4 and OMAP3.
>
> The first two HWMOD patches (for OMAP2/3) are not changed since v1.
>
>   Tomi
>
> Tomi Valkeinen (5):
>    OMAP2xxx: HWMOD: fix DSS opt clocks
>    OMAP3: HWMOD: fix DSS opt clocks
>    OMAP4: HWMOD: fix DSS opt clocks
>    OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
>    OMAP: HWMOD: Unify DSS resets for all OMAPs
>
>   arch/arm/mach-omap2/common-board-devices.h         |    4 ++
>   arch/arm/mach-omap2/display.c                      |   35 ++++++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   15 +++++++-
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   15 +++++++-
>   .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 ++-
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   35 +++++++++++++++++--
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   18 +++-------
>   7 files changed, 106 insertions(+), 21 deletions(-)
>

