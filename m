From: Mayuresh Janorkar <mayur@ti.com>
Subject: [PATCH v2 0/7] picodlp projector driver
Date: Mon,  2 May 2011 20:22:44 +0530
Message-ID: <1304347971-1504-1-git-send-email-mayur@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56037 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759779Ab1EBOje (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 May 2011 10:39:34 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p42EdYan020794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 2 May 2011 09:39:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Mayuresh Janorkar <mayur@ti.com>

picodlp projector is supported by OMAP.
OMAP4430 SDP and EVM boards have an on board projector called as picodlp projector.
picodlp would be connected to display sub system as a display panel.
It has a dlp processor dpp2600.

The panel would be connected using 24 bit parallel interface.
It is a WVGA panel with 864 X 480 resolution.

To know more about picodlp please visit:
http://omappedia.org/wiki/PicoDLP_projector_guide

picodlp is muxed with DSI2 so we can either use secondary LCD or picodlp.
So the channel used is OMAP_DSS_CHANNEL_LCD2.

GPIO pin settings are also required and are done in board file.
Configuartion of picodlp involves passing number of commands through i2c.
All these commands are defined in a panel header file.

About DLP (Digital Light Processing):
DLP is Texas Instruments award-winning display technology which has powered
the worlds top projectors and displays, delivering pictures rich with color,
contrast, clarity and brightness to screens of all sizes.
Every DLP chip features an array of up to 2.2 million microscopic mirrors that
switch at ultra high speeds  an innovative advantage that remains cutting edge
and ideal for current and future applications alike. The results are
high-resolution, highly reliable, razor-sharp images, that even work with
fast motion video.
To learn more about DLP technology, please visit www.DLP.com

picodlp on OMAP4430 boards would make use of same technology.
picodlp makes use of i2c bus device at 0x1b address for sending configuration
commands to panel. In software picodlp panel driver has an i2c client.

To know more about picodlp configuration commands please visit:
http://focus.ti.com/lit/ug/dlpu002a/dlpu002a.pdf
The link talks more about the timing specific things:
http://focus.ti.com/lit/ds/dlps019b/dlps019b.pdf

To know more about i2c_client model please visit:
http://lxr.linux.no/#linux+v2.6.38/Documentation/i2c/writing-clients

------------------------------------------------------------------------------
These patches have been developed on top of master branch of
Tomi's gitorious tree.

I am maintaining a gitorious tree for these patches and can be found at:
http://gitorious.org/~mayuresh/linux-omap-dss2/mayuresh-picodlp/commits/picodlp

The driver has been tested when compiled as a module.

Validated with a Penguin logos on OMAP4430 SDP ES2.1

Checkpatch.pl warnings:
WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers/timers-howto.txt
I think this warning can be ignored

New compilation warnings introduced: Nil
-----------------------------------------------------------------------------

Mayuresh Janorkar (3):
  OMAP: DSS: Adding a header file for picodlp panel data
  OMAP: DSS: Add i2c client driver for picodlp
  OMAP4: DSS: Adding a picodlp in OMAP4430 SDP board file

Mythri P K (4):
  OMAP: DSS: Adding a picodlp panel header file
  OMAP: DSS: Adding a picodlp panel driver
  OMAP: DSS: Adding initialization routine to picodlp panel
  OMAP4: DSS: Adding picodlp panel entry in Kconfig and Makefile

 arch/arm/mach-omap2/board-4430sdp.c             |   40 ++
 arch/arm/plat-omap/include/plat/panel-picodlp.h |   25 +
 drivers/video/omap2/displays/Kconfig            |    7 +
 drivers/video/omap2/displays/Makefile           |    1 +
 drivers/video/omap2/displays/panel-picodlp.c    |  554 +++++++++++++++++++++++
 drivers/video/omap2/displays/panel-picodlp.h    |  287 ++++++++++++
 6 files changed, 914 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/panel-picodlp.h
 create mode 100644 drivers/video/omap2/displays/panel-picodlp.c
 create mode 100644 drivers/video/omap2/displays/panel-picodlp.h

