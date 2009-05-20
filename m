From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH 0/2] McSPI Slave and DMA,FIFO support
Date: Wed, 20 May 2009 11:26:40 +0530 (IST)
Message-ID: <54284.10.24.255.18.1242799000.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41779 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbZETF4p (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 01:56:45 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4K5ufj9007067
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 00:56:46 -0500
Received: from dbdmail.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4K5udp4017638
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 00:56:40 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series of 2 patches adds support for McSPI slave
and DMA,FIFO. It incorporates review comments from
Kevin Hilman


PATCH[1/2]: Adds Slave,FIFO support to McSPI driver
PATCH[2/2]: Mux and board specific changes

 arch/arm/mach-omap2/devices.c           |    5
 arch/arm/plat-omap/include/mach/mcspi.h |   16 +
 drivers/spi/omap2_mcspi.c               |  343 ++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/board-3430sdp.c   |   26 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c             |   11 +++++++++++
 arch/arm/plat-omap/include/mach/mux.h |    7 +++++++


