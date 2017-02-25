From: Mauro Carvalho Chehab <mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH] [media] serial_ir: ensure we're ready to receive
 interrupts
Date: Sat, 25 Feb 2017 10:34:37 -0300
Message-ID: <20170225103437.58c5a199@vento.lan>
References: <58b07b30.9XFLj9Hhl7F6HMc2%fengguang.wu@intel.com>
 <CA+55aFytXj+TZ_TanbxcY0KgRTrV7Vvr=fWON8tioUGmYHYiNA@mail.gmail.com>
 <20170225111424.GA7659@gofer.mess.org>
 <20170225112816.GA7981@gofer.mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170225112816.GA7981-3XSxi2G4b3iXFJAUJl40Xg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sean Young <sean-hENCXIMQXOg@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ruslan Ruslichenko <rruslich-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, wfg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Linux LED Subsystem <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, kernel test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKP <lkp-JC7UmRfGjtg@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Em Sat, 25 Feb 2017 11:28:16 +0000
Sean Young <sean-hENCXIMQXOg@public.gmane.org> escreveu:

> When the interrupt requested with devm_request_irq(), serial_ir.rcdev
> is still null so will cause null deference if the irq handler is called
> early on.
> 
> Also ensure that timeout_timer is setup.
> 
> Link: http://lkml.kernel.org/r/CA+55aFxsh2uF8gi5sN_guY3Z+tiLv7LpJYKBw+y8vqLzp+TsnQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org
> 
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.10
> Signed-off-by: Sean Young <sean-hENCXIMQXOg@public.gmane.org>
> ---
>  drivers/media/rc/serial_ir.c | 243 +++++++++++++++++++++----------------------
>  1 file changed, 118 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
> index 923fb22..22144b4 100644
> --- a/drivers/media/rc/serial_ir.c
> +++ b/drivers/media/rc/serial_ir.c
> @@ -487,74 +487,6 @@ static void serial_ir_timeout(unsigned long arg)
>  	ir_raw_event_handle(serial_ir.rcdev);
>  }
>  
> -static int serial_ir_probe(struct platform_device *dev)
> -{
> -	int i, nlow, nhigh, result;

Hmm... why did you move this function to be after serial_ir_open()?

That messes with the diff without no good reason, making harder to
identify what you changed here.

> -
> -	result = devm_request_irq(&dev->dev, irq, serial_ir_irq_handler,
> -				  share_irq ? IRQF_SHARED : 0,
> -				  KBUILD_MODNAME, &hardware);
> -	if (result < 0) {
> -		if (result == -EBUSY)
> -			dev_err(&dev->dev, "IRQ %d busy\n", irq);
> -		else if (result == -EINVAL)
> -			dev_err(&dev->dev, "Bad irq number or handler\n");
> -		return result;
> -	}
> -
> -	/* Reserve io region. */
> -	if ((iommap &&
> -	     (devm_request_mem_region(&dev->dev, iommap, 8 << ioshift,
> -				      KBUILD_MODNAME) == NULL)) ||
> -	     (!iommap && (devm_request_region(&dev->dev, io, 8,
> -			  KBUILD_MODNAME) == NULL))) {
> -		dev_err(&dev->dev, "port %04x already in use\n", io);
> -		dev_warn(&dev->dev, "use 'setserial /dev/ttySX uart none'\n");
> -		dev_warn(&dev->dev,
> -			 "or compile the serial port driver as module and\n");
> -		dev_warn(&dev->dev, "make sure this module is loaded first\n");
> -		return -EBUSY;
> -	}
> -
> -	setup_timer(&serial_ir.timeout_timer, serial_ir_timeout,
> -		    (unsigned long)&serial_ir);
> -
> -	result = hardware_init_port();
> -	if (result < 0)
> -		return result;
> -
> -	/* Initialize pulse/space widths */
> -	init_timing_params(50, 38000);
> -
> -	/* If pin is high, then this must be an active low receiver. */
> -	if (sense == -1) {
> -		/* wait 1/2 sec for the power supply */
> -		msleep(500);
> -
> -		/*
> -		 * probe 9 times every 0.04s, collect "votes" for
> -		 * active high/low
> -		 */
> -		nlow = 0;
> -		nhigh = 0;
> -		for (i = 0; i < 9; i++) {
> -			if (sinp(UART_MSR) & hardware[type].signal_pin)
> -				nlow++;
> -			else
> -				nhigh++;
> -			msleep(40);
> -		}
> -		sense = nlow >= nhigh ? 1 : 0;
> -		dev_info(&dev->dev, "auto-detected active %s receiver\n",
> -			 sense ? "low" : "high");
> -	} else
> -		dev_info(&dev->dev, "Manually using active %s receiver\n",
> -			 sense ? "low" : "high");
> -
> -	dev_dbg(&dev->dev, "Interrupt %d, port %04x obtained\n", irq, io);
> -	return 0;
> -}
> -
>  static int serial_ir_open(struct rc_dev *rcdev)
>  {
>  	unsigned long flags;
> @@ -679,6 +611,123 @@ static int serial_ir_resume(struct platform_device *dev)
>  	return 0;
>  }
>  
> +static int serial_ir_probe(struct platform_device *dev)
> +{
> +	struct rc_dev *rcdev;
> +	int i, nlow, nhigh, result;
> +
> +	rcdev = devm_rc_allocate_device(&dev->dev, RC_DRIVER_IR_RAW);
> +	if (!rcdev)
> +		return -ENOMEM;
> +
> +	if (hardware[type].send_pulse && hardware[type].send_space)
> +		rcdev->tx_ir = serial_ir_tx;
> +	if (hardware[type].set_send_carrier)
> +		rcdev->s_tx_carrier = serial_ir_tx_carrier;
> +	if (hardware[type].set_duty_cycle)
> +		rcdev->s_tx_duty_cycle = serial_ir_tx_duty_cycle;
> +
> +	switch (type) {
> +	case IR_HOMEBREW:
> +		rcdev->input_name = "Serial IR type home-brew";
> +		break;
> +	case IR_IRDEO:
> +		rcdev->input_name = "Serial IR type IRdeo";
> +		break;
> +	case IR_IRDEO_REMOTE:
> +		rcdev->input_name = "Serial IR type IRdeo remote";
> +		break;
> +	case IR_ANIMAX:
> +		rcdev->input_name = "Serial IR type AnimaX";
> +		break;
> +	case IR_IGOR:
> +		rcdev->input_name = "Serial IR type IgorPlug";
> +		break;
> +	}
> +
> +	rcdev->input_phys = KBUILD_MODNAME "/input0";
> +	rcdev->input_id.bustype = BUS_HOST;
> +	rcdev->input_id.vendor = 0x0001;
> +	rcdev->input_id.product = 0x0001;
> +	rcdev->input_id.version = 0x0100;
> +	rcdev->open = serial_ir_open;
> +	rcdev->close = serial_ir_close;
> +	rcdev->dev.parent = &serial_ir.pdev->dev;
> +	rcdev->allowed_protocols = RC_BIT_ALL_IR_DECODER;
> +	rcdev->driver_name = KBUILD_MODNAME;
> +	rcdev->map_name = RC_MAP_RC6_MCE;
> +	rcdev->min_timeout = 1;
> +	rcdev->timeout = IR_DEFAULT_TIMEOUT;
> +	rcdev->max_timeout = 10 * IR_DEFAULT_TIMEOUT;
> +	rcdev->rx_resolution = 250000;
> +
> +	serial_ir.rcdev = rcdev;
> +
> +	setup_timer(&serial_ir.timeout_timer, serial_ir_timeout,
> +		    (unsigned long)&serial_ir);
> +
> +	result = devm_request_irq(&dev->dev, irq, serial_ir_irq_handler,
> +				  share_irq ? IRQF_SHARED : 0,
> +				  KBUILD_MODNAME, &hardware);
> +	if (result < 0) {
> +		if (result == -EBUSY)
> +			dev_err(&dev->dev, "IRQ %d busy\n", irq);
> +		else if (result == -EINVAL)
> +			dev_err(&dev->dev, "Bad irq number or handler\n");
> +		return result;
> +	}
> +
> +	/* Reserve io region. */
> +	if ((iommap &&
> +	     (devm_request_mem_region(&dev->dev, iommap, 8 << ioshift,
> +				      KBUILD_MODNAME) == NULL)) ||
> +	     (!iommap && (devm_request_region(&dev->dev, io, 8,
> +			  KBUILD_MODNAME) == NULL))) {
> +		dev_err(&dev->dev, "port %04x already in use\n", io);
> +		dev_warn(&dev->dev, "use 'setserial /dev/ttySX uart none'\n");
> +		dev_warn(&dev->dev,
> +			 "or compile the serial port driver as module and\n");
> +		dev_warn(&dev->dev, "make sure this module is loaded first\n");
> +		return -EBUSY;
> +	}
> +
> +	result = hardware_init_port();
> +	if (result < 0)
> +		return result;
> +
> +	/* Initialize pulse/space widths */
> +	init_timing_params(50, 38000);
> +
> +	/* If pin is high, then this must be an active low receiver. */
> +	if (sense == -1) {
> +		/* wait 1/2 sec for the power supply */
> +		msleep(500);
> +
> +		/*
> +		 * probe 9 times every 0.04s, collect "votes" for
> +		 * active high/low
> +		 */
> +		nlow = 0;
> +		nhigh = 0;
> +		for (i = 0; i < 9; i++) {
> +			if (sinp(UART_MSR) & hardware[type].signal_pin)
> +				nlow++;
> +			else
> +				nhigh++;
> +			msleep(40);
> +		}
> +		sense = nlow >= nhigh ? 1 : 0;
> +		dev_info(&dev->dev, "auto-detected active %s receiver\n",
> +			 sense ? "low" : "high");
> +	} else
> +		dev_info(&dev->dev, "Manually using active %s receiver\n",
> +			 sense ? "low" : "high");
> +
> +	dev_dbg(&dev->dev, "Interrupt %d, port %04x obtained\n", irq, io);
> +
> +	return devm_rc_register_device(&dev->dev, rcdev);
> +}
> +
>  static struct platform_driver serial_ir_driver = {
>  	.probe		= serial_ir_probe,
>  	.suspend	= serial_ir_suspend,
> @@ -723,7 +772,6 @@ static void serial_ir_exit(void)
>  
>  static int __init serial_ir_init_module(void)
>  {
> -	struct rc_dev *rcdev;
>  	int result;
>  
>  	switch (type) {
> @@ -754,63 +802,9 @@ static int __init serial_ir_init_module(void)
>  		sense = !!sense;
>  
>  	result = serial_ir_init();
> -	if (result)
> -		return result;
> -
> -	rcdev = devm_rc_allocate_device(&serial_ir.pdev->dev, RC_DRIVER_IR_RAW);
> -	if (!rcdev) {
> -		result = -ENOMEM;
> -		goto serial_cleanup;
> -	}
> -
> -	if (hardware[type].send_pulse && hardware[type].send_space)
> -		rcdev->tx_ir = serial_ir_tx;
> -	if (hardware[type].set_send_carrier)
> -		rcdev->s_tx_carrier = serial_ir_tx_carrier;
> -	if (hardware[type].set_duty_cycle)
> -		rcdev->s_tx_duty_cycle = serial_ir_tx_duty_cycle;
> -
> -	switch (type) {
> -	case IR_HOMEBREW:
> -		rcdev->input_name = "Serial IR type home-brew";
> -		break;
> -	case IR_IRDEO:
> -		rcdev->input_name = "Serial IR type IRdeo";
> -		break;
> -	case IR_IRDEO_REMOTE:
> -		rcdev->input_name = "Serial IR type IRdeo remote";
> -		break;
> -	case IR_ANIMAX:
> -		rcdev->input_name = "Serial IR type AnimaX";
> -		break;
> -	case IR_IGOR:
> -		rcdev->input_name = "Serial IR type IgorPlug";
> -		break;
> -	}
> -
> -	rcdev->input_phys = KBUILD_MODNAME "/input0";
> -	rcdev->input_id.bustype = BUS_HOST;
> -	rcdev->input_id.vendor = 0x0001;
> -	rcdev->input_id.product = 0x0001;
> -	rcdev->input_id.version = 0x0100;
> -	rcdev->open = serial_ir_open;
> -	rcdev->close = serial_ir_close;
> -	rcdev->dev.parent = &serial_ir.pdev->dev;
> -	rcdev->allowed_protocols = RC_BIT_ALL_IR_DECODER;
> -	rcdev->driver_name = KBUILD_MODNAME;
> -	rcdev->map_name = RC_MAP_RC6_MCE;
> -	rcdev->min_timeout = 1;
> -	rcdev->timeout = IR_DEFAULT_TIMEOUT;
> -	rcdev->max_timeout = 10 * IR_DEFAULT_TIMEOUT;
> -	rcdev->rx_resolution = 250000;
> -
> -	serial_ir.rcdev = rcdev;
> -
> -	result = rc_register_device(rcdev);
> -
>  	if (!result)
>  		return 0;
> -serial_cleanup:
> +
>  	serial_ir_exit();
>  	return result;
>  }
> @@ -818,7 +812,6 @@ static int __init serial_ir_init_module(void)
>  static void __exit serial_ir_exit_module(void)
>  {
>  	del_timer_sync(&serial_ir.timeout_timer);
> -	rc_unregister_device(serial_ir.rcdev);
>  	serial_ir_exit();
>  }
>  



Thanks,
Mauro
