From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: convert to module_platform_driver"
Date: Thu, 2 Aug 2012 17:54:08 -0600
Message-ID: <CACxGe6scCYLpsEDGGwaXw_ijAk027w6Mk7D7FSOTZZdC6VkKSg@mail.gmail.com>
References: <1343948917-14760-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53171 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab2HBXy3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 19:54:29 -0400
Received: by vcbfk26 with SMTP id fk26so145236vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 16:54:28 -0700 (PDT)
In-Reply-To: <1343948917-14760-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, balbi@ti.com, tomi.valkeinen@ti.com

On Thu, Aug 2, 2012 at 5:08 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> This reverts commit 9fdca9dfe093c76fe1ac1a09888ba9679d46996a.
>
> Changing omap2_mcspi_init() from subsys_initcall to device_initcall broke
> the display initialization on N900 when all the drivers are compiled
> built-in. Display subsystem drivers need a certain initialization order
> and having all of them initialize with device_initcall seems to be too
> fragile. Without this revert the display init fails and the boot hangs
> with the following messages:
>
> [    1.260955] acx565akm spi1.2: invalid display ID
> [    1.265899] panel-acx565akm display0: acx_panel_probe panel detect error
> [    1.273071] omapdss CORE error: driver probe failed: -19

The dependencies are all messed up. The reverted commit is part of
fixing that and I don't really want to go backwards on it. How many
drivers are failing? Can you try modifying the failure path of those
drivers to return -EPROBE_DEFER and see if that helps?

g.
