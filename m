From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v6 07/12] usb: otg: add OTG/dual-role core
Date: Mon, 25 Apr 2016 17:05:27 +0300
Message-ID: <571E2427.9070103@ti.com>
References: <1459865117-7032-1-git-send-email-rogerq@ti.com>
 <1459865117-7032-8-git-send-email-rogerq@ti.com>
 <20160421065242.GB13772@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160421065242.GB13772@shlinux2.ap.freescale.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: stern@rowland.harvard.edu, balbi@kernel.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, abrestic@chromium.org, r.baldyga@samsung.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Peter,

On 21/04/16 09:52, Peter Chen wrote:
> On Tue, Apr 05, 2016 at 05:05:12PM +0300, Roger Quadros wrote:
>> It provides APIs for the following tasks
>>
>> - Registering an OTG/dual-role capable controller
>> - Registering Host and Gadget controllers to OTG core
>> - Providing inputs to and kicking the OTG state machine
>>
>> Provide a dual-role device (DRD) state machine.
>> DRD mode is a reduced functionality OTG mode. In this mode
>> we don't support SRP, HNP and dynamic role-swap.
>>
>> In DRD operation, the controller mode (Host or Peripheral)
>> is decided based on the ID pin status. Once a cable plug (Type-A
>> or Type-B) is attached the controller selects the state
>> and doesn't change till the cable in unplugged and a different
>> cable type is inserted.
>>
>> As we don't need most of the complex OTG states and OTG timers
>> we implement a lean DRD state machine in usb-otg.c.
>> The DRD state machine is only interested in 2 hardware inputs
>> 'id' and 'b_sess_vld'.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/common/Makefile  |    2 +-
>>  drivers/usb/common/usb-otg.c | 1058 ++++++++++++++++++++++++++++++++++++++++++
>>  drivers/usb/common/usb-otg.h |   71 +++
>>  drivers/usb/core/Kconfig     |    2 +-
>>  include/linux/usb/gadget.h   |    2 +
>>  include/linux/usb/hcd.h      |    1 +
>>  include/linux/usb/otg-fsm.h  |    7 +
>>  include/linux/usb/otg.h      |  154 +++++-
>>  8 files changed, 1292 insertions(+), 5 deletions(-)
>>  create mode 100644 drivers/usb/common/usb-otg.c
>>  create mode 100644 drivers/usb/common/usb-otg.h
>>
>> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
>> index f8f2c88..730d928 100644
>> --- a/drivers/usb/common/Makefile
>> +++ b/drivers/usb/common/Makefile
>> @@ -7,5 +7,5 @@ usb-common-y			  += common.o
>>  usb-common-$(CONFIG_USB_LED_TRIG) += led.o
>>  
>>  obj-$(CONFIG_USB_ULPI_BUS)	+= ulpi.o
>> -usbotg-y		:= usb-otg-fsm.o
>> +usbotg-y		:= usb-otg.o usb-otg-fsm.o
>>  obj-$(CONFIG_USB_OTG)	+= usbotg.o
>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>> new file mode 100644
>> index 0000000..41e762a
>> --- /dev/null
>> +++ b/drivers/usb/common/usb-otg.c
>> @@ -0,0 +1,1058 @@
>> +/**
>> + * drivers/usb/common/usb-otg.c - USB OTG core
>> + *
>> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com
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
>> +#include <linux/kernel.h>
>> +#include <linux/ktime.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/list.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/usb/otg.h>
>> +#include <linux/usb/gadget.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "usb-otg.h"
>> +
>> +struct otg_gcd {
>> +	struct usb_gadget *gadget;
>> +	struct otg_gadget_ops *ops;
>> +};
>> +
>> +/* OTG device list */
>> +LIST_HEAD(otg_list);
>> +static DEFINE_MUTEX(otg_list_mutex);
>> +
>> +/* Hosts and Gadgets waiting for OTG controller */
>> +struct otg_wait_data {
>> +	struct device *dev;		/* OTG controller device */
>> +
>> +	struct otg_hcd primary_hcd;
>> +	struct otg_hcd shared_hcd;
>> +	struct otg_gcd gcd;
>> +	struct list_head list;
>> +};
>> +
>> +LIST_HEAD(wait_list);
>> +static DEFINE_MUTEX(wait_list_mutex);
>> +
>> +static int usb_otg_hcd_is_primary_hcd(struct usb_hcd *hcd)
>> +{
>> +	if (!hcd->primary_hcd)
>> +		return 1;
>> +	return hcd == hcd->primary_hcd;
>> +}
> 
> Just find there is already a usb_hcd_is_primary_hcd at hcd.c,
> would you use it directly?

We can't even if we make it public as HCD can be a loadable module
and OTG is always built-in thus leading to undefined reference.

cheers,
-roger

