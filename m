From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/2] Fix/Clean regulator consumer mapping for 3430sdp
Date: Thu,  3 Feb 2011 18:15:20 +0530
Message-ID: <1296737122-20765-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59653 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751017Ab1BCMpb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 07:45:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Rajendra Nayak <rnayak@ti.com>

This is a short series to fix some, and clean the
existing regulator consumer supply mappings for
the OMAP3430sdp board.

The series is boot tested on the 3430sdp board
and applies on 2.6.38-rc3.

Changes in v2:
Define regulator_consumer_supply as array's
and use ARRAY_SIZE macro to define
num_consumer_supplies

Rajendra Nayak (2):
  omap3sdp: Fix regulator mapping for ads7846 TS controller
  omap3sdp: clean regulator supply mapping in board file

 arch/arm/mach-omap2/board-3430sdp.c |   78 +++++++++++++++++------------------
 1 files changed, 38 insertions(+), 40 deletions(-)

