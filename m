From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 0/3] ARM: omap2plus_defconfig: Enable OMAP3 ISP and dependencies
Date: Mon,  8 Feb 2016 14:53:00 -0300
Message-ID: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Hello,

This small series enables all the Kconfig symbols needed to test the
OMAP3 ISP on the IGEPv2 board. I've enabled as much as possible as a
module and only as built-in the options that are boolean.

Best regards,
Javier


Javier Martinez Canillas (3):
  ARM: omap2plus_defconfig: Enable OMAP IOMMU support
  ARM: omap2plus_defconfig: Enable ISP support and dependencies
  ARM: omap2plus_defconfig: Enable TI TVP5150 video decoder support

 arch/arm/configs/omap2plus_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.5.0
