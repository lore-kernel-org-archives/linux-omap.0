From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: fix CONFIGDATA register read issue
Date: Tue, 28 Jul 2009 11:46:03 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940432A6DCEA@dbde02.ent.ti.com>
References: <1246858408-24953-1-git-send-email-ajay.gupta@ti.com>
 <ce9ab5790907272306g40bb2447m32e976573a33e992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33060 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbZG1GQX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Jul 2009 02:16:23 -0400
In-Reply-To: <ce9ab5790907272306g40bb2447m32e976573a33e992@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimal.newwork@gmail.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gadiyar, Anand" <gadiyar@ti.com>, "gregkh@suse.de" <gregkh@suse.de>

> > INDEX register has to be set to '0' before reading
> > CONFIGDATA register which is only present in TI musb
> > platforms.
> >
> > Currently the default register access mode is set to
> > FLAT_MODE thus INDEX register is not getting set
> > properly with musb_ep_select() which is just a nop
> > operation in FLAT_MODE.This invalid register read is
> > causing module reinset failure.
> >
> > Fixing the issue by moving INDEX register write part to
> > musb_read_configdata() function itself.
> >
> > Signed-off-by: Vikram Pandita <vikram.pandita at ti.com>
> 
> Please correct the e-mail address above.
> 

Here it is with correct mail id and David's "Acked-by".

--Ajay

==================cut here ==========================================
INDEX register has to be set to '0' before reading
CONFIGDATA register which is only present in TI musb
platforms.

Currently the default register access mode is set to
FLAT_MODE thus INDEX register is not getting set
properly with musb_ep_select() which is just a nop
operation in FLAT_MODE.This invalid register read is
causing module reinset failure.

Fixing the issue by moving INDEX register write part to
musb_read_configdata() function itself.

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
---
Based on a previous patch from Anand at,
http://marc.info/?l=linux-omap&m=122051303604377&w=2

Another version of this fix by Vikram is at,
http://linux.omap.com/pipermail/linux-omap-open-source/2007-November/012084.html

 drivers/usb/musb/musb_core.c |    1 -
 drivers/usb/musb/musb_regs.h |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 554a414..3ec68a1 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1326,7 +1326,6 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 	int		i;
 
 	/* log core options (read using indexed model) */
-	musb_ep_select(mbase, 0);
 	reg = musb_read_configdata(mbase);
 
 	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
index de3b2f1..fbfd3fd 100644
--- a/drivers/usb/musb/musb_regs.h
+++ b/drivers/usb/musb/musb_regs.h
@@ -323,6 +323,7 @@ static inline void  musb_write_rxfifoadd(void __iomem *mbase, u16 c_off)
 
 static inline u8 musb_read_configdata(void __iomem *mbase)
 {
+	musb_writeb(mbase, MUSB_INDEX, 0);
 	return musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
 }
 
-- 
1.6.2.4
