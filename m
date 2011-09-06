From: Mans Rullgard <mans.rullgard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] ASoC: omap: add MODULE_ALIAS to mcbsp and pcm drivers
Date: Tue,  6 Sep 2011 21:14:16 +0100
Message-ID: <1315340056-32148-1-git-send-email-mans.rullgard@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This adds MODULE_ALIAS directives to the omap-mcbsp-dai and
omap-pcm-audio drivers so they can be auto-loaded when platform
devices are scanned.

Signed-off-by: Mans Rullgard <mans.rullgard-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 sound/soc/omap/omap-mcbsp.c |    2 ++
 sound/soc/omap/omap-pcm.c   |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 07b7723..56b7504 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -758,6 +758,8 @@ static int __devexit asoc_mcbsp_remove(struct platform_device *pdev)
 	return 0;
 }
 
+MODULE_ALIAS("platform:omap-mcbsp-dai");
+
 static struct platform_driver asoc_mcbsp_driver = {
 	.driver = {
 			.name = "omap-mcbsp-dai",
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index e6a6b99..6c85b69 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -412,6 +412,8 @@ static int __devexit omap_pcm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+MODULE_ALIAS("platform:omap-pcm-audio");
+
 static struct platform_driver omap_pcm_driver = {
 	.driver = {
 			.name = "omap-pcm-audio",
-- 
1.7.6.1
