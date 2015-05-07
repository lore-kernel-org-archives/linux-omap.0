From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: DM3730 + MUSB host mode + DMA + USB Ethernet dongle = Fail
Date: Thu, 7 May 2015 09:06:06 -0700
Message-ID: <20150507160606.GB15563@atomide.com>
References: <554AA11B.9040909@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <554AA11B.9040909-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tim Nordell <tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tim Nordell <tim.nordell-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org> [150506 16:19]:
> Hi all -
> 
> I'm running kernel v3.19 (although I've tried v4.1-rc2's version of the MUSB
> code) on a DM3730 processor.  I'm running into an issue where if I enable
> MUSB Inventra DMA, plug in a USB Ethernet Dongle, and run iperf between the
> dongle and a PC, the MUSB driver stops working.  I get the following in my
> kernel log, twice back-to-back:
> 
>     musb_host_rx 1762: Rx interrupt with no errors or packet!
> 
> Any ideas?
> 
> The test above works in PIO mode, but I'd like to reduce the system CPU
> usage of the driver by using DMA.  I'm using a ASIX AX88772B Ethernet
> dongle, although, this shouldn't impact the error above.  I also tried
> re-reading the RXCSR register immediately after the error printout above,
> and the immediate subsequent time it contains the bit the driver is looking
> for.  I tried nesting the check so that if the bit the driver is looking for
> is set with an immediate subsequent read that it would continue past it, but
> it still keels over (albeit lasting maybe a second longer).
> 
> Something about this feels race conditiony too.  Depending on the kernel
> configuration options in the kernel debug menu (which slows down other parts
> of the kernel), or if I enable verbose debug message output from the MUSB
> driver, it lasts much, much longer before keeling over as a system.  You can
> restore normal behavior by unplugging/replugging in the device.

This sounds like some issue dealing with certain size transfers where
there's data remaining after a DMA transfer. You might be able to make
it easily reproducable with a variable size ping from your PC even with
debugging enabled. Something like the script below.

Regards,

Tony

8< --------------
#!/bin/bash

device=$1
size=$2

while [ 1 ]; do
	#echo "Pinging with size $size"
	if ! ping -w0 -c1 $device -s$size > /dev/null 2>&1; then
		break;
	fi
	size=$(expr $SIZE + 1)

	if [ $size -gt 8192 ]; then
		size=1
	fi
done

echo "Test ran up to $size"
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
