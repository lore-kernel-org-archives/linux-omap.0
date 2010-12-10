From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 7/8 V2] usb: musb: Adding musb support for OMAP4430
Date: Fri, 10 Dec 2010 14:51:34 +0200
Message-ID: <20101210125134.GI6027@legolas.emea.dhcp.ti.com>
References: <1291984851-26040-1-git-send-email-hemahk@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1291984851-26040-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 10, 2010 at 06:10:51PM +0530, Hema HK wrote:
>@@ -214,9 +235,62 @@ static inline void omap2430_low_level_in
> 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
> }
>
>+/* blocking notifier support */
>+static int musb_otg_notifications(struct notifier_block *nb,
>+		unsigned long event, void *unused)
>+{
>+	struct musb	*musb = container_of(nb, struct musb, nb);
>+	struct device *dev = musb->controller;
>+	struct musb_hdrc_platform_data *pdata = dev->platform_data;
>+	struct omap_musb_board_data *data = pdata->board_data;
>+
>+	switch (event) {
>+	case USB_EVENT_ID:
>+		DBG(4, "ID GND\n");
>+
>+		if (is_otg_enabled(musb)) {
>+			if (musb->gadget_driver) {

This breaks compilation:

drivers/usb/musb/omap2430.c: In function 'musb_otg_notifications':
drivers/usb/musb/omap2430.c:252: error: 'struct musb' has no member
named 'gadget_driver'
make[2]: *** [drivers/usb/musb/omap2430.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [drivers/usb/musb] Error 2
make: *** [drivers] Error 2

you need to ifdef that.

-- 
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
