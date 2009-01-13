From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 3/3] usb: musb: fix null pointer check in
	musb_platform_init()
Date: Tue, 13 Jan 2009 12:17:39 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECF70AC7@dbde02.ent.ti.com>
References: <1231326860-22727-1-git-send-email-ajay.gupta@ti.com>
 <20090112223154.GO25493@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49863 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbZAMGsu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2009 01:48:50 -0500
In-Reply-To: <20090112223154.GO25493@frodo>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> -----Original Message-----
> From: Felipe Balbi [mailto:me@felipebalbi.com]
> Sent: Tuesday, January 13, 2009 4:02 AM
> To: Gupta, Ajay Kumar
> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; david-b@pacbell.net;
> felipe.balbi@nokia.com
> Subject: Re: [PATCH 3/3] usb: musb: fix null pointer check in musb_platform_init()
> 
> On Wed, Jan 07, 2009 at 04:44:20PM +0530, Ajay Kumar Gupta wrote:
> > Fixes kernel panic when musb is selected for OMAP35x EVM but twl4030 is not
> > selected as in this case otg_get_transceiver() returns null.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Ajay, can you update this patch so we dev_err() the absence of a
> transceiver driver ???
> 
> Thanks, besides that, you can put my s-o-b or ack

Felipe, please check if the below one is fine.

-Ajay
> --
> balbi

========================== cut here =========================================
Fixes kernel panic when musb is selected for OMAP35x EVM but twl4030 is not
selected as in this case otg_get_transceiver() returns null.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3f99536..93252c9 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -232,6 +232,10 @@ int __init musb_platform_init(struct musb *musb)
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
 #endif
+	if (!x) {
+		pr_err("omap: musb: null transceiver found\n");
+		return -ENODEV;
+	}
 
 	musb->xceiv = *x;
 	musb_platform_resume(musb);
-- 
1.5.6

