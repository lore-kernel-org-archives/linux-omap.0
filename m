From: Mohamed Thalib H <hmthalib@gmail.com>
Subject: Re: [Q] USB OTG host
Date: Thu, 05 May 2011 15:39:30 +0530
Message-ID: <4DC2775A.2070704@gmail.com>
References: <1304517788.17252.16.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49054 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691Ab1EEKJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 06:09:33 -0400
Received: by pwi15 with SMTP id 15so915173pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 03:09:33 -0700 (PDT)
In-Reply-To: <1304517788.17252.16.camel@lws-weitzel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: J.Weitzel@phytec.de
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wednesday 04 May 2011 07:33 PM, Jan Weitzel wrote:
> Hello,
> I am using drivers/usb/musb/omap2430.c for a board configured in
> MUSB_OTG mode.
> Is it correct that I need to load gadget driver to get it working as
> host?
No. Host mode don't need gadget driver. Once OTG mode needs them.
> I got an USB_EVENT_ID event, but in musb_otg_notifications vbus will not
> switched on if !musb->gadget_driver.
> Any ideas?
> Kind regards,
> Jan Weitzel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Mohamed Thalib H.
