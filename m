From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/2] OMAP: hwmod: Fixes and OMAP2&3 data update
Date: Mon, 24 May 2010 23:23:12 +0200
Message-ID: <1274736194-30652-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45152 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756673Ab0EXVXT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 May 2010 17:23:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: Benoit Cousson <b-cousson@ti.com>

Add the missing braces in hwmod fw and clean the data for 
OMAP2420, 2430 and 3430.

The brace fix was tested on OMAP4 PAB.
Please note that the data changes were built for the 3 platforms
but not tested on board.

The series is based on l-o master. 

Thanks,
Benoit


Benoit Cousson (2):
  OMAP: hwmod: Fix the missing braces
  OMAP2&3: hwmod: Remove _hwmod prefix in name string

 arch/arm/mach-omap2/omap_hwmod.c           |    9 ++++++---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    8 ++++----
 4 files changed, 16 insertions(+), 13 deletions(-)

