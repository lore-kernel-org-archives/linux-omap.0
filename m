From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
Date: Wed, 17 Feb 2010 16:09:43 -0600
Message-ID: <87mxz7tsyg.fsf@deeprootsystems.com>
References: <1265981968-14696-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f197.google.com ([209.85.211.197]:43735 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab0BQWJs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 17:09:48 -0500
Received: by ywh35 with SMTP id 35so377436ywh.4
        for <linux-omap@vger.kernel.org>; Wed, 17 Feb 2010 14:09:45 -0800 (PST)
In-Reply-To: <1265981968-14696-1-git-send-email-charu@ti.com> (Charulatha Varadarajan's message of "Fri\, 12 Feb 2010 19\:09\:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> This patch series makes the OMAP3430 GPIO module
> use hwmod framework.
>
> This patch series applies on top of pm branch
> and it requires my previous patch set which converts
> GPIO into an early init device. 

There's no reason this needs to depend on the PM branch.  

I have a WIP branch on my tree named 'pm-wip/hwmod' which already has
a set of hwmod updates (UART and MMC currently.)  This branch is based
on Tony's omap-for-linus branch.  

To best avoid conflicts with other hwmods, please base this series on
my pm-wip/hwmod branch.

Kevin

> They are boot tested on SDP 3430 and compile tested
> for OMAP 2420 and 2430.
>
> Charulatha V (2):
>   OMAP3: hwmod: add GPIO hwmods for OMAP3430
>   OMAP3: hwmod: Adapt HWMOD FW for GPIO OMAP3430
>
>  arch/arm/mach-omap2/gpio.c             |  901 ++++----------------------------
>  arch/arm/mach-omap2/omap_hwmod_34xx.h  |  410 +++++++++++++++
>  arch/arm/plat-omap/include/plat/gpio.h |   25 +-
>  3 files changed, 533 insertions(+), 803 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
