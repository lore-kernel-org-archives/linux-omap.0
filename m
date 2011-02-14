From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/7] usb: musb: OMAP4430: Fix usb device detection if
 connected during boot
Date: Mon, 14 Feb 2011 12:05:39 +0200
Message-ID: <20110214100539.GM2549@legolas.emea.dhcp.ti.com>
References: <yes>
 <1296726587-10530-7-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50476 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953Ab1BNKFo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 14 Feb 2011 05:05:44 -0500
Content-Disposition: inline
In-Reply-To: <1296726587-10530-7-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

Hi,

On Thu, Feb 03, 2011 at 03:19:47PM +0530, Hema HK wrote:
> +static void omap2430_musb_enable(struct musb *musb)
> +{
> +	u8		devctl;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
> +	struct device *dev = musb->controller;
> +	struct musb_hdrc_platform_data *pdata = dev->platform_data;
> +	struct omap_musb_board_data *data = pdata->board_data;
> +
> +	switch (musb->xceiv->last_event) {
> +
> +	case USB_EVENT_ID:
> +		otg_init(musb->xceiv);
> +		if (data->interface_type == MUSB_INTERFACE_UTMI) {
> +			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
> +			/* start the session */
> +			devctl |= MUSB_DEVCTL_SESSION;
> +			musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
> +			while (musb_readb(musb->mregs, MUSB_DEVCTL) & 0x80) {

isn't this BDEVICE bit ? We have a define for that, please use it.

-- 
balbi
