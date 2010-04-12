From: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] omap2_mcspi: change default
	DMA_MIN_BYTES value to 160
Date: Mon, 12 Apr 2010 12:07:54 +0300
Message-ID: <1271063274-13222-1-git-send-email-roman.tereshonkov@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: juuso.oikarinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, glikely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, imre.deak-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, samuel.ortiz-EmnPodGKVbzby3iVrkZq2A@public.gmane.org, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The value 160 has been obtained as optimal in testing it for
wl1271 which use spi for communication.
In some sense this change might also influence on other spi devices
connected to omap2_mcspi controller.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/omap2_mcspi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index a9d58ce..d24a05e 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -112,7 +112,7 @@ struct omap2_mcspi_dma {
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
  * cache operations; better heuristics consider wordsize and bitrate.
  */
-#define DMA_MIN_BYTES			8
+#define DMA_MIN_BYTES			160
 
 
 struct omap2_mcspi {
-- 
1.6.2.rc1.3.g81d3f


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
