From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 0/2] Remove elm address space from omap4 hwmod
Date: Wed, 28 Oct 2015 16:02:15 -0500
Message-ID: <1446066137-11527-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, rogerq@ti.com, nm@ti.com, lokeshvutla@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

This patchset removes elm address entry from omap4 hwmod and adds
an elm DT node to omap4.dtsi.

Since no omap4 supports nand in mainline this patchset was boot
tested on a pandaboard.

Franklin S Cooper Jr (2):
  ARM: dts: omap4: Add elm node
  ARM: omap4: hwmod: Remove elm address space from hwmod data

 arch/arm/boot/dts/omap4.dtsi               |  8 ++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 ----------
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.6.1
