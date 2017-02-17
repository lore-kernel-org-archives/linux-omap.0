From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v3] omapfb: dss: Handle return error in dss_init_ports.
Date: Fri, 17 Feb 2017 11:40:27 +0530
Message-ID: <1487311827-15644-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Here, dss_init_ports is not handling return error form
dpi_init_port and sdi_init_port. Now dss_init_ports is returning
always 0. And it's making below code as a dead code.

static int dss_bind(struct device *dev)
{
  .
  .
  r = dss_init_ports(pdev); //dss_init_ports will return always 0
  if (r)// This condition will always false
      goto err_init_ports; //Dead Code
  .
  .
}

This change is to handle return error from dpi_init_port and
sdi_init_port. Also, It will remove dead code from function 'dss_bind'.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Changes in v3:
             -We should not stop initialization after port init fails.
             - Trying to get port initalization successful.
Changes in v2:
             - handle cleanup of partially initialized ports.
---
 drivers/video/fbdev/omap2/omapfb/dss/dss.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 47d7f69..2b1e5c6 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -114,6 +114,8 @@ struct dss_features {
 
 static bool dss_initialized;
 
+static void dss_uninit_ports(struct platform_device *pdev);
+
 bool omapdss_is_initialized(void)
 {
 	return dss_initialized;
@@ -946,6 +948,7 @@ static int dss_init_ports(struct platform_device *pdev)
 	struct device_node *parent = pdev->dev.of_node;
 	struct device_node *port;
 	int r;
+	int ret = 0;
 
 	if (parent == NULL)
 		return 0;
@@ -972,17 +975,24 @@ static int dss_init_ports(struct platform_device *pdev)
 
 		switch (port_type) {
 		case OMAP_DISPLAY_TYPE_DPI:
-			dpi_init_port(pdev, port);
+			ret = dpi_init_port(pdev, port);
+			if (ret)
+				continue;
 			break;
 		case OMAP_DISPLAY_TYPE_SDI:
-			sdi_init_port(pdev, port);
+			ret = sdi_init_port(pdev, port);
+			if (ret)
+				continue;
 			break;
 		default:
 			break;
 		}
 	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
 
-	return 0;
+	if (ret)
+		dss_uninit_ports(pdev);
+
+	return ret;
 }
 
 static void dss_uninit_ports(struct platform_device *pdev)
-- 
1.9.1
