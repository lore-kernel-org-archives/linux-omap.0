From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH 0/2] Misc LED-related IGEPv2 patches
Date: Sun, 12 Dec 2010 19:34:54 +0100
Message-ID: <1292178894-9749-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:51174 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab0LLSeI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 12 Dec 2010 13:34:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: eballetbo@gmail.com

Hi,

Here are two small patches for the IGEPv2 board file to cleanup LED support and
configure the heartbeat LED as active low.

The second patch is valid for revision C hardware, I don't know if the LED is
active low on revision B hardware as well.

Laurent Pinchart (2):
  omap3: igepv2: Don't call gpio_set_value right after gpio_direction_output
  omap3: igepv2: LED gpio-led:green:d1 is active low

 arch/arm/mach-omap2/board-igep0020.c |   21 +++++++++------------
 1 files changed, 9 insertions(+), 12 deletions(-)

-- 
Regards,

Laurent Pinchart

