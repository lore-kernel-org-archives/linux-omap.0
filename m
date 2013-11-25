From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v2 00/11]: add remaining support for IGEP boards
Date: Mon, 25 Nov 2013 16:30:27 +0100
Message-ID: <CABxcv=k+Lk=PFONKLvXab5iHExG7WCJRfE6BzEkv_YtPVwB8Dw@mail.gmail.com>
References: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63249 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857Ab3KYPa3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 10:30:29 -0500
Received: by mail-wi0-f178.google.com with SMTP id ca18so5626165wib.11
        for <linux-omap@vger.kernel.org>; Mon, 25 Nov 2013 07:30:27 -0800 (PST)
In-Reply-To: <1384909575-19108-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Sebastian Reichel <sre@ring0.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Nov 20, 2013 at 2:06 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> In order to make mach-omap2 Device Tree only, the board file for
> IGEP boards was removed even when support for wifi and display
> was still not supported by its DTS.
>
> This is a second version of a patch-set that adds support for
> these remaining peripherals and also adds support for USB,
> HDMI and user LED for the am33xx SoC based IGEP Aquila board.
>
> The patch-set is composed of the following patches:
>
> Enric Balletbo i Serra (7):
>       ARM: dts: omap3-igep: Fix bus-width for mmc1.
>       ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi connected to SDIO.
>       ARM: dts: omap3-igep: Update to use the TI AM/DM37x processor.
>       ARM: dts: AM33XX BASE0033: add pinmux and hdmi node to enable display
>       ARM: dts: AM33XX BASE0033: add pinmux and user led support.
>       ARM: dts: AM33XX BASE0033: add 32KBit EEPROM support.
>       ARM: dts: AM33XX IGEP0033: add USB support.
>
> Javier Martinez Canillas (4):
>       ARM: dts: omap3-igep0020: Add pinmux setup for i2c devices
>       ARM: dts: omap3-igep0020: Add pinmuxing for DVI output
>       ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus
>       ARM: dts: omap3-igep0020: name twl4030 VPLL2 regulator as vdds_dsi
>
> Changes since v1:
>
>  Don't add a workaround in drivers/video/omap2/dss/dpi.c to use the
>  VPLL2 regulator from twl4030 if VDDS_DSI regulator is not linked to
>  the DPI device since the used regulator is a per board configuration.
>
>  Instead add a regulator-name = "vdds_dsi" property to the regulator
>  in the IGEPv2 DTS file as suggested by Tony Lindgren.
>
> Tony,
>
> Most of these patches are just DTS changes so they have to be picked
> by Benoit besides the following patch that has to go through your tree
>
> [PATCH 10/11] ARM: OMAP: dss-common: change IGEP's DVI DDC i2c bus
>
> Since we have removed the board file for IGEP boards I think these
> can be considered as regression fixes for 3.13 although I don't mind
> if you prefer to wait for 3.14.
>
> Thanks a lot and best regards,
> Javier
> --

Hi Benoit and Tony,

Now that 3.13-rc1 is out, do you think that it would be possible to
include this series as a fix for the -rc cycle?

Otherwise we will have missing functionality for IGEP boards on 3.13
due the board file removal. The changes are mostly DT and won't affect
other boards.

Thanks a lot and best regards,
Javier
