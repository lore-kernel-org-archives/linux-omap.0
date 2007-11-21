From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATH 0/2] ARM: OMAP2: Camera: Fixes compile errors and adds little
	improvements
Date: Wed, 21 Nov 2007 12:43:49 -0400
Message-ID: <1195663431-20390-1-git-send-email-edubezval@gmail.com>
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
Cc: Eduardo Valentin <eduardo.valentin@indt.org.br>, Sakari Ailus <sakari.ailus@nokia.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi All,

       This patch set fixes compile erros and adds little improvements
camera code for omap2. Here is the overall description:

V4l2:
- Updates this camera driver to use correctly the new videobuf API.
Corrently, changed to use videobuf_gen and videobuf_dma_sg.
- Removed VIDEO_BUF reference from Kconfig.

S/G:
- Update this code to sg_* helper functions.

ov9640:
- Removes unecessary structures and functions when config OV9640
is not selected.
- Reduces powerset code for ov9640.

Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>

Overall diffstat:

 arch/arm/mach-omap2/board-h4.c    |   71 +++++++++++---------------------------
 drivers/media/video/Kconfig       |    3 +
 drivers/media/video/omap24xxcam.c |   68 +++++++++++++++++++-----------------
 drivers/media/video/omap24xxcam.h |    3 -
 4 files changed, 61 insertions(+), 84 deletions(-)
