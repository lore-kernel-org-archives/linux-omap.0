From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/5 RESEND] ARM: OMAP: USB: Build the USB HOST TLL omap
 device
Date: Mon, 19 Mar 2012 14:53:14 +0400
Message-ID: <4F67101A.6050304@mvista.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com> <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com> <1332139715-1495-3-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:65354 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756175Ab2CSKyk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 06:54:40 -0400
Received: by bkcik5 with SMTP id ik5so4150029bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 03:54:39 -0700 (PDT)
In-Reply-To: <1332139715-1495-3-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keshava Munegowda <keshava_mgowda@ti.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, govindraj.raja@ti.com, paul@pwsan.com, b-cousson@ti.com

Hello.

On 19-03-2012 10:48, Keshava Munegowda wrote:

> From: Keshava Munegowda<Keshava_mgowda@ti.com>

> The hwmod of the usb tll is retrieved and omap device build is
> performed to created the platform device for the usb tll component.

> Signed-off-by: Keshava Munegowda<keshava_mgowda@ti.com>
> Reviewed-by: Partha Basak<parthab@india.ti.com>
> ---
>   arch/arm/mach-omap2/usb-host.c |   28 ++++++++++++++++++++--------
>   1 files changed, 20 insertions(+), 8 deletions(-)

> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index f51348d..dc6769a 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
[...]
> @@ -510,25 +512,35 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
[...]
> -	pdev = omap_device_build_ss(OMAP_USBHS_DEVICE, bus_id, oh, 2,
> +	pdev = omap_device_build(OMAP_USBTLL_DEVICE, bus_id, tll_hwm,
> +				(void *)&usbtll_data, sizeof(usbtll_data),

    There's no need to explicitly cast to 'void *'. The cast is automatic.

> +				omap_uhhtll_latency,
> +				ARRAY_SIZE(omap_uhhtll_latency), false);
> +	if (IS_ERR(pdev)) {
> +		pr_err("Could not build hwmod device %s\n",
> +			USBHS_TLL_HWMODNAME);
> +		return;
> +	}
> +
> +	pdev = omap_device_build(OMAP_USBHS_DEVICE, bus_id, uhh_hwm,
>   				(void *)&usbhs_data, sizeof(usbhs_data),

    Same here.

WBR, Sergei
