From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: video_mode_to_dss_mode
Date: Sun, 30 Dec 2012 11:30:28 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1212301122090.26072@pmeerw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43319 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194Ab2L3Kac (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 30 Dec 2012 05:30:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hello,

mode may be used uninitialized; the case 0 looks wrong (in 
drivers/media/platform/omap/omap_vout.c)

this issue was raised in May 2012 already 
(http://comments.gmane.org/gmane.linux.drivers.video-input-infrastructure/48617)

will Vaibhav submit a patch?

static int video_mode_to_dss_mode(struct omap_vout_device *vout)
{
...
	enum omap_color_mode mode;
...
	switch (pix->pixelformat) {
	case 0:
		break;
	case V4L2_PIX_FMT_YUYV:
...
	default:
		mode = -EINVAL;
	}
	return mode;

thanks, regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
