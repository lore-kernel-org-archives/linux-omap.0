From: Todd Poynor <tpoynor@mvista.com>
Subject: Fix audio driver miscompile
Date: Fri, 2 Dec 2005 20:17:38 -0800
Message-ID: <20051203041738.GA24673@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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
List-Id: linux-omap@vger.kernel.org

Fix OMAP audio miscompile.

---
commit b20b0ffcf86bcd9d814833f11b8989586ee122e2
tree 51a5bf7a592529abb4d3319131d3e56a207c65dc
parent 279a7045accc927dbb2b1d41691424c4d345489c
author Todd Poynor <tpoynor@mvista.com> Fri, 02 Dec 2005 20:16:19 -0800
committer Todd Poynor <tpoynor@mvista.com> Fri, 02 Dec 2005 20:16:19 -0800

 sound/oss/omap-audio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/oss/omap-audio.c b/sound/oss/omap-audio.c
index 523dffd..3885700 100644
--- a/sound/oss/omap-audio.c
+++ b/sound/oss/omap-audio.c
@@ -360,7 +360,7 @@ static int audio_suspend(struct platform
  * audio_resume(): Function to handle resume operations
  *
  *********************************************************************************/
-static int audio_resume(struct platform_device *dev)
+static int audio_resume(struct platform_device *pdev)
 {
 	int ret = 0;
 
