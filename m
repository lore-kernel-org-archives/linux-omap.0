From: Sourav <sourav.poddar@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP2: UART: fix console UART mismatched runtime
 PM status
Date: Mon, 22 Oct 2012 17:43:41 +0530
Message-ID: <50853875.6020109@ti.com>
References: <1350685470-3634-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34747 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab2JVMNc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 08:13:32 -0400
In-Reply-To: <1350685470-3634-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>

Hi,
On Saturday 20 October 2012 03:54 AM, Kevin Hilman wrote:
> From: Kevin Hilman <khilman@ti.com>
>
> The runtime PM framework assumes that the hardware state of devices
> when initialized is disabled.  For all omap_devices, we idle/disable
> device by default.  However, the console uart uses a "no idle" option
> during omap_device init in order to allow earlyprintk usage to work
> seamlessly during boot.
>
> Because the hardware is left partially enabled after init (whatever
> the bootloader settings were), the omap_device should later be fully
> initialized (including mux) and the runtime PM framework should be
> told that the device is active, and not disabled so that the hardware
> state is in sync with runtime PM state.
>
> To fix, after the device has been created/registered, call
> omap_device_enable() to finialize init and use pm_runtime_set_active()
> to tell the runtime PM core the device is enabled.
>
> Tested on 2420/n810, 3530/Overo, 3530/Beagle, 3730/OveroSTORM,
> 3730/Beagle-xM, 4460/PandaES.
>
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Sourav Poddar <sourav.poddar@ti.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Applies to v3.7-rc1.
> v2: call omap_device_enable() only after oh->mux has been initialized
>      otherwise, IO ring wakeups not properly enabled.
>
>   arch/arm/mach-omap2/serial.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 0405c81..a507cd6 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -329,6 +329,11 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
>   
>   	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
>   
> +	if (console_uart_id == bdata->id) {
> +		omap_device_enable(pdev);
> +		pm_runtime_set_active(&pdev->dev);
> +	}
> +
>   	oh->dev_attr = uart;
>   
>   	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
Tested on 3630/Beagle-xm, 4430/Panda, 4430/Sdp, 5430/Evm.

  Tested-by: Sourav Poddar <sourav.poddar@ti.com>
