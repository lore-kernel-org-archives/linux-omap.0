From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 2/4] can: c_can: Add d_can raminit support
Date: Tue, 4 Sep 2012 13:06:45 +0530
Message-ID: <5045AF8D.7020208@ti.com>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com> <1346673139-14540-3-git-send-email-anilkumar@ti.com> <50451573.4090109@pengutronix.de> <331ABD5ECB02734CA317220B2BBEABC13EA26305@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA26305@DBDE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "wg@grandegger.com" <wg@grandegger.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org



On 9/4/2012 11:44 AM, AnilKumar, Chimata wrote:
> Hi Marc,
> 
> On Tue, Sep 04, 2012 at 02:09:15, Marc Kleine-Budde wrote:
>> On 09/03/2012 01:52 PM, AnilKumar Ch wrote:
>>> Add D_CAN raminit support to C_CAN driver to enable D_CAN RAM.
>>> DCAN RAM holds all the message objects during transmission or
>>> receiving of data. This initialization/de-initialization should
>>> be done in synchronous with D_CAN clock.
>>>
>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>> ---
>>>  drivers/net/can/c_can/c_can.c          |   13 ++++++++++++
>>>  drivers/net/can/c_can/c_can.h          |    2 ++
>>>  drivers/net/can/c_can/c_can_platform.c |   10 +++++++++
>>>  include/linux/can/platform/c_can.h     |   36 ++++++++++++++++++++++++++++++++
>>>  4 files changed, 61 insertions(+)
>>>  create mode 100644 include/linux/can/platform/c_can.h
>>>
>>> diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
>>> index aa6c5eb..c175410 100644
>>> --- a/drivers/net/can/c_can/c_can.c
>>> +++ b/drivers/net/can/c_can/c_can.c
>>> @@ -214,6 +214,12 @@ static inline void c_can_pm_runtime_put_sync(const struct c_can_priv *priv)
>>>  		pm_runtime_put_sync(priv->device);
>>>  }
>>>  
>>> +static inline void c_can_reset_ram(const struct c_can_priv *priv, bool enable)
>>> +{
>>> +	if (priv->ram_init)
>>> +		priv->ram_init(priv->instance, enable);
>>> +}
>>> +
>>>  static inline int get_tx_next_msg_obj(const struct c_can_priv *priv)
>>>  {
>>>  	return (priv->tx_next & C_CAN_NEXT_MSG_OBJ_MASK) +
>>> @@ -1071,6 +1077,8 @@ static int c_can_open(struct net_device *dev)
>>>  	struct c_can_priv *priv = netdev_priv(dev);
>>>  
>>>  	c_can_pm_runtime_get_sync(priv);
>>> +	/* Initialize DCAN RAM */
>>> +	c_can_reset_ram(priv, true);
>>>  
>>>  	/* open the can device */
>>>  	err = open_candev(dev);
>>> @@ -1099,6 +1107,8 @@ static int c_can_open(struct net_device *dev)
>>>  exit_irq_fail:
>>>  	close_candev(dev);
>>>  exit_open_fail:
>>> +	/* De-Initialize DCAN RAM */
>>> +	c_can_reset_ram(priv, false);
>>>  	c_can_pm_runtime_put_sync(priv);
>>>  	return err;
>>>  }
>>> @@ -1112,6 +1122,9 @@ static int c_can_close(struct net_device *dev)
>>>  	c_can_stop(dev);
>>>  	free_irq(dev->irq, dev);
>>>  	close_candev(dev);
>>> +
>>> +	/* De-Initialize DCAN RAM */
>>> +	c_can_reset_ram(priv, false);
>>>  	c_can_pm_runtime_put_sync(priv);
>>>  
>>>  	return 0;
>>> diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
>>> index 1437a6d..5f6339c 100644
>>> --- a/drivers/net/can/c_can/c_can.h
>>> +++ b/drivers/net/can/c_can/c_can.h
>>> @@ -166,6 +166,8 @@ struct c_can_priv {
>>>  	unsigned int tx_echo;
>>>  	void *priv;		/* for board-specific data */
>>>  	u16 irqstatus;
>>> +	unsigned int instance;
>>> +	void (*ram_init) (unsigned int instance, bool enable);
>>>  };
>>>  
>>>  struct net_device *alloc_c_can_dev(void);
>>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
>>> index c351975..c6963b2 100644
>>> --- a/drivers/net/can/c_can/c_can_platform.c
>>> +++ b/drivers/net/can/c_can/c_can_platform.c
>>> @@ -34,6 +34,7 @@
>>>  #include <linux/of_device.h>
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/pinctrl/consumer.h>
>>> +#include <linux/can/platform/c_can.h>
>>>  
>>>  #include <linux/can/dev.h>
>>>  
>>> @@ -98,6 +99,7 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>>>  	struct net_device *dev;
>>>  	struct c_can_priv *priv;
>>>  	const struct of_device_id *match;
>>> +	struct c_can_platform_data *pdata = NULL;
>>>  	const struct platform_device_id *id;
>>>  	struct pinctrl *pinctrl;
>>>  	struct resource *mem;
>>> @@ -179,6 +181,14 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>>>  		priv->can.ctrlmode_supported |= CAN_CTRLMODE_3_SAMPLES;
>>>  		priv->read_reg = c_can_plat_read_reg_aligned_to_16bit;
>>>  		priv->write_reg = c_can_plat_write_reg_aligned_to_16bit;
>>> +		pdata = pdev->dev.platform_data;
>>> +		if (!pdata) {
>>> +			dev_err(&pdev->dev, "d_can platform data missing\n");
>>> +			ret = -EINVAL;
>>
>> Is the ram_init mandatory on all d_can? There might be non omap d_can users.
> 
> As per AM335x specifications d_can module should have ram_init.
> In that case it's better to print warning and break the switch.
> 

As far as I know, "ram_init" is part of IP spec, how it is controlled
does varies based on SoC integration.

Thanks,
Vaibhav
>>
>> Marc
>>
>>> +			goto exit_free_device;
>>> +		}
>>> +		priv->ram_init = pdata->ram_init;
>>> +		priv->instance = pdata->instance;
>>>  		break;
>>>  	default:
>>>  		ret = -EINVAL;
>>> diff --git a/include/linux/can/platform/c_can.h b/include/linux/can/platform/c_can.h
>>> new file mode 100644
>>> index 0000000..84b27d2
>>> --- /dev/null
>>> +++ b/include/linux/can/platform/c_can.h
>>> @@ -0,0 +1,36 @@
>>> +/*
>>> + * C_CAN controller driver platform header
>>> + *
>>> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
>>> + *
>>> + * Bosch C_CAN/D_CAN controller is compliant to CAN protocol version 2.0
>>> + * part A and B.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License as
>>> + * published by the Free Software Foundation version 2.
>>> + *
>>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>>> + * kind, whether express or implied; without even the implied warranty
>>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + */
>>> +
>>> +#ifndef __CAN_PLATFORM_C_CAN_H__
>>> +#define __CAN_PLATFORM_C_CAN_H__
>>> +
>>> +/**
>>> + * struct c_can_platform_data - C_CAN/D_CAN Platform Data
>>> + *
>>> + * @instance:		CAN instance, required for d_can raminit
>>> + * @ram_init:		CAN RAM initialization
>>> + *
>>> + * Platform data structure to get all platform specific settings.
>>> + * this structure also accounts the fact that the IP may have different
>>> + * RAM for different SOC's
>>> + */
>>> +struct c_can_platform_data {
>>> +	unsigned int instance;
>>> +	void (*ram_init) (unsigned int instance, bool enable);
>>> +};
>>> +#endif
>>>
>>
>>
>> -- 
>> Pengutronix e.K.                  | Marc Kleine-Budde           |
>> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
>> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
>> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
>>
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
