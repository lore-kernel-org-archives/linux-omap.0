From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 3/5] usb: ehci: relocate PHY reset code
Date: Thu, 19 Aug 2010 09:01:26 +0300
Message-ID: <20100819060126.GS4385@nokia.com>
References: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-2-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-3-git-send-email-keshava_mgowda@ti.com>
 <1282100145-27485-4-git-send-email-keshava_mgowda@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53114 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab0HSGBp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Aug 2010 02:01:45 -0400
Content-Disposition: inline
In-Reply-To: <1282100145-27485-4-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Keshava Munegowda <keshava_mgowda@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>

On Wed, Aug 18, 2010 at 04:55:43AM +0200, ext Keshava Munegowda wrote:
>The PHY reset code is moved at the begining and end of the function
>omap_start_ehc. This simplfies the writing clocks enabling code for
>OMAP4 later.
>
>Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>---
> drivers/usb/host/ehci-omap.c |   52 +++++++++++++++++++++----------------------
> 1 file changed, 26 insertions(+), 26 deletions(-)
>
>Index: linux-2.6/drivers/usb/host/ehci-omap.c
>===================================================================
>--- linux-2.6.orig/drivers/usb/host/ehci-omap.c
>+++ linux-2.6/drivers/usb/host/ehci-omap.c
>@@ -279,6 +279,24 @@ static int omap_start_ehc(struct ehci_hc
>
> 	dev_dbg(omap->dev, "starting TI EHCI USB Controller\n");
>
>+	if (omap->phy_reset) {
>+		/* Refer: ISSUE1 */
>+		if (gpio_is_valid(omap->reset_gpio_port[0])) {
>+			gpio_request(omap->reset_gpio_port[0],
>+						"USB1 PHY reset");
>+			gpio_direction_output(omap->reset_gpio_port[0], 0);
>+		}
>+
>+		if (gpio_is_valid(omap->reset_gpio_port[1])) {
>+			gpio_request(omap->reset_gpio_port[1],
>+						"USB2 PHY reset");
>+			gpio_direction_output(omap->reset_gpio_port[1], 0);
>+		}
>+
>+		/* Hold the PHY in RESET for enough time till DIR is high */
>+		udelay(10);
>+	}

there was another patch doing this with ulpi messages and that's more 
portable as every board will have support for softreset but we can't 
guarantee all of them will have these gpio routed correctly, right ?

-- 
balbi

DefectiveByDesign.org
