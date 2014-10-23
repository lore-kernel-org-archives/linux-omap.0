From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH] omap2430: use MUSB_DEVCTL_BDEVICE
Date: Fri, 24 Oct 2014 00:34:12 +0400
Message-ID: <3162760.hUohyUNsZE@wasted.cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:47618 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932231AbaJWUeQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Oct 2014 16:34:16 -0400
Received: by mail-lb0-f179.google.com with SMTP id l4so1488224lbv.24
        for <linux-omap@vger.kernel.org>; Thu, 23 Oct 2014 13:34:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-omap@vger.kernel.org

The OMAP2+ MUSB glue layer still uses a bare number for the DEVCTL.B-Device bit
in one place, while there's #define MUSB_DEVCTL_BDEVICE for that.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.

 drivers/usb/musb/omap2430.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: usb/drivers/usb/musb/omap2430.c
===================================================================
--- usb.orig/drivers/usb/musb/omap2430.c
+++ usb/drivers/usb/musb/omap2430.c
@@ -162,7 +162,8 @@ static void omap2430_musb_set_vbus(struc
 			 * Wait for the musb to set as A device to enable the
 			 * VBUS
 			 */
-			while (musb_readb(musb->mregs, MUSB_DEVCTL) & 0x80) {
+			while (musb_readb(musb->mregs, MUSB_DEVCTL) &
+			       MUSB_DEVCTL_BDEVICE) {
 
 				mdelay(5);
 				cpu_relax();

