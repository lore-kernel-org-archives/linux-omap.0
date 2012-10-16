From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 0/6] Create platform device for audio support
Date: Mon, 15 Oct 2012 20:27:13 -0500
Message-ID: <1350350839-30408-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44014 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755486Ab2JPB3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 21:29:43 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q9G1TgOG007234
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:42 -0500
Received: from DFLE72.ent.ti.com (dfle72.ent.ti.com [128.247.5.109])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q9G1TgUO015130
	for <linux-omap@vger.kernel.org>; Mon, 15 Oct 2012 20:29:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-guiriec@ti.com, peter.ujfalusi@ti.com, b-cousson@ti.com, linux-omap@vger.kernel.org, Ricardo Neri <ricardo.neri@ti.com>

Hi Tomi, l-o list,

The main purpose of this patch set is to create a platform device for audio
support from the OMAPDSS HDMI driver. This follows an approach similar to MFD
drivers in which a core driver creates domain-specific devices. Under this
approach, the OMAPDSS HDMI drivers as the core driver, retrieves its resources
(from DT or hwmod) and passes them to the platform device for audio for other
drivers to use (e.g., ASoC).

This is also beneficial for future DT boot support, as the OMAP HDMI IP will be
represented by a single node in the tree.

Before creating the platform device for audio, I also did minor cleanup to the
OMAPDSS HDMI driver probe.

BR,

Ricardo

Ricardo Neri (6):
  OMAPDSS: HDMI: Rename resource variable at probe.
  OMAPDSS: Convert to devm_ioremap
  OMAPDSS: HDMI: Make panel return error if cannot register driver
  OMAPDSS: HDMI: Uninit display if unable to register device
  OMAPDSS: HDMI: Handle error when initing the display at probe
  OMAPDSS: HDMI: Create platform device to support audio.

 drivers/video/omap2/dss/hdmi.c       |  101 ++++++++++++++++++++++++++++++----
 drivers/video/omap2/dss/hdmi_panel.c |    4 +-
 2 files changed, 91 insertions(+), 14 deletions(-)

-- 
1.7.5.4

