From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v2 0/6] Add camera support to the OMAP1 Amstrad Delta videophone
Date: Sat, 11 Sep 2010 03:17:53 +0200
Message-ID: <201009110317.54899.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:40200 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab0IKBTD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Sep 2010 21:19:03 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Richard Purdie <rpurdie@rpsys.net>, Discussion of the Amstrad E3 emailer hardware/software <e3-hacking@earth.li>

This set consists of the following patches:

  1/6	SoC Camera: add driver for OMAP1 camera interface
  2/6	OMAP1: Add support for SoC camera interface
  3/6	SoC Camera: add driver for OV6650 sensor
  4/6	SoC Camera: add support for g_parm / s_parm operations
  5/6	OMAP1: Amstrad Delta: add support for on-board camera
  6/6	OMAP1: Amstrad Delta: add camera controlled LEDS trigger

 arch/arm/mach-omap1/board-ams-delta.c     |   69 +
 arch/arm/mach-omap1/devices.c             |   43
 arch/arm/mach-omap1/include/mach/camera.h |    8
 drivers/media/video/Kconfig               |   14
 drivers/media/video/Makefile              |    2
 drivers/media/video/omap1_camera.c        | 1781 ++++++++++++++++++++++++++++++
 drivers/media/video/ov6650.c              | 1242 ++++++++++++++++++++
 drivers/media/video/soc_camera.c          |   18
 include/media/omap1_camera.h              |   35
 include/media/v4l2-chip-ident.h           |    1
 10 files changed, 3213 insertions(+)

