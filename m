From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [RFC][PATCH v2 05/13] usb: otg: add OTG core
Date: Wed, 15 Apr 2015 11:29:09 +0200
Message-ID: <1429090149.16771.19.camel@x220>
References: <1429008120-5395-1-git-send-email-rogerq@ti.com>
	 <1429008120-5395-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lb3-smtp-cloud2.xs4all.net ([194.109.24.29]:54724 "EHLO
	lb3-smtp-cloud2.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753936AbbDOJ3O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 05:29:14 -0400
In-Reply-To: <1429008120-5395-6-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: gregkh@linuxfoundation.org, balbi@ti.com, stern@rowland.harvard.edu, dan.j.williams@intel.com, peter.chen@freescale.com, jun.li@freescale.com, mathias.nyman@linux.intel.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

(This will go into a minor detail. That's probably not what you want
when posting an RFC. But this patch got caught by an email filter I use
and a future, non-RFC, version will get caught too. So I decided to
bother you with this now.)

On Tue, 2015-04-14 at 13:41 +0300, Roger Quadros wrote:
> --- a/drivers/usb/common/Makefile
> +++ b/drivers/usb/common/Makefile

> +obj-$(CONFIG_USB_OTG_CORE) += usb-otg.o

This creates a module usb-otg.ko if CONFIG_USB_OTG_CORE is 'm', built
from just usb-otg.c.

> --- /dev/null
> +++ b/drivers/usb/common/usb-otg.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

> +EXPORT_SYMBOL_GPL(usb_otg_register);

> +EXPORT_SYMBOL_GPL(usb_otg_unregister);

> +EXPORT_SYMBOL_GPL(usb_otg_sync_inputs);

> +EXPORT_SYMBOL_GPL(usb_otg_kick_fsm);

> +EXPORT_SYMBOL_GPL(usb_otg_register_hcd);

> +EXPORT_SYMBOL_GPL(usb_otg_unregister_hcd);

> +EXPORT_SYMBOL_GPL(usb_otg_register_gadget);

> +EXPORT_SYMBOL_GPL(usb_otg_unregister_gadget);
 
> +EXPORT_SYMBOL_GPL(usb_otg_fsm_to_dev);

This code adds no MODULE_LICENSE() macro in this patch and usb-otg.ko
will carry no license field. So I think the loading of that module
(triggered by loading another module that uses one of the exported
symbols, I suppose) taints the kernel. Am I correct?


Paul Bolle

