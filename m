From: Archit Taneja <archit@ti.com>
Subject: [PATCH 0/3] OMAP: DSS2: DISPC register definition clean up
Date: Fri,  6 May 2011 11:45:48 +0530
Message-ID: <1304662551-23832-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35759 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938Ab1EFGLD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 May 2011 02:11:03 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p466B2wN012383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 6 May 2011 01:11:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

With more overlays and overlay managers on OMAP4, and more coming in future
OMAPs, the current way of defining the DISPC overlay and manager register
offsets through macros isn't scalable. Introduce a new dispc.h header which
contains Macros for common DISPC registers and inline functions for overlay and
manager specific registers. Remove usage of struct dispc_reg and use u16
instead.

Note:
Can be tried on:

https://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone/commits/master

Tested on: 4430sdp and 3430sdp.

Archit Taneja (3):
  OMAP: DSS2: Clean up DISPC overlay register definitions
  OMAP: DSS2: Clean up DISPC overlay manager register definitions
  OMAP: DSS2: Remove usage of struct dispc_reg

 drivers/video/omap2/dss/dispc.c | 1086 +++++++++++++++++---------------------
 drivers/video/omap2/dss/dispc.h |  544 ++++++++++++++++++++
 2 files changed, 1030 insertions(+), 600 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dispc.h

