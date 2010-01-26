From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Add tmp register for debug-macro.S,
	do not select CPU_32v6K for omap2
Date: Tue, 26 Jan 2010 11:37:34 -0800
Message-ID: <20100126193311.15134.24078.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50753 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712Ab0AZThU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 14:37:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi,

Here are three patches for review to allow more complicated
DEBUG_LL port handling by adding a tmp register for addruart.

The third patch makes it possible to boot mach-omap2 kernels with 
omap2420 (v6) and omap34xx (v7) compiled in.

These are needed for the following omap specific patch series.

Regards,

Tony


---

Tony Lindgren (3):
      ARM: Add tmp register for addruart and loadsp
      ARM: Add tmp register for debug-macro.S files
      ARM: Select CPU_32v6K for CPU_V7 only if ARCH_OMAP2 is not selected


 arch/arm/boot/compressed/head.S                    |   20 ++++++++++----------
 arch/arm/kernel/debug.S                            |   12 ++++++------
 arch/arm/mach-aaec2000/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-at91/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-clps711x/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-davinci/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-dove/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-ebsa110/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ep93xx/include/mach/debug-macro.S    |    2 +-
 .../arm/mach-footbridge/include/mach/debug-macro.S |    4 ++--
 arch/arm/mach-gemini/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-h720x/include/mach/debug-macro.S     |    2 +-
 .../arm/mach-integrator/include/mach/debug-macro.S |    2 +-
 arch/arm/mach-iop13xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-iop32x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-iop33x/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-ixp2000/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp23xx/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ixp4xx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-kirkwood/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-ks8695/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-l7200/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-lh7a40x/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-loki/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-mmp/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-msm/include/mach/debug-macro.S       |    4 ++--
 arch/arm/mach-mv78xx0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-netx/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-nomadik/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-ns9xxx/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-omap1/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-orion5x/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-pnx4008/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-pxa/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-realview/include/mach/debug-macro.S  |    2 +-
 arch/arm/mach-rpc/include/mach/debug-macro.S       |    2 +-
 arch/arm/mach-s3c2410/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c24a0/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s3c6400/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-s5pc100/include/mach/debug-macro.S   |    2 +-
 arch/arm/mach-sa1100/include/mach/debug-macro.S    |    2 +-
 arch/arm/mach-shark/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-u300/include/mach/debug-macro.S      |    2 +-
 arch/arm/mach-ux500/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-versatile/include/mach/debug-macro.S |    2 +-
 arch/arm/mm/Kconfig                                |    4 ++--
 arch/arm/plat-mxc/include/mach/debug-macro.S       |    2 +-
 arch/arm/plat-stmp3xxx/include/mach/debug-macro.S  |    2 +-
 49 files changed, 66 insertions(+), 66 deletions(-)

-- 
Signature
