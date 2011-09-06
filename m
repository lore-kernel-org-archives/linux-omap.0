From: <mythripk@ti.com>
Subject: [PATCH v4 00/11] HDMI: Split hdmi.c in DSS to seperate OMAP dependent
Date: Tue, 6 Sep 2011 17:28:44 +0530
Message-ID: <1315310335-26054-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52217 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590Ab1IFMHG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 08:07:06 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p86C72dl014481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Sep 2011 07:07:04 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p86C70g4001244
	for <linux-omap@vger.kernel.org>; Tue, 6 Sep 2011 17:37:01 +0530 (IST)
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

changes since
v3:Handle the sparse error for set_pll_pwr function
Move audio functions out of hdmi.c to ip file.
rename hdmi_data to ip_data 
V2: Rename certain files/function to have standard format and handle scenario
when hdmi is disabled.
V1: Function pointer approach to call the HDMI IP functions from DSS HDMI

Mythri P K (11):
  OMAP4: DSS: HDMI: HDMI clean up to pass base_address dynamically to
    IP dependant functions of HDMI
  OMAP4: DSS: HDMI: Move pll and video configuration info to ip_data
    structure
  OMAP4: DSS: HDMI: Use specific HDMI timings structure instead of OMAP
    DSS timings
  OMAP4: DSS: HDMI: Move IP independent common header file definition
    to generic header file
  OMAP4 : DSS : HDMI : Move the EDID portion from HDMI IP header
  OMAP4: DSS2: HDMI: Split the HDMI driver to DSS and IP          
    specific portion.
  OMAP4: DSS2: HDMI: Move the HDMI IP dependent audio functions to IP
    library
  OMAP4: DSS: HDMI: Rename the functions in HDMI IP      library to IP
    specific name
  OMAP4: DSS: HDMI: Move the common HDMI header file      definition to
    Include/video
  OMAP4: DSS2: HDMI: Function pointer approach to call HDMI IP driver
    function from DSS
  OMAP4: DSS: Rename hdmi_omap4_panel.c to hdmi_panel.c

 drivers/video/omap2/dss/Makefile                   |    2 +-
 drivers/video/omap2/dss/dss.h                      |   10 -
 drivers/video/omap2/dss/dss_features.c             |   20 +
 drivers/video/omap2/dss/dss_features.h             |    3 +
 drivers/video/omap2/dss/hdmi.c                     | 1027 ++------------------
 drivers/video/omap2/dss/hdmi.h                     |  631 ------------
 .../omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} |    2 +-
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c          | 1032 ++++++++++++++++++++
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h          |  597 +++++++++++
 include/video/omapdss.h                            |   23 +
 include/video/ti_hdmi.h                            |  103 ++
 11 files changed, 1851 insertions(+), 1599 deletions(-)
 delete mode 100644 drivers/video/omap2/dss/hdmi.h
 rename drivers/video/omap2/dss/{hdmi_omap4_panel.c => hdmi_panel.c} (99%)
 create mode 100644 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c
 create mode 100644 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.h
 create mode 100644 include/video/ti_hdmi.h

-- 
1.7.5.4

