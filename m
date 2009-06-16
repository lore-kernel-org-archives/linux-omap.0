From: Jean Pihet <jpihet@mvista.com>
Subject: [PATCH 0/2] Allows the SDRAM self refresh to work with 2 chip selects
Date: Tue, 16 Jun 2009 10:11:33 +0200
Message-ID: <200906161011.33725.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:12564 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZFPILi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 04:11:38 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

Those 2 patches allow the self refresh to work in case of 2 chip selects are 
in use by the SDRC.
It applies on top of the master branch.

Regards,
Jean

---
OMAP3-add-support-for-2-SDRAM-chip-selects.patch
OMAP3-Setup-MUX-settings-for-SDRC-CKE-signals.patch

 arch/arm/mach-omap2/board-2430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c      |    2 +-
 arch/arm/mach-omap2/board-apollon.c      |    2 +-
 arch/arm/mach-omap2/board-generic.c      |    2 +-
 arch/arm/mach-omap2/board-h4.c           |    2 +-
 arch/arm/mach-omap2/board-ldp.c          |    2 +-
 arch/arm/mach-omap2/board-n800.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c  |    7 ++-
 arch/arm/mach-omap2/board-omap3evm.c     |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c |    8 ++-
 arch/arm/mach-omap2/board-overo.c        |    8 ++-
 arch/arm/mach-omap2/board-rx51.c         |    6 +-
 arch/arm/mach-omap2/board-zoom2.c        |    2 +-
 arch/arm/mach-omap2/clock34xx.c          |   37 ++++++--
 arch/arm/mach-omap2/io.c                 |    5 +-
 arch/arm/mach-omap2/mux.c                |    6 ++
 arch/arm/mach-omap2/sdrc.c               |   63 +++++++++-----
 arch/arm/mach-omap2/sram34xx.S           |  137 
+++++++++++++++++++++++-------
 arch/arm/plat-omap/include/mach/io.h     |    3 +-
 arch/arm/plat-omap/include/mach/mux.h    |    4 +
 arch/arm/plat-omap/include/mach/sdrc.h   |   11 ++-
 arch/arm/plat-omap/include/mach/sram.h   |   23 +++---
 arch/arm/plat-omap/sram.c                |   30 ++++---
 24 files changed, 265 insertions(+), 103 deletions(-)
