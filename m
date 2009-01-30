From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH v2 0/6] Add support for Sony imx046 sensor.
Date: Fri, 30 Jan 2009 17:45:40 -0600
Message-ID: <200901301745.40837.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45593 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756775AbZA3Xps (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Jan 2009 18:45:48 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>
Cc: greg.hofer@hp.com

From: Dominic Curran <dcurran@ti.com>
Subject: [OMAPZOOM][PATCH v2 0/6] Add support for Sony imx046 sensor.

This set of patches adds support for the Sony IMX046 camera.

Submitting version 2 with comments from:
 - Vaibhav Hiremath
 - Hans Verkuil

Driver supports:
 - Sensor output format RAW10 (YUV conversion through CCDC)
 - Output resolution 
    - 3280x2464 @ 7.5fps  (8MP)
    - 3280x616
    - 820x616   @ 30fps
 - Frame rate control
 - Exposure & Gain control
 - Platforms: SDP3430 & Zoom2

thanks
dom
