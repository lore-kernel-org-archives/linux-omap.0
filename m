From: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 1/2] omap2430: fix wrong devm_kzalloc() result check
Date: Tue, 8 Jan 2013 22:11:14 +0300
Message-ID: <201301082211.14413.sshtylyov@ru.mvista.com>
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
tree support for omap musb glue) assigns result of devm_kzalloc() call to
the 'config' variable but then checks for NULL the 'data' variable (already
checked after previous call). Thus we risk a kernel oops further when data
pointed by 'config' is written to by subsequent of_property_read_u32() calls
iff the allocation happens to fail...

Signed-off-by: Sergei Shtylyov <sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

---
This patch is atop of 'musb' branch of Felipe's tree but can also be applied to
the 'fixes' branch.

 drivers/usb/musb/omap2430.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: usb/drivers/usb/musb/omap2430.c
===================================================================
--- usb.orig/drivers/usb/musb/omap2430.c
+++ usb/drivers/usb/musb/omap2430.c
@@ -545,7 +545,7 @@ static int __devinit omap2430_probe(stru
 		}
 
 		config = devm_kzalloc(&pdev->dev, sizeof(*config), GFP_KERNEL);
-		if (!data) {
+		if (!config) {
 			dev_err(&pdev->dev,
 				"failed to allocate musb hdrc config\n");
 			goto err2;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
