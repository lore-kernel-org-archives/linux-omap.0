From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 0/3] ARM: dts: omap3-igep MMC updates for v3.13
Date: Sat, 19 Oct 2013 21:54:05 +0200
Message-ID: <1382212448-31094-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:57007 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164Ab3JST4h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 19 Oct 2013 15:56:37 -0400
Received: by mail-wg0-f54.google.com with SMTP id c11so5172720wgh.9
        for <linux-omap@vger.kernel.org>; Sat, 19 Oct 2013 12:56:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@gmail.com>

Hi Benoit,

This series are some updates for IGEP boards that would be great if can make
it for v3.13 (not sure if merge window is already closed as I saw your last
pull request).

The first patch is fix for mmc1 that should be configured for 4 bits not 8,
the second patch add support for the WiFi module connected to MMC2 SDIO
interface, and the third patch, updates the default processor to AM/DM37x
as most of the boards uses this processor instead of the old OMAP353x.

Best regards,

Enric Balletbo i Serra (3):
  ARM: dts: omap3-igep: Fix bus-width for mmc1.
  ARM: dts: omap3-igep: Add support for LBEE1USJYC WiFi connected to
    SDIO.
  ARM: dts: omap3-igep*: Update to use the TI AM/DM37x processor.

 arch/arm/boot/dts/omap3-igep.dtsi    | 55 ++++++++++++++++++++++++++++++------
 arch/arm/boot/dts/omap3-igep0020.dts |  4 +--
 arch/arm/boot/dts/omap3-igep0030.dts |  4 +--
 3 files changed, 51 insertions(+), 12 deletions(-)

-- 
1.8.1.2

