From: Samu Onkalo <samu.p.onkalo@nokia.com>
Subject: [PATCH 0/1] Prefetch support for DMA transfer
Date: Wed, 30 Jun 2010 11:47:05 +0300
Message-ID: <1277887626-11917-1-git-send-email-samu.p.onkalo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40534 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0F3Ir3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 04:47:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

Add support for Prefetech mode in destination synchronized DMA transfer.
This enables DMA controller to fetch data from memory in advance.
When the destination HW block requests new data block, it can be send out
faster compared to read from memory. This may prevent stalls in target
HW block. 

Samu Onkalo (1):
  omap: dma: Support for prefetch in destination synchronized transfer

 arch/arm/plat-omap/dma.c              |   11 +++++++----
 arch/arm/plat-omap/include/plat/dma.h |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

