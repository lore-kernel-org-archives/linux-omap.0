From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [PATCH v3 0/4] Adding OMAP DMIC driver to kernel
Date: Wed, 26 Jan 2011 06:52:36 +0530
Message-ID: <20110126012236.GB8524@manju-desktop>
References: <1295992862-6154-1-git-send-email-dlambert@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:54474 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751379Ab1AZBWm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 20:22:42 -0500
Received: by mail-gw0-f48.google.com with SMTP id 15so2109596gwj.21
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 17:22:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295992862-6154-1-git-send-email-dlambert@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Lambert <dlambert@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, Jan 25, 2011 at 04:00:58PM -0600, David Lambert wrote:
> This is a patch series to add the OMAP Digital Microphone
> driver for OMAP4.
> 
> It includes the driver, a generic DMIC codec, platform devices,
> as well as HWMOD entries for OMAP44xx chipsets.
> 
> Note: The DMIC codec driver was removed from this series as it was
> accepted for and merged for the 2.6.38 kernel.

You have not mentioned the baseline for this patch series. I tried to apply
first patch of this series on linux omap master branch, patch applies cleanly
but the changes are not getting compiled eventhough it is enabled in Makefile
if I use omap2plus_defconfig. Am I missing anything?

-Manjunath

> 
> Benoit Cousson (1):
>   OMAP4: hwmod: add entries for DMIC driver
> 
> David Lambert (3):
>   ASoC: DMIC: Adding the OMAP DMIC driver
>   OMAP4: DMIC: initializes the DMIC driver
>   OMAP4: DMIC: Add DMIC codec platform devices
> 
>  arch/arm/mach-omap2/board-4430sdp.c        |   11 +
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 +++++
>  arch/arm/plat-omap/devices.c               |   35 ++
>  arch/arm/plat-omap/include/plat/dmic.h     |   82 +++++
>  sound/soc/omap/Kconfig                     |    3 +
>  sound/soc/omap/Makefile                    |    2 +
>  sound/soc/omap/omap-dmic.c                 |  534 ++++++++++++++++++++++++++++
>  7 files changed, 758 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/dmic.h
>  create mode 100644 sound/soc/omap/omap-dmic.c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
