From: Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC][PATCH 0/6] OMAP1: CAMERA: Converts omap1 camera to use
	v4l2-int-device api
Date: Tue,  9 Oct 2007 08:52:27 -0400
Message-ID: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-mailing-list <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi all,

This patch set converts omap1 camera to use v4l2-int-device api. It was
tested on H3 with ov9640 sensor, so board-h3.c was modified to add ov9640
specific initializations. The gpio-expander code was modified also to use
the i2c adapter id configured with i2c board specific info. Currently, it is
working only with read method. To work with MMAP, camera_core.c needs more
re-work.

Here is the overall diffstat:
 b/arch/arm/mach-omap1/board-h3.c         |  141 +++++++++
 b/drivers/i2c/chips/gpio_expander_omap.c |    5
 b/drivers/media/video/omap/Kconfig       |    6
 b/drivers/media/video/omap/Makefile      |    4
 b/drivers/media/video/omap/camera_core.c |  394 ++++++++++++++++++---------
 b/drivers/media/video/omap/camera_core.h |   27 -
 b/drivers/media/video/omap/omap16xxcam.c |  442 +++++++++++++++----------------
 drivers/media/video/omap/camera_core.c   |  404 +++++++++++++---------------
 8 files changed, 827 insertions(+), 596 deletions(-)

BR,

Eduardo Valentin
