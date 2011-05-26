From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/3] Some omap_device/hwmod/pwrdomain patches
Date: Thu, 26 May 2011 10:30:34 -0700
Message-ID: <87ipsxfjyd.fsf@ti.com>
References: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58809 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753203Ab1EZRaj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 13:30:39 -0400
Received: by mail-pw0-f49.google.com with SMTP id 8so616255pwi.22
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 10:30:39 -0700 (PDT)
In-Reply-To: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com> (Tomi
	Valkeinen's message of "Thu, 26 May 2011 19:45:04 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> I came up with these patches while implementing pm runtime adaptation for DSS
> driver. I'm not quite sure on who's turf they belong, or do they even belong
> together, but here they are anyway.
>
> get_context_loss_count patch was discussed on l-o with Kevin.
>
> The omap_device_reset patch I made as some parts of DSS currently presume that
> the HW module is reset when it is enabled, and the reset is better handled in
> hwmod code.
>
> can_ever_lose_context code I didn't strictly need, but as there's such a
> function I added that to the context save code in DSS while rewriting the code.

Are any of the DSS blocks in power domains that can't lose context
(WKUP?)

This isn't something in general that drivers should be aware of, so I'd
rather not see this exposed to drivers (unless there's a real need.)

As soon as I finish the move to device power domains (hopefully for
2.6.41), the driver's callbacks will only be called if the device has
lost context, so checking for context loss will not be needed at all at
the driver level.

Kevin

>
>  Tomi
>
> Tomi Valkeinen (3):
>   OMAP: change get_context_loss_count ret value to int
>   OMAP: add omap_device_reset()
>   OMAP: Add (omap_device|omap_hwmod)_can_ever_lose_context functions
>
>  arch/arm/mach-omap2/omap_hwmod.c              |   24 ++++++++++++-
>  arch/arm/mach-omap2/powerdomain.c             |   14 +++++--
>  arch/arm/mach-omap2/powerdomain.h             |    2 +-
>  arch/arm/plat-omap/include/plat/omap-pm.h     |    4 +-
>  arch/arm/plat-omap/include/plat/omap_device.h |    4 ++-
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    3 +-
>  arch/arm/plat-omap/omap-pm-noop.c             |   24 +++++++++----
>  arch/arm/plat-omap/omap_device.c              |   48 ++++++++++++++++++++++++-
>  8 files changed, 105 insertions(+), 18 deletions(-)
