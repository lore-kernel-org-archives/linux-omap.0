From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v7 17/21] OMAP2+: UART: Remove omap_uart_can_sleep and
 add pm_qos
Date: Tue, 08 Nov 2011 14:46:24 +0530
Message-ID: <4EB8F368.5070603@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>	<1318952110-10659-3-git-send-email-govindraj.raja@ti.com> <87vcqz33y8.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:57769 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752869Ab1KHJQf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 04:16:35 -0500
In-Reply-To: <87vcqz33y8.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On Saturday 05 November 2011 04:12 AM, Kevin Hilman wrote:
> However, as mentioned previously[1], due to a HW sleepdep between MPU
> and CORE, this constraint isn't actually needed for CORE UARTs, so it's
> a bit wasteful to go through all the constraint setting for no reason.

I had a short chat with Govind on this and was trying to understand
this better.
Are you referring to the 'autodeps' for omap3 here, because they would
prevent any clock domain from idling as long as MPU or IVA are active,
but not the other way round. Which means MPU can still idle, while CORE
does not.

My guess was, its probably the CORE domain idling itself thats causing
the UART sluggishness, (and not MPU idling), due to higher latency,
which is prevented with an active UART module in CORE, but not in PER.
So Govind did a small experiment to prevent just CORE idling and let MPU
idle alone and that did not show any sluggishness.

Now, putting a pm-qos constraint for a UART in CORE still looks
redundant because the latency requirement that UART has is in
some way *indirectly* met (because the active UART in CORE prevents
CORE transitions in idle).
But don't you think the UART driver should express its
latency constraints regardless, without thinking of any indirect ways
in which the same requirements would have already been met?

regards,
Rajendra

