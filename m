From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [Help 1/2] MUSB: ZiO! CF card reader will trigger a change from MUSB host mode to MUSB peripheral mode
Date: Mon, 7 Apr 2008 04:08:33 -0700
Message-ID: <386072610804070408q16c5ffa1u6a0c2e35295aa327@mail.gmail.com>
References: <386072610804070335g21f3f29fwb9e4b82bd7edc9bb@mail.gmail.com>
	 <e0316c6403b78ad735478172580310c0@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:41790 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbYDGLIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Apr 2008 07:08:38 -0400
Received: by ug-out-1314.google.com with SMTP id z38so445741ugc.16
        for <linux-omap@vger.kernel.org>; Mon, 07 Apr 2008 04:08:34 -0700 (PDT)
In-Reply-To: <e0316c6403b78ad735478172580310c0@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, tony@atomide.com, linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com

On Mon, Apr 7, 2008 at 3:46 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>
>
>
>  On Mon, 7 Apr 2008 03:35:38 -0700, "Bryan Wu" <cooloney@kernel.org> wrote:
>  > On Mon, Apr 7, 2008 at 3:19 AM, Felipe Balbi <me@felipebalbi.com> wrote:
>  >>
>  >>
>  >>
>  >>  On Mon, 7 Apr 2008 03:15:38 -0700, "Bryan Wu" <cooloney@kernel.org>
>  > wrote:
>  >>  > Hi folks,
>  >>  >
>  >>  > Here is our bug tracker,
>  >>  >
>  >>
>  >
>  https://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_id=141&tracker_item_id=3788
>  >>  >
>  >>  > ZiO! CF card reader is here:
>  >>  > http://www.psism.com/zio.htm
>  >>  >
>  >>  > - Firstly, MUSB is working as in host mode which can be figured out
>  > by
>  >>  > the debug message.
>  >>  > - Enumeration of the ZiO! CF card reader is OK.
>  >>  > - When the upper drivers/usb/storage/shuttle_usbat.c try to send out
>  >>  > the first packet:
>  >>  > --
>  >>  >         /* Enable peripheral control signals */
>  >>  >         rc = usbat_write_user_io(us,
>  >>  >                                  USBAT_UIO_OE1 | USBAT_UIO_OE0,
>  >>  >                                  USBAT_UIO_EPAD | USBAT_UIO_1);
>  >>  >         if (rc != USB_STOR_XFER_GOOD)
>  >>  >                 return USB_STOR_TRANSPORT_ERROR;
>  >>  > --
>  >>  >
>  >>  > - Finally, we got VBUS_ERROR interrupt in peripheral mode. I don't
>  >>  > know how to recover it.
>  >>  > If I am not wrong, the ZiO! CF card reader must have dropped the VBUS
>  >>  > and this triggered the mode change of MUSB.
>  >>  >
>  >>  > Are you guys have any idea about this?
>  >>  >
>  >>  > B.T.W, I found the packet sequence of
>  >>  > drivers/usb/storage/shuttle_usbat.c is not the same as Windows Host
>  >>  > does.
>  >>  > So I modified the code to send out the same packet as Windows Host.
>  >>  > The result is the same.
>  >>
>  >>  It's probably drawing more the 100mA, try using a self-powered usb hub
>  >>  attached
>  >>  to musb and zio to hub.
>  >>
>  >
>  > So that means it's possible related with the hardware design?
>  > Unfortunately, there is no self-powered usb hub on my side.
>  > Only have normal full-speed usb hub which is powered by usb host. So
>  > maybe we should add this kind of usb devices to the black list of MUSB
>  > driver.
>
>  MUSB can only source up to 100mA on the bus, which is perfectly ok on the
>  otg point of view. If you attach a device that needs more than 100mA you'll
>  get
>  a vbus error.
>

Right.
>From the device descriptor, if the MaxPower is greater than 100mA, our
usb OTG stack should refuse it, right?

>  To have a clue about how much your reader does attach it to you host pc and
>  issue
>  lsusb -v -d <vendorid>:<productid> and check the MaxPower field. Of course
>  this is just
>  a string and if the manufacturer decided to mess it up it's not our fault
>  :-p
>
>  The correct way to measure the current consumption would be with a
>  multimeter, but the
>  string usually give you a clue :-)
>

Thanks, that is pretty handy for us.
But I found the MaxPower of my ZiO! is 100mA, too bad.
--
$ sudo lsusb -v -d 04e6:1010

Bus 002 Device 003: ID 04e6:1010 SCM Microsystems, Inc. USBAT-2
CompactFlash Card Reader
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        16
  idVendor           0x04e6 SCM Microsystems, Inc.
  idProduct          0x1010 USBAT-2 CompactFlash Card Reader
  bcdDevice            0.05
  iManufacturer           1 SHUTTLE
  iProduct                2 SCM Micro USBAT-02
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      1
      bInterfaceProtocol    255
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval               5
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
Device Status:     0x0001
  Self Powered
--

-Bryan Wu
