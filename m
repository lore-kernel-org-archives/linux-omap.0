From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/8 RFC] OMAP: GPIO: Split OMAP1 and OMAP2PLUS
Date: Tue, 06 Apr 2010 15:31:19 -0700
Message-ID: <87hbnojjrc.fsf@deeprootsystems.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38760 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab0DFWbY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 18:31:24 -0400
Received: by gyg13 with SMTP id 13so182033gyg.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 15:31:23 -0700 (PDT)
In-Reply-To: <1270038239-1090-1-git-send-email-charu@ti.com> (Charulatha V.'s message of "Wed\, 31 Mar 2010 17\:53\:51 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, paul@pwsan.com, tony@atomide.com

Charulatha V <charu@ti.com> writes:

> This patch series is in preparation to adapt GPIO to HWMOD FW.
> It creates OMAP architecture specific gpio files to handle
> SoC specific gpio_init. The common plat-omap/gpio.c handles all
> common GPIO APIs.
>
> OMAP2PLUS GPIO module is implemented as early platform device and
> OMAP1 GPIO is still handled in old way via gpio_init from board files.
>
> Save/restore context, gpio_prepare_for_retention and
> gpio_resume_after_retention APIs are also handled in plat-omap layer.
> These APIs are currently not used in OMAP1, but still they might
> become common for different OMAP architectures in the future.
> Hence they are handled in plat-omap layer. If they need to be moved
> to mach-omap2 layer, additional patches may be sent during
> next version of this patch series.
>
> This patch series is generated on top of linux-omap-2.6 branch: master
> and tested on 3430SDP, 4430SDP & zoom3.

I have many problems with this series, but without going into the
specifics of each patch, I have a big problem with the general
approach being taken here.

You say this is in preparation for adaptation to hwmod, but in fact,
this series is duplicating a lot of the work you would get for free by
starting with hwmod.

You're generating a bunch of code that will be completely thrown away
with a hwmod conversion.  Instead, you should *start* by using hwmod +
omap_device to generate the platform_devices for you.  Doing this, you
will drop patches 2, 3 and 4 entirely (they are mostly identical
anyways, except for the search-and-replace) and also eliminate the
need for patch 5.

What is needed here is a way to introduce the platform_device
conversion without introducing signifcant functional changes at the
same time.  Here's a proposal to do that, and which should also be
considerably easier to review for sanity:

- use hwmod + omap_device to generate (early) platform_devices
- modify plat-omap/gpio.c to use base addr and IRQ from platform_device
- modify plat-omap/gpio.c to get clocks based on 'struct device'

For an example, you can see the pm-wip/hwmods branch in my tree for
how this was done for UART and the pm-wip/mmc branch for how this was
done for MMC.

Kevin
