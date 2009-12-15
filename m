From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 1/3] musb: save dynfifo in musb struct
Date: Tue, 15 Dec 2009 09:34:30 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372AAD03@dbde02.ent.ti.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <20091214162454.GA31829@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37279 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756695AbZLOEEn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 23:04:43 -0500
In-Reply-To: <20091214162454.GA31829@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "david-b@pacbell.net" <david-b@pacbell.net>

> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
> Sent: Monday, December 14, 2009 9:55 PM
> To: Gupta, Ajay Kumar
> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Balbi Felipe
> (Nokia-D/Helsinki); david-b@pacbell.net
> Subject: Re: [PATCH 1/3] musb: save dynfifo in musb struct
> 
> Hi,
> 
> On Mon, Dec 14, 2009 at 02:39:40PM +0100, ext Ajay Kumar Gupta wrote:
> >Save dynamic FIFO read only information for later uses such as, during
> >musb_save/restore_context functions.
> >
> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> NAK
> 
> >---
> > drivers/usb/musb/musb_core.c |    4 +++-
> > drivers/usb/musb/musb_core.h |    1 +
> > 2 files changed, 4 insertions(+), 1 deletions(-)
> >
> >diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> >index 49f2346..d4adbbf 100644
> >--- a/drivers/usb/musb/musb_core.c
> >+++ b/drivers/usb/musb/musb_core.c
> >@@ -1328,8 +1328,10 @@ static int __init musb_core_init(u16 musb_type,
> struct musb *musb)
> > 	reg = musb_read_configdata(mbase);
> >
> > 	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-
> 8");
> >-	if (reg & MUSB_CONFIGDATA_DYNFIFO)
> >+	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
> > 		strcat(aInfo, ", dyn FIFOs");
> >+		musb->dyn_fifo = true;
> 
> we have this inside struct musb_hdrc_config.
> This is duplicating that.

musb->config->dyn_fifo is coming from platform files and is user defined
but we need to check if the mentor core itself supports dynamic fifo.

See the dynamic fifo code snippet:

--------------------------------------------------------
        if (reg & MUSB_CONFIGDATA_DYNFIFO) {
                if (musb->config->dyn_fifo)
                        status = ep_config_from_table(musb);
                else {
                        ERR("reconfigure software for Dynamic FIFOs\n");
                        status = -ENODEV;
                }
        } else {
--------------------------------------------------------

If CONFIGDATA register bit indicates that dynamic FIFO is supported then
musb->config->dyn_fifo has to be set to '1' for suceessful initialization.

Thus CONFIGDATA register bit alone is sufficient condition to save/restore
Tx/Rx FIFOSZ/FIFOADDR registers.

-Ajay

> 
> --
> balbi
