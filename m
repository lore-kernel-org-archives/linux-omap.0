From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PULL] http://www.linuxtv.org/hg/~hverkuil/v4l-dvb-ng
Date: Mon, 1 Dec 2008 12:46:08 +0100
Message-ID: <200812011246.08885.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Cc: v4l <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Mauro,

Please pull from http://www.linuxtv.org/hg/~hverkuil/v4l-dvb-ng for the 
following:

- v4l2: add v4l2_device and v4l2_subdev structs to the v4l2 framework.
- v4l2-common: add i2c helper functions
- cs53l32a: convert to v4l2_subdev.
- cx25840: convert to v4l2_subdev.
- m52790: convert to v4l2_subdev.
- msp3400: convert to v4l2_subdev.
- saa7115: convert to v4l2_subdev.
- saa7127: convert to v4l2_subdev.
- saa717x: convert to v4l2_subdev.
- tuner: convert to v4l2_subdev.
- upd64031a: convert to v4l2_subdev.
- upd64083: convert to v4l2_subdev.
- vp27smpx: convert to v4l2_subdev.
- wm8739: convert to v4l2_subdev.
- wm8775: convert to v4l2_subdev.
- ivtv/ivtvfb: convert to v4l2_device/v4l2_subdev.

All points raised in reviews are addressed so I think it is time to get 
this merged so people can start to use it.

Reviewed-by: Laurent Pinchart <laurent.pinchart@skynet.be>
Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reviewed-by: Andy Walls <awalls@radix.net>
Reviewed-by: David Brownell <david-b@pacbell.net>

Once this is in I'll start on converting the other i2c drivers.

Thanks,

        Hans

diffstat:
 b/linux/Documentation/video4linux/v4l2-framework.txt |  362 ++++++++
 b/linux/drivers/media/video/v4l2-device.c            |   86 +
 b/linux/drivers/media/video/v4l2-subdev.c            |  108 ++
 b/linux/include/media/v4l2-device.h                  |  109 ++
 b/linux/include/media/v4l2-subdev.h                  |  188 ++++
 linux/drivers/media/video/Makefile                   |    2
 linux/drivers/media/video/cs53l32a.c                 |  186 ++--
 linux/drivers/media/video/cx25840/cx25840-audio.c    |   14
 linux/drivers/media/video/cx25840/cx25840-core.c     |  459 ++++++----
 linux/drivers/media/video/cx25840/cx25840-core.h     |    7
 linux/drivers/media/video/cx25840/cx25840-firmware.c |    2
 linux/drivers/media/video/cx25840/cx25840-vbi.c      |    2
 linux/drivers/media/video/ivtv/ivtv-controls.c       |   16
 linux/drivers/media/video/ivtv/ivtv-driver.c         |  220 +----
 linux/drivers/media/video/ivtv/ivtv-driver.h         |   52 -
 linux/drivers/media/video/ivtv/ivtv-fileops.c        |   44 -
 linux/drivers/media/video/ivtv/ivtv-gpio.c           |  354 +++++---
 linux/drivers/media/video/ivtv/ivtv-gpio.h           |    3
 linux/drivers/media/video/ivtv/ivtv-i2c.c            |  340 +------
 linux/drivers/media/video/ivtv/ivtv-i2c.h            |   13
 linux/drivers/media/video/ivtv/ivtv-ioctl.c          |   73 -
 linux/drivers/media/video/ivtv/ivtv-routing.c        |   12
 linux/drivers/media/video/ivtv/ivtv-streams.c        |   13
 linux/drivers/media/video/ivtv/ivtv-vbi.c            |   17
 linux/drivers/media/video/ivtv/ivtvfb.c              |   91 +-
 linux/drivers/media/video/m52790.c                   |  172 ++-
 linux/drivers/media/video/msp3400-driver.c           |  408 +++++----
 linux/drivers/media/video/msp3400-driver.h           |    7
 linux/drivers/media/video/msp3400-kthreads.c         |   34
 linux/drivers/media/video/saa7115.c                  |  829 
+++++++++----------
 linux/drivers/media/video/saa7127.c                  |  425 +++++----
 linux/drivers/media/video/saa717x.c                  |  600 
+++++++------
 linux/drivers/media/video/tuner-core.c               |  403 +++++----
 linux/drivers/media/video/upd64031a.c                |  193 ++--
 linux/drivers/media/video/upd64083.c                 |  176 ++--
 linux/drivers/media/video/v4l2-common.c              |  170 +++
 linux/drivers/media/video/vp27smpx.c                 |  134 ++-
 linux/drivers/media/video/wm8739.c                   |  198 ++--
 linux/drivers/media/video/wm8775.c                   |  217 +++-
 linux/include/media/v4l2-common.h                    |   41
 40 files changed, 4098 insertions(+), 2682 deletions(-)

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
