From: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/5] usb: musb: dsps: get resources by index
Date: Fri, 2 Nov 2012 22:02:41 +0530
Message-ID: <f7d128612330900dde4717422950fed34aae9ee9.1351870620.git.afzal@ti.com>
References: <cover.1351870620.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1351870620.git.afzal-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Santhapuri Damodar <damodar.santhapuri-l0cyMroinI0@public.gmane.org>, Ravi Babu <ravibabu-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

dsps wrapper is now dt only. This requires that resources be obtained
using index and not name, modify accordingly.

Signed-off-by: Afzal Mohammed <afzal-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 524c003..c90e4d3 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -450,22 +450,20 @@ static int __devinit dsps_create_musb_pdev(struct dsps_glue *glue, u8 id)
 	char res_name[10];
 	int ret;
 
-	/* get memory resource */
-	sprintf(res_name, "musb%d", id);
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, res_name);
+	/* first resource is for usbss, so start index from 1 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, id + 1);
 	if (!res) {
-		dev_err(dev, "%s get mem resource failed\n", res_name);
+		dev_err(dev, "failed to get memory for instance %d\n", id);
 		ret = -ENODEV;
 		goto err0;
 	}
 	res->parent = NULL;
 	resources[0] = *res;
 
-	/* get irq resource */
-	sprintf(res_name, "musb%d-irq", id);
-	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, res_name);
+	/* first resource is for usbss, so start index from 1 */
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, id + 1);
 	if (!res) {
-		dev_err(dev, "%s get irq resource failed\n", res_name);
+		dev_err(dev, "failed to get irq for instance %d\n", id);
 		ret = -ENODEV;
 		goto err0;
 	}
-- 
1.7.12

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
