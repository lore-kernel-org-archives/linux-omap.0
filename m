From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 1/7] usb: musb: Add context save and restore support
Date: Fri, 22 Jan 2010 20:33:33 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703007F229A@dbde02.ent.ti.com>
References: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
 <1264080838-9452-2-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45190 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab0AVPDs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 10:03:48 -0500
In-Reply-To: <1264080838-9452-2-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "Gadiyar, Anand" <gadiyar@ti.com>

Ajay/Felipe
Off usb list not to interfere with your merge req to Gregkh

>-----Original Message-----
>From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Felipe
>Balbi
>Sent: Thursday, January 21, 2010 7:34 AM
>To: Greg KH
>Cc: Linux USB Mailing List; Linux OMAP Mailing List; Gupta, Ajay Kumar; Gadiyar, Anand; Felipe Balbi
>Subject: [PATCH 1/7] usb: musb: Add context save and restore support
>Importance: High
>
>From: Ajay Kumar Gupta <ajay.gupta@ti.com>
>
>Adding support for MUSB register save and restore during system
>suspend and resume.
>
>Changes:
>        - Added musb_save/restore_context() functions
>        - Added platform specific musb_platform_save/restore_context()
>          to handle platform specific jobs.
>        - Maintaining BlackFin compatibility by adding read/write
>          functions for registers which are not available in BlackFin
>
>Tested system suspend and resume on OMAP3EVM board.
>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
>---
> drivers/usb/musb/musb_core.c |  146 ++++++++++++++++++++++++++++++++++++++++++
> drivers/usb/musb/musb_core.h |   39 +++++++++++
> drivers/usb/musb/musb_regs.h |   90 ++++++++++++++++++++++++++
> drivers/usb/musb/omap2430.c  |   16 +++++
> 4 files changed, 291 insertions(+), 0 deletions(-)
>
<snip>
>diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
>index 83beeac..15a3f27 100644
>--- a/drivers/usb/musb/omap2430.c
>+++ b/drivers/usb/musb/omap2430.c
>@@ -255,6 +255,22 @@ int __init musb_platform_init(struct musb *musb)
> 	return 0;
> }
>
>+#ifdef CONFIG_PM
>+void musb_platform_save_context(struct musb_context_registers
>+		*musb_context)
>+{
>+	musb_context->otg_sysconfig = omap_readl(OTG_SYSCONFIG);
>+	musb_context->otg_forcestandby = omap_readl(OTG_FORCESTDBY);

Any reason not to store: OTG_INTERFSEL
Depending on reset value is not a good idea.

>+}
>+
>+void musb_platform_restore_context(struct musb_context_registers
>+		*musb_context)
>+{
>+	omap_writel(musb_context->otg_sysconfig, OTG_SYSCONFIG);
>+	omap_writel(musb_context->otg_forcestandby, OTG_FORCESTDBY);
>+}
>+#endif
>+
> int musb_platform_suspend(struct musb *musb)
> {
> 	u32 l;
>--
>1.6.6.rc0
>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
