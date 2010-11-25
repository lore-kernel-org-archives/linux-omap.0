From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RFC/PATCH v3 0/7] OMAP3 ISP driver
Date: Thu, 25 Nov 2010 03:54:31 +0100
Message-ID: <1290653678-15556-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:53692 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab0KYCy2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 21:54:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: sakari.ailus@maxwell.research.nokia.com

Hi everybody,

Here's the third version of the OMAP3 ISP driver patches (and the first one to
be posted to linux-omap), updated to 2.6.37-rc3 and the latest changes in the
media controller and sub-device APIs. The patches have been posted to the
linux-media mailing list minutes ago and I managed not to CC linux-omap by
mistake, sorry about that :-( Please CC the linux-media mailing list when
answering.

You can find the patches in http://git.linuxtv.org/pinchartl/media.git as
usual (media-00043-omap3isp).

The driver is in a pretty good shape now, its public API has been cleaned up
quite a lot compared to the previous submission. We still have a couple of
private ioctls that will need to change (that's on my loooooong todo list).

Laurent Pinchart (5):
  v4l: subdev: Generic ioctl support
  v4l: Remove module_name argument to the v4l2_i2c_new_subdev*
    functions
  v4l: Add subdev sensor g_skip_frames operation
  v4l: Include linux/videodev2.h in media/v4l2-ctrls.h
  OMAP3 ISP driver

Stanimir Varbanov (1):
  omap3: Export omap3isp platform device structure

Tuukka Toivonen (1):
  ARM: OMAP3: Update Camera ISP definitions for OMAP3630

 Documentation/video4linux/v4l2-framework.txt  |    5 +
 arch/arm/mach-omap2/devices.c                 |   46 +-
 arch/arm/mach-omap2/devices.h                 |   17 +
 arch/arm/plat-omap/include/plat/omap34xx.h    |   16 +-
 drivers/media/radio/radio-si4713.c            |    2 +-
 drivers/media/video/Kconfig                   |   15 +
 drivers/media/video/Makefile                  |    2 +
 drivers/media/video/au0828/au0828-cards.c     |    4 +-
 drivers/media/video/bt8xx/bttv-cards.c        |   22 +-
 drivers/media/video/cafe_ccic.c               |    2 +-
 drivers/media/video/cx18/cx18-i2c.c           |    8 +-
 drivers/media/video/cx231xx/cx231xx-cards.c   |    4 +-
 drivers/media/video/cx23885/cx23885-cards.c   |    2 +-
 drivers/media/video/cx23885/cx23885-video.c   |    4 +-
 drivers/media/video/cx88/cx88-cards.c         |    9 +-
 drivers/media/video/cx88/cx88-video.c         |    7 +-
 drivers/media/video/davinci/vpfe_capture.c    |    1 -
 drivers/media/video/davinci/vpif_capture.c    |    1 -
 drivers/media/video/davinci/vpif_display.c    |    2 +-
 drivers/media/video/em28xx/em28xx-cards.c     |   18 +-
 drivers/media/video/fsl-viu.c                 |    2 +-
 drivers/media/video/isp/Makefile              |   13 +
 drivers/media/video/isp/cfa_coef_table.h      |  601 +++++++
 drivers/media/video/isp/gamma_table.h         |   90 +
 drivers/media/video/isp/isp.c                 | 1977 ++++++++++++++++++++++
 drivers/media/video/isp/isp.h                 |  400 +++++
 drivers/media/video/isp/ispccdc.c             | 2189 +++++++++++++++++++++++++
 drivers/media/video/isp/ispccdc.h             |  220 +++
 drivers/media/video/isp/ispccp2.c             | 1100 +++++++++++++
 drivers/media/video/isp/ispccp2.h             |  101 ++
 drivers/media/video/isp/ispcsi2.c             | 1265 ++++++++++++++
 drivers/media/video/isp/ispcsi2.h             |  169 ++
 drivers/media/video/isp/ispcsiphy.c           |  246 +++
 drivers/media/video/isp/ispcsiphy.h           |   77 +
 drivers/media/video/isp/isph3a.h              |  117 ++
 drivers/media/video/isp/isph3a_aewb.c         |  356 ++++
 drivers/media/video/isp/isph3a_af.c           |  410 +++++
 drivers/media/video/isp/isphist.c             |  505 ++++++
 drivers/media/video/isp/isphist.h             |   40 +
 drivers/media/video/isp/isppreview.c          | 2091 +++++++++++++++++++++++
 drivers/media/video/isp/isppreview.h          |  214 +++
 drivers/media/video/isp/ispqueue.c            | 1135 +++++++++++++
 drivers/media/video/isp/ispqueue.h            |  184 +++
 drivers/media/video/isp/ispreg.h              | 1655 +++++++++++++++++++
 drivers/media/video/isp/ispresizer.c          | 1711 +++++++++++++++++++
 drivers/media/video/isp/ispresizer.h          |  149 ++
 drivers/media/video/isp/ispstat.c             | 1093 ++++++++++++
 drivers/media/video/isp/ispstat.h             |  168 ++
 drivers/media/video/isp/ispvideo.c            | 1199 ++++++++++++++
 drivers/media/video/isp/ispvideo.h            |  183 ++
 drivers/media/video/isp/luma_enhance_table.h  |  154 ++
 drivers/media/video/isp/noise_filter_table.h  |   90 +
 drivers/media/video/ivtv/ivtv-i2c.c           |   23 +-
 drivers/media/video/mxb.c                     |   12 +-
 drivers/media/video/pvrusb2/pvrusb2-hdw.c     |    6 +-
 drivers/media/video/s5p-fimc/fimc-capture.c   |    3 +-
 drivers/media/video/saa7134/saa7134-cards.c   |    8 +-
 drivers/media/video/saa7134/saa7134-core.c    |    4 +-
 drivers/media/video/sh_vou.c                  |    2 +-
 drivers/media/video/soc_camera.c              |    2 +-
 drivers/media/video/usbvision/usbvision-i2c.c |    6 +-
 drivers/media/video/v4l2-common.c             |   15 +-
 drivers/media/video/v4l2-subdev.c             |    2 +-
 drivers/media/video/via-camera.c              |    2 +-
 drivers/media/video/vino.c                    |    4 +-
 drivers/media/video/zoran/zoran_card.c        |    5 +-
 drivers/staging/go7007/go7007-driver.c        |    2 +-
 drivers/staging/tm6000/tm6000-cards.c         |    4 +-
 include/linux/Kbuild                          |    1 +
 include/linux/omap3isp.h                      |  631 +++++++
 include/media/v4l2-common.h                   |    9 +-
 include/media/v4l2-ctrls.h                    |    1 +
 include/media/v4l2-subdev.h                   |    4 +
 73 files changed, 20719 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm/mach-omap2/devices.h
 create mode 100644 drivers/media/video/isp/Makefile
 create mode 100644 drivers/media/video/isp/cfa_coef_table.h
 create mode 100644 drivers/media/video/isp/gamma_table.h
 create mode 100644 drivers/media/video/isp/isp.c
 create mode 100644 drivers/media/video/isp/isp.h
 create mode 100644 drivers/media/video/isp/ispccdc.c
 create mode 100644 drivers/media/video/isp/ispccdc.h
 create mode 100644 drivers/media/video/isp/ispccp2.c
 create mode 100644 drivers/media/video/isp/ispccp2.h
 create mode 100644 drivers/media/video/isp/ispcsi2.c
 create mode 100644 drivers/media/video/isp/ispcsi2.h
 create mode 100644 drivers/media/video/isp/ispcsiphy.c
 create mode 100644 drivers/media/video/isp/ispcsiphy.h
 create mode 100644 drivers/media/video/isp/isph3a.h
 create mode 100644 drivers/media/video/isp/isph3a_aewb.c
 create mode 100644 drivers/media/video/isp/isph3a_af.c
 create mode 100644 drivers/media/video/isp/isphist.c
 create mode 100644 drivers/media/video/isp/isphist.h
 create mode 100644 drivers/media/video/isp/isppreview.c
 create mode 100644 drivers/media/video/isp/isppreview.h
 create mode 100644 drivers/media/video/isp/ispqueue.c
 create mode 100644 drivers/media/video/isp/ispqueue.h
 create mode 100644 drivers/media/video/isp/ispreg.h
 create mode 100644 drivers/media/video/isp/ispresizer.c
 create mode 100644 drivers/media/video/isp/ispresizer.h
 create mode 100644 drivers/media/video/isp/ispstat.c
 create mode 100644 drivers/media/video/isp/ispstat.h
 create mode 100644 drivers/media/video/isp/ispvideo.c
 create mode 100644 drivers/media/video/isp/ispvideo.h
 create mode 100644 drivers/media/video/isp/luma_enhance_table.h
 create mode 100644 drivers/media/video/isp/noise_filter_table.h
 create mode 100644 include/linux/omap3isp.h

-- 
Regards,

Laurent Pinchart

