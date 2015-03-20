From: Roger Quadros <rogerq@ti.com>
Subject: Re: [RFC][PATCH 3/9] usb: otg: add OTG core
Date: Fri, 20 Mar 2015 11:18:45 +0200
Message-ID: <550BE5F5.8050006@ti.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com> <1426686963-11613-4-git-send-email-rogerq@ti.com> <20150319034034.GA7779@shlinux2> <550AA28F.6040201@ti.com> <20150320074550.GG7537@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150320074550.GG7537@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20/03/15 09:45, Peter Chen wrote:
> On Thu, Mar 19, 2015 at 12:18:55PM +0200, Roger Quadros wrote:
>> On 19/03/15 05:40, Peter Chen wrote:
>>> On Wed, Mar 18, 2015 at 03:55:57PM +0200, Roger Quadros wrote:
>>>> The OTG core instantiates the OTG Finite State Machine
>>>> per OTG controller and manages starting/stopping the
>>>> host and gadget controllers based on the bus state.
>>>>
>>>> It provides APIs for the following tasks
>>>>
>>>> - Registering an OTG capable controller
>>>> - Registering Host and Gadget controllers to OTG core
>>>> - Providing inputs to and kicking the OTG state machine
>>>>
>>>> TODO:
>>>> - sysfs interface to allow application inputs to OTG state machine
>>>> - otg class?
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>>  drivers/usb/Makefile         |   1 +
>>>>  drivers/usb/common/Makefile  |   1 +
>>>>  drivers/usb/common/usb-otg.c | 732 +++++++++++++++++++++++++++++++++++++++++++
>>>>  drivers/usb/common/usb-otg.h |  71 +++++
>>>>  drivers/usb/core/Kconfig     |   8 +
>>>>  include/linux/usb/usb-otg.h  |  86 +++++
>>>>  6 files changed, 899 insertions(+)
>>>>  create mode 100644 drivers/usb/common/usb-otg.c
>>>>  create mode 100644 drivers/usb/common/usb-otg.h
>>>>  create mode 100644 include/linux/usb/usb-otg.h
>>>>
>>>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
>>>> index 2f1e2aa..07f59a5 100644
>>>> --- a/drivers/usb/Makefile
>>>> +++ b/drivers/usb/Makefile
>>>> @@ -60,5 +60,6 @@ obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
>>>>  obj-$(CONFIG_USB_GADGET)	+= gadget/
>>>>  
>>>>  obj-$(CONFIG_USB_COMMON)	+= common/
>>>> +obj-$(CONFIG_USB_OTG_CORE)	+= common/
>>>>  
>>>>  obj-$(CONFIG_USBIP_CORE)	+= usbip/
>>>> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
>>>> index ca2f8bd..573fc75 100644
>>>> --- a/drivers/usb/common/Makefile
>>>> +++ b/drivers/usb/common/Makefile
>>>> @@ -7,3 +7,4 @@ usb-common-y			  += common.o
>>>>  usb-common-$(CONFIG_USB_LED_TRIG) += led.o
>>>>  
>>>>  obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
>>>> +obj-$(CONFIG_USB_OTG_CORE) += usb-otg.o
>>>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>>>> new file mode 100644
>>>> index 0000000..1433fc9
>>>> --- /dev/null
>>>> +++ b/drivers/usb/common/usb-otg.c
>>>> @@ -0,0 +1,732 @@
>>>> +/**
>>>> + * drivers/usb/common/usb-otg.c - USB OTG core
>>>> + *
>>>> + * Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
>>>> + * Author: Roger Quadros <rogerq@ti.com>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + *
>>>> + * This program is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + * GNU General Public License for more details.
>>>> + */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/list.h>
>>>> +#include <linux/timer.h>
>>>> +#include <linux/usb/otg.h>
>>>> +#include <linux/usb/phy.h>	/* enum usb_otg_state */
>>>> +#include <linux/usb/gadget.h>
>>>> +#include <linux/usb/usb-otg.h>
>>>> +#include <linux/workqueue.h>
>>>> +
>>>> +#include "usb-otg.h"
>>>> +
>>>> +/* to link timer with callback data */
>>>> +struct otg_timer {
>>>> +	struct timer_list timer;
>>>> +	/* callback data */
>>>> +	int *timeout_bit;
>>>> +	struct otg_data *otgd;
>>>> +};
>>>> +
>>>> +struct otg_data {
>>>> +	struct device *dev;	/* HCD & GCD's parent device */
>>>> +
>>>> +	struct otg_fsm fsm;
>>>> +	/* HCD, GCD and usb_otg_state are present in otg_fsm->otg
>>>> +	 * HCD is bus_to_hcd(fsm->otg->host)
>>>> +	 * GCD is fsm->otg->gadget
>>>> +	 */
>>>> +	struct otg_fsm_ops fsm_ops;	/* private copy for override */
>>>> +	struct usb_otg otg;
>>>> +	struct usb_hcd *shared_hcd;	/* if shared HCD registered */
>>>> +
>>>> +	/* saved hooks to OTG device */
>>>> +	int (*start_host)(struct otg_fsm *fsm, int on);
>>>> +	int (*start_gadget)(struct otg_fsm *fsm, int on);
>>>> +
>>>> +	struct list_head list;
>>>> +
>>>> +	struct work_struct work;	/* OTG FSM work */
>>>> +	struct workqueue_struct *wq;
>>>> +
>>>> +	struct otg_timer timers[NUM_OTG_FSM_TIMERS];
>>>> +
>>>> +	bool fsm_running;
>>>> +	bool gadget_can_start;		/* OTG FSM says gadget can start */
>>>> +	bool host_can_start;		/* OTG FSM says host can start */
>>>> +
>>>> +	/* use otg->fsm.lock for serializing access */
>>>> +};
>>>
>>> What's the relationship between struct usb_otg otg and this one?
>>
>> Did you mean why struct usb_otg otg is there in struct otg_data?
>> Just for easy allocation. fsm_ops only contains the pointer to struct usb_otg.
>>
> 
> The reason why I ask this question is the most structures at usb_otg
> (only enum usb_otg_state)are useless for otg_fsm, this structure may
> only for hardware otg fsm driver, so your OTG framework should only
> for software FSM drivers, right?