> 
> Peter
>> +
>> +/**
>> + * Check if the OTG device is in our wait list and return
>> + * otg_wait_data, else NULL.
>> + *
>> + * wait_list_mutex must be held.
>> + */
>> +static struct otg_wait_data *usb_otg_get_wait(struct device *otg_dev)
>> +{
>> +	struct otg_wait_data *wait;
>> +
>> +	if (!otg_dev)
>> +		return NULL;
>> +
>> +	/* is there an entry for this otg_dev ?*/
>> +	list_for_each_entry(wait, &wait_list, list) {
>> +		if (wait->dev == otg_dev)
>> +			return wait;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * Add the hcd to our wait list
>> + */
>> +static int usb_otg_hcd_wait_add(struct device *otg_dev, struct usb_hcd *hcd,
>> +				unsigned int irqnum, unsigned long irqflags,
>> +				struct otg_hcd_ops *ops)
>> +{
>> +	struct otg_wait_data *wait;
>> +	int ret = -EINVAL;
>> +
>> +	mutex_lock(&wait_list_mutex);
>> +
>> +	wait = usb_otg_get_wait(otg_dev);
>> +	if (!wait) {
>> +		/* Not yet in wait list? allocate and add */
>> +		wait = kzalloc(sizeof(*wait), GFP_KERNEL);
>> +		if (!wait) {
>> +			ret = -ENOMEM;
>> +			goto fail;
>> +		}
>> +
>> +		wait->dev = otg_dev;
>> +		list_add_tail(&wait->list, &wait_list);
>> +	}
>> +
>> +	if (usb_otg_hcd_is_primary_hcd(hcd)) {
>> +		if (wait->primary_hcd.hcd)	/* already assigned? */
>> +			goto fail;
>> +
>> +		wait->primary_hcd.hcd = hcd;
>> +		wait->primary_hcd.irqnum = irqnum;
>> +		wait->primary_hcd.irqflags = irqflags;
>> +		wait->primary_hcd.ops = ops;
>> +		wait->primary_hcd.otg_dev = otg_dev;
>> +	} else {
>> +		if (wait->shared_hcd.hcd)	/* already assigned? */
>> +			goto fail;
>> +
>> +		wait->shared_hcd.hcd = hcd;
>> +		wait->shared_hcd.irqnum = irqnum;
>> +		wait->shared_hcd.irqflags = irqflags;
>> +		wait->shared_hcd.ops = ops;
>> +		wait->shared_hcd.otg_dev = otg_dev;
>> +	}
>> +
>> +	mutex_unlock(&wait_list_mutex);
>> +	return 0;
>> +
>> +fail:
>> +	mutex_unlock(&wait_list_mutex);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * Check and free wait list entry if empty
>> + *
>> + * wait_list_mutex must be held
>> + */
>> +static void usb_otg_check_free_wait(struct otg_wait_data *wait)
>> +{
>> +	if (wait->primary_hcd.hcd || wait->shared_hcd.hcd || wait->gcd.gadget)
>> +		return;
>> +
>> +	list_del(&wait->list);
>> +	kfree(wait);
>> +}
>> +
>> +/**
>> + * Remove the hcd from our wait list
>> + */
>> +static int usb_otg_hcd_wait_remove(struct usb_hcd *hcd)
>> +{
>> +	struct otg_wait_data *wait;
>> +
>> +	mutex_lock(&wait_list_mutex);
>> +
>> +	/* is there an entry for this hcd ?*/
>> +	list_for_each_entry(wait, &wait_list, list) {
>> +		if (wait->primary_hcd.hcd == hcd) {
>> +			wait->primary_hcd.hcd = 0;
>> +			goto found;
>> +		} else if (wait->shared_hcd.hcd == hcd) {
>> +			wait->shared_hcd.hcd = 0;
>> +			goto found;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&wait_list_mutex);
>> +	return -EINVAL;
>> +
>> +found:
>> +	usb_otg_check_free_wait(wait);
>> +	mutex_unlock(&wait_list_mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * Add the gadget to our wait list
>> + */
>> +static int usb_otg_gadget_wait_add(struct device *otg_dev,
>> +				   struct usb_gadget *gadget,
>> +				   struct otg_gadget_ops *ops)
>> +{
>> +	struct otg_wait_data *wait;
>> +	int ret = -EINVAL;
>> +
>> +	mutex_lock(&wait_list_mutex);
>> +
>> +	wait = usb_otg_get_wait(otg_dev);
>> +	if (!wait) {
>> +		/* Not yet in wait list? allocate and add */
>> +		wait = kzalloc(sizeof(*wait), GFP_KERNEL);
>> +		if (!wait) {
>> +			ret = -ENOMEM;
>> +			goto fail;
>> +		}
>> +
>> +		wait->dev = otg_dev;
>> +		list_add_tail(&wait->list, &wait_list);
>> +	}
>> +
>> +	if (wait->gcd.gadget) /* already assigned? */
>> +		goto fail;
>> +
>> +	wait->gcd.gadget = gadget;
>> +	wait->gcd.ops = ops;
>> +	mutex_unlock(&wait_list_mutex);
>> +
>> +	return 0;
>> +
>> +fail:
>> +	mutex_unlock(&wait_list_mutex);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * Remove the gadget from our wait list
>> + */
>> +static int usb_otg_gadget_wait_remove(struct usb_gadget *gadget)
>> +{
>> +	struct otg_wait_data *wait;
>> +
>> +	mutex_lock(&wait_list_mutex);
>> +
>> +	/* is there an entry for this gadget ?*/
>> +	list_for_each_entry(wait, &wait_list, list) {
>> +		if (wait->gcd.gadget == gadget) {
>> +			wait->gcd.gadget = 0;
>> +			goto found;
>> +		}
>> +	}
>> +
>> +	mutex_unlock(&wait_list_mutex);
>> +
>> +	return -EINVAL;
>> +
>> +found:
>> +	usb_otg_check_free_wait(wait);
>> +	mutex_unlock(&wait_list_mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * Register pending host/gadget and remove entry from wait list
>> + */
>> +static void usb_otg_flush_wait(struct device *otg_dev)
>> +{
>> +	struct otg_wait_data *wait;
>> +	struct otg_hcd *host;
>> +	struct otg_gcd *gadget;
>> +
>> +	mutex_lock(&wait_list_mutex);
>> +
>> +	wait = usb_otg_get_wait(otg_dev);
>> +	if (!wait)
>> +		goto done;
>> +
>> +	dev_dbg(otg_dev, "otg: registering pending host/gadget\n");
>> +	gadget = &wait->gcd;
>> +	if (gadget)
>> +		usb_otg_register_gadget(gadget->gadget, gadget->ops);
>> +
>> +	host = &wait->primary_hcd;
>> +	if (host->hcd)
>> +		usb_otg_register_hcd(host->hcd, host->irqnum, host->irqflags,
>> +				     host->ops);
>> +
>> +	host = &wait->shared_hcd;
>> +	if (host->hcd)
>> +		usb_otg_register_hcd(host->hcd, host->irqnum, host->irqflags,
>> +				     host->ops);
>> +
>> +	list_del(&wait->list);
>> +	kfree(wait);
>> +
>> +done:
>> +	mutex_unlock(&wait_list_mutex);
>> +}
>> +
>> +/**
>> + * Check if the OTG device is in our OTG list and return
>> + * usb_otg data, else NULL.
>> + *
>> + * otg_list_mutex must be held.
>> + */
>> +static struct usb_otg *usb_otg_get_data(struct device *otg_dev)
>> +{
>> +	struct usb_otg *otg;
>> +
>> +	if (!otg_dev)
>> +		return NULL;
>> +
>> +	list_for_each_entry(otg, &otg_list, list) {
>> +		if (otg->dev == otg_dev)
>> +			return otg;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * usb_otg_start_host - start/stop the host controller
>> + * @otg:	usb_otg instance
>> + * @on:		true to start, false to stop
>> + *
>> + * Start/stop the USB host controller. This function is meant
>> + * for use by the OTG controller driver.
>> + */
>> +int usb_otg_start_host(struct usb_otg *otg, int on)
>> +{
>> +	struct otg_hcd_ops *hcd_ops = otg->hcd_ops;
>> +
>> +	dev_dbg(otg->dev, "otg: %s %d\n", __func__, on);
>> +	if (!otg->host) {
>> +		WARN_ONCE(1, "otg: fsm running without host\n");
>> +		return 0;
>> +	}
>> +
>> +	if (on) {
>> +		if (otg->flags & OTG_FLAG_HOST_RUNNING)
>> +			return 0;
>> +
>> +		otg->flags |= OTG_FLAG_HOST_RUNNING;
>> +
>> +		/* start host */
>> +		hcd_ops->add(otg->primary_hcd.hcd, otg->primary_hcd.irqnum,
>> +			     otg->primary_hcd.irqflags);
>> +		if (otg->shared_hcd.hcd) {
>> +			hcd_ops->add(otg->shared_hcd.hcd,
>> +				     otg->shared_hcd.irqnum,
>> +				     otg->shared_hcd.irqflags);
>> +		}
>> +	} else {
>> +		if (!(otg->flags & OTG_FLAG_HOST_RUNNING))
>> +			return 0;
>> +
>> +		otg->flags &= ~OTG_FLAG_HOST_RUNNING;
>> +
>> +		/* stop host */
>> +		if (otg->shared_hcd.hcd)
>> +			hcd_ops->remove(otg->shared_hcd.hcd);
>> +
>> +		hcd_ops->remove(otg->primary_hcd.hcd);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_start_host);
>> +
>> +/**
>> + * usb_otg_start_gadget - start/stop the gadget controller
>> + * @otg:	usb_otg instance
>> + * @on:		true to start, false to stop
>> + *
>> + * Start/stop the USB gadget controller. This function is meant
>> + * for use by the OTG controller driver.
>> + */
>> +int usb_otg_start_gadget(struct usb_otg *otg, int on)
>> +{
>> +	struct usb_gadget *gadget = otg->gadget;
>> +
>> +	dev_dbg(otg->dev, "otg: %s %d\n", __func__, on);
>> +	if (!gadget) {
>> +		WARN_ONCE(1, "otg: fsm running without gadget\n");
>> +		return 0;
>> +	}
>> +
>> +	if (on) {
>> +		if (otg->flags & OTG_FLAG_GADGET_RUNNING)
>> +			return 0;
>> +
>> +		otg->flags |= OTG_FLAG_GADGET_RUNNING;
>> +		otg->gadget_ops->start(otg->gadget);
>> +	} else {
>> +		if (!(otg->flags & OTG_FLAG_GADGET_RUNNING))
>> +			return 0;
>> +
>> +		otg->flags &= ~OTG_FLAG_GADGET_RUNNING;
>> +		otg->gadget_ops->stop(otg->gadget);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_start_gadget);
>> +
>> +/**
>> + * Change USB protocol when there is a protocol change.
>> + * fsm->lock must be held.
>> + */
>> +static int drd_set_protocol(struct otg_fsm *fsm, int protocol)
>> +{
>> +	struct usb_otg *otg = container_of(fsm, struct usb_otg, fsm);
>> +	int ret = 0;
>> +
>> +	if (fsm->protocol != protocol) {
>> +		dev_dbg(otg->dev, "otg: changing role fsm->protocol= %d; new protocol= %d\n",
>> +			fsm->protocol, protocol);
>> +		/* stop old protocol */
>> +		if (fsm->protocol == PROTO_HOST)
>> +			ret = otg_start_host(otg, 0);
>> +		else if (fsm->protocol == PROTO_GADGET)
>> +			ret = otg_start_gadget(otg, 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		/* start new protocol */
>> +		if (protocol == PROTO_HOST)
>> +			ret = otg_start_host(otg, 1);
>> +		else if (protocol == PROTO_GADGET)
>> +			ret = otg_start_gadget(otg, 1);
>> +		if (ret)
>> +			return ret;
>> +
>> +		fsm->protocol = protocol;
>> +		return 0;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * Called when entering a DRD state.
>> + * fsm->lock must be held.
>> + */
>> +static void drd_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
>> +{
>> +	struct usb_otg *otg = container_of(fsm, struct usb_otg, fsm);
>> +
>> +	if (otg->state == new_state)
>> +		return;
>> +
>> +	fsm->state_changed = 1;
>> +	dev_dbg(otg->dev, "otg: set state: %s\n",
>> +		usb_otg_state_string(new_state));
>> +	switch (new_state) {
>> +	case OTG_STATE_B_IDLE:
>> +		drd_set_protocol(fsm, PROTO_UNDEF);
>> +		otg_drv_vbus(otg, 0);
>> +		break;
>> +	case OTG_STATE_B_PERIPHERAL:
>> +		drd_set_protocol(fsm, PROTO_GADGET);
>> +		otg_drv_vbus(otg, 0);
>> +		break;
>> +	case OTG_STATE_A_HOST:
>> +		drd_set_protocol(fsm, PROTO_HOST);
>> +		otg_drv_vbus(otg, 1);
>> +		break;
>> +	case OTG_STATE_UNDEFINED:
>> +	case OTG_STATE_B_SRP_INIT:
>> +	case OTG_STATE_B_WAIT_ACON:
>> +	case OTG_STATE_B_HOST:
>> +	case OTG_STATE_A_IDLE:
>> +	case OTG_STATE_A_WAIT_VRISE:
>> +	case OTG_STATE_A_WAIT_BCON:
>> +	case OTG_STATE_A_SUSPEND:
>> +	case OTG_STATE_A_PERIPHERAL:
>> +	case OTG_STATE_A_WAIT_VFALL:
>> +	case OTG_STATE_A_VBUS_ERR:
>> +	default:
>> +		dev_warn(otg->dev, "%s: otg: invalid state: %s\n",
>> +			 __func__, usb_otg_state_string(new_state));
>> +		break;
>> +	}
>> +
>> +	otg->state = new_state;
>> +}
>> +
>> +/**
>> + * DRD state change judgement
>> + *
>> + * For DRD we're only interested in some of the OTG states
>> + * i.e. OTG_STATE_B_IDLE: both peripheral and host are stopped
>> + *	OTG_STATE_B_PERIPHERAL: peripheral active
>> + *	OTG_STATE_A_HOST: host active
>> + * we're only interested in the following inputs
>> + *	fsm->id, fsm->b_sess_vld
>> + */
>> +int drd_statemachine(struct usb_otg *otg)
>> +{
>> +	struct otg_fsm *fsm = &otg->fsm;
>> +	enum usb_otg_state state;
>> +	int ret;
>> +
>> +	mutex_lock(&fsm->lock);
>> +
>> +	fsm->state_changed = 0;
>> +	state = otg->state;
>> +
>> +	switch (state) {
>> +	case OTG_STATE_UNDEFINED:
>> +		if (!fsm->id)
>> +			drd_set_state(fsm, OTG_STATE_A_HOST);
>> +		else if (fsm->id && fsm->b_sess_vld)
>> +			drd_set_state(fsm, OTG_STATE_B_PERIPHERAL);
>> +		else
>> +			drd_set_state(fsm, OTG_STATE_B_IDLE);
>> +		break;
>> +	case OTG_STATE_B_IDLE:
>> +		if (!fsm->id)
>> +			drd_set_state(fsm, OTG_STATE_A_HOST);
>> +		else if (fsm->b_sess_vld)
>> +			drd_set_state(fsm, OTG_STATE_B_PERIPHERAL);
>> +		break;
>> +	case OTG_STATE_B_PERIPHERAL:
>> +		if (!fsm->id)
>> +			drd_set_state(fsm, OTG_STATE_A_HOST);
>> +		else if (!fsm->b_sess_vld)
>> +			drd_set_state(fsm, OTG_STATE_B_IDLE);
>> +		break;
>> +	case OTG_STATE_A_HOST:
>> +		if (fsm->id && fsm->b_sess_vld)
>> +			drd_set_state(fsm, OTG_STATE_B_PERIPHERAL);
>> +		else if (fsm->id && !fsm->b_sess_vld)
>> +			drd_set_state(fsm, OTG_STATE_B_IDLE);
>> +		break;
>> +
>> +	/* invalid states for DRD */
>> +	case OTG_STATE_B_SRP_INIT:
>> +	case OTG_STATE_B_WAIT_ACON:
>> +	case OTG_STATE_B_HOST:
>> +	case OTG_STATE_A_IDLE:
>> +	case OTG_STATE_A_WAIT_VRISE:
>> +	case OTG_STATE_A_WAIT_BCON:
>> +	case OTG_STATE_A_SUSPEND:
>> +	case OTG_STATE_A_PERIPHERAL:
>> +	case OTG_STATE_A_WAIT_VFALL:
>> +	case OTG_STATE_A_VBUS_ERR:
>> +		dev_err(otg->dev, "%s: otg: invalid usb-drd state: %s\n",
>> +			__func__, usb_otg_state_string(state));
>> +		drd_set_state(fsm, OTG_STATE_UNDEFINED);
>> +	break;
>> +	}
>> +
>> +	ret = fsm->state_changed;
>> +	mutex_unlock(&fsm->lock);
>> +	dev_dbg(otg->dev, "otg: quit statemachine, changed %d\n",
>> +		fsm->state_changed);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(drd_statemachine);
>> +
>> +/**
>> + * OTG FSM/DRD work function
>> + */
>> +static void usb_otg_work(struct work_struct *work)
>> +{
>> +	struct usb_otg *otg = container_of(work, struct usb_otg, work);
>> +
>> +	pm_runtime_get_sync(otg->dev);
>> +	drd_statemachine(otg);
>> +	pm_runtime_put_sync(otg->dev);
>> +}
>> +
>> +/**
>> + * usb_otg_register() - Register the OTG/dual-role device to OTG core
>> + * @dev: OTG/dual-role controller device.
>> + * @config: OTG configuration.
>> + *
>> + * Registers the OTG/dual-role controller device with the USB OTG core.
>> + *
>> + * Return: struct usb_otg * if success, ERR_PTR() if error.
>> + */
>> +struct usb_otg *usb_otg_register(struct device *dev,
>> +				 struct usb_otg_config *config)
>> +{
>> +	struct usb_otg *otg;
>> +	struct otg_wait_data *wait;
>> +	int ret = 0;
>> +
>> +	if (!dev || !config || !config->fsm_ops)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/* already in list? */
>> +	mutex_lock(&otg_list_mutex);
>> +	if (usb_otg_get_data(dev)) {
>> +		dev_err(dev, "otg: %s: device already in otg list\n",
>> +			__func__);
>> +		ret = -EINVAL;
>> +		goto unlock;
>> +	}
>> +
>> +	/* allocate and add to list */
>> +	otg = kzalloc(sizeof(*otg), GFP_KERNEL);
>> +	if (!otg) {
>> +		ret = -ENOMEM;
>> +		goto unlock;
>> +	}
>> +
>> +	otg->dev = dev;
>> +	otg->caps = config->otg_caps;
>> +
>> +	if ((otg->caps->hnp_support || otg->caps->srp_support ||
>> +	     otg->caps->adp_support) && !config->otg_work)
>> +		dev_info(dev, "otg: limiting to dual-role\n");
>> +
>> +	if (config->otg_work)	/* custom otg_work ? */
>> +		INIT_WORK(&otg->work, config->otg_work);
>> +	else
>> +		INIT_WORK(&otg->work, usb_otg_work);
>> +
>> +	otg->wq = create_singlethread_workqueue("usb_otg");
>> +	if (!otg->wq) {
>> +		dev_err(dev, "otg: %s: can't create workqueue\n",
>> +			__func__);
>> +		ret = -ENOMEM;
>> +		goto err_wq;
>> +	}
>> +
>> +	/* set otg ops */
>> +	otg->fsm.ops = config->fsm_ops;
>> +
>> +	mutex_init(&otg->fsm.lock);
>> +
>> +	list_add_tail(&otg->list, &otg_list);
>> +	mutex_unlock(&otg_list_mutex);
>> +
>> +	/* were we in wait list? */
>> +	mutex_lock(&wait_list_mutex);
>> +	wait = usb_otg_get_wait(dev);
>> +	mutex_unlock(&wait_list_mutex);
>> +	if (wait) {
>> +		/* register pending host/gadget and flush from list */
>> +		usb_otg_flush_wait(dev);
>> +	}
>> +
>> +	return otg;
>> +
>> +err_wq:
>> +	kfree(otg);
>> +unlock:
>> +	mutex_unlock(&otg_list_mutex);
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_register);
>> +
>> +/**
>> + * usb_otg_unregister() - Unregister the OTG/dual-role device from USB OTG core
>> + * @dev: OTG controller device.
>> + *
>> + * Unregisters the OTG/dual-role controller device from USB OTG core.
>> + * Prevents unregistering till both the associated Host and Gadget controllers
>> + * have unregistered from the OTG core.
>> + *
>> + * Return: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_unregister(struct device *dev)
>> +{
>> +	struct usb_otg *otg;
>> +
>> +	mutex_lock(&otg_list_mutex);
>> +	otg = usb_otg_get_data(dev);
>> +	if (!otg) {
>> +		dev_err(dev, "otg: %s: device not in otg list\n",
>> +			__func__);
>> +		mutex_unlock(&otg_list_mutex);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* prevent unregister till both host & gadget have unregistered */
>> +	if (otg->host || otg->gadget) {
>> +		dev_err(dev, "otg: %s: host/gadget still registered\n",
>> +			__func__);
>> +		return -EBUSY;
>> +	}
>> +
>> +	/* OTG FSM is halted when host/gadget unregistered */
>> +	destroy_workqueue(otg->wq);
>> +
>> +	/* remove from otg list */
>> +	list_del(&otg->list);
>> +	kfree(otg);
>> +	mutex_unlock(&otg_list_mutex);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_unregister);
>> +
>> +/**
>> + * start/kick the OTG FSM if we can
>> + * fsm->lock must be held
>> + */
>> +static void usb_otg_start_fsm(struct usb_otg *otg)
>> +{
>> +	struct otg_fsm *fsm = &otg->fsm;
>> +
>> +	if (fsm->running)
>> +		goto kick_fsm;
>> +
>> +	if (!otg->host) {
>> +		dev_info(otg->dev, "otg: can't start till host registers\n");
>> +		return;
>> +	}
>> +
>> +	if (!otg->gadget) {
>> +		dev_info(otg->dev, "otg: can't start till gadget registers\n");
>> +		return;
>> +	}
>> +
>> +	fsm->running = true;
>> +kick_fsm:
>> +	queue_work(otg->wq, &otg->work);
>> +}
>> +
>> +/**
>> + * stop the OTG FSM. Stops Host & Gadget controllers as well.
>> + * fsm->lock must be held
>> + */
>> +static void usb_otg_stop_fsm(struct usb_otg *otg)
>> +{
>> +	struct otg_fsm *fsm = &otg->fsm;
>> +
>> +	if (!fsm->running)
>> +		return;
>> +
>> +	/* no more new events queued */
>> +	fsm->running = false;
>> +
>> +	flush_workqueue(otg->wq);
>> +	otg->state = OTG_STATE_UNDEFINED;
>> +
>> +	/* stop host/gadget immediately */
>> +	if (fsm->protocol == PROTO_HOST)
>> +		otg_start_host(otg, 0);
>> +	else if (fsm->protocol == PROTO_GADGET)
>> +		otg_start_gadget(otg, 0);
>> +	fsm->protocol = PROTO_UNDEF;
>> +}
>> +
>> +/**
>> + * usb_otg_sync_inputs - Sync OTG inputs with the OTG state machine
>> + * @fsm:	OTG FSM instance
>> + *
>> + * Used by the OTG driver to update the inputs to the OTG
>> + * state machine.
>> + *
>> + * Can be called in IRQ context.
>> + */
>> +void usb_otg_sync_inputs(struct usb_otg *otg)
>> +{
>> +	/* Don't kick FSM till it has started */
>> +	if (!otg->fsm.running)
>> +		return;
>> +
>> +	/* Kick FSM */
>> +	queue_work(otg->wq, &otg->work);
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_sync_inputs);
>> +
>> +/**
>> + * usb_otg_kick_fsm - Kick the OTG state machine
>> + * @otg_dev:	OTG controller device
>> + *
>> + * Used by USB host/device stack to sync OTG related
>> + * events to the OTG state machine.
>> + * e.g. change in host_bus->b_hnp_enable, gadget->b_hnp_enable
>> + *
>> + * Returns: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_kick_fsm(struct device *otg_dev)
>> +{
>> +	struct usb_otg *otg;
>> +
>> +	mutex_lock(&otg_list_mutex);
>> +	otg = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otg) {
>> +		dev_dbg(otg_dev, "otg: %s: invalid otg device\n",
>> +			__func__);
>> +		return -ENODEV;
>> +	}
>> +
>> +	usb_otg_sync_inputs(otg);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_kick_fsm);
>> +
>> +/**
>> + * usb_otg_register_hcd - Register the host controller to OTG core
>> + * @hcd:	host controller device
>> + * @irqnum:	interrupt number
>> + * @irqflags:	interrupt flags
>> + * @ops:	HCD ops to interface with the HCD
>> + *
>> + * This is used by the USB Host stack to register the host controller
>> + * to the OTG core. Host controller must not be started by the
>> + * caller as it is left upto the OTG state machine to do so.
>> + * hcd->otg_dev must contain the related otg controller device.
>> + *
>> + * Returns: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>> +			 unsigned long irqflags, struct otg_hcd_ops *ops)
>> +{
>> +	struct usb_otg *otg;
>> +	struct device *hcd_dev = hcd->self.controller;
>> +	struct device *otg_dev = hcd->otg_dev;
>> +
>> +	if (!otg_dev)
>> +		return -EINVAL;
>> +
>> +	/* we're otg but otg controller might not yet be registered */
>> +	mutex_lock(&otg_list_mutex);
>> +	otg = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otg) {
>> +		dev_dbg(hcd_dev,
>> +			"otg: controller not yet registered. waiting..\n");
>> +		/*
>> +		 * otg controller might register later. Put the hcd in
>> +		 * wait list and call us back when ready
>> +		 */
>> +		if (usb_otg_hcd_wait_add(otg_dev, hcd, irqnum, irqflags, ops)) {
>> +			dev_err(hcd_dev, "otg: failed to add hcd to wait list\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +	/* HCD will be started by OTG fsm when needed */
>> +	mutex_lock(&otg->fsm.lock);
>> +	if (otg->primary_hcd.hcd) {
>> +		/* probably a shared HCD ? */
>> +		if (usb_otg_hcd_is_primary_hcd(hcd)) {
>> +			dev_err(otg_dev, "otg: primary host already registered\n");
>> +			goto err;
>> +		}
>> +
>> +		if (hcd->shared_hcd == otg->primary_hcd.hcd) {
>> +			if (otg->shared_hcd.hcd) {
>> +				dev_err(otg_dev, "otg: shared host already registered\n");
>> +				goto err;
>> +			}
>> +
>> +			otg->shared_hcd.hcd = hcd;
>> +			otg->shared_hcd.irqnum = irqnum;
>> +			otg->shared_hcd.irqflags = irqflags;
>> +			otg->shared_hcd.ops = ops;
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
>> +		otg->primary_hcd.hcd = hcd;
>> +		otg->primary_hcd.irqnum = irqnum;
>> +		otg->primary_hcd.irqflags = irqflags;
>> +		otg->primary_hcd.ops = ops;
>> +		otg->hcd_ops = ops;
>> +		dev_info(otg_dev, "otg: primary host %s registered\n",
>> +			 dev_name(hcd->self.controller));
>> +	}
>> +
>> +	/*
>> +	 * we're ready only if we have shared HCD
>> +	 * or we don't need shared HCD.
>> +	 */
>> +	if (otg->shared_hcd.hcd || !otg->primary_hcd.hcd->shared_hcd) {
>> +		otg->host = hcd_to_bus(hcd);
>> +		/* FIXME: set bus->otg_port if this is true OTG port with HNP */
>> +
>> +		/* start FSM */
>> +		usb_otg_start_fsm(otg);
>> +	} else {
>> +		dev_dbg(otg_dev, "otg: can't start till shared host registers\n");
>> +	}
>> +
>> +	mutex_unlock(&otg->fsm.lock);
>> +
>> +	return 0;
>> +
>> +err:
>> +	mutex_unlock(&otg->fsm.lock);
>> +	return -EINVAL;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_register_hcd);
>> +
>> +/**
>> + * usb_otg_unregister_hcd - Unregister the host controller from OTG core
>> + * @hcd:	host controller device
>> + *
>> + * This is used by the USB Host stack to unregister the host controller
>> + * from the OTG core. Ensures that host controller is not running
>> + * on successful return.
>> + *
>> + * Returns: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_unregister_hcd(struct usb_hcd *hcd)
>> +{
>> +	struct usb_otg *otg;
>> +	struct device *hcd_dev = hcd_to_bus(hcd)->controller;
>> +	struct device *otg_dev = hcd->otg_dev;
>> +
>> +	if (!otg_dev)
>> +		return -EINVAL;	/* we're definitely not OTG */
>> +
>> +	mutex_lock(&otg_list_mutex);
>> +	otg = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otg) {
>> +		/* are we in wait list? */
>> +		if (!usb_otg_hcd_wait_remove(hcd))
>> +			return 0;
>> +
>> +		dev_dbg(hcd_dev, "otg: host wasn't registered with otg\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&otg->fsm.lock);
>> +	if (hcd == otg->primary_hcd.hcd) {
>> +		otg->primary_hcd.hcd = NULL;
>> +		dev_info(otg_dev, "otg: primary host %s unregistered\n",
>> +			 dev_name(hcd_dev));
>> +	} else if (hcd == otg->shared_hcd.hcd) {
>> +		otg->shared_hcd.hcd = NULL;
>> +		dev_info(otg_dev, "otg: shared host %s unregistered\n",
>> +			 dev_name(hcd_dev));
>> +	} else {
>> +		dev_err(otg_dev, "otg: host %s wasn't registered with otg\n",
>> +			dev_name(hcd_dev));
>> +		mutex_unlock(&otg->fsm.lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* stop FSM & Host */
>> +	usb_otg_stop_fsm(otg);
>> +	otg->host = NULL;
>> +
>> +	mutex_unlock(&otg->fsm.lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_unregister_hcd);
>> +
>> +/**
>> + * usb_otg_register_gadget - Register the gadget controller to OTG core
>> + * @gadget:	gadget controller
>> + *
>> + * This is used by the USB gadget stack to register the gadget controller
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
>> +	struct usb_otg *otg;
>> +	struct device *gadget_dev = &gadget->dev;
>> +	struct device *otg_dev = gadget->otg_dev;
>> +
>> +	if (!otg_dev)
>> +		return -EINVAL;	/* we're definitely not OTG */
>> +
>> +	/* we're otg but otg controller might not yet be registered */
>> +	mutex_lock(&otg_list_mutex);
>> +	otg = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otg) {
>> +		dev_dbg(gadget_dev,
>> +			"otg: controller not yet registered. waiting..\n");
>> +		/*
>> +		 * otg controller might register later. Put the gadget in
>> +		 * wait list and call us back when ready
>> +		 */
>> +		if (usb_otg_gadget_wait_add(otg_dev, gadget, ops)) {
>> +			dev_err(gadget_dev,
>> +				"otg: failed to add to gadget to wait list\n");
>> +			return -EINVAL;
>> +		}
>> +
>> +		return 0;
>> +	}
>> +
>> +	mutex_lock(&otg->fsm.lock);
>> +	if (otg->gadget) {
>> +		dev_err(otg_dev, "otg: gadget already registered with otg\n");
>> +		mutex_unlock(&otg->fsm.lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	otg->gadget = gadget;
>> +	otg->gadget_ops = ops;
>> +	dev_info(otg_dev, "otg: gadget %s registered\n",
>> +		 dev_name(&gadget->dev));
>> +
>> +	/* start FSM */
>> +	usb_otg_start_fsm(otg);
>> +	mutex_unlock(&otg->fsm.lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_register_gadget);
>> +
>> +/**
>> + * usb_otg_unregister_gadget - Unregister the gadget controller from OTG core
>> + * @gadget:	gadget controller
>> + *
>> + * This is used by the USB gadget stack to unregister the gadget controller
>> + * from the OTG core. Ensures that gadget controller is halted
>> + * on successful return.
>> + *
>> + * Returns: 0 on success, error value otherwise.
>> + */
>> +int usb_otg_unregister_gadget(struct usb_gadget *gadget)
>> +{
>> +	struct usb_otg *otg;
>> +	struct device *gadget_dev = &gadget->dev;
>> +	struct device *otg_dev = gadget->otg_dev;
>> +
>> +	if (!otg_dev)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&otg_list_mutex);
>> +	otg = usb_otg_get_data(otg_dev);
>> +	mutex_unlock(&otg_list_mutex);
>> +	if (!otg) {
>> +		/* are we in wait list? */
>> +		if (!usb_otg_gadget_wait_remove(gadget))
>> +			return 0;
>> +
>> +		dev_dbg(gadget_dev, "otg: gadget wasn't registered with otg\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&otg->fsm.lock);
>> +	if (otg->gadget != gadget) {
>> +		dev_err(otg_dev, "otg: gadget %s wasn't registered with otg\n",
>> +			dev_name(&gadget->dev));
>> +		mutex_unlock(&otg->fsm.lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Stop FSM & gadget */
>> +	usb_otg_stop_fsm(otg);
>> +	otg->gadget = NULL;
>> +	mutex_unlock(&otg->fsm.lock);
>> +
>> +	dev_info(otg_dev, "otg: gadget %s unregistered\n",
>> +		 dev_name(&gadget->dev));
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_otg_unregister_gadget);
>> diff --git a/drivers/usb/common/usb-otg.h b/drivers/usb/common/usb-otg.h
>> new file mode 100644
>> index 0000000..2bf3fbf
>> --- /dev/null
>> +++ b/drivers/usb/common/usb-otg.h
>> @@ -0,0 +1,71 @@
>> +/**
>> + * drivers/usb/common/usb-otg.h - USB OTG core local header
>> + *
>> + * Copyright (C) 2016 Texas Instruments Incorporated - http://www.ti.com
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
>> index ae228d0..b468a9f 100644
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
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index 8c0ae64..1878ae1 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -583,6 +583,7 @@ struct usb_gadget_ops {
>>   * @out_epnum: last used out ep number
>>   * @in_epnum: last used in ep number
>>   * @otg_caps: OTG capabilities of this gadget.
>> + * @otg_dev: OTG controller device, if needs to be used with OTG core.
>>   * @sg_supported: true if we can handle scatter-gather
>>   * @is_otg: True if the USB device port uses a Mini-AB jack, so that the
>>   *	gadget driver must provide a USB OTG descriptor.
>> @@ -639,6 +640,7 @@ struct usb_gadget {
>>  	unsigned			out_epnum;
>>  	unsigned			in_epnum;
>>  	struct usb_otg_caps		*otg_caps;
>> +	struct device			*otg_dev;
>>  
>>  	unsigned			sg_supported:1;
>>  	unsigned			is_otg:1;
>> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
>> index 861ccaa..2017cd4 100644
>> --- a/include/linux/usb/hcd.h
>> +++ b/include/linux/usb/hcd.h
>> @@ -184,6 +184,7 @@ struct usb_hcd {
>>  	struct mutex		*bandwidth_mutex;
>>  	struct usb_hcd		*shared_hcd;
>>  	struct usb_hcd		*primary_hcd;
>> +	struct device		*otg_dev;	/* OTG controller device */
>>  
>>  
>>  #define HCD_BUFFER_POOLS	4
>> diff --git a/include/linux/usb/otg-fsm.h b/include/linux/usb/otg-fsm.h
>> index 36f0cf9..ba6755c 100644
>> --- a/include/linux/usb/otg-fsm.h
>> +++ b/include/linux/usb/otg-fsm.h
>> @@ -61,6 +61,11 @@ enum otg_fsm_timer {
>>  /**
>>   * struct otg_fsm - OTG state machine according to the OTG spec
>>   *
>> + * DRD mode hardware Inputs
>> + *
>> + * @id:		TRUE for B-device, FALSE for A-device.
>> + * @b_sess_vld:	VBUS voltage in regulation.
>> + *
>>   * OTG hardware Inputs
>>   *
>>   *	Common inputs for A and B device
>> @@ -133,6 +138,7 @@ enum otg_fsm_timer {
>>   * a_clr_err:	Asserted (by application ?) to clear a_vbus_err due to an
>>   *		overcurrent condition and causes the A-device to transition
>>   *		to a_wait_vfall
>> + * running:	state machine running/stopped indicator
>>   */
>>  struct otg_fsm {
>>  	/* Input */
>> @@ -188,6 +194,7 @@ struct otg_fsm {
>>  	int b_ase0_brst_tmout;
>>  	int a_bidl_adis_tmout;
>>  
>> +	bool running;
>>  	struct otg_fsm_ops *ops;
>>  
>>  	/* Current usb protocol used: 0:undefine; 1:host; 2:client */
>> diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
>> index 85b8fb5..b094352 100644
>> --- a/include/linux/usb/otg.h
>> +++ b/include/linux/usb/otg.h
>> @@ -10,10 +10,55 @@
>>  #define __LINUX_USB_OTG_H
>>  
>>  #include <linux/phy/phy.h>
>> -#include <linux/usb/phy.h>
>> -#include <linux/usb/otg-fsm.h>
>> +#include <linux/device.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/ktime.h>
>> +#include <linux/usb.h>
>>  #include <linux/usb/hcd.h>
>> +#include <linux/usb/gadget.h>
>> +#include <linux/usb/otg-fsm.h>
>> +#include <linux/usb/phy.h>
>>  
>> +/**
>> + * struct otg_hcd - host controller state and interface
>> + *
>> + * @hcd: host controller
>> + * @irqnum: irq number
>> + * @irqflags: irq flags
>> + * @ops: otg to host controller interface
>> + * @ops: otg to host controller interface
>> + * @otg_dev: otg controller device
>> + */
>> +struct otg_hcd {
>> +	struct usb_hcd *hcd;
>> +	unsigned int irqnum;
>> +	unsigned long irqflags;
>> +	struct otg_hcd_ops *ops;
>> +	struct device *otg_dev;
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
>> + * @hcd_ops: host controller interface
>> + * ------- internal use only -------
>> + * @primary_hcd: primary host state and interface
>> + * @shared_hcd: shared host state and interface
>> + * @gadget_ops: gadget controller interface
>> + * @list: list of otg controllers
>> + * @work: otg state machine work
>> + * @wq: otg state machine work queue
>> + * @flags: to track if host/gadget is running
>> + */
>>  struct usb_otg {
>>  	u8			default_a;
>>  
>> @@ -24,9 +69,24 @@ struct usb_otg {
>>  	struct usb_gadget	*gadget;
>>  
>>  	enum usb_otg_state	state;
>> +	struct device *dev;
>> +	struct usb_otg_caps *caps;
>>  	struct otg_fsm fsm;
>>  	struct otg_hcd_ops	*hcd_ops;
>>  
>> +	/* internal use only */
>> +	struct otg_hcd primary_hcd;
>> +	struct otg_hcd shared_hcd;
>> +	struct otg_gadget_ops *gadget_ops;
>> +	struct list_head list;
>> +	struct work_struct work;
>> +	struct workqueue_struct *wq;
>> +	u32 flags;
>> +#define OTG_FLAG_GADGET_RUNNING (1 << 0)
>> +#define OTG_FLAG_HOST_RUNNING (1 << 1)
>> +	/* use otg->fsm.lock for serializing access */
>> +
>> +/*------------- deprecated interface -----------------------------*/
>>  	/* bind/unbind the host controller */
>>  	int	(*set_host)(struct usb_otg *otg, struct usb_bus *host);
>>  
>> @@ -42,7 +102,7 @@ struct usb_otg {
>>  
>>  	/* start or continue HNP role switch */
>>  	int	(*start_hnp)(struct usb_otg *otg);
>> -
>> +/*---------------------------------------------------------------*/
>>  };
>>  
>>  /**
>> @@ -60,8 +120,92 @@ struct usb_otg_caps {
>>  	bool adp_support;
>>  };
>>  
>> +/**
>> + * struct usb_otg_config - otg controller configuration
>> + * @caps: otg capabilities of the controller
>> + * @ops: otg fsm operations
>> + * @otg_work: optional custom otg state machine work function
>> + */
>> +struct usb_otg_config {
>> +	struct usb_otg_caps *otg_caps;
>> +	struct otg_fsm_ops *fsm_ops;
>> +	void (*otg_work)(struct work_struct *work);
>> +};
>> +
>>  extern const char *usb_otg_state_string(enum usb_otg_state state);
>>  
>> +#if IS_ENABLED(CONFIG_USB_OTG)
>> +struct usb_otg *usb_otg_register(struct device *dev,
>> +				 struct usb_otg_config *config);
>> +int usb_otg_unregister(struct device *dev);
>> +int usb_otg_register_hcd(struct usb_hcd *hcd, unsigned int irqnum,
>> +			 unsigned long irqflags, struct otg_hcd_ops *ops);
>> +int usb_otg_unregister_hcd(struct usb_hcd *hcd);
>> +int usb_otg_register_gadget(struct usb_gadget *gadget,
>> +			    struct otg_gadget_ops *ops);
>> +int usb_otg_unregister_gadget(struct usb_gadget *gadget);
>> +void usb_otg_sync_inputs(struct usb_otg *otg);
>> +int usb_otg_kick_fsm(struct device *otg_dev);
>> +int usb_otg_start_host(struct usb_otg *otg, int on);
>> +int usb_otg_start_gadget(struct usb_otg *otg, int on);
>> +
>> +#else /* CONFIG_USB_OTG */
>> +
>> +static inline struct usb_otg *usb_otg_register(struct device *dev,
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
>> +static inline void usb_otg_sync_inputs(struct usb_otg *otg)
>> +{
>> +}
>> +
>> +static inline int usb_otg_kick_fsm(struct device *otg_dev)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int usb_otg_start_host(struct usb_otg *otg, int on)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +
>> +static inline int usb_otg_start_gadget(struct usb_otg *otg, int on)
>> +{
>> +	return -ENOTSUPP;
>> +}
>> +#endif /* CONFIG_USB_OTG */
>> +
>> +/*------------- deprecated interface -----------------------------*/
>>  /* Context: can sleep */
>>  static inline int
>>  otg_start_hnp(struct usb_otg *otg)
>> @@ -113,6 +257,8 @@ otg_start_srp(struct usb_otg *otg)
>>  	return -ENOTSUPP;
>>  }
>>  
>> +/*---------------------------------------------------------------*/
>> +
>>  /* for OTG controller drivers (and maybe other stuff) */
>>  extern int usb_bus_start_enum(struct usb_bus *bus, unsigned port_num);
>>  
>> @@ -237,4 +383,6 @@ static inline int otg_start_gadget(struct usb_otg *otg, int on)
>>  	return otg->fsm.ops->start_gadget(otg, on);
>>  }
>>  
>> +int drd_statemachine(struct usb_otg *otg);
>> +
>>  #endif /* __LINUX_USB_OTG_H */
>> -- 
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
