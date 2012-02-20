From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/3] tty: serial: OMAP: block idle while the UART is transferring
 data in PIO mode
Date: Mon, 20 Feb 2012 13:35:52 +0100
Message-ID: <4F423E28.3040404@ti.com>
References: <20120126024903.31613.24730.stgit@dusk> <20120126025036.31613.67819.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55399 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2BTMgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Feb 2012 07:36:08 -0500
In-Reply-To: <20120126025036.31613.67819.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>

+ Rajendra

Hi Paul,

3.3-rc4 is broken in the DT case because of the serial driver. And it looks like it is due to this fix.
We cannot rely on pdata anymore in DT, and in that case it leads to an Oops due to NULL pdata.

[    2.120605] Unable to handle kernel NULL pointer dereference at virtual address 00000028
[    2.120605] pgd = ed568000
[    2.131958] [00000028] *pgd=ad73f831, *pte=00000000, *ppte=00000000
[    2.131958] Internal error: Oops: 17 [#1] SMP
[    2.131958] Modules linked in:
[    2.131958] CPU: 1    Not tainted  (3.3.0-rc4-00001-g6851380-dirty #244)
[    2.153350] PC is at serial_omap_start_tx+0x1c0/0x20c
[    2.153350] LR is at serial_omap_start_tx+0x1b8/0x20c
[    2.153350] pc : [<c02b4244>]    lr : [<c02b423c>]    psr: 60000193
[    2.163940] sp : ed579e68  ip : c07024b0  fp : a0000113
[    2.163940] r10: ed780800  r9 : ed6aca00  r8 : 00000017
[    2.163940] r7 : 00000004  r6 : 00000007  r5 : 00000000  r4 : ed6aca00
[    2.188262] r3 : ef0ef540  r2 : fa020000  r1 : 00000000  r0 : c02b423c
[    2.188262] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    2.188262] Control: 10c53c7d  Table: ad56804a  DAC: 00000015
[    2.188262] Process rcS (pid: 494, stack limit = 0xed5782f8)
[    2.214630] Stack: (0xed579e68 to 0xed57a000)
[    2.214630] 9e60:                   ed6aca00 ed780800 a0000113 c0476f94 00000002 ed6aca00
[    2.227752] 9e80: ed780800 20000113 00000000 c02ac2ec 60000193 c02acbd4 00000000 ed6a22d0
[    2.236328] 9ea0: ef0bf017 c02ae270 00000017 ed780800 ed780cfc 00000017 ef0bf000 ed578000
[    2.236328] 9ec0: c049dde8 ef0b5380 00000000 c0297488 60000113 c0292f84 ef0bf000 ed780994
[    2.236328] 9ee0: ef0003c0 00000000 ef0ef540 c0073cfc ed7809b4 ed7809b4 ed780cb4 ef0b5380
[    2.236328] 9f00: ed780800 b6f15000 00000017 ed578000 00000400 00000000 00000000 c0292fd0
[    2.236328] 9f20: c06e413c 00000017 c02972b4 ed778800 ed579f80 ed578000 00000000 ef0b5380
[    2.236328] 9f40: 00000017 b6f15000 ed579f80 00000017 ed578000 00000000 b6f16000 c0107df8
[    2.287750] 9f60: c0013ec0 ef0ef540 ef0b5380 b6f15000 00000000 00000000 00000017 c0108080
[    2.287750] 9f80: 00000000 00000000 b6e47600 00000000 00000017 b6f15000 b6e47600 00000004
[    2.287750] 9fa0: c0013f68 c0013da0 00000017 b6f15000 00000001 b6f15000 00000017 00000000
[    2.287750] 9fc0: 00000017 b6f15000 b6e47600 00000004 00000017 00000000 00000001 b6f16000
[    2.287750] 9fe0: b6f15000 beb025d8 b6d8d120 b6ddb1bc 60000110 00000001 0da805a1 84808223
[    2.330627] [<c02b4244>] (serial_omap_start_tx+0x1c0/0x20c) from [<c02ac2ec>] (__uart_start+0x40/0x44)
[    2.330627] [<c02ac2ec>] (__uart_start+0x40/0x44) from [<c02acbd4>] (uart_start+0x24/0x34)
[    2.340393] [<c02acbd4>] (uart_start+0x24/0x34) from [<c02ae270>] (uart_write+0xc0/0xe4)
[    2.349060] [<c02ae270>] (uart_write+0xc0/0xe4) from [<c0297488>] (n_tty_write+0x1d4/0x404)
[    2.349060] [<c0297488>] (n_tty_write+0x1d4/0x404) from [<c0292fd0>] (tty_write+0x138/0x22c)
[    2.366302] [<c0292fd0>] (tty_write+0x138/0x22c) from [<c0107df8>] (vfs_write+0xb4/0x148)
[    2.366302] [<c0107df8>] (vfs_write+0xb4/0x148) from [<c0108080>] (sys_write+0x40/0x70)
[    2.366302] [<c0108080>] (sys_write+0x40/0x70) from [<c0013da0>] (ret_fast_syscall+0x0/0x3c)


I guess we should stop accessing the pdata from the driver except during probe and populate the needed information inside the drvdata instead.

And then we will have to add the support for all these OMAP custom hooks without pdata.

A basic fix (below) for the moment is to test for valid pdata inside the driver.
I'll repost it properly if you are fine with it.

Regards,
Benoit

---
>From af9f18e15e0ef0e227b3efa42489b7bd8a20c2a9 Mon Sep 17 00:00:00 2001
From: Benoit Cousson <b-cousson@ti.com>
Date: Mon, 20 Feb 2012 12:19:24 +0100
Subject: [PATCH] tty: serial: OMAP: Fix oops due to NULL pdata in DT boot

The following commit: be4b0281956c5cae4f63f31f11d07625a6988766
(tty: serial: OMAP: block idle while the UART is transferring data in PIO mode),
is introducing a oops if OMAP is booted using device tree blob because
the pdata will not be initialized.

Check if pdata is set before de-referencing it.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 drivers/tty/serial/omap-serial.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f809041..0121486 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -159,7 +159,7 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		serial_out(up, UART_IER, up->ier);
 	}
 
