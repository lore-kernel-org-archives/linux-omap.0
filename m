From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC/RFT PATCH 2/2] SERIAL: OMAP: Remove the idle handling from
 the driver
Date: Fri, 15 Feb 2013 18:49:20 +0530
Message-ID: <511E35D8.1030109@ti.com>
References: <1360930135-32092-1-git-send-email-santosh.shilimkar@ti.com> <20130215125740.GB16558@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40942 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161258Ab3BONSR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Feb 2013 08:18:17 -0500
In-Reply-To: <20130215125740.GB16558@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, sourav.poddar@ti.com, vaibhav.bedia@ti.com, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, Rajendra nayak <rnayak@ti.com>

On Friday 15 February 2013 06:27 PM, Felipe Balbi wrote:
> Hi,
>
> On Fri, Feb 15, 2013 at 05:38:55PM +0530, Santosh Shilimkar wrote:
>> UART IP idle handling now taken care by runtime pm apis so remove
>> the hackery from the driver.
>>
>> Signed-off-by: Rajendra nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>   arch/arm/mach-omap2/serial.c     |   31 -------------------------------
>>   drivers/tty/serial/omap-serial.c |   23 -----------------------
>>   2 files changed, 54 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
>> index 04fdbc4..037e691 100644
>> --- a/arch/arm/mach-omap2/serial.c
>> +++ b/arch/arm/mach-omap2/serial.c
>> @@ -95,38 +95,9 @@ static void omap_uart_enable_wakeup(struct device *dev, bool enable)
>>   		omap_hwmod_disable_wakeup(od->hwmods[0]);
>>   }
>>
>> -/*
>> - * Errata i291: [UART]:Cannot Acknowledge Idle Requests
>> - * in Smartidle Mode When Configured for DMA Operations.
>> - * WA: configure uart in force idle mode.
>> - */
>> -static void omap_uart_set_noidle(struct device *dev)
>> -{
>> -	struct platform_device *pdev = to_platform_device(dev);
>> -	struct omap_device *od = to_omap_device(pdev);
>> -
>> -	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_NO);
>> -}
>> -
>> -static void omap_uart_set_smartidle(struct device *dev)
>> -{
>> -	struct platform_device *pdev = to_platform_device(dev);
>> -	struct omap_device *od = to_omap_device(pdev);
>> -	u8 idlemode;
>> -
>> -	if (od->hwmods[0]->class->sysc->idlemodes & SIDLE_SMART_WKUP)
>> -		idlemode = HWMOD_IDLEMODE_SMART_WKUP;
>> -	else
>> -		idlemode = HWMOD_IDLEMODE_SMART;
>> -
>> -	omap_hwmod_set_slave_idlemode(od->hwmods[0], idlemode);
>> -}
>> -
>>   #else
>>   static void omap_uart_enable_wakeup(struct device *dev, bool enable)
>>   {}
>> -static void omap_uart_set_noidle(struct device *dev) {}
>> -static void omap_uart_set_smartidle(struct device *dev) {}
>>   #endif /* CONFIG_PM */
>>
>>   #ifdef CONFIG_OMAP_MUX
>> @@ -299,8 +270,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
>>   	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
>>   	omap_up.flags = UPF_BOOT_AUTOCONF;
>>   	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
>> -	omap_up.set_forceidle = omap_uart_set_smartidle;
>> -	omap_up.set_noidle = omap_uart_set_noidle;
>>   	omap_up.enable_wakeup = omap_uart_enable_wakeup;
>>   	omap_up.dma_rx_buf_size = info->dma_rx_buf_size;
>>   	omap_up.dma_rx_timeout = info->dma_rx_timeout;
>> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
>> index 57d6b29..5722eaf 100644
>> --- a/drivers/tty/serial/omap-serial.c
>> +++ b/drivers/tty/serial/omap-serial.c
>> @@ -201,26 +201,6 @@ static int serial_omap_get_context_loss_count(struct uart_omap_port *up)
>>   	return pdata->get_context_loss_count(up->dev);
>>   }
>>
>> -static void serial_omap_set_forceidle(struct uart_omap_port *up)
>> -{
>> -	struct omap_uart_port_info *pdata = up->dev->platform_data;
>> -
>> -	if (!pdata || !pdata->set_forceidle)
>> -		return;
>> -
>> -	pdata->set_forceidle(up->dev);
>> -}
>> -
>> -static void serial_omap_set_noidle(struct uart_omap_port *up)
>> -{
>> -	struct omap_uart_port_info *pdata = up->dev->platform_data;
>> -
>> -	if (!pdata || !pdata->set_noidle)
>> -		return;
>> -
>> -	pdata->set_noidle(up->dev);
>> -}
>> -
>>   static void serial_omap_enable_wakeup(struct uart_omap_port *up, bool enable)
>>   {
>>   	struct omap_uart_port_info *pdata = up->dev->platform_data;
>> @@ -279,8 +259,6 @@ static void serial_omap_stop_tx(struct uart_port *port)
>>   		serial_out(up, UART_IER, up->ier);
>>   	}
>>
>> -	serial_omap_set_forceidle(up);
>> -
>>   	pm_runtime_mark_last_busy(up->dev);
>>   	pm_runtime_put_autosuspend(up->dev);
>>   }
>> @@ -348,7 +326,6 @@ static void serial_omap_start_tx(struct uart_port *port)
>>
>>   	pm_runtime_get_sync(up->dev);
>>   	serial_omap_enable_ier_thri(up);
>> -	serial_omap_set_noidle(up);
>
> this patch is changing behavior. Currently driver has:
>
> start_tx()
> get_sync()
> set_noidle()
> put_autosuspend()
>
> ....
>
> stop_tx()
> get_sync()
> set_force_idle()
> put_autosuspend()
>
> with this change, you will have:
>
> start_tx()
> get_sync()
> set_noidle()
> put_autosuspend()
> set_force_idle()
>
> this in itself might be enough to go back to corrupted serial if
> put_autosuspend is so quick that set_force_idle() is called before all
> data has been shifted out of FIFO and through the UART lines.
>
Really. Infact the old sequence was buggy because you are setting 
force_idle even before suspending the device. And that force idle
isn't really force idle but setting ip to smart idle. Just look at
what serial.c

> Before doing this, you should at least test that removing
> pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() from
> start_tx() and removing pm_runtime_get_sync() from stop_tx() works fine.
>
Seems to work for me with above changes as well. Can you please
try out and see if you see any issue. I doubt you will...

> Also, $SUBJECT isn't improving the situation regarding UART Wakeup,
> there is still the regression of UART never being wakeup capable.
>
You are mixing the stuff here. The subject is correct.

> I wonder what are your ideas to sort that part out, I mean, how do you
> plan to implement ->set_wake() for the tty port ?
>
That is not related to module idle modes. It is for ioring and that
needs pin control support. As you can see the patch doesn't touch
omap_uart_enable_wakeup(). Thats needs pincontrol support so that
it can be made work with DT. Today hwmod handles that for you with
pin information provided by platform code.

> One last comment, to avoid conflicts, it'd be better to split driver
> part from removal of platform_data function pointer initialization, so
> that we can send driver changes in one merge window and the
> platform_data part in another.
>
Agree. We can split the patch once everybody is ok with it.

Regards
Santosh
