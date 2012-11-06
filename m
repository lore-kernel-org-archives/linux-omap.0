From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3 0/7] Create platform device for audio support
Date: Tue, 6 Nov 2012 00:19:10 -0600
Message-ID: <1352182757-1216-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54615 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751254Ab2KFFVt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 00:21:49 -0500
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id qA65LmO1001767
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:48 -0600
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id qA65LmGD016068
	for <linux-omap@vger.kernel.org>; Mon, 5 Nov 2012 23:21:48 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: peter.ujfalusi@ti.com, s-guiriec@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Hi Tomi, l-o list,

The main purpose of this patch set is to create a platform device for audio
support from the OMAPDSS HDMI driver. This tries to follow an approach similar
to MFD drivers in which a core driver creates domain-specific devices. Under
this approach, the OMAPDSS HDMI drivers acts as the core driver, retrieves its
resources (from DT or hwmod) and passes the relevant audio resources for
other drivers to use.

This is also beneficial for future DT boot support, as the OMAP HDMI IP will be
represented by a single node in the tree.

Before creating the platform device for audio, I also did minor cleanup to the
OMAPDSS HDMI driver probe function.

Changes from v2:
*Check the validity of the audio platform device by checking a non-NULL condition
 rather than an error pointer condition.
*Pass the ID of the HDMI platform device to handle more than one instance of
 HDMI audio platform devices. This is for future implementations that support
 more than one HDMI output.

Changes from v1:
*Simplify ioremap further by using devm_request_and_ioremap.
*Pass to the audio driver only the DMA port and not the whole register space.
*Use a local array for the audio resources and init them with DEFINE_RES_MEM.
*Obtain the DMA port address offset and size from the HDMI IP-specific library.

v2 is accessible here:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg79529.html

v1 is accessible here:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg77861.html

BR,

Ricardo

Ricardo Neri (7):
  OMAPDSS: HDMI: Rename resource variable at probe.
  OMAPDSS: HDMI: Convert to devm_request_and_ioremap
  OMAPDSS: HDMI: Make panel return dssdev register errors
  OMAPDSS: HDMI: Handle panel init error at probe
  OMAPDSS: HDMI: Uninit display on device add error
  OMAPDSS: HDMI: Add op to get audio DMA port address offset
  OMAPDSS: HDMI: Create platform device for audio support

 drivers/video/omap2/dss/dss_features.c    |    1 +
 drivers/video/omap2/dss/hdmi.c            |   90 +++++++++++++++++++++++++----
 drivers/video/omap2/dss/hdmi_panel.c      |    4 +-
 drivers/video/omap2/dss/ti_hdmi.h         |    3 +
 drivers/video/omap2/dss/ti_hdmi_4xxx_ip.c |    9 +++
 5 files changed, 93 insertions(+), 14 deletions(-)

-- 
1.7.5.4

