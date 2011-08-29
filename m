From: <mythripk@ti.com>
Subject: [PATCH v2 00/10]HDMI: Split hdmi.c in DSS to seperate OMAP dependent
Date: Mon, 29 Aug 2011 11:44:50 +0530
Message-ID: <1314598500-24005-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44196 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810Ab1H2GXM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 02:23:12 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p7T6N9js002998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 01:23:11 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p7T6N8bR021125
	for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:53:08 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

HDMI IP block is common between TI OMAP4 Procerssor and Netra processor although
the Display subsytem is different.Also the IP block in future OMAP may differ
from the one existing in OMAP4. Thus to reuse the code between these two
processors , and maintain the multi omap build functionality in DSS.
HDMI IP dependant code is seperated out from hdmi.c and moved to
new library file hdmi_ti_4xxx_ip.c.From the DSS dependent HDMI code only the
function pointer to functionality/features offered by HDMI is called.

This patch series does the split and also renames hdmi_omap4_panel.c to
hdmi_panel.c as that file has nothing specific to OMAP4 and can be reused for
other OMAP family of processors as well.

This patch series is based on Tomi's LO-DSS2 master branch.

changes since V1: Function pointer approach to call the HDMI IP functions from
DSS HDMI

Mythri P K (10):
  OMAP4: DSS: HDMI: HDMI clean up to pass base_address      dynamically
    to IP dependant functions of HDMI
  OMAP4: DSS: HDMI: Move pll and video configuration info to ip_data
    structure
  OMAP4: DSS: HDMI: Use specific HDMI timings structure instead of OMAP
    DSS timings
  OMAP4: DSS: HDMI: Move the common header file definition to
    Include/video
  OMAP4 : DSS : HDMI : Move the EDID portion from HDMI IP header
  OMAP4: DSS2: HDMI: Split the HDMI driver to DSS and IP        
    specific portion.
  OMAP4: DSS2: HDMI: Provide a wrapper API to configure      PLL and
    PHY configuration
  OMAP4: DSS2: HDMI: Function pointer approach to call      HDMI IP
    driver function from DSS
  MAP4: DSS: HDMI: Rename the functions in HDMI IP      library to IP
    specific name
  OMAP4: DSS: Rename hdmi_omap4_panel.c to hdmi_panel.c

 drivers/video/omap2/dss/Makefile                   |    2 +-
 drivers/video/omap2/dss/dss.h                      |   10 -
 drivers/video/omap2/dss/dss_features.c             |   24 +-
 drivers/video/omap2/dss/dss_features.h             |    1 +
 drivers/video/omap2/dss/hdmi.c                     |  925 +++-----------------
 drivers/video/omap2/dss/hdmi.h                     |  631 -------------
 .../omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} |    0
 drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c          |  776 ++++++++++++++++
 drivers/video/omap2/dss/hdmi_ti_4xxx_ip.h          |  582 ++++++++++++
 include/video/omapdss.h                            |   19 +
 include/video/omaphdmi.h                           |   95 ++
 11 files changed, 1642 insertions(+), 1423 deletions(-)
 delete mode 100644 drivers/video/omap2/dss/hdmi.h
 rename drivers/video/omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} (100%)
 create mode 100644 drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c
 create mode 100644 drivers/video/omap2/dss/hdmi_ti_4xxx_ip.h
 create mode 100644 include/video/omaphdmi.h

-- 
1.7.5.4

