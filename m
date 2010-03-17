From: Roger Quadros <roger.quadros@nokia.com>
Subject: [PATCHv2 0/3] OMAP: DSS2: Allow us to use SDI
Date: Wed, 17 Mar 2010 14:35:18 +0200
Message-ID: <1268829321-29769-1-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:17336 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788Ab0CQMfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 08:35:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

SDI now makes use of vdds_sdi regulator supply.
DPI can now be disabled on systems that don't have it

changes since v1:
- Incorporated review comments
- no more omap3xx checks for regulator enable/disable in SDI
- Added Kconfig option to enable/disable DPI

Roger Quadros (3):
  OMAP: DSS2: Add Kconfig option for DPI display type
  OMAP: DSS2: Remove redundant enable/disable calls from SDI
  OMAP: DSS2: Use vdds_sdi regulator supply in SDI

 drivers/video/omap2/dss/Kconfig   |    6 ++++++
 drivers/video/omap2/dss/Makefile  |    3 ++-
 drivers/video/omap2/dss/core.c    |    4 ++++
 drivers/video/omap2/dss/display.c |    4 ++++
 drivers/video/omap2/dss/sdi.c     |   26 +++++++++++++++-----------
 5 files changed, 31 insertions(+), 12 deletions(-)

