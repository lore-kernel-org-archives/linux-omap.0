From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 0/3] OMAP: DSS: Low power refresh rate support for dss
Date: Tue, 22 Dec 2009 15:07:44 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD401DA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53308 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143AbZLVJhY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 04:37:24 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


These patches add Low Power Refresh functionality for DSS.
Short info on patches

DSS PM_WKEN to refill DMA
	- DMA request to refill the FIFO will wake up the CORE domain
DSS2 LPR enable and disable function definition
	- LPR enable and disable functions implementing FIFO merge
DSS2 sysfs enteries to export LPR enable to user
	- sysfs entries for above methods

Subramani Venkatesh (3):

DSS PM_WKEN to refill DMA
DSS2 LPR enable and disable function definition
DSS2 sysfs enteries to export LPR enable to user

arch/arm/mach-omap2/pm34xx.c      |    5 ++
drivers/video/omap2/dss/dispc.c   |  132 +++++++++++++++++++++++++++++++++++++
drivers/video/omap2/dss/display.c |   25 +++++++
3 files changed, 162 insertions(+), 0 deletions(-)

Regards,
Kishore Y
Ph:- +918039813085

