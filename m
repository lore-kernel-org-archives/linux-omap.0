From: "Bryan Wu" <cooloney@kernel.org>
Subject: [Help 1/2] MUSB: ZiO! CF card reader will trigger a change from MUSB host mode to MUSB peripheral mode
Date: Mon, 7 Apr 2008 03:15:38 -0700
Message-ID: <386072610804070315m2ebda41au363e62ea2ab27169@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:16034 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129AbYDGKPj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 06:15:39 -0400
Received: by rn-out-0910.google.com with SMTP id e24so1311465rng.1
        for <linux-omap@vger.kernel.org>; Mon, 07 Apr 2008 03:15:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>, tony@atomide.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com

Hi folks,

Here is our bug tracker,
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3788

ZiO! CF card reader is here:
http://www.psism.com/zio.htm

- Firstly, MUSB is working as in host mode which can be figured out by
the debug message.
- Enumeration of the ZiO! CF card reader is OK.
- When the upper drivers/usb/storage/shuttle_usbat.c try to send out
the first packet:
--
        /* Enable peripheral control signals */
        rc = usbat_write_user_io(us,
                                 USBAT_UIO_OE1 | USBAT_UIO_OE0,
                                 USBAT_UIO_EPAD | USBAT_UIO_1);
        if (rc != USB_STOR_XFER_GOOD)
                return USB_STOR_TRANSPORT_ERROR;
--

- Finally, we got VBUS_ERROR interrupt in peripheral mode. I don't
know how to recover it.
If I am not wrong, the ZiO! CF card reader must have dropped the VBUS
and this triggered the mode change of MUSB.

Are you guys have any idea about this?

B.T.W, I found the packet sequence of
drivers/usb/storage/shuttle_usbat.c is not the same as Windows Host
does.
So I modified the code to send out the same packet as Windows Host.
The result is the same.

Thanks a lot
-Bryan Wu
