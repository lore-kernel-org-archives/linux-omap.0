From: Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Fri, 22 Jan 2016 11:35:16 +0100
Message-ID: <56A205E4.6050305@samsung.com>
References: <20160115224839.GA19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20160115224839.GA19432-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

W dniu 15.01.2016 o 23:48, Tony Lindgren pisze:
> Hi all,
>
> Looks like there's some issue with the USB gadgets and configfs.
>
> I'm seeing rmmod of the UDC driver cause a warning and then reboot
> hangs the system. This happens at least with v4.4, and I've reproduced
> it with dwc3 and musb so it seems to be generic.
>

I can't reproduce your problem on 4.4-rc4 nor on 4.4 release
with the script you provided

I'm using Odroid XU3, which has dwc3.

> I think Felipe is offline for next few days, but anyways here are
> the error messages and a shells script to reproduce the issue.
>
> Cheers,
>
> Tony

<snip>

>
> Test script to reproduce the problem, need to uncomment the reboot part:
>
> 8< --------------------
> #!/bin/bash
>
> # Change for your UDC controller
> udc_module=dwc3-omap
> udc_name=4a030000.dwc3

for me these are:

udc_module=dwc3-exynos
udc_name=12400000.dwc3

>
> #
> # Calling this and then doing rmmod $udc_module
> # followed by reboot seems to produce the follow:
> # WARNING: CPU: 1 PID: 1617 at lib/debugobjects.c:263
> #
> start_usb_gadgets() {
> 	vendor=0x1d6b
> 	product=0x0106
> 	file=$1
>
> 	mount -t configfs none /sys/kernel/config
> 	mkdir /sys/kernel/config/usb_gadget/g1
> 	old_pwd=$(pwd)
> 	cd /sys/kernel/config/usb_gadget/g1
>
> 	echo $product > idProduct
> 	echo $vendor > idVendor
> 	mkdir strings/0x409
> 	echo 123456789 > strings/0x409/serialnumber
> 	echo foo > strings/0x409/manufacturer
> 	echo "Multi Gadget" > strings/0x409/product
>
> 	mkdir configs/c.1
> 	echo 120 > configs/c.1/MaxPower
> 	mkdir configs/c.1/strings/0x409
> 	echo "Conf 1" > configs/c.1/strings/0x409/configuration
>
> 	mkdir configs/c.2
> 	echo 500 > configs/c.2/MaxPower
> 	mkdir configs/c.2/strings/0x409
> 	echo "Conf 2" > configs/c.2/strings/0x409/configuration
>
> 	mkdir functions/mass_storage.0
> 	echo $file > functions/mass_storage.0/lun.0/file
> 	ln -s functions/mass_storage.0 configs/c.1
> 	ln -s functions/mass_storage.0 configs/c.2
>
> 	# Not configuring further here just produces
> 	# WARNING: CPU: 1 PID: 1609 at lib/debugobjects.c:263
>
> 	mkdir functions/acm.0
> 	ln -s functions/acm.0 configs/c.1
> 	ln -s functions/acm.0 configs/c.2
>
> 	mkdir functions/ecm.0
> 	ln -s functions/acm.0 configs/c.1

I assume you meant ecm.0 here and in the next line.

> 	ln -s functions/acm.0 configs/c.2
>
> 	# Adding rndis seems to cause alignment trap or some
> 	# random oops on reboot after rmmod $udc_module
> 	mkdir functions/rndis.0
> 	ln -s functions/rndis.0 configs/c.1
> 	ln -s functions/rndis.0 configs/c.2
>
> 	echo $udc_name > /sys/kernel/config/usb_gadget/g1/UDC
> 	cd $old_pwd
> }
>
> function rmmod_and_shutdown() {
> 	rmmod $udc_module
> 	reboot
> }
>
> modprobe $udc_module
>
> start_usb_gadgets ""
>
> # uncomment this to reproduce bug
> # rmmod_and_shutdown

I have it uncommented, no problems.

But before I run this script I need to modprobe libcomposite,
though.

AP
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
