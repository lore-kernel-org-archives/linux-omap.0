From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] omap_udc fixes for omap7xx
Date: Tue, 10 Nov 2009 16:33:46 -0800
Message-ID: <20091111003346.GG23952@atomide.com>
References: <6cb013310910050748o748d008ch60a85ef504029d9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60385 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbZKKAdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2009 19:33:42 -0500
Content-Disposition: inline
In-Reply-To: <6cb013310910050748o748d008ch60a85ef504029d9c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [091005 07:51]:
> The following four patches patch the OMAP UDC subsystem to allow
> omap7xx-based systems to operate with USB in client mode.
> 
> Cory Maccarrone (4):
>   [OMAP] Clocks: Add omap7xx-specific USB clock configuration
>   [OMAP] omap_udc: Updates for omap7xx IRQs and config
>   [OMAP] omap_udc: Add clocking and disable vbus sense for omap7xx
>   [OMAP1] Make ARCH_OMAP850 select ARCH_OMAP_OTG
> 
>  arch/arm/mach-omap1/Kconfig   |    1 +
>  arch/arm/mach-omap1/clock.c   |    3 ++-
>  arch/arm/mach-omap1/clock.h   |   10 ++++++++++
>  arch/arm/plat-omap/usb.c      |   20 ++++++++++++++------
>  drivers/usb/gadget/omap_udc.c |   19 +++++++++++++++++--

Pushing these as a single patch to omap for-next today. Please
check and patch as needed.

BTW, had to unwrap some of these manually..

Tony
