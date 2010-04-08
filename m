From: Nishanth Menon <nm@ti.com>
Subject: [PM][PATCH 0/4] OMAP3: Serial Misc fixes
Date: Thu,  8 Apr 2010 12:54:05 -0500
Message-ID: <1270749249-14041-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45735 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932978Ab0DHRy0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 13:54:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Deepak K <deepak.k@ti.com>, Govindraj R <govindraj.raja@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <tero.kristo@nokia.com>

Hi All,

Starting off from Android kernel, found a few fixes whic have
been backported to l-o pm branch and a basic sanity tests run
against SDP3430/SDP3630.

Deepak K (1):
  OMAP3: Serial: Errata i202: fix for MDR1 access

Govindraj R (1):
  OMAP3: Serial: Add context save and restore for mcr

Nishanth Menon (2):
  OMAP3: Serial: remove initialization sparse warnings
  OMAP3: Serial: kill dev_attr_sleep_timeout sparse warn

 arch/arm/mach-omap2/serial.c |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

Regards,
Nishanth Menon

Cc: Deepak K <deepak.k@ti.com>
Cc: Govindraj R <govindraj.raja@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tero Kristo <tero.kristo@nokia.com>
