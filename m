From: Ladislav Michl <Ladislav.Michl@seznam.cz>
Subject: [PATCH 0/2] OMAP: convert boards to use platform data with smc91x
Date: Tue, 8 Dec 2009 18:00:38 +0100
Message-ID: <20091208170038.GA19338@localhost.localdomain>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:45757 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154AbZLHQAd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Dec 2009 11:00:33 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-netdev@vger.kernel.org

As smc91x driver allows specifying settings in board resources, use that
rather than needing CONFIG_ARCH_OMAP in the drivers/net/smc91x.h header.

 arch/arm/mach-omap1/board-fsample.c   |   10 ++++++++++
 arch/arm/mach-omap1/board-h2.c        |   10 ++++++++++
 arch/arm/mach-omap1/board-h3.c        |   10 ++++++++++
 arch/arm/mach-omap1/board-innovator.c |   13 +++++++++++++
 arch/arm/mach-omap1/board-osk.c       |   10 ++++++++++
 arch/arm/mach-omap1/board-perseus2.c  |   10 ++++++++++
 arch/arm/mach-omap1/board-voiceblue.c |   10 ++++++++++
 arch/arm/mach-omap2/board-apollon.c   |   10 ++++++++++
 arch/arm/mach-omap2/gpmc-smc91x.c     |    8 +++++---
 arch/arm/plat-omap/debug-devices.c    |   10 ++++++++++
 drivers/net/smc91x.h                  |   15 ---------------
 11 files changed, 98 insertions(+), 18 deletions(-)