>
> The changelog should summarize this, and the init code should only
> enable the constraints for PER UARTs, at least on OMAP3.  I'm not sure
> about OMAP4.
>
>> >    	},
>> >    };
>> >
>> >  @@ -87,28 +88,6 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
>> >    };
>> >
>> >    #ifdef CONFIG_PM
>> >  -
>> >  -int omap_uart_can_sleep(void)
>> >  -{
>> >  -	struct omap_uart_state *uart;
>> >  -	int can_sleep = 1;
>> >  -
>> >  -	list_for_each_entry(uart,&uart_list, node) {
>> >  -		if (!uart->clocked)
>> >  -			continue;
>> >  -
>> >  -		if (!uart->can_sleep) {
>> >  -			can_sleep = 0;
>> >  -			continue;
>> >  -		}
>> >  -
>> >  -		/* This UART can now safely sleep. */
>> >  -		omap_uart_allow_sleep(uart);
>> >  -	}
>> >  -
>> >  -	return can_sleep;
>> >  -}
>> >  -
>> >    static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
>> >    {
>> >    	struct omap_device *od = to_omap_device(pdev);
>> >  @@ -363,6 +342,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
>> >    	omap_up.dma_rx_timeout = info->dma_rx_timeout;
>> >    	omap_up.dma_rx_poll_rate = info->dma_rx_poll_rate;
>> >    	omap_up.autosuspend_timeout = info->autosuspend_timeout;
>> >  +	omap_up.use_pm_qos = info->use_pm_qos;
>> >
>> >    	/* Enable the MDR1 errata for OMAP3 */
>> >    	if (cpu_is_omap34xx()&&  !cpu_is_ti816x())
>> >  diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
>> >  index 9a6879c..41eda3c 100644
>> >  --- a/arch/arm/plat-omap/include/plat/omap-serial.h
>> >  +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
>> >  @@ -19,6 +19,7 @@
>> >
>> >    #include<linux/serial_core.h>
>> >    #include<linux/platform_device.h>
>> >  +#include<linux/pm_qos_params.h>
>> >
>> >    #include<plat/mux.h>
>> >
>> >  @@ -68,6 +69,7 @@ struct omap_uart_port_info {
>> >    	unsigned int		dma_rx_timeout;
>> >    	unsigned int		autosuspend_timeout;
>> >    	unsigned int		dma_rx_poll_rate;
>> >  +	u8			use_pm_qos;
>> >
>> >    	u32 (*get_context_loss_count)(struct device *);
>> >    	void (*set_forceidle)(struct platform_device *);
>> >  @@ -129,6 +131,12 @@ struct uart_omap_port {
>> >    	u32			context_loss_cnt;
>> >    	u32			errata;
>> >    	u8			wakeups_enabled;
>> >  +
>> >  +	struct pm_qos_request_list pm_qos_request;
>> >  +	u32			latency;
>> >  +	struct work_struct	work;
> minor: call this qos_work.
>
>> >  +	u8			request_qos;
>> >  +	u8			use_pm_qos;
>> >    };
>> >
>> >    #endif /* __OMAP_SERIAL_H__ */
>> >  diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> >  index 1714bd2..956736c 100644
>> >  --- a/drivers/tty/serial/omap-serial.c
>> >  +++ b/drivers/tty/serial/omap-serial.c
>> >  @@ -51,6 +51,8 @@ static void serial_omap_rxdma_poll(unsigned long uart_no);
>> >    static int serial_omap_start_rxdma(struct uart_omap_port *up);
>> >    static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1);
>> >
>> >  +static struct workqueue_struct *serial_omap_uart_wq;
>> >  +
>> >    static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
>> >    {
>> >    	offset<<= up->port.regshift;
>> >  @@ -674,6 +676,21 @@ serial_omap_configure_xonxoff
>> >    	serial_out(up, UART_LCR, up->lcr);
>> >    }
>> >
>> >  +static void serial_omap_uart_qos_work(struct work_struct *work)
>> >  +{
>> >  +	struct uart_omap_port *up = container_of(work, struct uart_omap_port,
>> >  +						work);
>> >  +
>> >  +	if (!up->request_qos) {
>> >  +		pm_qos_add_request(&up->pm_qos_request,
>> >  +			PM_QOS_CPU_DMA_LATENCY, up->latency);
>> >  +		up->request_qos = true;
> ->request_qos is a confusing name.  ->qos_requested would help
> readability, IMO.
>
>> >  +	} else {
>> >  +		pm_qos_remove_request(&up->pm_qos_request);
>> >  +		up->request_qos = false;
>> >  +	}
>> >  +}
>> >  +
>> >    static void
>> >    serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
>> >    			struct ktermios *old)
>> >  @@ -869,6 +886,13 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
>> >    	serial_omap_configure_xonxoff(up, termios);
>> >
>> >    	spin_unlock_irqrestore(&up->port.lock, flags);
>> >  +
>> >  +	if (up->use_pm_qos) {
>> >  +		/* calculate wakeup latency constraint */
>> >  +		up->latency = (1000000 * up->port.fifosize) / (1000 * baud / 8);
>> >  +		schedule_work(&up->work);
> Is this one really needed?  There's a pm_runtime_put() right after this
> that will immediately remove the constraint.
>
> Actually, it seems like it would be better to calculate the latency
> earlier in this function (right after the baud rate) so that the
> subsequent pm_runtime_get() sets the constraint...
>
>> >  +	}
>> >  +
>> >    	pm_runtime_put(&up->pdev->dev);
> ...and this will remove the constraint.
>
>> >    	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->pdev->id);
>> >    }
>> >  @@ -1144,8 +1168,11 @@ static int serial_omap_suspend(struct device *dev)
>> >    {
>> >    	struct uart_omap_port *up = dev_get_drvdata(dev);
>> >
>> >  -	if (up)
>> >  +	if (up) {
>> >    		uart_suspend_port(&serial_omap_reg,&up->port);
>> >  +		flush_work_sync(&up->work);
>> >  +	}
>> >  +
>> >    	return 0;
>> >    }
>> >
>> >  @@ -1368,6 +1395,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>> >    	up->port.uartclk = omap_up_info->uartclk;
>> >    	up->uart_dma.uart_base = mem->start;
>> >    	up->errata = omap_up_info->errata;
>> >  +	up->use_pm_qos = omap_up_info->use_pm_qos;
>> >
>> >    	if (omap_up_info->dma_enabled) {
>> >    		up->uart_dma.uart_dma_tx = dma_tx->start;
>> >  @@ -1382,6 +1410,11 @@ static int serial_omap_probe(struct platform_device *pdev)
>> >    		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
>> >    	}
>> >
>> >  +	if (up->use_pm_qos) {
>> >  +		serial_omap_uart_wq = create_workqueue(up->name);
>> >  +		INIT_WORK(&up->work, serial_omap_uart_qos_work);
>> >  +	}
>> >  +
>> >    	pm_runtime_use_autosuspend(&pdev->dev);
>> >    	pm_runtime_set_autosuspend_delay(&pdev->dev,
>> >    			omap_up_info->autosuspend_timeout);
>> >  @@ -1516,6 +1549,9 @@ static int serial_omap_runtime_suspend(struct device *dev)
>> >    	if (up->use_dma&&  pdata->set_forceidle)
>> >    		pdata->set_forceidle(up->pdev);
>> >
>> >  +	if (up->use_pm_qos&&  up->request_qos)
>> >  +		schedule_work(&up->work);
>> >  +
>> >    	return 0;
>> >    }
>> >
>> >  @@ -1535,6 +1571,9 @@ static int serial_omap_runtime_resume(struct device *dev)
>> >    		/* Errata i291 */
>> >    		if (up->use_dma&&  pdata->set_noidle)
>> >    			pdata->set_noidle(up->pdev);
>> >  +
>> >  +		if (up->use_pm_qos&&  !up->request_qos)
>> >  +			schedule_work(&up->work);
>> >    	}
>> >
>> >    	return 0;
> Kevin
>
> [1]http://www.mail-archive.com/linux-omap@vger.kernel.org/msg57577.html