-	if (!up->use_dma && pdata->set_forceidle)
+	if (!up->use_dma && pdata && pdata->set_forceidle)
 		pdata->set_forceidle(up->pdev);
 
 	pm_runtime_mark_last_busy(&up->pdev->dev);
@@ -298,7 +298,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 	if (!up->use_dma) {
 		pm_runtime_get_sync(&up->pdev->dev);
 		serial_omap_enable_ier_thri(up);
-		if (pdata->set_noidle)
+		if (pdata && pdata->set_noidle)
 			pdata->set_noidle(up->pdev);
 		pm_runtime_mark_last_busy(&up->pdev->dev);
 		pm_runtime_put_autosuspend(&up->pdev->dev);
@@ -1613,7 +1613,7 @@ static int serial_omap_runtime_resume(struct device *dev)
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 	struct omap_uart_port_info *pdata = dev->platform_data;
 
-	if (up) {
+	if (up && pdata) {
 		if (pdata->get_context_loss_count) {
 			u32 loss_cnt = pdata->get_context_loss_count(dev);
 
-- 
1.7.0.4


On 1/26/2012 3:50 AM, Paul Walmsley wrote:
> Prevent OMAP UARTs from going idle while they are still transferring
> data in PIO mode.  This works around an oversight in the OMAP UART
> hardware present in OMAP34xx and earlier: an idle UART won't send a
> wakeup when the TX FIFO threshold is reached.  This causes long delays
> during data transmission when the MPU powerdomain enters a low-power
> mode.  The MPU interrupt controller is not able to respond to
> interrupts when it's in a low-power state, so the TX buffer is not
> refilled until another wakeup event occurs.
> 
> This fix changes the erratum i291 DMA idle workaround.  Rather than
> toggling between force-idle and no-idle, it will toggle between
> smart-idle and no-idle.  The important part of the workaround is the
> no-idle part, so this shouldn't result in any change in behavior.
> 
> This fix should work on all OMAP UARTs.  Future patches intended for
> the 3.4 merge window will make this workaround conditional on a
> "feature" flag, and will use the OMAP36xx+ TX event wakeup support.
> 
> Thanks to Kevin Hilman<khilman@ti.com>  for mentioning the erratum i291
> workaround, which led to the development of this approach.
> 
> Signed-off-by: Paul Walmsley<paul@pwsan.com>
> Cc: Kevin Hilman<khilman@ti.com>
> Cc: Govindraj.R<govindraj.raja@ti.com>
> Cc: Greg Kroah-Hartman<gregkh@suse.de>
> Cc: Alan Cox<alan@linux.intel.com>
> Cc: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/serial.c     |    8 ++++----
>   drivers/tty/serial/omap-serial.c |    7 +++++++
>   2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 247d894..f590afc 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -107,18 +107,18 @@ static void omap_uart_set_noidle(struct platform_device *pdev)
>   	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_NO);
>   }
> 
> -static void omap_uart_set_forceidle(struct platform_device *pdev)
> +static void omap_uart_set_smartidle(struct platform_device *pdev)
>   {
>   	struct omap_device *od = to_omap_device(pdev);
> 
> -	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_FORCE);
> +	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_SMART);
>   }
> 
>   #else
>   static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
>   {}
>   static void omap_uart_set_noidle(struct platform_device *pdev) {}
> -static void omap_uart_set_forceidle(struct platform_device *pdev) {}
> +static void omap_uart_set_smartidle(struct platform_device *pdev) {}
>   #endif /* CONFIG_PM */
> 
>   #ifdef CONFIG_OMAP_MUX
> @@ -349,7 +349,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
>   	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
>   	omap_up.flags = UPF_BOOT_AUTOCONF;
>   	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
> -	omap_up.set_forceidle = omap_uart_set_forceidle;
> +	omap_up.set_forceidle = omap_uart_set_smartidle;
>   	omap_up.set_noidle = omap_uart_set_noidle;
>   	omap_up.enable_wakeup = omap_uart_enable_wakeup;
>   	omap_up.dma_rx_buf_size = info->dma_rx_buf_size;
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index c9c9ba2..11fa156 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -136,6 +136,7 @@ static void serial_omap_enable_ms(struct uart_port *port)
>   static void serial_omap_stop_tx(struct uart_port *port)
>   {
>   	struct uart_omap_port *up = (struct uart_omap_port *)port;
> +	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
> 
>   	if (up->use_dma&&
>   		up->uart_dma.tx_dma_channel != OMAP_UART_DMA_CH_FREE) {
> @@ -158,6 +159,9 @@ static void serial_omap_stop_tx(struct uart_port *port)
>   		serial_out(up, UART_IER, up->ier);
>   	}
> 
> +	if (!up->use_dma&&  pdata->set_forceidle)
> +		pdata->set_forceidle(up->pdev);
> +
>   	pm_runtime_mark_last_busy(&up->pdev->dev);
>   	pm_runtime_put_autosuspend(&up->pdev->dev);
>   }
> @@ -286,6 +290,7 @@ static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
>   static void serial_omap_start_tx(struct uart_port *port)
>   {
>   	struct uart_omap_port *up = (struct uart_omap_port *)port;
> +	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
>   	struct circ_buf *xmit;
>   	unsigned int start;
>   	int ret = 0;
> @@ -293,6 +298,8 @@ static void serial_omap_start_tx(struct uart_port *port)
>   	if (!up->use_dma) {
>   		pm_runtime_get_sync(&up->pdev->dev);
>   		serial_omap_enable_ier_thri(up);
> +		if (pdata->set_noidle)
> +			pdata->set_noidle(up->pdev);
>   		pm_runtime_mark_last_busy(&up->pdev->dev);
>   		pm_runtime_put_autosuspend(&up->pdev->dev);
>   		return;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

