From: Peter Chen <Peter.Chen@freescale.com>
Subject: RE: [RFC][PATCH 3/9] usb: otg: add OTG core
Date: Fri, 20 Mar 2015 09:32:41 +0000
Message-ID: <BN3PR0301MB084970F0BE5DC15E694DE697810E0@BN3PR0301MB0849.namprd03.prod.outlook.com>
References: <1426686963-11613-1-git-send-email-rogerq@ti.com>
 <1426686963-11613-4-git-send-email-rogerq@ti.com>
 <20150319034034.GA7779@shlinux2> <550AA28F.6040201@ti.com>
 <20150320074550.GG7537@shlinux2> <550BE5F5.8050006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-by2on0110.outbound.protection.outlook.com ([207.46.100.110]:38400
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750990AbbCTJcr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 05:32:47 -0400
In-Reply-To: <550BE5F5.8050006@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, "balbi@ti.com" <balbi@ti.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "Jun.Li@freescale.com" <Jun.Li@freescale.com>, "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 
> >>>>
> >>>> - Registering an OTG capable controller
> >>>> - Registering Host and Gadget controllers to OTG core
> >>>> - Providing inputs to and kicking the OTG state machine
> >>>>
> >>>> TODO:
> >>>> - sysfs interface to allow application inputs to OTG state machine
> >>>> - otg class?
> >>>>
> >>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> >>>> ---
> >>>>  drivers/usb/Makefile         |   1 +
> >>>>  drivers/usb/common/Makefile  |   1 +
> >>>>  drivers/usb/common/usb-otg.c | 732
> >>>> +++++++++++++++++++++++++++++++++++++++++++
> >>>>  drivers/usb/common/usb-otg.h |  71 +++++
> >>>>  drivers/usb/core/Kconfig     |   8 +
> >>>>  include/linux/usb/usb-otg.h  |  86 +++++
> >>>>  6 files changed, 899 insertions(+)  create mode 100644
> >>>> drivers/usb/common/usb-otg.c  create mode 100644
> >>>> drivers/usb/common/usb-otg.h  create mode 100644
> >>>> include/linux/usb/usb-otg.h
> >>>>
> >>>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile index
> >>>> 2f1e2aa..07f59a5 100644
> >>>> --- a/drivers/usb/Makefile
> >>>> +++ b/drivers/usb/Makefile
> >>>> @@ -60,5 +60,6 @@ obj-$(CONFIG_USB_RENESAS_USBHS)	+=
> renesas_usbhs/
> >>>>  obj-$(CONFIG_USB_GADGET)	+= gadget/
> >>>>
> >>>>  obj-$(CONFIG_USB_COMMON)	+= common/
> >>>> +obj-$(CONFIG_USB_OTG_CORE)	+= common/
> >>>>
> >>>>  obj-$(CONFIG_USBIP_CORE)	+= usbip/
> >>>> diff --git a/drivers/usb/common/Makefile
> >>>> b/drivers/usb/common/Makefile index ca2f8bd..573fc75 100644
> >>>> --- a/drivers/usb/common/Makefile
> >>>> +++ b/drivers/usb/common/Makefile
> >>>> @@ -7,3 +7,4 @@ usb-common-y			  += common.o
> >>>>  usb-common-$(CONFIG_USB_LED_TRIG) += led.o
> >>>>
> >>>>  obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
> >>>> +obj-$(CONFIG_USB_OTG_CORE) += usb-otg.o
> >>>> diff --git a/drivers/usb/common/usb-otg.c
> >>>> b/drivers/usb/common/usb-otg.c new file mode 100644 index
> >>>> 0000000..1433fc9
> >>>> --- /dev/null
> >>>> +++ b/drivers/usb/common/usb-otg.c
> >>>> @@ -0,0 +1,732 @@
> >>>> +/**
> >>>> + * drivers/usb/common/usb-otg.c - USB OTG core
> >>>> + *
> >>>> + * Copyright (C) 2015 Texas Instruments Incorporated -
> >>>> +http://www.ti.com
> >>>> + * Author: Roger Quadros <rogerq@ti.com>
> >>>> + *
> >>>> + * This program is free software; you can redistribute it and/or
> >>>> +modify
> >>>> + * it under the terms of the GNU General Public License version 2
> >>>> +as
> >>>> + * published by the Free Software Foundation.
> >>>> + *
> >>>> + * This program is distributed in the hope that it will be useful,
> >>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>>> + * GNU General Public License for more details.
> >>>> + */
> >>>> +
> >>>> +#include <linux/kernel.h>
> >>>> +#include <linux/list.h>
> >>>> +#include <linux/timer.h>
> >>>> +#include <linux/usb/otg.h>
> >>>> +#include <linux/usb/phy.h>	/* enum usb_otg_state */
> >>>> +#include <linux/usb/gadget.h>
> >>>> +#include <linux/usb/usb-otg.h>
> >>>> +#include <linux/workqueue.h>
> >>>> +
> >>>> +#include "usb-otg.h"
> >>>> +
> >>>> +/* to link timer with callback data */ struct otg_timer {
> >>>> +	struct timer_list timer;
> >>>> +	/* callback data */
> >>>> +	int *timeout_bit;
> >>>> +	struct otg_data *otgd;
> >>>> +};
> >>>> +
> >>>> +struct otg_data {
> >>>> +	struct device *dev;	/* HCD & GCD's parent device */
> >>>> +
> >>>> +	struct otg_fsm fsm;
> >>>> +	/* HCD, GCD and usb_otg_state are present in otg_fsm->otg
> >>>> +	 * HCD is bus_to_hcd(fsm->otg->host)
> >>>> +	 * GCD is fsm->otg->gadget
> >>>> +	 */
> >>>> +	struct otg_fsm_ops fsm_ops;	/* private copy for override */
> >>>> +	struct usb_otg otg;
> >>>> +	struct usb_hcd *shared_hcd;	/* if shared HCD registered */
> >>>> +
> >>>> +	/* saved hooks to OTG device */
> >>>> +	int (*start_host)(struct otg_fsm *fsm, int on);
> >>>> +	int (*start_gadget)(struct otg_fsm *fsm, int on);
> >>>> +
> >>>> +	struct list_head list;
> >>>> +
> >>>> +	struct work_struct work;	/* OTG FSM work */
> >>>> +	struct workqueue_struct *wq;
> >>>> +
> >>>> +	struct otg_timer timers[NUM_OTG_FSM_TIMERS];
> >>>> +
> >>>> +	bool fsm_running;
> >>>> +	bool gadget_can_start;		/* OTG FSM says gadget can start */
> >>>> +	bool host_can_start;		/* OTG FSM says host can start */
> >>>> +
> >>>> +	/* use otg->fsm.lock for serializing access */ };
> >>>
> >>> What's the relationship between struct usb_otg otg and this one?
> >>
> >> Did you mean why struct usb_otg otg is there in struct otg_data?
> >> Just for easy allocation. fsm_ops only contains the pointer to struct usb_otg.
> >>
> >
> > The reason why I ask this question is the most structures at usb_otg
> > (only enum usb_otg_state)are useless for otg_fsm, this structure may
> > only for hardware otg fsm driver, so your OTG framework should only
> > for software FSM drivers, right?
> 
> right. we only need it for enum usb_otg_state.
> Do you see how we can improve it?
> 

Felipe & Roger, if we need to go on supporting legacies otg driver, we need to
keep struct usb_otg unchanged, and teach new otg driver using Roger's framework.

Peter

