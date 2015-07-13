From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 07/11] usb: otg: add OTG core
Date: Mon, 13 Jul 2015 13:20:43 +0300
Message-ID: <55A390FB.5080406@ti.com>
References: <1436350777-28056-1-git-send-email-rogerq@ti.com> <1436350777-28056-8-git-send-email-rogerq@ti.com> <20150713021456.GE27710@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150713021456.GE27710@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: stern@rowland.harvard.edu, balbi@ti.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 13/07/15 05:14, Peter Chen wrote:
> On Wed, Jul 08, 2015 at 01:19:33PM +0300, Roger Quadros wrote:
>> The OTG core instantiates the OTG Finite State Machine
>> per OTG controller and manages starting/stopping the
>> host and gadget controllers based on the bus state.
>>
>> It provides APIs for the following tasks
>>
>> - Registering an OTG capable controller
>> - Registering Host and Gadget controllers to OTG core
>> - Providing inputs to and kicking the OTG state machine
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  MAINTAINERS                  |   4 +-
>>  drivers/usb/Kconfig          |   2 +-
>>  drivers/usb/Makefile         |   1 +
>>  drivers/usb/common/Makefile  |   3 +-
>>  drivers/usb/common/usb-otg.c | 768 +++++++++++++++++++++++++++++++++++++++++++
>>  drivers/usb/common/usb-otg.h |  71 ++++
>>  drivers/usb/core/Kconfig     |  11 +-
>>  include/linux/usb/otg.h      |  91 ++++-
>>  8 files changed, 930 insertions(+), 21 deletions(-)
>>  create mode 100644 drivers/usb/common/usb-otg.c
>>  create mode 100644 drivers/usb/common/usb-otg.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8133cef..b21278e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10640,12 +10640,14 @@ S:	Maintained
>>  F:	Documentation/usb/ohci.txt
>>  F:	drivers/usb/host/ohci*
>>  
>> -USB OTG FSM (Finite State Machine)
>> +USB OTG/DRD core and FSM (Finite State Machine)
>>  M:	Peter Chen <Peter.Chen@freescale.com>
>> +M:	Roger Quadros <rogerq@ti.com>
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
>>  L:	linux-usb@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/usb/common/usb-otg-fsm.c
>> +F:	drivers/usb/common/usb-otg.c
>>  
>>  USB OVER IP DRIVER
>>  M:	Valentina Manea <valentina.manea.m@gmail.com>
>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>> index 8ed451d..5b625e2 100644
>> --- a/drivers/usb/Kconfig
>> +++ b/drivers/usb/Kconfig
>> @@ -32,7 +32,7 @@ if USB_SUPPORT
>>  config USB_COMMON
>>  	tristate
>>  	default y
>> -	depends on USB || USB_GADGET
>> +	depends on USB || USB_GADGET || USB_OTG
>>  
> 
> USB_OTG can depends on USB || UB_GADGET?

I didn't understand. The above is for USB_COMMON.

> 
>>  config USB_ARCH_HAS_HCD
>>  	def_bool y
>> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
>> index d8926c6..769d13b 100644
>> --- a/drivers/usb/Makefile
>> +++ b/drivers/usb/Makefile
>> @@ -60,5 +60,6 @@ obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs/
>>  obj-$(CONFIG_USB_GADGET)	+= gadget/
>>  
>>  obj-$(CONFIG_USB_COMMON)	+= common/
>> +obj-$(CONFIG_USB_OTG)		+= common/
>>  
> 
> The comment like above.

What should it look like?

> 
>>  obj-$(CONFIG_USBIP_CORE)	+= usbip/
>> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
>> index 6bbb3ec..730d928 100644
>> --- a/drivers/usb/common/Makefile
>> +++ b/drivers/usb/common/Makefile
>> @@ -6,5 +6,6 @@ obj-$(CONFIG_USB_COMMON)	  += usb-common.o
>>  usb-common-y			  += common.o
>>  usb-common-$(CONFIG_USB_LED_TRIG) += led.o
>>  
>> -obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
>>  obj-$(CONFIG_USB_ULPI_BUS)	+= ulpi.o
>> +usbotg-y		:= usb-otg.o usb-otg-fsm.o
>> +obj-$(CONFIG_USB_OTG)	+= usbotg.o
>> diff --git a/drivers/usb/common/usb-otg.c b/drivers/usb/common/usb-otg.c
>> new file mode 100644
>> index 0000000..0379034
>> --- /dev/null
>> +++ b/drivers/usb/common/usb-otg.c
>> @@ -0,0 +1,768 @@
>> +/**
>> + * drivers/usb/common/usb-otg.c - USB OTG core
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
>> +#include <linux/kernel.h>
>> +#include <linux/ktime.h>
>> +#include <linux/hrtimer.h>
>> +#include <linux/list.h>
>> +#include <linux/usb/otg.h>
>> +#include <linux/usb/phy.h>	/* enum usb_otg_state */
>> +#include <linux/usb/gadget.h>
>> +#include <linux/workqueue.h>
>> +
>> +#include "usb-otg.h"
>> +
>> +/* to link timer with callback data */
>> +struct otg_timer {
>> +	struct hrtimer timer;
>> +	ktime_t timeout;
>> +	/* callback data */
>> +	int *timeout_bit;
>> +	struct otg_data *otgd;
>> +};
>> +
>> +struct otg_hcd {
>> +	struct usb_hcd *hcd;
>> +	unsigned int irqnum;
>> +	unsigned long irqflags;
>> +	struct otg_hcd_ops *ops;
>> +};
>> +
>> +struct otg_data {
>> +	struct device *dev;	/* HCD & GCD's parent device */
>> +
>> +	struct otg_fsm fsm;
>> +	/* HCD, GCD and usb_otg_state are present in otg_fsm->otg
>> +	 * HCD is bus_to_hcd(fsm->otg->host)
>> +	 * GCD is fsm->otg->gadget
>> +	 */
>> +	struct otg_fsm_ops fsm_ops;	/* private copy for override */
>> +	struct usb_otg otg;		/* allocator for fsm->otg */
>> +
>> +	struct otg_hcd primary_hcd;
>> +	struct otg_hcd shared_hcd;
>> +
>> +	struct otg_gadget_ops *gadget_ops; /* interface to gadget f/w */
>> +
>> +	/* saved hooks to OTG device */
>> +	int (*start_host)(struct otg_fsm *fsm, int on);
>> +	int (*start_gadget)(struct otg_fsm *fsm, int on);
>> +
>> +	struct list_head list;
>> +
>> +	struct work_struct work;	/* OTG FSM work */
>> +	struct workqueue_struct *wq;
>> +
>> +	struct otg_timer timers[NUM_OTG_FSM_TIMERS];
>> +
>> +	bool fsm_running;
>> +	/* use otg->fsm.lock for serializing access */
>> +};
>> +
> 
> Would you consider enhance struct usb_otg, and instead of this
> structure, I am wonder similar structures may increase the confuse
> in future.

Yes, that should be possible.

cheers,
-roger
