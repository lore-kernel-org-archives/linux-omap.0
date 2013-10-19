From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 0/3] ARM: dts: omap3-igep MMC updates for v3.13
Date: Sun, 20 Oct 2013 01:25:22 +0200
Message-ID: <CAAwP0s1nZySOeTBpuE12j=RS+oN4jdRdK-hn9Gsecr86_S6p6Q@mail.gmail.com>
References: <1382212448-31094-1-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59011 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab3JSXZn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 19:25:43 -0400
Received: by mail-ie0-f175.google.com with SMTP id aq17so8772714iec.20
        for <linux-omap@vger.kernel.org>; Sat, 19 Oct 2013 16:25:43 -0700 (PDT)
In-Reply-To: <1382212448-31094-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

[cc'ing current Benoit's address instead of the old one]

On Sat, Oct 19, 2013 at 9:54 PM, Enric Balletbo i Serra
<eballetbo@gmail.com> wrote:
> Hi Benoit,
>
> This series are some updates for IGEP boards that would be great if can make
> it for v3.13 (not sure if merge window is already closed as I saw your last
> pull request).
>
> The first patch is fix for mmc1 that should be configured for 4 bits not 8,
> the second patch add support for the WiFi module connected to MMC2 SDIO
> interface, and the third patch, updates the default processor to AM/DM37x
> as most of the boards uses this processor instead of the old OMAP353x.
>
> Best regards,
>

Hi Enric,

Thanks a lot for this patch-set. I don't have access to my IGEP board
right now so I can't give a try but will do as soon as possible.

I've just two minors nits that I commented on the individual patches
but I'm not sure if those justifies a v2 so:

Reviewed-by: Javier Martinez Canillas <javier@collabora.co.uk>

> Enric Balletbo i Serra (3):
>   ARM: dts: omap3-igep: Fix bus-width for mmc1.
>   ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi connected to
>     SDIO.
>   ARM: dts: omap3-igep*: Update to use the TI AM/DM37x processor.
>
>  arch/arm/boot/dts/omap3-igep.dtsi    | 55 ++++++++++++++++++++++++++++++------
>  arch/arm/boot/dts/omap3-igep0020.dts |  4 +--
>  arch/arm/boot/dts/omap3-igep0030.dts |  4 +--
>  3 files changed, 51 insertions(+), 12 deletions(-)
>
> --
> 1.8.1.2
>
