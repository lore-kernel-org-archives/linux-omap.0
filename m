From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] tty: omap-serial: Keep the wakeup mechanism enabled by default
Date: Tue, 17 Apr 2012 16:25:45 -0700
Message-ID: <87vckyq6ti.fsf@ti.com>
References: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:59692 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751990Ab2DQXZs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 19:25:48 -0400
Received: by pbcup15 with SMTP id up15so8553891pbc.0
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 16:25:47 -0700 (PDT)
In-Reply-To: <1334579407-16970-1-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Mon, 16 Apr 2012 18:00:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> From: "Govindraj.R" <govindraj.raja@ti.com>
>
> The wakeups can be left enabled by default and should be disabled
> only when disabled from sysfs and while entering suspend.

Left enabled?  That assumes something else has initizlied them, but we
can't make that assumption.

First, wakeups should be disabled when ->probe has finished.  Then,
they should be enabled whenever driver is in use, and disabled when
the driver is not in use.

I'm not familiar enough with uart_ops, but it looks like they should
probably be enabled in uart_ops->startup and disabled in
uart_ops->shutdown.  

I've hacked up a test patch[1] which was required for module-wakeups to
work for me.  I tested module-level wakeups by disabling all C-states
except C1 using the new sysfs control for disabling C-states[2].

More comments below...

> Thanks to Kevin Hilman <khilman@ti.com> for suggesting this.
> Discussion References:
> http://www.spinics.net/lists/linux-omap/msg67764.html
> http://www.spinics.net/lists/linux-omap/msg67838.html
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  drivers/tty/serial/omap-serial.c |   30 +++++++++++-------------------
>  1 files changed, 11 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index d00b38e..4a92447 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -930,13 +930,6 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
>  	serial_out(up, UART_EFR, efr);
>  	serial_out(up, UART_LCR, 0);
>  
> -	if (!device_may_wakeup(&up->pdev->dev)) {
> -		if (!state)
> -			pm_runtime_forbid(&up->pdev->dev);
> -		else
> -			pm_runtime_allow(&up->pdev->dev);
> -	}
> -
>  	pm_runtime_put(&up->pdev->dev);
>  }
>  
> @@ -1184,10 +1177,16 @@ static struct uart_driver serial_omap_reg = {
>  static int serial_omap_suspend(struct device *dev)
>  {
>  	struct uart_omap_port *up = dev_get_drvdata(dev);
> +	struct omap_uart_port_info *pdata = dev->platform_data;
>  
>  	if (up) {
>  		uart_suspend_port(&serial_omap_reg, &up->port);
>  		flush_work_sync(&up->qos_work);
> +
> +		if (!device_may_wakeup(dev)) {
> +			pdata->enable_wakeup(up->pdev, false);

Should check for the presence of pdata->enable_wakeup() before calling.  
Same thing below.

> +			up->wakeups_enabled = false;
> +		}
>  	}
>  
>  	return 0;
> @@ -1582,18 +1581,6 @@ static int serial_omap_runtime_suspend(struct device *dev)
>  	if (pdata->get_context_loss_count)
>  		up->context_loss_cnt = pdata->get_context_loss_count(dev);
>  
> -	if (device_may_wakeup(dev)) {
> -		if (!up->wakeups_enabled) {
> -			pdata->enable_wakeup(up->pdev, true);
> -			up->wakeups_enabled = true;
> -		}
> -	} else {
> -		if (up->wakeups_enabled) {
> -			pdata->enable_wakeup(up->pdev, false);
> -			up->wakeups_enabled = false;
> -		}
> -	}
> -
>  	/* Errata i291 */
>  	if (up->use_dma && pdata->set_forceidle &&
>  			(up->errata & UART_ERRATA_i291_DMA_FORCEIDLE))
> @@ -1618,6 +1605,11 @@ static int serial_omap_runtime_resume(struct device *dev)
>  				serial_omap_restore_context(up);
>  		}
>  
> +		if (!up->wakeups_enabled) {
> +			pdata->enable_wakeup(up->pdev, true);
> +			up->wakeups_enabled = true;
> +		}

You put the disable in ->suspend, but the enable in ->runtime_resume.

Doesn't this belong in ->resume ?

Kevin

>  		/* Errata i291 */
>  		if (up->use_dma && pdata->set_noidle &&
>  				(up->errata & UART_ERRATA_i291_DMA_FORCEIDLE))



[1] Feel free to fold this into your original patch.

>From 8a4a24998aaf35240f0010b172537da64351a7d6 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Tue, 17 Apr 2012 16:24:05 -0700
Subject: [PATCH] omap-serial: fix default wakeup settings

---
 drivers/tty/serial/omap-serial.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 4a92447..6458ec9 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -511,6 +511,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 static int serial_omap_startup(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
 	unsigned long flags = 0;
 	int retval;
 
@@ -525,6 +526,9 @@ static int serial_omap_startup(struct uart_port *port)
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
 
 	pm_runtime_get_sync(&up->pdev->dev);
+	if (pdata->enable_wakeup)
+		pdata->enable_wakeup(up->pdev, true);
+
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
@@ -589,6 +593,7 @@ static int serial_omap_startup(struct uart_port *port)
 static void serial_omap_shutdown(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	struct omap_uart_port_info *pdata = up->pdev->dev.platform_data;
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->port.line);
@@ -628,6 +633,8 @@ static void serial_omap_shutdown(struct uart_port *port)
 		up->uart_dma.rx_buf = NULL;
 	}
 
+	if (pdata->enable_wakeup)
+		pdata->enable_wakeup(up->pdev, false);
 	pm_runtime_put(&up->pdev->dev);
 	free_irq(up->port.irq, up);
 }
@@ -1475,6 +1482,9 @@ static int serial_omap_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto err_add_port;
 
+	if (omap_up_info->enable_wakeup)
+		omap_up_info->enable_wakeup(pdev, false);
+
 	pm_runtime_put(&pdev->dev);
 	platform_set_drvdata(pdev, up);
 	return 0;
-- 
1.7.9.2



[1] shell snippit for disabling C-states

# CPUidle: disable everything but C1
cd /sys/devices/system/cpu/cpu0/cpuidle
for state in state[1-6]*; do
  if [ -e ${state} ]; then 
    echo 1 > cat ${state}/disable
  fi
done
