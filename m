From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v3] Provide interface for audio support in DSS
Date: Wed, 9 May 2012 22:42:31 -0500
Message-ID: <1336621352-27959-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34342 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab2EJDm6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 23:42:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

Hi,

This patch is proposed as a result of a previous discussion related to
include audio support in the DSS device driver
(http://www.spinics.net/lists/linux-omap/msg64748.html)

At the moment, this is intended to cover display technologies with audio based
on CEA-861 and IEC-60958, such as HDMI and DisplayPort. However, provisions are
made to make it extensible (see below).

These are the changes with respect to v2:

* A new enum and field is added to DSS to help implementations of the interface
  to keep track of the audio state.

These are the changes with respect to v1:

* The audio_enable and audio_start functions were split into enable/disable
  and  start/stop respectively to improve readability.
* Comments were added on whether the DSS audio functions may sleep.
* In order to make the audio configuration parameters extensible, a
  struct omap_dss_audio is defined. This helps to easily add more config
  parameters in the future if/when required (e.g., speaker order configuration).
 
BR,

Ricardo

Ricardo Neri (1):
  OMAPDSS: Provide an interface for audio support

 Documentation/arm/OMAP/DSS |   45 ++++++++++++++++++++++++++++++++++++++++++++
 include/video/omapdss.h    |   34 +++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 0 deletions(-)

-- 
1.7.5.4

