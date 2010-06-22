From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v4 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
Date: Tue, 22 Jun 2010 17:27:04 +0530
Message-ID: <1277207827-15833-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59104 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756449Ab0FVL5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 07:57:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy  <svadivu@ti.com>

Please ignore the previous v3 and consider v4.

The changelog till v4 are:
	- Address Multi-omap build issue
	- Added a check to warn the wrong usage of vrfb 
	in non-vrfb omap devices.
	- The patch subject is as per the naming conventions
	- patch 2/3 now has the changes in omap2/omapfb/Kconfig
	instead of omap2/Kconfig.  The functional effect remains
	the same, and the place of implementation is more appropriate.
	

Thanks,
Senthil
