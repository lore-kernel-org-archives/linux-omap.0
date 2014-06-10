From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: usb: musb: omap: Add device tree support for omap musb glue
Date: Tue, 10 Jun 2014 22:02:34 +0300
Message-ID: <20140610182900.GA7569@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37484 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbaFJTCq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jun 2014 15:02:46 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kishon@ti.com
Cc: linux-omap@vger.kernel.org

Hello Kishon Vijay Abraham I,

The patch 00a0b1d58af873d8: "usb: musb: omap: Add device tree support
for omap musb glue", from Sep 11 2012, leads to the following static
checker warning:

	drivers/usb/musb/omap2430.c:569 omap2430_probe()
	warn: does endianness matter for 'config->num_eps'?

drivers/usb/musb/omap2430.c
   565  
   566                  of_property_read_u32(np, "mode", (u32 *)&pdata->mode);
   567                  of_property_read_u32(np, "interface-type",
   568                                                  (u32 *)&data->interface_type);
   569                  of_property_read_u32(np, "num-eps", (u32 *)&config->num_eps);
                                                                    ^^^^^^^^^^^^^^^

This is not endian safe, but more importantly ->num_eps is a u8 so when
we write 32 bits to it, we are corrupting ->dma_channels,
->dyn_fifo_size, and ->vendor_ctrl.  On little endian, it's going to be
setting them to zero so it might not cause and immediate problem.

The way to do this is to use a 32 bit temporary variable and then save
the value to ->num_eps afterward.  Create a small function to do this in
a nice way.

All the casts here are a bit scary.

   570                  of_property_read_u32(np, "ram-bits", (u32 *)&config->ram_bits);
   571                  of_property_read_u32(np, "power", (u32 *)&pdata->power);

regards,
dan carpenter
