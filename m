From: Sukumar Ghorai <s-ghorai@ti.com>
Subject: [PATCH] nand support on omap3 boards
Date: Tue, 13 Apr 2010 23:07:21 +0530
Message-ID: <1271180246-31779-10-git-send-email-s-ghorai@ti.com>
References: <Sukumar Ghorai <s-ghorai@ti.com>
 <1271180246-31779-1-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-2-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-3-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-4-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-5-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-6-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-7-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-8-git-send-email-s-ghorai@ti.com>
 <1271180246-31779-9-git-send-email-s-ghorai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56860 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab0DMRhe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 13:37:34 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o3DHbVCV011052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Apr 2010 12:37:33 -0500
In-Reply-To: <1271180246-31779-9-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sukumar Ghorai <s-ghorai@ti.com>

   The following set of patches applies on top of the Tony's master branch. 
   And dependency on following series of patch -


Sukumar Ghorai (3):
  omap3: GPMC register definition at common location
  omap3: NAND Prefetch in IRQ mode support
  omap-3630 NAND: enable NAND io in prefetch-irq mode
  omap: NAND: ecc layout select from board file
  omap: NAND: Making ecc layout as compatible with romcode ecc

