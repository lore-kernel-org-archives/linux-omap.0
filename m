From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: omap2plus_defconfig: enable CMA allocator
Date: Mon, 21 Jan 2013 23:27:58 +0100
Message-ID: <CAAwP0s2=_wrPYjmckiXMwK8-4MkyYxtX8HtWv9NuaTtqqN7icg@mail.gmail.com>
References: <1355920420-20852-1-git-send-email-javier.martinez@collabora.co.uk>
 <1355920420-20852-2-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f178.google.com ([209.85.210.178]:63628 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245Ab3AUW2T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jan 2013 17:28:19 -0500
Received: by mail-ia0-f178.google.com with SMTP id y26so2967860iab.9
        for <linux-omap@vger.kernel.org>; Mon, 21 Jan 2013 14:28:18 -0800 (PST)
In-Reply-To: <1355920420-20852-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Wed, Dec 19, 2012 at 1:33 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> The OMAP framebuffer driver now uses the standard dma allocator
> instead of the (now removed) omap specific vram allocator.
>
> Enable the Contiguous Memory Allocator by default to allow large
> dma memory buffers allocation.
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/configs/omap2plus_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index da530a0..dc4789e 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -64,6 +64,7 @@ CONFIG_MAC80211=m
>  CONFIG_MAC80211_RC_PID=y
>  CONFIG_MAC80211_RC_DEFAULT_PID=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> +CONFIG_CMA=y
>  CONFIG_CONNECTOR=y
>  CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
> --

Hi Tony,

Are you considering adding this patch and

ARM: OMAP2+: omap2plus_defconfig: enable TFP410 chip support [1]

to the 3.8-rc series or 3.9?

These patches have been acked by Tomi and are necessary to have
framebuffer video working on many OMAP3 based boards.

Thanks a lot and best regards,
Javier

[1]: https://patchwork.kernel.org/patch/1895451/
