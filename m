From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [Help 1/2] MUSB: ZiO! CF card reader will trigger a change from MUSB
 host mode to MUSB peripheral mode
Date: Mon, 7 Apr 2008 05:46:19 -0500
Message-ID: <e0316c6403b78ad735478172580310c0@felipebalbi.com>
References: <386072610804070335g21f3f29fwb9e4b82bd7edc9bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49711 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbYDGKqY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 06:46:24 -0400
In-Reply-To: <386072610804070335g21f3f29fwb9e4b82bd7edc9bb@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <cooloney@kernel.org>
Cc: David Brownell <david-b@pacbell.net>, tony@atomide.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com



On Mon, 7 Apr 2008 03:35:38 -0700, "Bryan Wu" <cooloney@kernel.org> wrote:
> On Mon, Apr 7, 2008 at 3:19 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>>
>>
>>
>>  On Mon, 7 Apr 2008 03:15:38 -0700, "Bryan Wu" <cooloney@kernel.org>
> wrote:
>>  > Hi folks,
>>  >
>>  > Here is our bug tracker,
>>  >
>> 
>
https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3788
>>  >
>>  > ZiO! CF card reader is here:
>>  > http://www.psism.com/zio.htm
>>  >
>>  > - Firstly, MUSB is working as in host mode which can be figured out
> by
>>  > the debug message.
>>  > - Enumeration of the ZiO! CF card reader is OK.
>>  > - When the upper drivers/usb/storage/shuttle_usbat.c try to send out
>>  > the first packet:
>>  > --
>>  >         /* Enable peripheral control signals */
>>  >         rc = usbat_write_user_io(us,
>>  >                                  USBAT_UIO_OE1 | USBAT_UIO_OE0,
>>  >                                  USBAT_UIO_EPAD | USBAT_UIO_1);
>>  >         if (rc != USB_STOR_XFER_GOOD)
>>  >                 return USB_STOR_TRANSPORT_ERROR;
>>  > --
>>  >
>>  > - Finally, we got VBUS_ERROR interrupt in peripheral mode. I don't
>>  > know how to recover it.
>>  > If I am not wrong, the ZiO! CF card reader must have dropped the VBUS
>>  > and this triggered the mode change of MUSB.
>>  >
>>  > Are you guys have any idea about this?
>>  >
>>  > B.T.W, I found the packet sequence of
>>  > drivers/usb/storage/shuttle_usbat.c is not the same as Windows Host
>>  > does.
>>  > So I modified the code to send out the same packet as Windows Host.
>>  > The result is the same.
>>
>>  It's probably drawing more the 100mA, try using a self-powered usb hub
>>  attached
>>  to musb and zio to hub.
>>
> 
> So that means it's possible related with the hardware design?
> Unfortunately, there is no self-powered usb hub on my side.
> Only have normal full-speed usb hub which is powered by usb host. So
> maybe we should add this kind of usb devices to the black list of MUSB
> driver.

MUSB can only source up to 100mA on the bus, which is perfectly ok on the 
otg point of view. If you attach a device that needs more than 100mA you'll
get
a vbus error.

To have a clue about how much your reader does attach it to you host pc and
issue
lsusb -v -d <vendorid>:<productid> and check the MaxPower field. Of course
this is just
a string and if the manufacturer decided to mess it up it's not our fault
:-p

The correct way to measure the current consumption would be with a
multimeter, but the
string usually give you a clue :-)


-- 
Best Regards,

Felipe Balbi
http://felipebalbi.com
me@felipebalbi.com

