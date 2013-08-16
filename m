From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 0/9] USB: phy: phy-nop: Manage RESET GPIO in the driver
Date: Fri, 16 Aug 2013 12:52:17 +0200
Message-ID: <520E0461.70305@baylibre.com>
References: <1376561909-4406-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32845 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab3HPKwU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Aug 2013 06:52:20 -0400
Received: by mail-wi0-f171.google.com with SMTP id hr7so662767wib.10
        for <linux-omap@vger.kernel.org>; Fri, 16 Aug 2013 03:52:19 -0700 (PDT)
In-Reply-To: <1376561909-4406-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, tony@atomide.com, p.zabel@pengutronix.de, broonie@kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Roger,

On 15/08/2013 12:18, Roger Quadros wrote:
> Hi,
>
> Modelling the RESET line as a regulator supply wasn't a good idea
> as it abuses the regulator framework and makes adaptation
> code/data more complex.
>
> Instead, manage the RESET gpio line directly in the driver.
>
> This also makes us easy to migrate to a dedicated GPIO RESET controller
> whenever it becomes available. As of now, it doesn't seem to be making
> it into 3.12.
>
> *NOTE:* As there are changes to platform data, Patch 1 needs to be shared
> between the arm-soc tree and usb tree.
>
> Patch 1 is available at repo
> 	git://github.com/rogerq/linux.git
> in branch
> 	phy-reset-common
>
> Patch 2 contains the phy-nop driver changes
> Patches 3 and 4 adapt legacy boot code to the phy-nop driver changes.
> Patches 5, 6 and 7 adapt DT data to the binding changes.
> Patch 8 is cleanup of omap3-beagle DT.
> Patch 9 adds USB host support to omap3-beagle-xm using the new binding.
>
> Patches are based on v3.11-rc5.
> Tested leacy boot on omap3-beagle and omap3-beagle-xm
> Tested DT boot on omap3-beagle, omap3-beagle-xm and omap4-panda-es
>
> v2:
> - Added RESET GPIO polarity feature
> - Changed to gpio_set_value_cansleep()
>
> cheers,
> -roger
>
> ---
> Roger Quadros (9):
>    usb: phy: nop: Add gpio_reset to platform data
>    usb: phy: nop: Don't use regulator framework for RESET line
>    ARM: OMAP2+: omap-usb-host: Get rid of platform_data from struct
>      usbhs_phy_data
>    ARM: OMAP2+: usb-host: Adapt to USB phy-nop RESET line changes
>    ARM: dts: omap3-beagle: Use reset-gpios for hsusb2_reset
>    ARM: dts: omap4-panda: Use reset-gpios for hsusb1_reset
>    ARM: dts: omap5-uevm: Use reset-gpios for hsusb2_reset
>    ARM: dts: omap3-beagle: Make USB host pin naming consistent
>    ARM: dts: omap3-beagle-xm: Add USB Host support

The 5 DTS patches looks good to me, and I can apply them, but you need 
to be sure that the driver will be merged for 3.12 as well.

Regards,
Benoit

