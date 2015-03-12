From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH 0/2] ARM: devicetree: Remove unused ti,codec property
Date: Thu, 12 Mar 2015 22:14:57 +0100
Message-ID: <1426194899-14037-1-git-send-email-marek@goldelico.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:43566 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbbCLVPN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2015 17:15:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, peter.ujfalusi@ti.com
Cc: eballetbo@gmail.com, javier@dowhile0.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jarkko.nikula@bitmer.com, hns@goldelico.com, Marek Belisko <marek@goldelico.com>

ti,codec in not parsed in omap-twl4030 sound driver. It's not necessary
to specify this property in DT because ti,twl4030-audio which ti,codec
was pointing to by phandle is mfd driver and device for ASoC ic created w/o
any DT property (codec name is hardcoded in ASoC driver).

Please see reply [1] from Peter Ujfalusi.

[1]: http://comments.gmane.org/gmane.linux.ports.arm.omap/124273

Marek Belisko (2):
  ARM: dts: omap3: Remove all references to ti,codec property
  Documentation: omap-twl4030: Remove ti,codec property

 Documentation/devicetree/bindings/sound/omap-twl4030.txt | 2 --
 arch/arm/boot/dts/omap3-beagle-xm.dts                    | 1 -
 arch/arm/boot/dts/omap3-beagle.dts                       | 1 -
 arch/arm/boot/dts/omap3-cm-t3x30.dtsi                    | 1 -
 arch/arm/boot/dts/omap3-devkit8000.dts                   | 1 -
 arch/arm/boot/dts/omap3-gta04.dtsi                       | 1 -
 arch/arm/boot/dts/omap3-igep.dtsi                        | 1 -
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi                  | 1 -
 arch/arm/boot/dts/omap3-overo-base.dtsi                  | 1 -
 arch/arm/boot/dts/omap3-tao3530.dtsi                     | 1 -
 10 files changed, 11 deletions(-)

-- 
1.9.1

