From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH] OMAPDSS: Provide interface for audio support in DSS
Date: Wed, 28 Mar 2012 15:51:55 -0600
Message-ID: <1332971516-4325-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755696Ab2C1Vxs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 17:53:48 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q2SLrlVQ020330
	for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 16:53:47 -0500
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q2SLrl7Y018259
	for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 16:53:47 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Hi,

This patch is proposed as a result of a previous discussion related to
include audio support in the DSS device driver
(http://www.spinics.net/lists/linux-omap/msg64748.html)

As discussed in the description of the patch, this is intended to cover
audio implementation based on CEA-861 and IEC-60958, such as HDMI and
DisplayPort.

This patch #includes definitions from asound.h that are not yet present,
I will be sending the patch shortly to alsa-devel.

BR,

Ricardo

Ricardo Neri (1):
  OMAPDSS: Provide interface for audio support in DSS

 Documentation/arm/OMAP/DSS |   28 ++++++++++++++++++++++++++++
 include/video/omapdss.h    |   12 ++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

