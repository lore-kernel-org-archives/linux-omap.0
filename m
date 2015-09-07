From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4 07/13] usb: otg: add OTG core
Date: Mon, 7 Sep 2015 13:23:01 +0300
Message-ID: <55ED6585.5050200@ti.com>
References: <1440422484-4737-1-git-send-email-rogerq@ti.com>
 <1440422484-4737-8-git-send-email-rogerq@ti.com>
 <20150907012327.GG4914@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150907012327.GG4914@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 07/09/15 04:23, Peter Chen wrote:
> On Mon, Aug 24, 2015 at 04:21:18PM +0300, Roger Quadros wrote:
>> + * This is used by the USB Host stack to register the Host controller
>> + * to the OTG core. Host controller must not be started by the
>> + * caller as it is left upto the OTG state machine to do so.
>> + *
>> + * Returns: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>> +			 unsigned long irqflags, struct otg_hcd_ops *ops)
>> +{
>> +	struct usb_otg *otgd;
>> +	struct device *hcd_dev = hcd->self.controller;
>> +	struct device *otg_dev = usb_otg_get_device(hcd_dev);
>> +
> 
> One big problem here is: there are two designs for current (IP) driver
> code, one creates dedicated hcd device as roothub's parent, like dwc3.
> Another one doesn't do this, roothub's parent is core device (or otg device
> in your patch), like chipidea and dwc2.
> 
> Then, otg_dev will be glue layer device for chipidea after that.

OK. Let's add a way for the otg controller driver to provide the host and gadget
information to the otg core for such devices like chipidea and dwc2.

This API must be called before the hcd/gadget-driver is added so that the otg
core knows it's linked to an OTG controller.

Any better idea?

cheers,
-roger

> 
> Peter
> 
>> +	if (!otg_dev)
>> +		return -EINVAL;	/* we're definitely not OTG */
>> +
>> +	/* we're otg but otg controller might not yet be registered */
>> +	mutex_lock(&otg_list_mutex);
>> +	otgd = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otgd) {
>> +		dev_dbg(hcd_dev,
>> +			"otg: controller not yet registered. waiting..\n");
>> +		/*
>> +		 * otg controller might register later. Put the hcd in
>> +		 * wait list and call us back when ready
>> +		 */
>> +		if (usb_otg_hcd_wait_add(otg_dev, hcd, irqnum, irqflags, ops)) {
>> +			dev_dbg(hcd_dev, "otg: failed to add to wait list\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +	/* HCD will be started by OTG fsm when needed */
>> +	mutex_lock(&otgd->fsm.lock);
>> +	if (otgd->primary_hcd.hcd) {
>> +		/* probably a shared HCD ? */
>> +		if (usb_otg_hcd_is_primary_hcd(hcd)) {
>> +			dev_err(otg_dev, "otg: primary host already registered\n");
>> +			goto err;
>> +		}
>> +
>> +		if (hcd->shared_hcd == otgd->primary_hcd.hcd) {
>> +			if (otgd->shared_hcd.hcd) {
>> +				dev_err(otg_dev, "otg: shared host already registered\n");
>> +				goto err;
>> +			}
>> +
>> +			otgd->shared_hcd.hcd = hcd;
>> +			otgd->shared_hcd.irqnum = irqnum;
>> +			otgd->shared_hcd.irqflags = irqflags;
>> +			otgd->shared_hcd.ops = ops;
>> +			dev_info(otg_dev, "otg: shared host %s registered\n",
>> +				 dev_name(hcd->self.controller));
>> +		} else {
>> +			dev_err(otg_dev, "otg: invalid shared host %s\n",
>> +				dev_name(hcd->self.controller));
>> +			goto err;
>> +		}
>> +	} else {
>> +		if (!usb_otg_hcd_is_primary_hcd(hcd)) {
>> +			dev_err(otg_dev, "otg: primary host must be registered first\n");
>> +			goto err;
>> +		}
>> +
>> +		otgd->primary_hcd.hcd = hcd;
>> +		otgd->primary_hcd.irqnum = irqnum;
>> +		otgd->primary_hcd.irqflags = irqflags;
>> +		otgd->primary_hcd.ops = ops;
>> +		dev_info(otg_dev, "otg: primary host %s registered\n",
>> +			 dev_name(hcd->self.controller));
>> +	}
>> +
>> +	/*
>> +	 * we're ready only if we have shared HCD
>> +	 * or we don't need shared HCD.
>> +	 */
>> +	if (otgd->shared_hcd.hcd || !otgd->primary_hcd.hcd->shared_hcd) {
>> +		otgd->fsm.otg->host = hcd_to_bus(hcd);
>> +		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
>> +
>> +		/* start FSM */
>> +		usb_otg_start_fsm(&otgd->fsm);
>> +	} else {
>> +		dev_dbg(otg_dev, "otg: can't start till shared host registers\n");
>> +	}
>> +
>> +	mutex_unlock(&otgd->fsm.lock);
>> +
>> +	return 0;
>> +
>> +err:
>> +	mutex_unlock(&otgd->fsm.lock);
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_register_hcd);
>> +
>> +/**
>> + * usb_otg_unregister_hcd - Unregister Host controller from OTG core
>> + * @hcd:	Host controller device
>> + *
>> + * This is used by the USB Host stack to unregister the Host controller
>> + * from the OTG core. Ensures that Host controller is not running
>> + * on successful return.
>> + *
>> + * Returns: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_unregister_hcd(struct usb_hcd *hcd)
>> +{
>> +	struct usb_otg *otgd;
>> +	struct device *hcd_dev = hcd_to_bus(hcd)->controller;
>> +	struct device *otg_dev = usb_otg_get_device(hcd_dev);
>> +
>> +	if (!otg_dev)
>> +		return -EINVAL;	/* we're definitely not OTG */
>> +
>> +	mutex_lock(&otg_list_mutex);
>> +	otgd = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otgd) {
>> +		/* are we in wait list? */
>> +		if (!usb_otg_hcd_wait_remove(hcd))
>> +			return 0;
>> +
>> +		dev_dbg(hcd_dev, "otg: host wasn't registered with otg\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&otgd->fsm.lock);
>> +	if (hcd == otgd->primary_hcd.hcd) {
>> +		otgd->primary_hcd.hcd = NULL;
>> +		dev_info(otg_dev, "otg: primary host %s unregistered\n",
>> +			 dev_name(hcd_dev));
>> +	} else if (hcd == otgd->shared_hcd.hcd) {
>> +		otgd->shared_hcd.hcd = NULL;
>> +		dev_info(otg_dev, "otg: shared host %s unregistered\n",
>> +			 dev_name(hcd_dev));
>> +	} else {
>> +		dev_err(otg_dev, "otg: host %s wasn't registered with otg\n",
>> +			dev_name(hcd_dev));
>> +		mutex_unlock(&otgd->fsm.lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* stop FSM & Host */
>> +	usb_otg_stop_fsm(&otgd->fsm);
>> +	otgd->fsm.otg->host = NULL;
>> +
>> +	mutex_unlock(&otgd->fsm.lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_unregister_hcd);
>> +
>> +/**
>> + * usb_otg_register_gadget - Register Gadget controller to OTG core
>> + * @gadget:	Gadget controller
>> + *
>> + * This is used by the USB Gadget stack to register the Gadget controller
>> + * to the OTG core. Gadget controller must not be started by the
>> + * caller as it is left upto the OTG state machine to do so.
>> + *
>> + * Gadget core must call this only when all resources required for
>> + * gadget controller to run are available.
>> + * i.e. gadget function driver is available.
>> + *
>> + * Returns: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_register_gadget(struct usb_gadget *gadget,
>> +			    struct otg_gadget_ops *ops)
>> +{
>> +	struct usb_otg *otgd;
>> +	struct device *gadget_dev = &gadget->dev;
>> +	struct device *otg_dev = usb_otg_get_device(gadget_dev);
>> +
>> +	if (!otg_dev)
>> +		return -EINVAL;	/* we're definitely not OTG */
>> +
>> +	/* we're otg but otg controller might not yet be registered */
>> +	mutex_lock(&otg_list_mutex);
>> +	otgd = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otgd) {
>> +		dev_dbg(gadget_dev,
>> +			"otg: controller not yet registered. waiting..\n");
>> +		/*
>> +		 * otg controller might register later. Put the gadget in
>> +		 * wait list and call us back when ready
>> +		 */
>> +		if (usb_otg_gadget_wait_add(otg_dev, gadget, ops)) {
>> +			dev_dbg(gadget_dev, "otg: failed to add to wait list\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +	mutex_lock(&otgd->fsm.lock);
>> +	if (otgd->fsm.otg->gadget) {
>> +		dev_err(otg_dev, "otg: gadget already registered with otg\n");
>> +		mutex_unlock(&otgd->fsm.lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	otgd->fsm.otg->gadget = gadget;
>> +	otgd->gadget_ops = ops;
>> +	dev_info(otg_dev, "otg: gadget %s registered\n",
>> +		 dev_name(&gadget->dev));
>> +
>> +	/* start FSM */
>> +	usb_otg_start_fsm(&otgd->fsm);
>> +	mutex_unlock(&otgd->fsm.lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_register_gadget);
>> +
>> +/**
>> + * usb_otg_unregister_gadget - Unregister Gadget controller from OTG core
>> + * @gadget:	Gadget controller
>> + *
>> + * This is used by the USB Gadget stack to unregister the Gadget controller
>> + * from the OTG core. Ensures that Gadget controller is not running
>> + * on successful return.
>> + *
>> + * Returns: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_unregister_gadget(struct usb_gadget *gadget)
>> +{
>> +	struct usb_otg *otgd;
>> +	struct device *gadget_dev = &gadget->dev;
>> +	struct device *otg_dev = usb_otg_get_device(gadget_dev);
>> +
>> +	if (!otg_dev)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&otg_list_mutex);
>> +	otgd = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otgd) {
>> +		/* are we in wait list? */
>> +		if (!usb_otg_gadget_wait_remove(gadget))
>> +			return 0;
>> +
>> +		dev_dbg(gadget_dev, "otg: gadget wasn't registered with otg\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&otgd->fsm.lock);
>> +	if (otgd->fsm.otg->gadget != gadget) {
>> +		dev_err(otg_dev, "otg: gadget %s wasn't registered with otg\n",
>> +			dev_name(&gadget->dev));
>> +		mutex_unlock(&otgd->fsm.lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Stop FSM & gadget */
>> +	usb_otg_stop_fsm(&otgd->fsm);
>> +	otgd->fsm.otg->gadget = NULL;
>> +	mutex_unlock(&otgd->fsm.lock);
>> +
>> +	dev_info(otg_dev, "otg: gadget %s unregistered\n",
>> +		 dev_name(&gadget->dev));
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_unregister_gadget);
>> +
>> +/**
>> + * usb_otg_fsm_to_dev - Get OTG controller device from struct otg_fsm
>> + * @fsm:	otg_fsm data structure
>> + *
>> + * This is used by the OTG controller driver to get it's device node
>> + * from any of the otg_fsm->ops.
>> + */
>> +struct device *usb_otg_fsm_to_dev(struct otg_fsm *fsm)
>> +{
>> +	struct usb_otg *otgd = container_of(fsm, struct usb_otg, fsm);
>> +
>> +	return otgd->dev;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_fsm_to_dev);
>> diff --git a/drivers/usb/common/usb-otg.h b/drivers/usb/common/usb-otg.h
>> new file mode 100644
>> index 0000000..05331f0
>> --- /dev/null
>> +++ b/drivers/usb/common/usb-otg.h
>> @@ -0,0 +1,71 @@
>> +/**
>> + * drivers/usb/common/usb-otg.h - USB OTG core local header
>> + *
>> + * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
>> + * Author: Roger Quadros <rogerq@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#ifndef __DRIVERS_USB_COMMON_USB_OTG_H
>> +#define __DRIVERS_USB_COMMON_USB_OTG_H
>> +
>> +/*
>> + *  A-DEVICE timing constants
>> + */
>> +
>> +/* Wait for VBUS Rise  */
>> +#define TA_WAIT_VRISE        (100)	/* a_wait_vrise: section 7.1.2
>> +					 * a_wait_vrise_tmr: section 7.4.5.1
>> +					 * TA_VBUS_RISE <= 100ms, section 4.4
>> +					 * Table 4-1: Electrical Characteristics
>> +					 * ->DC Electrical Timing
>> +					 */
>> +/* Wait for VBUS Fall  */
>> +#define TA_WAIT_VFALL        (1000)	/* a_wait_vfall: section 7.1.7
>> +					 * a_wait_vfall_tmr: section: 7.4.5.2
>> +					 */
>> +/* Wait for B-Connect */
>> +#define TA_WAIT_BCON         (10000)	/* a_wait_bcon: section 7.1.3
>> +					 * TA_WAIT_BCON: should be between 1100
>> +					 * and 30000 ms, section 5.5, Table 5-1
>> +					 */
>> +/* A-Idle to B-Disconnect */
>> +#define TA_AIDL_BDIS         (5000)	/* a_suspend min 200 ms, section 5.2.1
>> +					 * TA_AIDL_BDIS: section 5.5, Table 5-1
>> +					 */
>> +/* B-Idle to A-Disconnect */
>> +#define TA_BIDL_ADIS         (500)	/* TA_BIDL_ADIS: section 5.2.1
>> +					 * 500ms is used for B switch to host
>> +					 * for safe
>> +					 */
>> +
>> +/*
>> + * B-device timing constants
>> + */
>> +
>> +/* Data-Line Pulse Time*/
>> +#define TB_DATA_PLS          (10)	/* b_srp_init,continue 5~10ms
>> +					 * section:5.1.3
>> +					 */
>> +/* SRP Fail Time  */
>> +#define TB_SRP_FAIL          (6000)	/* b_srp_init,fail time 5~6s
>> +					 * section:5.1.6
>> +					 */
>> +/* A-SE0 to B-Reset  */
>> +#define TB_ASE0_BRST         (155)	/* minimum 155 ms, section:5.3.1 */
>> +/* SE0 Time Before SRP */
>> +#define TB_SE0_SRP           (1000)	/* b_idle,minimum 1s, section:5.1.2 */
>> +/* SSEND time before SRP */
>> +#define TB_SSEND_SRP         (1500)	/* minimum 1.5 sec, section:5.1.2 */
>> +
>> +#define TB_SESS_VLD          (1000)
>> +
>> +#endif /* __DRIVERS_USB_COMMON_USB_OTG_H */
>> diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
>> index a99c89e..b468a9f 100644
>> --- a/drivers/usb/core/Kconfig
>> +++ b/drivers/usb/core/Kconfig
>> @@ -42,7 +42,7 @@ config USB_DYNAMIC_MINORS
>>  	  If you are unsure about this, say N here.
>>  
>>  config USB_OTG
>> -	bool "OTG support"
>> +	bool "OTG/Dual-role support"
>>  	depends on PM
>>  	default n
>>  	help
>> @@ -75,15 +75,6 @@ config USB_OTG_BLACKLIST_HUB
>>  	  and software costs by not supporting external hubs.  So
>>  	  are "Embedded Hosts" that don't offer OTG support.
>>  
>> -config USB_OTG_FSM
>> -	tristate "USB 2.0 OTG FSM implementation"
>> -	depends on USB
>> -	select USB_OTG
>> -	select USB_PHY
>> -	help
>> -	  Implements OTG Finite State Machine as specified in On-The-Go
>> -	  and Embedded Host Supplement to the USB Revision 2.0 Specification.
>> -
>>  config USB_ULPI_BUS
>>  	tristate "USB ULPI PHY interface support"
>>  	depends on USB_SUPPORT
>> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
>> index bd1dcf8..38cabe0 100644
>> --- a/include/linux/usb/otg.h
>> +++ b/include/linux/usb/otg.h
>> @@ -10,19 +10,100 @@
>>  #define __LINUX_USB_OTG_H
>>  
>>  #include <linux/phy/phy.h>
>> +#include <linux/device.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/ktime.h>
>> +#include <linux/usb.h>
>> +#include <linux/usb/hcd.h>
>> +#include <linux/usb/gadget.h>
>> +#include <linux/usb/otg-fsm.h>
>>  #include <linux/usb/phy.h>
>>  
>> +/**
>> + * struct otg_hcd - host controller state and interface
>> + *
>> + * @hcd: host controller
>> + * @irqnum: irq number
>> + * @irqflags: irq flags
>> + * @ops: otg to host controller interface
>> + */
>> +struct otg_hcd {
>> +	struct usb_hcd *hcd;
>> +	unsigned int irqnum;
>> +	unsigned long irqflags;
>> +	struct otg_hcd_ops *ops;
>> +};
>> +
>> +struct usb_otg;
>> +
>> +/**
>> + * struct otg_timer - otg timer data
>> + *
>> + * @timer: high resolution timer
>> + * @timeout: timeout value
>> + * @timetout_bit: pointer to variable that is set on timeout
>> + * @otgd: usb otg data
>> + */
>> +struct otg_timer {
>> +	struct hrtimer timer;
>> +	ktime_t timeout;
>> +	/* callback data */
>> +	int *timeout_bit;
>> +	struct usb_otg *otgd;
>> +};
>> +
>> +/**
>> + * struct usb_otg - usb otg controller state
>> + *
>> + * @default_a: Indicates we are an A device. i.e. Host.
>> + * @phy: USB phy interface
>> + * @usb_phy: old usb_phy interface
>> + * @host: host controller bus
>> + * @gadget: gadget device
>> + * @state: current otg state
>> + * @dev: otg controller device
>> + * @caps: otg capabilities revision, hnp, srp, etc
>> + * @fsm: otg finite state machine
>> + * @fsm_ops: controller hooks for the state machine
>> + * ------- internal use only -------
>> + * @primary_hcd: primary host state and interface
>> + * @shared_hcd: shared host state and interface
>> + * @gadget_ops: gadget interface
>> + * @timers: otg timers for state machine
>> + * @list: list of otg controllers
>> + * @work: otg state machine work
>> + * @wq: otg state machine work queue
>> + * @fsm_running: state machine running/stopped indicator
>> + */
>>  struct usb_otg {
>>  	u8			default_a;
>>  
>>  	struct phy		*phy;
>>  	/* old usb_phy interface */
>>  	struct usb_phy		*usb_phy;
>> +
>>  	struct usb_bus		*host;
>>  	struct usb_gadget	*gadget;
>>  
>>  	enum usb_otg_state	state;
>>  
>> +	struct device *dev;
>> +	struct usb_otg_caps *caps;
>> +	struct otg_fsm fsm;
>> +	struct otg_fsm_ops fsm_ops;
>> +
>> +	/* internal use only */
>> +	struct otg_hcd primary_hcd;
>> +	struct otg_hcd shared_hcd;
>> +	struct otg_gadget_ops *gadget_ops;
>> +	struct otg_timer timers[NUM_OTG_FSM_TIMERS];
>> +	struct list_head list;
>> +	struct work_struct work;
>> +	struct workqueue_struct *wq;
>> +	bool fsm_running;
>> +	/* use otg->fsm.lock for serializing access */
>> +
>> +/*------------- deprecated interface -----------------------------*/
>>  	/* bind/unbind the host controller */
>>  	int	(*set_host)(struct usb_otg *otg, struct usb_bus *host);
>>  
>> @@ -38,7 +119,7 @@ struct usb_otg {
>>  
>>  	/* start or continue HNP role switch */
>>  	int	(*start_hnp)(struct usb_otg *otg);
>> -
>> +/*---------------------------------------------------------------*/
>>  };
>>  
>>  /**
>> @@ -56,8 +137,105 @@ struct usb_otg_caps {
>>  	bool adp_support;
>>  };
>>  
>> +/**
>> + * struct usb_otg_config - otg controller configuration
>> + * @caps: otg capabilities of the controller
>> + * @ops: otg fsm operations
>> + * @otg_timeouts: override default otg fsm timeouts
>> + */
>> +struct usb_otg_config {
>> +	struct usb_otg_caps otg_caps;
>> +	struct otg_fsm_ops *fsm_ops;
>> +	unsigned otg_timeouts[NUM_OTG_FSM_TIMERS];
>> +};
>> +
>>  extern const char *usb_otg_state_string(enum usb_otg_state state);
>>  
>> +enum usb_dr_mode {
>> +	USB_DR_MODE_UNKNOWN,
>> +	USB_DR_MODE_HOST,
>> +	USB_DR_MODE_PERIPHERAL,
>> +	USB_DR_MODE_OTG,
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_USB_OTG)
>> +struct otg_fsm *usb_otg_register(struct device *dev,
>> +				 struct usb_otg_config *config);
>> +int usb_otg_unregister(struct device *dev);
>> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>> +			 unsigned long irqflags, struct otg_hcd_ops *ops);
>> +int usb_otg_unregister_hcd(struct usb_hcd *hcd);
>> +int usb_otg_register_gadget(struct usb_gadget *gadget,
>> +			    struct otg_gadget_ops *ops);
>> +int usb_otg_unregister_gadget(struct usb_gadget *gadget);
>> +void usb_otg_sync_inputs(struct otg_fsm *fsm);
>> +int usb_otg_kick_fsm(struct device *hcd_gcd_device);
>> +struct device *usb_otg_fsm_to_dev(struct otg_fsm *fsm);
>> +int usb_otg_start_host(struct otg_fsm *fsm, int on);
>> +int usb_otg_start_gadget(struct otg_fsm *fsm, int on);
>> +
>> +#else /* CONFIG_USB_OTG */
>> +
>> +static inline struct otg_fsm *usb_otg_register(struct device *dev,
>> +					       struct usb_otg_config *config)
>> +{
>> +	return ERR_PTR(-ENOTSUPP);
>> +}
>> +
>> +static inline int usb_otg_unregister(struct device *dev)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>> +				       unsigned long irqflags,
>> +				       struct otg_hcd_ops *ops)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int usb_otg_unregister_hcd(struct usb_hcd *hcd)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int usb_otg_register_gadget(struct usb_gadget *gadget,
>> +					  struct otg_gadget_ops *ops)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int usb_otg_unregister_gadget(struct usb_gadget *gadget)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline void usb_otg_sync_inputs(struct otg_fsm *fsm)
>> +{
>> +}
>> +
>> +static inline int usb_otg_kick_fsm(struct device *hcd_gcd_device)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline struct device *usb_otg_fsm_to_dev(struct otg_fsm *fsm)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline int usb_otg_start_host(struct otg_fsm *fsm, int on)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int usb_otg_start_gadget(struct otg_fsm *fsm, int on)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +#endif /* CONFIG_USB_OTG */
>> +
>> +/*------------- deprecated interface -----------------------------*/
>>  /* Context: can sleep */
>>  static inline int
>>  otg_start_hnp(struct usb_otg *otg)
>> @@ -109,14 +287,9 @@ otg_start_srp(struct usb_otg *otg)
>>  	return -ENOTSUPP;
>>  }
>>  
>> +/*---------------------------------------------------------------*/
>> +
>>  /* for OTG controller drivers (and maybe other stuff) */
>>  extern int usb_bus_start_enum(struct usb_bus *bus, unsigned port_num);
>>  
>> -enum usb_dr_mode {
>> -	USB_DR_MODE_UNKNOWN,
>> -	USB_DR_MODE_HOST,
>> -	USB_DR_MODE_PERIPHERAL,
>> -	USB_DR_MODE_OTG,
>> -};
>> -
>>  #endif /* __LINUX_USB_OTG_H */
>> -- 
>> 2.1.4
>>
> 
