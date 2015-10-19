From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/3] ARM: dts: Use IOPAD pinmux for IGEP boards
Date: Mon, 19 Oct 2015 17:34:18 +0200
Message-ID: <1445268861-11857-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Hello,

This series use the IOPAD pinmux macros for the remaining IGEP boards that
still used the register offset instead of the physical address using these
macros so the DTS matches what is in the Technical Reference Manual.

The changes are only cosmetic since they make the DTS easier to read but
does not change functionality. I built tested and compared the binary DTB
MD5 checksum and both matches before and after the series applied:

Before

d7a56205bdc54365d49d9a90dfe3fafb  am335x-base0033.dtb
fa272fcdee65d7bf4c03bd5a6c5ec4fd  omap3-igep0020.dtb
ba65bf74d8c6ea8e7bd8face17179e6e  omap3-igep0020-rev-f.dtb

After

d7a56205bdc54365d49d9a90dfe3fafb  am335x-base0033.dtb
fa272fcdee65d7bf4c03bd5a6c5ec4fd  omap3-igep0020.dtb
ba65bf74d8c6ea8e7bd8face17179e6e  omap3-igep0020-rev-f.dtb

Best regards,
Javier


Javier Martinez Canillas (3):
  ARM: dts: omap3-igep0020: Use IOPAD pinmux macro
  ARM: dts: am335x-igep0033: Use IOPAD pinmux macro
  ARM: dts: am335x-base0033: Use IOPAD pinmux macro

 arch/arm/boot/dts/am335x-base0033.dts        | 48 +++++++++++------------
 arch/arm/boot/dts/am335x-igep0033.dtsi       | 40 +++++++++----------
 arch/arm/boot/dts/omap3-igep0020-common.dtsi | 58 ++++++++++++++--------------
 3 files changed, 73 insertions(+), 73 deletions(-)

-- 
2.4.3
