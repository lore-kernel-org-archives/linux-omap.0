From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATH 0/3] ARM: OMAP1: Camera: Updates API usage and removes unused
	files
Date: Wed, 21 Nov 2007 18:23:02 -0400
Message-ID: <1195683785-32132-1-git-send-email-edubezval@gmail.com>
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
To: linux-omap-open-source@linux.omap.com
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

       This patch set updates v4l2 API usage and removes unused
files on camera code for omap1. Here is an overall description:

       There are two updates on v4l2 API usage: on the use of videobuf and
v4l2-int-device deattach.

       As the ov9640 is already moved to the v4l2-int-device API and
the camera code for omap1 too, this patch set also removes unused and
duplicated files. The info from this removed files already moved to board
specific files and to other files (see previous related patches).

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

       Here is its  overall diffstat:
 b/drivers/media/video/omap/Kconfig         |    3
 b/drivers/media/video/omap/camera_core.c   |   11
 b/drivers/media/video/omap/camera_core.h   |    3
 drivers/media/video/omap/camera_core.c     |   13
 drivers/media/video/omap/h3_sensor_power.c |   63 -
 drivers/media/video/omap/h3sensorpower.h   |   17
 drivers/media/video/omap/h4_sensor_power.c |   76 -
 drivers/media/video/omap/h4sensorpower.h   |   17
 drivers/media/video/omap/ov9640.h          |  179 ----
 drivers/media/video/omap/sensor_if.h       |   50 -
 drivers/media/video/omap/sensor_ov9640.c   | 1221 -----------------------------
 11 files changed, 14 insertions(+), 1639 deletions(-)


BR,

---
Eduardo Bezerra Valentin
OpenBossa - INdT
+55 92 21261118
