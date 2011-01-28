From: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Subject: [PATCH 0/2] beagle: making DVI output work again
Date: Fri, 28 Jan 2011 01:49:29 -0200
Message-ID: <1296186571-22009-1-git-send-email-ricardo.salveti@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:37520 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888Ab1A1Dtr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 22:49:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

Hello,

These 2 patches are basically bugfixing to make DVI work again on beagle.

Tested with Beagle-xM and C4.

Mathieu J. Poirier (1):
  omap3: beagle: adding regulator supply for vdds_sdi.

Ricardo Salveti de Araujo (1):
  omap3: beaglexm: fix DVI initialization

 arch/arm/mach-omap2/board-omap3beagle.c |   28 ++++++++++++----------------
 1 files changed, 12 insertions(+), 16 deletions(-)

-- 
1.7.2.3

