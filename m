From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v3] omapfb: dss: Handle return error in dss_init_ports.
Date: Mon, 20 Mar 2017 17:38:51 +0100
Message-ID: <1628164.x9NLckFqdM@amdc3058>
References: <CGME20170217061504epcas4p1ca29ea6ab098359de52d547c4fe7cd11@epcas4p1.samsung.com>
 <1487311827-15644-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1487311827-15644-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

On Friday, February 17, 2017 11:40:27 AM Arvind Yadav wrote:
> Here, dss_init_ports is not handling return error form
> dpi_init_port and sdi_init_port. Now dss_init_ports is returning
> always 0. And it's making below code as a dead code.
> 
> static int dss_bind(struct device *dev)
> {
>   .
>   .
>   r = dss_init_ports(pdev); //dss_init_ports will return always 0
>   if (r)// This condition will always false
>       goto err_init_ports; //Dead Code
>   .
>   .
> }
> 
> This change is to handle return error from dpi_init_port and
> sdi_init_port. Also, It will remove dead code from function 'dss_bind'.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> 
> Changes in v3:
>              -We should not stop initialization after port init fails.

This is what v2 did and v3 still does. I asked about stopping
the initialization after the first failure.

Anyway, I fixed this and queued the patch for 4.12 (the updated
version is attached to this mail for reference), thanks!

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] omapfb: dss: Handle return errors in dss_init_ports()

dss_init_ports() is not handling return errors from dpi_init_port() and
sdi_init_port(). It is also always returning 0 currently which results in
part of error handling code in dss_bind() being unused.

Fix dss_init_ports() to handle return errors from dpi_init_port() and
sdi_init_port().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: tomi.valkeinen@ti.com
[b.zolnierkie: fail early on errors, minor fixups]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/omap2/omapfb/dss/dss.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

Index: b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
===================================================================
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c	2017-03-20 17:24:24.387753929 +0100
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c	2017-03-20 17:32:32.767766228 +0100
@@ -941,11 +941,13 @@ static int dss_init_features(struct plat
 	return 0;
 }
 
+static void dss_uninit_ports(struct platform_device *pdev);
+
 static int dss_init_ports(struct platform_device *pdev)
 {
 	struct device_node *parent = pdev->dev.of_node;
 	struct device_node *port;
-	int r;
+	int r, ret = 0;
 
 	if (parent == NULL)
 		return 0;
@@ -972,17 +974,21 @@ static int dss_init_ports(struct platfor
 
 		switch (port_type) {
 		case OMAP_DISPLAY_TYPE_DPI:
-			dpi_init_port(pdev, port);
+			ret = dpi_init_port(pdev, port);
 			break;
 		case OMAP_DISPLAY_TYPE_SDI:
-			sdi_init_port(pdev, port);
+			ret = sdi_init_port(pdev, port);
 			break;
 		default:
 			break;
 		}
-	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
+	} while (!ret &&
+		 (port = omapdss_of_get_next_port(parent, port)) != NULL);
 
-	return 0;
+	if (ret)
+		dss_uninit_ports(pdev);
+
+	return ret;
 }
 
 static void dss_uninit_ports(struct platform_device *pdev)
