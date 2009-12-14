From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] musb: save dynfifo in musb struct
Date: Mon, 14 Dec 2009 18:24:54 +0200
Message-ID: <20091214162454.GA31829@nokia.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1260797982-28880-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ext Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Dec 14, 2009 at 02:39:40PM +0100, ext Ajay Kumar Gupta wrote:
>Save dynamic FIFO read only information for later uses such as, during
>musb_save/restore_context functions.
>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>

NAK

>---
> drivers/usb/musb/musb_core.c |    4 +++-
> drivers/usb/musb/musb_core.h |    1 +
> 2 files changed, 4 insertions(+), 1 deletions(-)
>
>diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>index 49f2346..d4adbbf 100644
>--- a/drivers/usb/musb/musb_core.c
>+++ b/drivers/usb/musb/musb_core.c
>@@ -1328,8 +1328,10 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
> 	reg = musb_read_configdata(mbase);
>
> 	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
>-	if (reg & MUSB_CONFIGDATA_DYNFIFO)
>+	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
> 		strcat(aInfo, ", dyn FIFOs");
>+		musb->dyn_fifo = true;

we have this inside struct musb_hdrc_config.
This is duplicating that.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
