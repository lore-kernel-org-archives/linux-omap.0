From: =?UTF-8?B?RnJhbmsgU2Now6RmZXI=?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: Does USB isochronous mode work on EHCI port?
Date: Fri, 04 Jan 2013 17:33:08 +0100
Message-ID: <50E70444.7090407@googlemail.com>
References: <32bbff70-2fcd-4993-92ea-385ab02f735a@googlegroups.com> <eb7a9da0-7556-4d8f-b7b4-bf29768082df@googlegroups.com> <6ffddeae-3f7b-4972-a485-c62ecc7e2cdb@googlegroups.com> <50E6D710.4060409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <50E6D710.4060409-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gary Thomas <samoht.yrag-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rogerq-l0cyMroinI0@public.gmane.org, pandaboard-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, balbif-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Am 04.01.2013 14:20, schrieb Roger Quadros:
> Hi Gary,
>
> On 01/04/2013 02:20 PM, Gary Thomas wrote:
>>
>> On Thursday, January 3, 2013 9:21:19 AM UTC-7, Felipe Balbi wrote:
>>
>>     Hi,
>>
>>     On Wednesday, January 2, 2013 10:44:50 PM UTC+2, Gary Thomas wrote:
>>
>>         I have a video adapter attached to my EHCI port which runs full
>>         speed (480Mb/s) isochronous mode.  Sadly, I never get any data
>>         from the device (it uses the EM28xx driver).
>>         This same device + driver works fine on my laptop and from what
>>         I can tell looking at the module debug, it's failing when
>>         waiting for the ISOC frame data to arrive.
>>
>>         Should this work?  I recall lots of discussion in the past about
>>         ISOC transfers not working on certain OMAP devices...
>>
>>
>>     which kernel are you using ? Have you tested mainline kernel ?
>>
>>
>> I'm using the TI/Ubuntu kernel ( ti-ubuntu-3.4.0-1489.17)
>>
>> Using the mainline would be hard as there is a lot in this kernel that
>> isn't in the mainline.

I have added support for USB bulk transfers to the em28xx driver
recently. It will be include in kernels 3.9+.
Maybe it can be used to work around hardware problems with ISOC transfers.

So if your device has bulk endpoints for video (see lsusb -v), it's
probably worth testing the latest code from the media tree
(http://git.linuxtv.org/media_tree.git).
You will have to load the module with parameter usb_xfer_mode=1,
otherwise the driver selects ISOC transfers for TV devices by default.

Regards,
Frank
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
