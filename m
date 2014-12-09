From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 0/7] arm: omap: move more HWMOD data to DT
Date: Tue, 9 Dec 2014 16:27:45 -0600
Message-ID: <1418164072-19087-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47194 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753213AbaLIW2V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Dec 2014 17:28:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi,

here's a more complete series showing the out of debugfs interface.

So far only AM43xx has been converted and only those HWMODs which
play well with DT and/or are not common with other OMAPs/AM33xx.

I plan to work on AM33xx tomorrow, but this RFC shows what we can
achieve WRT HWMOD static data reduction.

As you can see, with AM43xx, data reduction is quite minimal, since
it reuses so much from AM33xx, but well, had to start somewhere.

All patches were boot tested with AM437x SK on top of:

commit 1ca7c606de868d172afb4eb65e04e290dbdb51ff
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Dec 4 19:49:10 2014 +1100

    Add linux-next specific files for 20141204
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

cheers

Felipe Balbi (7):
  arm: omap: hwmod: add debugfs interface
  arm: omap: devicetree: add new properties for OMAP devices
  arm: omap: hwmod: drop 'const' qualifier from omap_hwmod_class name
  arm: omap: device: add support for generating sysconfig data from DT
  arm: omap: hwmod: allow for registration of class-less hwmods
  arm: boot: dts: am4372: add sysconfig data to all HWMODs
  arm: omap: hwmod: 43xx: remove sysc and class data

 .../devicetree/bindings/arm/omap/omap.txt          |   7 +
 arch/arm/boot/dts/am4372.dtsi                      | 251 +++++++++++++++++++
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/omap_device.c                  | 117 +++++++++
 arch/arm/mach-omap2/omap_hwmod.c                   |  30 ++-
 arch/arm/mach-omap2/omap_hwmod.h                   |  11 +-
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  61 -----
 arch/arm/mach-omap2/omap_hwmod_debugfs.c           | 269 +++++++++++++++++++++
 8 files changed, 673 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_debugfs.c

-- 
2.2.0

