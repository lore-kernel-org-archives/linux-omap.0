From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 0/3]OMAP: DSS2: Abstract away DSI VC information from dsi panel drivers
Date: Tue,  1 Mar 2011 18:02:19 +0530
Message-ID: <1298982743-6771-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54427 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233Ab1CAM3g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 07:29:36 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p21CTaIs022110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Mar 2011 06:29:36 -0600
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

Archit Taneja (3):
  OMAP: DSS2: Functions to request/release DSI VCs
  OMAP: DSS2: Taal: Use 2 DSI Virtual Channels for Taal
  OMAP: DSS2: Taal: Use 2 DSI Virtual Channels for Taal

 arch/arm/plat-omap/include/plat/display.h |    3 +
 drivers/video/omap2/displays/panel-taal.c |  145 ++++++++++++++++++----------
 drivers/video/omap2/dss/dsi.c             |   61 +++++++++++--
 3 files changed, 149 insertions(+), 60 deletions(-)
--
v2:
-Fix the request_vc/release_vc functions to correctly allocate Virtual Channels
-Add function omap_dsi_set_vc_id to set the VC_ID for a given Virtual Channel

