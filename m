From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v3 00/11] OMAP4: Add DT support for i2c and twl6030
Date: Thu, 22 Dec 2011 09:07:49 -0600
Message-ID: <4EF347C5.5020401@gmail.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38353 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab1LVPHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Dec 2011 10:07:52 -0500
Received: by yhr47 with SMTP id 47so5973273yhr.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Dec 2011 07:07:51 -0800 (PST)
In-Reply-To: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 12/20/2011 10:27 AM, Benoit Cousson wrote:
> Hi Tony and Rob,
> 
> Here is the updated version of the i2c + twl DT adaptation series.
> 
> This update, compared to v2 [1], is adding some dedicated dtsi files for
> the twl PMIC and audio IC. These devices will contain a huge amount of
> regulator nodes and thus deserve a dedicated file to avoid every boards
> to redefine the same data.
> The twl patch is now included in Samuel's for-next branch and thus dropped
> from this update.
> The i2c binding was cleaned as suggested by Rob to avoid all the ugly
> hexa flags inside the DTS.
> 
> The pm.c was updated to prevent the SR / VP initialization in the DT
> context since none of them is DT aware for the moment.
> 
> A couple of basic i2c devices are added for panda, beagle and sdp board.
> 
> Patches are based on for_3.3/2_dt_irq, to get the latest GIC binding,
> and are available here:
> git://gitorious.org/omap-pm/linux.git for_3.3/3_omap_dt_i2c_twl
> 
> Tested on Beagle and sdp4430.
> 
> Comments are welcome.
> 
> Regards,
> Benoit
> 
> [1] http://www.spinics.net/lists/linux-omap/msg61260.html
> 
> 
> Benoit Cousson (11):
>   ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
>   i2c: OMAP: Add DT support for i2c controller
>   rtc: rtc-twl: Add DT support for RTC inside twl4030/twl6030
>   arm/dts: OMAP4: Add i2c controller nodes
>   arm/dts: OMAP3: Add i2c controller nodes
>   arm/dts: twl6030: Add DTS file for twl6030 PMIC
>   arm/dts: twl4030: Add DTS file for twl4030 PM + Audio IC
>   arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
>   arm/dts: omap4-sdp: Add twl6030, i2c3 and i2c4 devices
>   arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
>   ARM: OMAP2+: board-generic: Remove i2c static init
> 
>  Documentation/devicetree/bindings/i2c/omap-i2c.txt |   30 ++++++
>  Documentation/devicetree/bindings/rtc/twl-rtc.txt  |   12 +++
>  arch/arm/boot/dts/omap3-beagle.dts                 |   29 ++++++
>  arch/arm/boot/dts/omap3.dtsi                       |   21 ++++
>  arch/arm/boot/dts/omap4-panda.dts                  |   34 +++++++
>  arch/arm/boot/dts/omap4-sdp.dts                    |   53 ++++++++++
>  arch/arm/boot/dts/omap4.dtsi                       |   28 ++++++
>  arch/arm/boot/dts/twl4030.dtsi                     |   21 ++++
>  arch/arm/boot/dts/twl6030.dtsi                     |   22 ++++
>  arch/arm/mach-omap2/board-generic.c                |   48 +---------
>  arch/arm/mach-omap2/pm.c                           |    8 ++
>  drivers/i2c/busses/i2c-omap.c                      |  101 +++++++++++++-------
>  drivers/rtc/rtc-twl.c                              |   10 ++-
>  13 files changed, 334 insertions(+), 83 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/i2c/omap-i2c.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt
>  create mode 100644 arch/arm/boot/dts/twl4030.dtsi
>  create mode 100644 arch/arm/boot/dts/twl6030.dtsi

For the series:

Acked-by: Rob Herring <rob.herring@calxeda.com>
