From: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Subject: [PATCH v2 0/2] beagle: making DVI output work again
Date: Tue,  8 Feb 2011 17:43:53 -0200
Message-ID: <1297194235-7376-1-git-send-email-ricardo.salveti@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:60272 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455Ab1BHToU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 14:44:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

Hello,

These 2 patches are basically bugfixing to make DVI work again on beagle.

Tested with Beagle-xM and C4.

Changes in v2:
* Properly defining GPIO names and values for DVI reset
* Defining mux configuration for DVI reset pin

Mathieu J. Poirier (1):
  omap3: beagle: adding regulator supply for vdds_sdi.

Ricardo Salveti de Araujo (1):
  omap3: beaglexm: fix DVI initialization

 arch/arm/mach-omap2/board-omap3beagle.c |   33 ++++++++++++++++---------------
 1 files changed, 17 insertions(+), 16 deletions(-)

-- 
1.7.2.3

