From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V2 4/7] ARM: OMAP: Add a timer attribute for timers that
 can interrupt the DSP
Date: Thu, 20 Sep 2012 00:07:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209192356570.14850@utopia.booyaka.com>
References: <1347579091-3794-1-git-send-email-jon-hunter@ti.com> <1347579091-3794-5-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:58007 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab2ITAHF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 20:07:05 -0400
In-Reply-To: <1347579091-3794-5-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, 13 Sep 2012, Jon Hunter wrote:

> Some instances of the DMTIMER peripheral on OMAP devices have the ability
> to interrupt the on-chip DSP in addition to the ARM CPU. Add a DMTIMER
> attribute to indicate which timers can interrupt the DSP. By using the
> omap_dm_timer_request_by_cap() API, driver will now be able to allocate
> a DMTIMER that can interrupt the DSP based upon this attribute and not require
> the driver to know which instance has this capability.
> 
> DMTIMERs that have the ability to interrupt the DSP on OMAP devices are as
> follows ...
> 
> - OMAP1 (OMAP5912/16xx/17xx) devices	- All 8 DMTIMERs
> - OMAP2/3/4 devices			- DMTIMERs 5-8
> 
> Please note that for OMAP3+, timer8 has the ability to interrupt the DSP and
> generate a PWM output.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks, queued for 3.7.

- Paul
