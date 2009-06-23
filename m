From: "Hemanth V" <hemanthv@ti.com>
Subject: [RESEND][PATCH 0/2] McSPI Slave and DMA ,FIFO support
Date: Tue, 23 Jun 2009 19:23:51 +0530 (IST)
Message-ID: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41016 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbZFWNxy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jun 2009 09:53:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, dbrownell@users.sourceforge.net

This series of 2 patches adds support for McSPI slave
and DMA,FIFO. It incorporates review comments from
Kevin Hilman and Tony Lindgren


PATCH[1/2]: Changes to arch specific files
PATCH[2/2]: omap2_mcspi.c file changes

 arch/arm/mach-omap2/devices.c           |    5
 arch/arm/plat-omap/include/mach/mcspi.h |   16 +
 drivers/spi/omap2_mcspi.c               |  353
++++++++++++++++++++++++++++++++++++++++------


