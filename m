From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [RFC PATCH 1/9] HSI: Low Level Driver interface
Date: Fri, 30 Oct 2009 14:49:07 +0200
Message-ID: <20091030124907.GJ31472@nokia.com>
References: <1256896808-20152-1-git-send-email-s-jan@ti.com>
 <1256896808-20152-2-git-send-email-s-jan@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53569 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140AbZJ3Mt3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Oct 2009 08:49:29 -0400
Content-Disposition: inline
In-Reply-To: <1256896808-20152-2-git-send-email-s-jan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sebastien Jan <s-jan@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chinea Carlos (Nokia-D/Helsinki)" <Carlos.Chinea@nokia.com>

Hi,

On Fri, Oct 30, 2009 at 11:00:00AM +0100, ext Sebastien Jan wrote:
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 086857c..05b4190 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -111,3 +111,4 @@ obj-$(CONFIG_VLYNQ)         += vlynq/
>  obj-$(CONFIG_STAGING)          += staging/
>  obj-y                          += platform/
>  obj-y                          += ieee802154/
> +obj-$(CONFIG_OMAP_HSI)         += hsi/

not omap specific.

> diff --git a/drivers/hsi/Kconfig b/drivers/hsi/Kconfig
> new file mode 100644
> index 0000000..e10b522
> --- /dev/null
> +++ b/drivers/hsi/Kconfig
> @@ -0,0 +1,44 @@
> +#
> +# OMAP HSI driver configuration

this shouldn't be omap specific. The comment is misleading.

> diff --git a/drivers/hsi/Makefile b/drivers/hsi/Makefile
> new file mode 100644
> index 0000000..a7f579b
> --- /dev/null
> +++ b/drivers/hsi/Makefile
> @@ -0,0 +1,14 @@
> +#
> +# Makefile for HSI drivers
> +#
> +EXTRA_CFLAGS :=
> +
> +omap_hsi-objs  :=      hsi_driver.o hsi_driver_dma.o hsi_driver_int.o \
> +                       hsi_driver_if.o hsi_driver_bus.o hsi_driver_gpio.o \
> +                       hsi_driver_fifo.o

this should a more generic bus driver and it shouldn't know about how
the hardware handles e.g. reset signals.

What I suggest you to do is:

Bus Layer
hsi.ko -> MIPI HSI Bus Driver (like i2c-core.c or usbcore, etc etc)

HW Layer
hsi-omap.ko-> OMAP HSI Controller (like i2c-omap.c)

Clients Layer
any protocol driver using the HSI bus

> diff --git a/drivers/hsi/hsi_driver_if.c b/drivers/hsi/hsi_driver_if.c
> new file mode 100644
> index 0000000..fb0035d
> --- /dev/null
> +++ b/drivers/hsi/hsi_driver_if.c
> @@ -0,0 +1,657 @@
> +/*
> + * hsi_driver_if.c
> + *
> + * Implements HSI hardware driver interfaces for the upper layers.
> + *
> + * Copyright (C) 2007-2008 Nokia Corporation. All rights reserved.
> + * Copyright (C) 2009 Texas Instruments, Inc.
> + *
> + * Author: Carlos Chinea <carlos.chinea@nokia.com>
> + * Author: Sebastien JAN <s-jan@ti.com>
> + *
> + * This package is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + */
> +
> +#include "hsi_driver.h"

should be including something like:

#include <linux/hsi/driver.h>

or even

#include <linux/hsi.h>

> +int hsi_register_driver(struct hsi_device_driver *driver);
> +void hsi_unregister_driver(struct hsi_device_driver *driver);

> +int hsi_open(struct hsi_device *dev);
> +int hsi_write(struct hsi_device *dev, u32 *addr, unsigned int size);
> +void hsi_write_cancel(struct hsi_device *dev);
> +int hsi_read(struct hsi_device *dev, u32 *addr, unsigned int size);
> +void hsi_read_cancel(struct hsi_device *dev);
> +int hsi_poll(struct hsi_device *dev);
> +int hsi_ioctl(struct hsi_device *dev, unsigned int command, void *arg);
> +void hsi_close(struct hsi_device *dev);

are these used on some file_operations structure ?

they should be implemented by the client driver if when it needs instead
of letting the bus driver dictacte so much of the design.

> +void hsi_set_read_cb(struct hsi_device *dev,
> +               void (*read_cb)(struct hsi_device *dev, unsigned int size));
> +void hsi_set_write_cb(struct hsi_device *dev,
> +               void (*write_cb)(struct hsi_device *dev, unsigned int size));
> +void hsi_set_port_event_cb(struct hsi_device *dev,
> +                               void (*port_event_cb)(struct hsi_device *dev,
> +                                       unsigned int event, void *arg));

I wouldn't do it like this. If this is what I'm guessing, you're using
these functions to be sure when a transfer has completed like ?

I remember suggesting this to be done more like the usb gadget
framework:

struct hsi_request {
	void		*buf;
	dma_addr_t	dma;
	unsigned	length;
	unsigned	direction;

	void		(*complete)(struct hsi_device *hsi, struct
					hsi_channel *channel, struct
					hsi_request *req);
};

then, you send the data and when you get a complete irq, you call
request->complete();

maybe that would be better ??

-- 
balbi
