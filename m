From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch] Fix brf6510 cleanup code
Date: Mon, 15 Jun 2009 01:02:43 -0700
Message-ID: <20090615080242.GD4474@atomide.com>
References: <20090530180721.75203sfsqbpppfi8@lidskialf.net> <20090608210333.11295srly8te8xog@lidskialf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63625 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756581AbZFOICn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 04:02:43 -0400
Content-Disposition: inline
In-Reply-To: <20090608210333.11295srly8te8xog@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew de Quincey <adq_dvb@lidskialf.net>, "Tervo Ville (NMP/Helsinki)" <Ville.Tervo@nokia.com>
Cc: linux-omap@vger.kernel.org

* Andrew de Quincey <adq_dvb@lidskialf.net> [090608 13:04]:
> The brf6150 driver is missing several necessary cleanup steps to allow  
> module unloading. Add them.

I've removed the brf6150 from linux-omap as this should get merged into
the mainline kernel via bt list.

Ville & Andrew, can you guys please coordinate on the bt list to get
the driver merged in? I believe there were some changes needed for
passing the hw address as a module option and for loading the firmware
or something..

Thanks,

Tony

> Signed-off-by: Andrew de Quincey <adq@lidskialf.net>
>

> commit bf0e4cba53819df5590a88d551b35a2e79f4de75
> Author: Andrew de Quincey <adq@lidskialf.net>
> Date:   Sat May 30 18:01:58 2009 +0100
> 
>     Fix brf6150 init/shutdown cleanup
> 
> diff --git a/drivers/bluetooth/brf6150.c b/drivers/bluetooth/brf6150.c
> index f29caf5..4f0112a 100644
> --- a/drivers/bluetooth/brf6150.c
> +++ b/drivers/bluetooth/brf6150.c
> @@ -312,7 +312,7 @@ static int brf6150_send_negotiation(struct brf6150_info *info)
>  	skb = brf6150_read_fw_cmd(info, GFP_KERNEL);
>  
>  	if (!skb) {
> -		printk(KERN_WARNING "Cannot read negoatiation message");
> +		printk(KERN_WARNING "Cannot read negotiation message");
>  		return -1;
>  	}
>  
> @@ -873,6 +873,7 @@ static int brf6150_register_hdev(struct brf6150_info *info)
>  	hdev->owner = THIS_MODULE;
>  
>  	if (hci_register_dev(hdev) < 0) {
> +		hci_free_dev(hdev);
>  		printk(KERN_WARNING "brf6150: Can't register HCI device %s.\n", hdev->name);
>  		return -ENODEV;
>  	}
> @@ -885,10 +886,9 @@ static int __init brf6150_init(void)
>  	struct brf6150_info *info;
>  	int irq, err;
>  
> -	info = kmalloc(sizeof(struct brf6150_info), GFP_KERNEL);
> +	info = kzalloc(sizeof(struct brf6150_info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> -	memset(info, 0, sizeof(struct brf6150_info));
>  
>  	brf6150_device.dev.driver_data = info;
>  	init_completion(&info->init_completion);
> @@ -906,8 +906,11 @@ static int __init brf6150_init(void)
>  	exit_info = NULL;
>  
>  	info->btinfo = omap_get_config(OMAP_TAG_NOKIA_BT, struct omap_bluetooth_config);
> -	if (info->btinfo == NULL)
> +	if (info->btinfo == NULL) {
> +		tasklet_kill(&info->tx_task);
> +		kfree(info);
>  		return -1;
> +	}
>  
>  	NBT_DBG("RESET gpio: %d\n", info->btinfo->reset_gpio);
>  	NBT_DBG("BTWU gpio: %d\n", info->btinfo->bt_wakeup_gpio);
> @@ -920,6 +923,7 @@ static int __init brf6150_init(void)
>  	{
>  		printk(KERN_WARNING "Cannot get GPIO line %d", 
>  		       info->btinfo->reset_gpio);
> +		tasklet_kill(&info->tx_task);
>  		kfree(info);
>  		return err;
>  	}
> @@ -930,6 +934,7 @@ static int __init brf6150_init(void)
>  		printk(KERN_WARNING "Cannot get GPIO line 0x%d",
>  		       info->btinfo->bt_wakeup_gpio);
>  		gpio_free(info->btinfo->reset_gpio);
> +		tasklet_kill(&info->tx_task);
>  		kfree(info);
>  		return err;
>  	}
> @@ -941,6 +946,7 @@ static int __init brf6150_init(void)
>  		       info->btinfo->host_wakeup_gpio);
>  		gpio_free(info->btinfo->reset_gpio);
>  		gpio_free(info->btinfo->bt_wakeup_gpio);
> +		tasklet_kill(&info->tx_task);
>  		kfree(info);
>  		return err;
>  	}
> @@ -1027,6 +1033,7 @@ cleanup:
>  	gpio_free(info->btinfo->reset_gpio);
>  	gpio_free(info->btinfo->bt_wakeup_gpio);
>  	gpio_free(info->btinfo->host_wakeup_gpio);
> +	tasklet_kill(&info->tx_task);
>  	kfree(info);
>  
>  	return err;
> @@ -1035,12 +1042,16 @@ cleanup:
>  static void __exit brf6150_exit(void)
>  {
>  	brf6150_hci_close(exit_info->hdev);
> +	hci_unregister_dev(exit_info->hdev);
>  	hci_free_dev(exit_info->hdev);
>  	gpio_free(exit_info->btinfo->reset_gpio);
>  	gpio_free(exit_info->btinfo->bt_wakeup_gpio);
>  	gpio_free(exit_info->btinfo->host_wakeup_gpio);
>  	free_irq(exit_info->irq, (void *)exit_info);
>  	free_irq(gpio_to_irq(exit_info->btinfo->host_wakeup_gpio), (void *)exit_info);
> +	tasklet_kill(&exit_info->tx_task);
> +	platform_device_unregister(&brf6150_device);
> +	platform_driver_unregister(&brf6150_driver);
>  	kfree(exit_info);
>  }
>  
