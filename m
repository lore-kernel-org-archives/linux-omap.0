From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 0/3] Fix omap_type() function
Date: Sat, 10 Jul 2010 02:08:30 -0500
Message-ID: <1278745713-31255-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59988 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751780Ab0GJHHN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jul 2010 03:07:13 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6A77AEN012637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 02:07:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

Aim was to get omap_type() function work on omap4.
In doing so, fixing an issue with is_sram_locked() function.

Patches tested/verified on omap4 sdp.
Patches based of latest linus commit: e467e10

Vikram Pandita (3):
  omap: sram: fix is_sram_locked check
  omap4: fix omap_type() function
  omap4: SRAM start and size change for EMU/HS devices

 arch/arm/plat-omap/include/plat/omap44xx.h |    2 +-
 arch/arm/plat-omap/sram.c                  |   28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

