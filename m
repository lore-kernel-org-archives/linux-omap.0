From: Roger Quadros <roger.quadros@nokia.com>
Subject: [RFC][PATCH 0/3] OMAP: DSS2: Allow us to use SDI
Date: Fri, 12 Mar 2010 17:27:21 +0200
Message-ID: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:41351 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934310Ab0CLP22 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Mar 2010 10:28:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

I want to get DSS2 working on N900. N900 requires SDI.

Technically we should be able to use SDI without having DSI
regulators enabled.
Thes patches also add the vdds_sdi supply support to SDI.

NOTE: I cannot yet confirm that SDI was working or will work with this.

---
Roger Quadros (3):
  OMAP: DSS2: Do regulator stuff in dpi_init_display()
  OMAP: DSS2: Prevent recursive Panel Enable/Disable calls from SDI
  OMAP: DSS2: Use vdds_sdi regulator supply in SDI

 drivers/video/omap2/dss/dpi.c |   10 +++++-----
 drivers/video/omap2/dss/sdi.c |   32 +++++++++++++++++++++-----------
 2 files changed, 26 insertions(+), 16 deletions(-)

