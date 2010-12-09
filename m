From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/7] mfd: TWL6030: OMAP4: Registering the TWL6030-usb
 device
Date: Thu, 09 Dec 2010 15:46:44 +0300
Message-ID: <4D00CFB4.60901@ru.mvista.com>
References: <1291824116-7143-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f171.google.com ([209.85.215.171]:48583 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755305Ab0LIMrp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 07:47:45 -0500
In-Reply-To: <1291824116-7143-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Hello.

On 08-12-2010 19:01, Hema HK wrote:

> Registering the twl6030-usb transceiver device as a child to twl6030 core.
> Removed the NOP transceiver init call from board file.

> Populated twl4030_usb_data platform data structure with the function
> pointers for OMAP4430 internal PHY operation to be used twl630-usb driver.
                                                          ^ by?


> Signed-off-by: Hema HK<hemahk@ti.com>
> Cc: Samuel Ortiz<sameo@linux.intel.com>
> Cc: Felipe Balbi<balbi@ti.com>
> Cc: Tony Lindgren<tony@atomide.com>
[...]

> Index: linux-2.6/drivers/mfd/twl-core.c
> ===================================================================
> --- linux-2.6.orig/drivers/mfd/twl-core.c
> +++ linux-2.6/drivers/mfd/twl-core.c
[...]
> @@ -682,6 +683,43 @@ add_children(struct twl4030_platform_dat
[...]
> +		child = add_child(0, "twl6030_usb",
> +			pdata->usb, sizeof(*pdata->usb),
> +			true,
> +			/* irq1 = VBUS_PRES, irq0 = USB ID*/

    You forgot space before */.

> Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
> +++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c

    Your patch is not sorted.

WBR, Sergei
