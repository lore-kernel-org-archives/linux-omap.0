From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/7] usb: otg: OMAP4430: Add phy_suspend function pointer
 to twl4030_usb_data
Date: Thu, 03 Feb 2011 16:45:43 +0300
Message-ID: <4D4AB187.50406@ru.mvista.com>
References: <yes> <1296726587-10530-4-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64670 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756397Ab1BCNq5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 08:46:57 -0500
In-Reply-To: <1296726587-10530-4-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hello.

On 03-02-2011 12:49, Hema HK wrote:

> Introduce the .phy_suspend function pointer to twl4030_usb_data structure.
> assign the function to it for both sdp board and panda boards.
> This will be used by the twl6030-usb transceiver driver.

> Signed-off-by: Hema HK<hemahk@ti.com>
> Cc: Felipe Balbi<balbi@ti.com>
> Cc: Tony Lindgren<tony@atomide.com>

> Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
> +++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
> @@ -88,6 +88,7 @@ extern int omap4430_phy_power(struct dev
>   extern int omap4430_phy_set_clk(struct device *dev, int on);
>   extern int omap4430_phy_init(struct device *dev);
>   extern int omap4430_phy_exit(struct device *dev);
> +extern int omap4430_phy_suspend(struct device *dev, int suspend);

    And where it it defined? Why this doesn't happen in this patch?

WBR, Sergei
