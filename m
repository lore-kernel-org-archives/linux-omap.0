From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/3]OMAP: DSS2: Abstract away DSI VC information from dsi panel drivers
Date: Mon, 28 Feb 2011 14:17:26 +0530
Message-ID: <1298882849-7432-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47100 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1B1Iox (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 03:44:53 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S8iqZs017305
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 02:44:52 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The current DSI driver design requires the DSI panel driver to specify the
DSI Virtual Channel and the Panel Virtual Channel ID for the transfer of
commands and frame data. Out of these, only the second parameter is a property
of the Panel.

The DSI Virtual Channel in use by the panel driver ideally shouldn't be provided
by the panel driver. The current design leads to the following issues:
-Multiple panels connected to the same DSI interface would be unaware of the
VC's in use.
-Hard coded Virtual Channel numbers in panel drivers which is not generic.
-No clean way of configuring DSI for panels which need atleast 2 DSI Virtual
Channels.
-No clean way of configuring DSI for the special case where a panel may have 2
or VC ID's corresponding to it.

The panel driver should, instead, request for, and release DSI Virtual Channels
through calls to the DSI driver. The DSI driver should return VC numbers which
the panel can use. The panel driver then uses this VC to either send pixel data,
send commands and receive data from the panel. The DSI driver then automatically
configures the Virtual Channel source to either Video Port or L4 Slave Port.

This patch set tries to achieve the above design, and make Panel Taal driver use
this approach.

Note:
Patches can be tested on:
http://dev.omapzoom.org/?p=axelcx/kernel-display.git;a=shortlog;h=refs/heads/lo-dss2-Feb25

Archit Taneja (3):
  OMAP: DSS2: Functions to request/release DSI VCs
  OMAP: DSS2: Use request / release calls in Taal for DSI Virtual
    Channels.
  OMAP: DSS2: Taal: Use 2 DSI Virtual Channels for Taal

 arch/arm/plat-omap/include/plat/display.h |    3 +
 drivers/video/omap2/displays/panel-taal.c |  121 +++++++++++++++++------------
 drivers/video/omap2/dss/dsi.c             |   58 ++++++++++++--
 3 files changed, 124 insertions(+), 58 deletions(-)

