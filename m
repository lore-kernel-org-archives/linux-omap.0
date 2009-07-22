From: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 0/2] watchdog:OMAP3:Add support for IVA2, SECURE WDTs
Date: Wed, 22 Jul 2009 19:47:26 +0200
Message-ID: <20090722174726.GI2155@infomag.iguana.be>
References: <1247162663-27541-1-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:22267 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752801AbZGVRr2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jul 2009 13:47:28 -0400
Content-Disposition: inline
In-Reply-To: <1247162663-27541-1-git-send-email-ubh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-omap@vger.kernel.org

Hi Ulrik,

> This patch series enables support for IVA2 and SECURE
> WDTs, available on omap34xx.
> The WDTs will be accessible (when present on device) through:
> MPU:	/dev/watchdog
> SECURE:	/dev/watchdog_secure
> IVA2:	/dev/watchdog_iva2
> 
> Tested on Zoom1 OMAP3 platform, compile-tested for OMAP2
> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
> Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
> --- 
>  arch/arm/mach-omap1/clock.c     |    6 +-
>  arch/arm/mach-omap2/clock24xx.c |    4 -
>  arch/arm/mach-omap2/clock34xx.c |   12 ++---
>  arch/arm/plat-omap/devices.c    |   91 ++++++++++++++++++++++++++++++++--------
>  drivers/watchdog/omap_wdt.c     |   34 +++++++++++---
>  5 files changed, 112 insertions(+), 35 deletions(-)

Thanks for sending in this patch, but I will put the patch aside for some time.
The reason for this is that:
1) we need to have the new watchdog core infrastructure going in for 2.6.32.
This new core means that we won't reproduce the same code over and over again.
(Both Alan and myself are working on it).
2) We need a thorough discussion first on how we will support multiple watchdog
devices and what the best interface is. I'm not convinced dat the /dev/watchdog*
solution is the right way to go. I think a sysfs interface is suited more. This
sysfs interface would be "version 2" of the new core.

Sorry for the inconvenience, we will get back on this.
Wim.

