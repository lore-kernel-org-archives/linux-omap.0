From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH 0/6] Add support for Sony imx046 sensor.
Date: Thu, 29 Jan 2009 18:53:17 -0600
Message-ID: <200901291853.17775.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49799 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370AbZA3Axj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Jan 2009 19:53:39 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, video4linux-list@redhat.com
Cc: greg.hofer@hp.com

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH 0/6] Add support for Sony imx046 sensor.

This set of patches adds support for the Sony IMX046 camera.

Driver supports:
 - Sensor output format RAW10 (YUV conversion through CCDC)
 - Base output resolutions:
    - 3280x2464 @ 7.5fps  (8MP)
    - 3280x616  @ 7.5fps
    - 820x616   @ 30fps
 - Exposure & Gain control
 - Platforms: SDP3430 & Zoom2

thanks
dom
