From: Andrea Scian <rnd4@dave-tech.it>
Subject: RFC: PATCH TI81xx fix MUSB software mode setting
Date: Mon, 18 Jun 2012 16:55:28 +0200
Message-ID: <4FDF4160.5040907@dave-tech.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090606060108010301080801"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx.dave-tech.it ([2.229.21.40]:44613 "EHLO mx.dave-tech.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558Ab2FRPGx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 11:06:53 -0400
Received: from [127.0.0.1] (unknown [192.168.0.126])
	by mx.dave-tech.it (Postfix) with ESMTP id 9128153
	for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 16:55:28 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------090606060108010301080801
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit


Dear all,

when configuring our platform (DM8148 based) to work with USB0 as device 
and USB1 as host I've found some problems.
It was fine if I configure both as device or both as host or enable only 
one port, but configure both in different modes lead to a not working 
configuration.
After a bit of debug I've found that probably the problem is inside 
ti81xx_musb_set_mode() because this configure the controller but does 
not set musb->board_mode. IIUC, without setting this structure the whole 
musb generic state machine does not work correctly.

Attached you can find the patch that fixed the problem on our board. I 
hope this can help others too and can be integrated inside the main tree.

Feel free to comment and tell me if I've done something wrong.

I hope the the patch format is quite correct for you.

Best Regards,


-- 

Andrea SCIAN

--------------090606060108010301080801
Content-Type: text/plain; charset=windows-1252;
 name="0001-set-board_mode-too-when-forcing-musb-mode-in-this-wa.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-set-board_mode-too-when-forcing-musb-mode-in-this-wa.pa";
 filename*1="tch"

>From d88b38b52d6561e8cee40cb7726fd4dc099fb07f Mon Sep 17 00:00:00 2001
From: Andrea Scian <andrea.scian@dave.eu>
Date: Mon, 18 Jun 2012 16:17:28 +0200
Subject: [PATCH] set board_mode too when forcing musb mode, in this way musb is initialized
 properly

---
 drivers/usb/musb/ti81xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/ti81xx.c b/drivers/usb/musb/ti81xx.c
index 22390e7..3656c74 100644
--- a/drivers/usb/musb/ti81xx.c
+++ b/drivers/usb/musb/ti81xx.c
@@ -1011,6 +1011,7 @@ int ti81xx_musb_set_mode(struct musb *musb, u8 musb_mode)
 
 	/* TODO: implement this using CONF0 */
 	if (musb_mode == MUSB_HOST) {
+		musb->board_mode = MUSB_HOST;
 		regval = musb_readl(reg_base, USB_MODE_REG);
 
 		regval &= ~USBMODE_USBID_HIGH;
@@ -1023,6 +1024,7 @@ int ti81xx_musb_set_mode(struct musb *musb, u8 musb_mode)
 			musb_readl(reg_base, USB_MODE_REG), regval);
 	} else
 	if (musb_mode == MUSB_PERIPHERAL) {
+		musb->board_mode = MUSB_PERIPHERAL;
 		/* TODO commmented writing 8 to USB_MODE_REG device
 			mode is not working */
 		regval = musb_readl(reg_base, USB_MODE_REG);
-- 
1.6.5.GIT


--------------090606060108010301080801--
