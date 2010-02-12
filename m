From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/2 RFC]OMAP3430: hwmod FW for GPIO
Date: Fri, 12 Feb 2010 14:50:21 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002121449440.28188@utopia.booyaka.com>
References: <1265981968-14696-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36953 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657Ab0BLVuX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 16:50:23 -0500
In-Reply-To: <1265981968-14696-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com, rnayak@ti.com

On Fri, 12 Feb 2010, Varadarajan, Charulatha wrote:

> This patch series makes the OMAP3430 GPIO module
> use hwmod framework.
> 
> This patch series applies on top of pm branch
> and it requires my previous patch set which converts
> GPIO into an early init device. 
> 
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

NAK.  Your series just broke GPIO for all non-OMAP3430 chips.


- Paul
