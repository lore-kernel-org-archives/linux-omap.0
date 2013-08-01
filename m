From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [FAILURE] drivers/video/omap2/displays-new/connector-analog-tv.c
Date: Thu, 1 Aug 2013 20:19:04 +0100
Message-ID: <20130801191903.GC23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39606 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755862Ab3HATTe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Aug 2013 15:19:34 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Last couple of 4430SDP randconfig build attempts had this error in
common:

drivers/video/omap2/displays-new/connector-analog-tv.c: In function 'tvc_probe':
drivers/video/omap2/displays-new/connector-analog-tv.c:215:19: error: 'omap_dss_pal_timings' undeclared (first use in this function)

#ifdef CONFIG_OMAP2_DSS_VENC
/* Hardcoded timings for tv modes. Venc only uses these to
 * identify the mode, and does not actually use the configs
 * itself. However, the configs should be something that
 * a normal monitor can also show */
extern const struct omap_video_timings omap_dss_pal_timings;
extern const struct omap_video_timings omap_dss_ntsc_timings;
#endif

# CONFIG_OMAP2_DSS_VENC is not set

Maybe some required dependencies are missing?
