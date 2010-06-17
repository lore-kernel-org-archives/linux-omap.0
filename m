From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v3 0/3] OMAP: DSS2: OMAPFB: Allow FB_OMAP2 to build without VRFB
Date: Thu, 17 Jun 2010 18:14:59 +0530
Message-ID: <1276778702-15280-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49711 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028Ab0FQMpO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Jun 2010 08:45:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-dev@vger.kernel.org, tony@atomide.com, tomi.valkeinen@nokia.com, hvaibhav@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy  <svadivu@ti.com>

This patch series is the same as v3 content along with the naming
conventions followed for the patch subject.

The changelog till v3 are:
	- Address Multi-omap build issue
	- Added a check to warn the wrong usage of vrfb 
	in non-vrfb omap devices.
	

Thanks,
Senthil
