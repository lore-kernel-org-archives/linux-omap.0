From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/1] OMAP3: DMA: Enable idlemodes for DMA OCP
Date: Mon,  1 Dec 2008 10:55:24 +0200
Message-ID: <1228121725-14062-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35308 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbYLAIx3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 03:53:29 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com

Enabling smart idle modes in DMA4_OCP_SYSCONFIG enables sDMA to enter
standby if only synchronized dma transfers are programmed and no transfer
is active. This is needed to enable CORE power domain inactivity during
audio playback. 

Compile tested with omap_3430sdp_defconfig on l-o master. Compile+boot+audio
playback (aplay) tested on custom omap3 HW.

IMO, this could go to linux-omap directly, but PM-branch is ok as well.

Kalle Jokiniemi (1):
      OMAP3: DMA: Enable idlemodes for DMA OCP

 arch/arm/plat-omap/dma.c              |   13 +++++++++++++
 arch/arm/plat-omap/include/mach/dma.h |   15 +++++++++++++++
 2 files changed, 28 insertions(+)



