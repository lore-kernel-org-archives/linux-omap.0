From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v4 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
Date: Thu,  7 Oct 2010 14:38:52 +0530
Message-ID: <1286442535-28308-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49612 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622Ab0JGJJF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Oct 2010 05:09:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
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
