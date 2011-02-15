From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [PATCH 7/7] usb: musb: OMAP4430: Fix usb device detection if
 connected during boot
Date: Tue, 15 Feb 2011 13:53:49 +0530
Message-ID: <b0eeb3a36582afef10d707e445d6a68b@mail.gmail.com>
References: <yes> <1296726587-10530-7-git-send-email-hemahk@ti.com> <20110214100539.GM2549@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59258 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754084Ab1BOIXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 03:23:51 -0500
In-Reply-To: <20110214100539.GM2549@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

>-----Original Message-----
>From: Felipe Balbi [mailto:balbi@ti.com]
>Sent: Monday, February 14, 2011 3:36 PM
>To: Hema HK
>Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org; Felipe Balbi
>Subject: Re: [PATCH 7/7] usb: musb: OMAP4430: Fix usb device
>detection if connected during boot
>
>Hi,
>
>On Thu, Feb 03, 2011 at 03:19:47PM +0530, Hema HK wrote:
>> +static void omap2430_musb_enable(struct musb *musb)
>> +{
>> +	u8		devctl;
>> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
>> +	struct device *dev = musb->controller;
>> +	struct musb_hdrc_platform_data *pdata = dev->platform_data;
>> +	struct omap_musb_board_data *data = pdata->board_data;
>> +
>> +	switch (musb->xceiv->last_event) {
>> +
>> +	case USB_EVENT_ID:
>> +		otg_init(musb->xceiv);
>> +		if (data->interface_type == MUSB_INTERFACE_UTMI) {
>> +			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
>> +			/* start the session */
>> +			devctl |= MUSB_DEVCTL_SESSION;
>> +			musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
>> +			while (musb_readb(musb->mregs,
>MUSB_DEVCTL) & 0x80) {
>
>isn't this BDEVICE bit ? We have a define for that, please use it.
>
OK.

Regards,
Hema
>--
>balbi
>
