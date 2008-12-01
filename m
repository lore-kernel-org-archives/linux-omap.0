From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PULL] http://www.linuxtv.org/hg/~hverkuil/v4l-dvb
Date: Mon, 1 Dec 2008 14:51:06 +0100
Message-ID: <200812011451.06156.hverkuil@xs4all.nl>
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
Cc: v4l <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sakari Ailus <sakari.ailus@nokia.com>, Mauro Carvalho Chehab <mchehab@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Mauro,

Please pull from http://www.linuxtv.org/hg/~hverkuil/v4l-dvb for the 
following:

- omap2: add OMAP2 camera driver.

Thanks,

        Hans

diffstat:
 b/linux/drivers/media/video/omap24xxcam-dma.c |  601 ++++++++
 b/linux/drivers/media/video/omap24xxcam.c     | 1908 
++++++++++++++++++++++++++
 b/linux/drivers/media/video/omap24xxcam.h     |  593 ++++++++
 linux/drivers/media/video/Kconfig             |    7
 linux/drivers/media/video/Makefile            |    3
 5 files changed, 3112 insertions(+)

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
