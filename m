From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 2/2] omap2430: kill redundant assignments in omap2430_probe()
Date: Tue, 8 Jan 2013 22:13:40 +0300
Message-ID: <201301082213.41283.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Commit 00a0b1d58af873d842580dcac55f3b156c3a4077 (usb: musb: omap: Add device
tree support for omap musb glue) added assignments of the 'ret' variable to
-ENOMEM on *some* error paths of the calls to devm_kzalloc(), while that
variable was already pre-initialized for to that value, so these assignments
were completely redundant. Kill them, fixing overindented string, while at it.

Signed-off-by: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

---
This patch is atop of 'musb' branch of Felipe's tree.

 drivers/usb/musb/omap2430.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: usb/drivers/usb/musb/omap2430.c
===================================================================
--- usb.orig/drivers/usb/musb/omap2430.c
+++ usb/drivers/usb/musb/omap2430.c
@@ -532,15 +532,13 @@ static int __devinit omap2430_probe(stru
 		if (!pdata) {
 			dev_err(&pdev->dev,
 				"failed to allocate musb platfrom data\n");
-			ret = -ENOMEM;
 			goto err2;
 		}
 
 		data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 		if (!data) {
 			dev_err(&pdev->dev,
-					"failed to allocate musb board data\n");
-			ret = -ENOMEM;
+				"failed to allocate musb board data\n");
 			goto err2;
 		}
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
