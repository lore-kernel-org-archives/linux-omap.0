From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Pull Request for OMAP4
Date: Mon, 3 Aug 2009 14:37:58 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B5BF2825@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51240 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706AbZHCJIR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Aug 2009 05:08:17 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, "tony@atomide.com" <tony@atomide.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Linux OMAP Users <linux-omap@vger.kernel.org>

Hi Russell,

Could you please pull four patches below for the upcoming merging window.

The patches are rebased on commit 4be3bd7849165e7efa6b0b35a23d6a3598d97465:
  Linus Torvalds (1):        Linux 2.6.31-rc4

and available in the git repository at:

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git omap4_upstream

Summary:

Santosh Shilimkar (1):	
	OMAP4: sDMA: Update the request lines and new registers.
Syed Rafiuddin (3):
      ARM: OMAP4: Add McBSP support
      ARM: OMAP4: Add UART4 support
      ARM: OMAP4: Update the GPIO support

 arch/arm/mach-omap2/board-4430sdp.c     |    2 +-
 arch/arm/mach-omap2/mcbsp.c             |   41 +++++
 arch/arm/mach-omap2/serial.c            |   10 ++
 arch/arm/plat-omap/gpio.c               |  249 ++++++++++++++++++++++++-------
 arch/arm/plat-omap/include/mach/dma.h   |   88 +++++++++++
 arch/arm/plat-omap/include/mach/mcbsp.h |    8 +-
 arch/arm/plat-omap/mcbsp.c              |    2 +-
 7 files changed, 346 insertions(+), 54 deletions(-)

Regards,
Santosh
