From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/5 RESEND] ARM: OMAP: USB: Invoke the TLL driver from
 USB HS core driver
Date: Mon, 19 Mar 2012 14:59:32 +0400
Message-ID: <4F671194.6050209@mvista.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com> <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com> <1332139715-1495-3-git-send-email-keshava_mgowda@ti.com> <1332139715-1495-4-git-send-email-keshava_mgowda@ti.com> <1332139715-1495-5-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36599 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756654Ab2CSLA6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 07:00:58 -0400
Received: by bkcik5 with SMTP id ik5so4155158bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 04:00:57 -0700 (PDT)
In-Reply-To: <1332139715-1495-5-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com

Hello.

On 19-03-2012 10:48, Keshava Munegowda wrote:

> From: Keshava Munegowda<Keshava_mgowda@ti.com>

> The usbhs driver invokes the enable/disable APIs of the
> usb tll driver in the runtime resume/suspend callbacks
> of the runtime get sync and put sync of the usbhs driver.

> Signed-off-by: Keshava Munegowda<keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak<parthab@india.ti.com>
> ---
>   arch/arm/plat-omap/include/plat/usb.h |    1 +
>   drivers/mfd/omap-usb-host.c           |    7 +++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)

> diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
> index 4de87c6..9d84339 100644
> --- a/drivers/mfd/omap-usb-host.c
> +++ b/drivers/mfd/omap-usb-host.c
[...]
> @@ -655,8 +656,10 @@ static int __init omap_usbhs_drvinit(void)
>   * init before ehci and ohci drivers;
>   * The usbhs core driver should be initialized much before
>   * the omap ehci and ohci probe functions are called.
> + * this usbhs core driver should be initialized after

    s/this/This/

> + * usb tll driver.

WBR, Sergei
