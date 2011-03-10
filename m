From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v2 0/2] OMAP3: wdtimer: Fix CORE idle
Date: Thu, 10 Mar 2011 22:55:03 +0100
Message-ID: <20110310215503.GC1751@infomag.iguana.be>
References: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:58582 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751435Ab1CJVzG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 16:55:06 -0500
Content-Disposition: inline
In-Reply-To: <1299759058-26342-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: linux-watchdog@vger.kernel.org, khilman@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, jhnikula@gmail.com, ilkka.koskinen@nokia.com

Hi All,

> These patches fix the issue where the wdtimer blocks CORE idle
> transitions on n900 (OMAP3). The root cause was that SMART idle
> mode in wdtimer did not allow the CORE idle transition to happen.
> 
> v2: updated commit message on patch 1/2, Cc'd Wim, and added
> comments to code about possible HW bug in wdtimer2.
> 
> Wim, please check patch number one and add your acked by.
> 
> I propose that we push these upstream via linux-omap-pm,
> as the patches deal with PM and need to be applied together
> to get the desired functionality.
> 
> Paul Walmsley (2):
>   Watchdog: omap_wdt: add fine grain runtime-pm
>   OMAP3: wdtimer: Fix CORE idle transition
> 
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
>  drivers/watchdog/omap_wdt.c                |   25 +++++++++++++++++++++++--
>  2 files changed, 24 insertions(+), 2 deletions(-)

Acked-by: Wim Van Sebroeck <wim@iguana.be>

linux-omap-pm is indeed the best tree for getting this upstream.

Kind regards,
Wim.

