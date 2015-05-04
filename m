From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: EDMA oftree entry for AM335x
Date: Mon, 4 May 2015 08:43:23 +0200
Message-ID: <20150504064323.GU15254@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48058 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbbEDGn1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 02:43:27 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

since 5e863c561, I get this warning for an AM335x board:

  omap_hwmod: tptc0 using broken dt data from edma
  omap_hwmod: tptc1 using broken dt data from edma
  omap_hwmod: tptc2 using broken dt data from edma

It seems like the code in arch/arm/mach-omap2/omap_hwmod.c expects the oftree
entry to look differently than what we currently have in
arch/arm/boot/dts/am33xx.dtsi:

  edma: edma@49000000 {
          compatible = "ti,edma3";
          ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";    <==========
          reg =   <0x49000000 0x10000>,
                  <0x44e10f90 0x40>;
          interrupts = <12 13 14>;
          #dma-cells = <1>;
  };

The patch description says the device should be split into more devices instead
of specifying several ti,hwmods entries, but unfortunately the Documentation
still suggests the above format in Documentation/devicetree/bindings/dma/ti-edma.txt.

How would a correct entry look like?

Thanks,
rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
