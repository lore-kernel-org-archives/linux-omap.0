From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Power on EHCI, serial, camera and DVI on
 beagleboard-xM
Date: Fri, 17 Dec 2010 18:07:45 -0800
Message-ID: <20101218020744.GN5941@atomide.com>
References: <1291725639-86397-1-git-send-email-koen@beagleboard.org>
 <E4A07EF4-1694-4B22-8015-0710B6BE7A2E@dominion.thruhere.net>
 <4D077E25.5070609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:30311 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756938Ab0LRCHt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 21:07:49 -0500
Content-Disposition: inline
In-Reply-To: <4D077E25.5070609@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Anand Gadiyar <gadiyar@ti.com> [101214 06:25]:
> On 12/14/2010 7:41 PM, Koen Kooi wrote:
> > Any comments on this?
...

> >>
> >> -	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
> >> -	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
> 
> This disappeared. So no more PMU STAT led?

Koen, any update on this?

Tony
