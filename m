From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Allow using machine ID for DEBUG_LL macros
Date: Thu, 03 Feb 2011 17:22:03 -0800
Message-ID: <20110204012008.26298.16341.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13667 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752Ab1BDBWT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 20:22:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are two patches that allow using machine ID for DEBUG_LL
macros by adding a new macro inituart.

Will post the related omap changes separately.

Regards,

Tony


---

Tony Lindgren (2):
      ARM: Add inituart macro to initialize DEBUG_LL serial port based on the machine ID
      ARM: Add empty inituart macros


 arch/arm/kernel/head-common.S                      |    7 +++++++
 arch/arm/kernel/head.S                             |    5 +++++
 arch/arm/mach-aaec2000/include/mach/debug-macro.S  |    4 ++++
 arch/arm/mach-at91/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-clps711x/include/mach/debug-macro.S  |    3 +++
 arch/arm/mach-cns3xxx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-davinci/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-dove/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    3 +++
 .../arm/mach-footbridge/include/mach/debug-macro.S |    4 ++++
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    3 +++
 .../arm/mach-integrator/include/mach/debug-macro.S |    3 +++
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    3 +++
 arch/arm/mach-ks8695/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-l7200/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-loki/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-lpc32xx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-mmp/include/mach/debug-macro.S       |    3 +++
 arch/arm/mach-msm/include/mach/debug-macro.S       |    4 ++++
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-mxs/include/mach/debug-macro.S       |    3 +++
 arch/arm/mach-netx/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-nomadik/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-omap1/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-pxa/include/mach/debug-macro.S       |    3 +++
 arch/arm/mach-realview/include/mach/debug-macro.S  |    3 +++
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    3 +++
 arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s3c24a0/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s3c64xx/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5p6442/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5pv210/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-s5pv310/include/mach/debug-macro.S   |    3 +++
 arch/arm/mach-sa1100/include/mach/debug-macro.S    |    3 +++
 arch/arm/mach-shark/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-u300/include/mach/debug-macro.S      |    3 +++
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    3 +++
 arch/arm/mach-versatile/include/mach/debug-macro.S |    3 +++
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |    3 +++
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    3 +++
 arch/arm/plat-spear/include/plat/debug-macro.S     |    3 +++
 arch/arm/plat-stmp3xxx/include/mach/debug-macro.S  |    3 +++
 arch/arm/plat-tcc/include/mach/debug-macro.S       |    3 +++
 53 files changed, 168 insertions(+), 0 deletions(-)

-- 
Signature
