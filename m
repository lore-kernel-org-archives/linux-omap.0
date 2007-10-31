From: jarkko.nikula@nokia.com
Subject: [PATCH 2/3] CBUS: Manage bias voltage in retu-headset
	suspend/resume code
Date: Wed, 31 Oct 2007 14:04:41 +0200
Message-ID: <1193832282-10044-3-git-send-email-jarkko.nikula@nokia.com>
References: <1193832282-10044-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1193832282-10044-1-git-send-email-jarkko.nikula@nokia.com>
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

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/cbus/retu-headset.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index ac21394..7f3f808 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -288,11 +288,21 @@ static int retu_headset_remove(struct platform_device *pdev)
 static int retu_headset_suspend(struct platform_device *pdev,
 				pm_message_t mesg)
 {
+	struct retu_headset *hs = platform_get_drvdata(pdev);
+
+	if (hs->bias_enabled)
+		retu_headset_set_bias(0);
+
 	return 0;
 }
 
 static int retu_headset_resume(struct platform_device *pdev)
 {
+	struct retu_headset *hs = platform_get_drvdata(pdev);
+
+	if (hs->bias_enabled)
+		retu_headset_set_bias(1);
+
 	return 0;
 }
 
-- 
1.5.3.4
