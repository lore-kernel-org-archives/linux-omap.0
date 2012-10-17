From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V3 0/5] ARM: OMAP2+: Add device-tree support for timers
Date: Wed, 17 Oct 2012 13:03:16 -0500
Message-ID: <507EF2E4.3050509@ti.com>
References: <1350496873-21337-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52833 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932486Ab2JQSDZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 14:03:25 -0400
In-Reply-To: <1350496873-21337-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Vaibhav Hiremath <hvaibhav@ti.com>


On 10/17/2012 01:01 PM, Jon Hunter wrote:
> This series adds device-tree support for the timers on OMAP2+ devices
> including AM33xx.
> 
> Testing:
> 1. I have booted tested this series on OMAP2420 H4, OMAP3430 Beagle, OMAP4430
>    Panda and AM335x Beagle Bone with/without ...
>    a). device-tree present
>    b). CONFIG_OMAP_32K_TIMER set
>    c). kernel boot parameter "clocksource=gp_timer" present
> 2. I have tested the all the timers (not used by the kernel as sys-timers) on
>    OMAP2420 H4, OMAP3430 Beagle and OMAP4430 Panda with/without device-tree with
>    this series. The testing includes ...
>    a. Configuring, starting a timer and checking the counter value is
>       incrementing.
>    b. Testing timer overflow interrupt when timer expires.
>    c. Using different clock sources to operate the timer with.
> 
> V3 changes:
> - Removed definition "TIMER_PROP_ALWON" per Rob Herring's feedback
> - Updated OMAP system timer (clock-events and clock-source) code so that
>   HWMOD is NOT used for getting resource (memory and interrupt) information
>   when device-tree is present.
> 
> V2 changes:
> - Remove use of device-tree alias property
> - Migrate OMAP timers to request timers by property instead of device ID
> - Include OMAP2 support

Forgot to mention that this is based on top of v3.7-rc1.

Cheers
Jon
