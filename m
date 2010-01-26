From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: [PATCH 0/2] omap_globals cleanup
Date: Tue, 26 Jan 2010 14:08:34 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C089455A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52138 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816Ab0AZIim convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 03:38:42 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony, Kevin,

As discussed on off the list email, below two patches converts all the omap_globals to
physical address and ioremap the space dynamically. Patches generated against the latest 
2.6.33-rc5+ mainline kernel.

Boot tested on OMAP4430SDP and OMAP3430SDP. I don't have OMAP2 board here :(

The following changes since commit f6760aa024199cfbce564311dc4bc4d47b6fb349:
  Linus Torvalds (1):
        Merge branch 'timers-fixes-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

Santosh Shilimkar (2):
      OMAP2/3/4: Convert bases in omap_globals to physical address
      OMAP2/3/4: ioremap address space

 arch/arm/mach-omap2/control.c              |    6 +++-
 arch/arm/mach-omap2/id.c                   |    7 ++++-
 arch/arm/mach-omap2/prcm.c                 |   16 ++++++++--
 arch/arm/mach-omap2/sdrc.c                 |   11 +++++-
 arch/arm/plat-omap/common.c                |   46 ++++++++++++++--------------
 arch/arm/plat-omap/include/plat/common.h   |   14 ++++----
 arch/arm/plat-omap/include/plat/omap24xx.h |    2 +
 arch/arm/plat-omap/include/plat/omap34xx.h |    1 +
 8 files changed, 66 insertions(+), 37 deletions(-)

Regards
Santosh

