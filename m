From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/8 V2] usb: musb: Adding musb support for OMAP4430
Date: Fri, 10 Dec 2010 14:57:28 +0200
Message-ID: <20101210125728.GJ6027@legolas.emea.dhcp.ti.com>
References: <1291984851-26040-1-git-send-email-hemahk@ti.com>
 <20101210125134.GI6027@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:58573 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755892Ab0LJM5f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 07:57:35 -0500
Content-Disposition: inline
In-Reply-To: <20101210125134.GI6027@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Hema HK <hemahk@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Fri, Dec 10, 2010 at 02:51:34PM +0200, Felipe Balbi wrote:
>On Fri, Dec 10, 2010 at 06:10:51PM +0530, Hema HK wrote:
>>@@ -214,9 +235,62 @@ static inline void omap2430_low_level_in
>>	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
>>}
>>
>>+/* blocking notifier support */
>>+static int musb_otg_notifications(struct notifier_block *nb,
>>+		unsigned long event, void *unused)
>>+{
>>+	struct musb	*musb = container_of(nb, struct musb, nb);
>>+	struct device *dev = musb->controller;
>>+	struct musb_hdrc_platform_data *pdata = dev->platform_data;
>>+	struct omap_musb_board_data *data = pdata->board_data;
>>+
>>+	switch (event) {
>>+	case USB_EVENT_ID:
>>+		DBG(4, "ID GND\n");
>>+
>>+		if (is_otg_enabled(musb)) {
>>+			if (musb->gadget_driver) {
>
>This breaks compilation:
>
>drivers/usb/musb/omap2430.c: In function 'musb_otg_notifications':
>drivers/usb/musb/omap2430.c:252: error: 'struct musb' has no member
>named 'gadget_driver'
>make[2]: *** [drivers/usb/musb/omap2430.o] Error 1
>make[2]: *** Waiting for unfinished jobs....
>make[1]: *** [drivers/usb/musb] Error 2
>make: *** [drivers] Error 2
>
>you need to ifdef that.

fixed it already. Pushed to musb-hw branch.

-- 
balbi
