From: Roger Quadros <rogerq@ti.com>
Subject: Re: Does USB isochronous mode work on EHCI port?
Date: Fri, 4 Jan 2013 15:20:16 +0200
Message-ID: <50E6D710.4060409@ti.com>
References: <32bbff70-2fcd-4993-92ea-385ab02f735a@googlegroups.com> <eb7a9da0-7556-4d8f-b7b4-bf29768082df@googlegroups.com> <6ffddeae-3f7b-4972-a485-c62ecc7e2cdb@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54169 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734Ab3ADNUU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jan 2013 08:20:20 -0500
In-Reply-To: <6ffddeae-3f7b-4972-a485-c62ecc7e2cdb@googlegroups.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <samoht.yrag@gmail.com>
Cc: pandaboard@googlegroups.com, balbi@ti.com, balbif@gmail.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hi Gary,

On 01/04/2013 02:20 PM, Gary Thomas wrote:
> 
> 
> On Thursday, January 3, 2013 9:21:19 AM UTC-7, Felipe Balbi wrote:
> 
>     Hi,
> 
>     On Wednesday, January 2, 2013 10:44:50 PM UTC+2, Gary Thomas wrote:
> 
>         I have a video adapter attached to my EHCI port which runs full
>         speed (480Mb/s) isochronous mode.  Sadly, I never get any data
>         from the device (it uses the EM28xx driver).
>         This same device + driver works fine on my laptop and from what
>         I can tell looking at the module debug, it's failing when
>         waiting for the ISOC frame data to arrive.
> 
>         Should this work?  I recall lots of discussion in the past about
>         ISOC transfers not working on certain OMAP devices...
> 
> 
>     which kernel are you using ? Have you tested mainline kernel ?
> 
> 
> I'm using the TI/Ubuntu kernel ( ti-ubuntu-3.4.0-1489.17)
> 
> Using the mainline would be hard as there is a lot in this kernel that
> isn't in the mainline.

I don't have an ISO device with me at the moment. I can only test this
next week.

Could you please post the output of dmesg once you plug in the USB
device and start using it? Also the output of usbmon would be great.

--
cheers,
-roger
