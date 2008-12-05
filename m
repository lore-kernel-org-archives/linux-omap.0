From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PULL] http://www.linuxtv.org/hg/~hverkuil/v4l-dvb
Date: Fri, 5 Dec 2008 14:43:06 +0100
Message-ID: <200812051443.06154.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:1906 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbYLENpI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Dec 2008 08:45:08 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, davinci-linux-open-source-bounces@linux.davincidsp.com, "Hiremath, Vaibhav" <hvaibhav@ti.com>, v4l <video4linux-list@redhat.com>

Hi Mauro,

Please pull from http://www.linuxtv.org/hg/~hverkuil/v4l-dvb for the 
following:

- omap2: add OMAP2 camera driver.
- v4l2-int-if: add three new ioctls for std handling and routing
- v4l: add new tvp514x I2C video decoder driver

Thanks to Nokia and TI for these drivers!

Regards,

        Hans

diffstat:
 b/linux/drivers/media/video/omap24xxcam-dma.c |  601 ++++++++
 b/linux/drivers/media/video/omap24xxcam.c     | 1908 
++++++++++++++++++++++++++
 b/linux/drivers/media/video/omap24xxcam.h     |  593 ++++++++
 b/linux/drivers/media/video/tvp514x.c         | 1569 
+++++++++++++++++++++
 b/linux/drivers/media/video/tvp514x_regs.h    |  297 ++++
 b/linux/include/media/tvp514x.h               |  118 +
 linux/drivers/media/video/Kconfig             |   18
 linux/drivers/media/video/Makefile            |    4
 linux/include/media/v4l2-int-device.h         |    6
 9 files changed, 5114 insertions(+)

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
