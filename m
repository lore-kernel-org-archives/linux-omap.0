From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC] [PATCH 2/7] usb: ehci-omap: don't execute OMAP3-specific
 code on non-OMAP3
Date: Fri, 20 Aug 2010 08:35:41 +0300
Message-ID: <20100820053541.GA15196@nokia.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:20237 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab0HTFfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Aug 2010 01:35:55 -0400
Content-Disposition: inline
In-Reply-To: <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Keshava Munegowda <keshava_mgowda@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>

On Thu, Aug 19, 2010 at 01:49:32AM +0200, ext Keshava Munegowda wrote:
>@@ -297,194 +297,184 @@ static int omap_start_ehc(struct ehci_hc
>                udelay(10);
>        }
>
>-       /* Enable Clocks for USBHOST */
>-       omap->usbhost_ick = clk_get(omap->dev, "usbhost_ick");
>-       if (IS_ERR(omap->usbhost_ick)) {
>-               ret =  PTR_ERR(omap->usbhost_ick);
>-               goto err_host_ick;
>-       }
>-       clk_enable(omap->usbhost_ick);
>+       if (cpu_is_omap44xx()) {
>+               /* TODO */

please don't. Come back when you have clock framework support for omap4, 
this patch is anyway useless as you will revert it as soon as clock 
framework support is done. NAK

if you don't have clk support on omap4, make clk_* empty stubs.

-- 
balbi

DefectiveByDesign.org
