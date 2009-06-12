From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] adding back some features
Date: Fri, 12 Jun 2009 15:11:31 -0700
Message-ID: <1244844693-24126-1-git-send-email-khilman@ti.deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:36154 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934434AbZFLWLe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 18:11:34 -0400
Received: by pzk17 with SMTP id 17so811108pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 15:11:35 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.deeprootsystems.com>

Here's a couple patches to add-back some feature dropped in the
mainline sync.  These are needed for the PM branch among other things.

Applies to linux-omap master.

Kevin

Kalle Jokiniemi (1): OMAP3: DMA: Enable idlemodes for DMA OCP

Kevin Hilman (1):
  OMAP2/3: SoC IDs: add omap_type() for determining GP/EMU/HS

 arch/arm/mach-omap2/id.c              |   22 ++++++++++++++++++++++
 arch/arm/plat-omap/dma.c              |   13 +++++++++++++
 arch/arm/plat-omap/include/mach/dma.h |   15 +++++++++++++++
 3 files changed, 50 insertions(+), 0 deletions(-)

