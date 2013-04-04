From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] ARM: OMAP: DMTIMER updates for v3.10
Date: Thu, 4 Apr 2013 11:38:55 -0700
Message-ID: <20130404183855.GP10155@atomide.com>
References: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42389 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761674Ab3DDSi7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Apr 2013 14:38:59 -0400
Content-Disposition: inline
In-Reply-To: <1363714699-29622-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [130319 10:42]:
> Includes:
> - A couple fixes for DMTIMER context loss handling.
> - Populating DMTIMER errata when booting with device-tree.
> - A new function for requesting a DMTIMER by device-tree node.
> 
> Based upon v3.9-rc3.
> 
> Tested on OMAP5912 OSK, OMAP2420 H4, OMAP3430 SDP, OMAP4430 Blaze
> and AM335x EVM. Testing includes ...
> 1. Booting kernel on above boards
> 2. Testing of various DMTIMER request APIs
> 3. Testing the timer overflow and match interrupts.
> 4. Using different clock sources to operate the timer with.
> 
> Jon Hunter (4):
>   ARM: OMAP: Force dmtimer restore if context loss is not detectable
>   ARM: OMAP: Add function to request timer by node
>   ARM: dts: OMAP2+: Update DMTIMER compatibility property
>   ARM: OMAP2+: Populate DMTIMER errata when using device-tree
> 
> NeilBrown (1):
>   ARM: OMAP: Simplify dmtimer context-loss handling
> 
>  .../devicetree/bindings/arm/omap/timer.txt         |   17 +-
>  arch/arm/boot/dts/am33xx.dtsi                      |   14 +-
>  arch/arm/boot/dts/omap2.dtsi                       |   22 +-
>  arch/arm/boot/dts/omap2420.dtsi                    |    2 +-
>  arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
>  arch/arm/boot/dts/omap3.dtsi                       |   24 +-
>  arch/arm/boot/dts/omap4.dtsi                       |   22 +-
>  arch/arm/boot/dts/omap5.dtsi                       |   22 +-
>  arch/arm/mach-omap2/timer.c                        |    7 +-
>  arch/arm/plat-omap/dmtimer.c                       |  241 ++++++++++++--------
>  arch/arm/plat-omap/include/plat/dmtimer.h          |    1 +
>  11 files changed, 220 insertions(+), 154 deletions(-)

For all these it sounds like it's best that Benoit queues
them with the .dts changes:

Acked-by: Tony Lindgren <tony@atomide.com>
