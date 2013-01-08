From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v4 0/3] ARM/dts: omap3: Add DT support for IGEP devices
Date: Tue, 8 Jan 2013 17:13:08 +0100
Message-ID: <50EC4594.4060507@ti.com>
References: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43169 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756593Ab3AHQNS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Jan 2013 11:13:18 -0500
In-Reply-To: <1355923990-21240-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <elezegarcia@gmail.com>, Jon Hunter <jon-hunter@ti.com>, Matthias Brugger <matthias.bgg@googlemail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Javier,

On 12/19/2012 02:33 PM, Javier Martinez Canillas wrote:
> IGEP technology devices are TI OMAP3 SoC based industrial embedded
> and computer-on-module boards. This patch-set adds initial device
> tree support for these devices.
> 
> The device trees allows to boot from an MMC and are working all the
> components that already have device tree support on OMAP3 SoCs:
> 
> - MMC/SD
> - UARTs
> - GPIO LEDs
> - TWL4030 codec audio
> - pinmux/pinconf pinctrl
> 
> Some peripheral are still not working such as Flash storage and
> Ethernet but support for these will also be included once the
> OMAP GPMC device tree binding patches land on mainline.
> 
> This is a v4 of the patch-set that adds MMC mux pins setup and
> fixes a build issue due recent changes on twl4030.dtsi.
> 
> The patch-set is composed of the following patches:
> 
> [PATCH v4 1/3] ARM/dts: omap3: Add generic DT support for IGEP devices
> [PATCH v4 2/3] ARM/dts: omap3: Add support for IGEPv2 board
> [PATCH v4 3/3] ARM/dts: omap3: Add support for IGEP COM Module

I've just applied your series for 3.9 on top of 3.8-rc2 and had to update the Makefile that was different in the base you used. At the same time I updated the subjects to use "ARM: dts:" prefix to be compliant with the latest trend :-)

The patches are available here:
git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.9/dts

Regards,
Benoit