right. we only need it for enum usb_otg_state.
Do you see how we can improve it?

cheers,
-roger

> 
> Peter
> 
>>>
>>>> +
>>>> +/* OTG device list */
>>>> +LIST_HEAD(otg_list);
>>>> +static DEFINE_MUTEX(otg_list_mutex);
>>>> +
>>>> +/**
>>>> + * check if device is in our OTG list and return
>>>> + * otg_data, else NULL.
>>>> + *
>>>> + * otg_list_mutex must be held.
>>>> + */
>>>> +static struct otg_data *usb_otg_device_get_otgd(struct device *parent_dev)
>>>> +{
>>>> +	struct otg_data *otgd;
>>>> +
>>>> +	list_for_each_entry(otgd, &otg_list, list) {
>>>> +		if (otgd->dev == parent_dev)
>>>> +			return otgd;
>>>> +	}
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +/**
>>>> + * timer callback to set timeout bit and kick FSM
>>>> + */
>>>> +static void set_tmout(unsigned long data)
>>>> +{
>>>> +	struct otg_timer *tmr_data;
>>>> +
>>>> +	tmr_data = (struct otg_timer *)data;
>>>> +
>>>> +	if (tmr_data->timeout_bit)
>>>> +		*tmr_data->timeout_bit = 1;
>>>> +
>>>> +	usb_otg_sync_inputs(&tmr_data->otgd->fsm);
>>>> +}
>>>> +
>>>> +/**
>>>> + * Initialize one OTG timer with callback, timeout and timeout bit
>>>> + */
>>>> +static void otg_timer_init(enum otg_fsm_timer id, struct otg_data *otgd,
>>>> +			   void (*callback)(unsigned long),
>>>> +			   unsigned long expires_ms,
>>>> +			   int *timeout_bit)
>>>> +{
>>>> +	struct otg_timer *otgtimer = &otgd->timers[id];
>>>> +	struct timer_list *timer = &otgtimer->timer;
>>>> +
>>>> +	init_timer(timer);
>>>> +	timer->function = callback;
>>>> +	timer->expires = jiffies + msecs_to_jiffies(expires_ms);
>>>> +	timer->data = (unsigned long)otgtimer;
>>>> +
>>>
>>> The timer for TB_DATA_PLS is about 10ms or less, it is not suitable
>>> for using kernel timer, hrtimer is suitable choice.
>>
>> good catch. I will switch to hrtimer then.
>>
>>>
>>>> +	otgtimer->timeout_bit = timeout_bit;
>>>> +	otgtimer->otgd = otgd;
>>>> +}
>>>> +
>>>> +/**
>>>> + * Initialize standard OTG timers
>>>> + */
>>>> +static void usb_otg_init_timers(struct otg_data *otgd)
>>>> +{
>>>> +	struct otg_fsm *fsm = &otgd->fsm;
>>>> +
>>>> +	otg_timer_init(A_WAIT_VRISE, otgd, set_tmout, TA_WAIT_VRISE, &fsm->a_wait_vrise_tmout);
>>>> +	otg_timer_init(A_WAIT_VFALL, otgd, set_tmout, TA_WAIT_VFALL, &fsm->a_wait_vfall_tmout);
>>>> +	otg_timer_init(A_WAIT_BCON, otgd, set_tmout, TA_WAIT_BCON, &fsm->a_wait_bcon_tmout);
>>>> +	otg_timer_init(A_AIDL_BDIS, otgd, set_tmout, TA_AIDL_BDIS, &fsm->a_aidl_bdis_tmout);
>>>> +	otg_timer_init(A_BIDL_ADIS, otgd, set_tmout, TA_BIDL_ADIS, &fsm->a_bidl_adis_tmout);
>>>> +	otg_timer_init(B_ASE0_BRST, otgd, set_tmout, TB_ASE0_BRST, &fsm->b_ase0_brst_tmout);
>>>> +
>>>> +	otg_timer_init(B_SE0_SRP, otgd, set_tmout, TB_SE0_SRP, &fsm->b_se0_srp);
>>>> +	otg_timer_init(B_SRP_FAIL, otgd, set_tmout, TB_SRP_FAIL, &fsm->b_srp_done);
>>>> +
>>>> +	otg_timer_init(A_WAIT_ENUM, otgd, set_tmout, TB_SRP_FAIL, NULL);
>>>> +}
>>
>> <snip>
>>
>> cheers,
>> -roger
>>
> 
