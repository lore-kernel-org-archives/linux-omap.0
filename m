From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3] OMAPDSS: HDMI: Implement DSS driver interface for audio
Date: Wed, 9 May 2012 22:59:47 -0500
Message-ID: <1336622388-28183-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56191 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab2EJEBA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 00:01:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Hi,

This patch is the third version of PATCH 14 of this series:
   http://www.spinics.net/lists/linux-omap/msg69466.html

I send this patch separately to ease review, as the rest of the
patches in the series were regarded as OK by the DSS maintainer.

Changes with respect to v2:
*An improved locking strategy. The new strategy maintains an audio state
 machine. The audio state may only be transitioned if the panel is active.
 Audio can only be started if the previous state is AUDIO_ENABLED. Such state
 may only be reached if the panel is enabled. If the panel is disabled, it
 will also disable audio. As the panel and audio states are protected by
 a mutex and a spinlock, a video thread and audio thread cannot concurrently
 execute audio functions.

BR,

Ricardo


Ricardo Neri (1):
  OMAPDSS: HDMI: Implement DSS driver interface for audio

 drivers/video/omap2/dss/dss.h        |    8 ++
 drivers/video/omap2/dss/hdmi.c       |   42 ++++++++++
 drivers/video/omap2/dss/hdmi_panel.c |  140 ++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 0 deletions(-)

-- 
1.7.5.4

